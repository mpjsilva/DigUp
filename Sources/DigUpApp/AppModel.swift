import AppKit
import Observation

/// State the menubar, the panel and the windows share. Engine updates arrive on the main thread.
@Observable
final class AppModel {
    var status = EngineStatus()
    var settings: AppSettings
    var hotkey: KeyCombo?
    let download: ModelDownload
    /// A newer DigUp the daily check found ("0.6.1"), until you open it (`Updates`).
    var updateAvailable: String?

    init(settings: AppSettings, download: ModelDownload) {
        self.settings = settings
        self.download = download
    }

    var hasFolders: Bool { !settings.roots.isEmpty }
    /// Code search is on (there are code folders).
    var hasCode: Bool { !settings.codeRoots.isEmpty }

    /// One line for the menu and the windows: what the index is doing.
    var statusLine: String {
        let status = self.status
        guard hasFolders else { return "Nenhuma pasta escolhida ainda" }
        switch status.activity {
        case .starting: return "Iniciando…"
        case .failed(let problem): return "⚠︎ \(problem)"
        case .syncing: return "Verificando pastas…"
        case .indexing(let done, let total):
            let percent = total > 0 ? Int((Double(done) / Double(total) * 100).rounded(.down)) : 0
            return "Indexando \(percent)% · \(done.formatted()) de \(total.formatted())"
        case .finishing(let done, let total, let files):
            let percent = total > 0 ? Int((Double(done) / Double(total) * 100).rounded(.down)) : 0
            let which = files > 0 ? "\(files.formatted()) \(files == 1 ? "arquivo longo" : "arquivos longos")" : "arquivos longos"
            return "Lendo o restante de \(which) · \(percent)%"
        case .idle:
            if let line = downloadLine { return line }
            if let code = status.code.indexing, code.total > 0 {
                let percent = Int((Double(code.done) / Double(code.total) * 100).rounded(.down))
                return "Indexando código \(percent)% · \(code.done.formatted()) de \(code.total.formatted())"
            }
            let waiting = "\(status.pending.formatted()) \(status.pending == 1 ? "arquivo" : "arquivos") aguardando"
            if status.pending > 0, status.paused { return "Pausado · \(waiting)" }
            if let until = status.heldUntil, !status.paused {
                // Outside the set hours: what's known to wait, and when indexing starts again.
                let when = "indexação a partir de \(until.formatted(date: .omitted, time: .shortened))"
                if status.pending > 0 { return "\(waiting) · \(when)" }
                return "\(status.searchable.formatted()) \(status.searchable == 1 ? "arquivo indexado" : "arquivos indexados") · \(when)"
            }
            if status.pending > 0, let reason = status.waitingFor { return "\(waiting) · \(reason)" }
            if status.pending > 0 { return "\(waiting) na fila de indexação" }
            if status.unfinished > 0 {
                let rest = "\(status.unfinished.formatted()) \(status.unfinished == 1 ? "arquivo longo" : "arquivos longos") a concluir"
                if status.paused { return "Pausado · \(rest)" }
                if let reason = status.waitingFor { return "\(rest) · \(reason)" }
            }
            return "\(status.searchable.formatted()) \(status.searchable == 1 ? "arquivo indexado" : "arquivos indexados")"
                + (status.paused ? " · pausado" : "")
        }
    }

    /// While the model isn't there, how its download goes.
    private var downloadLine: String? {
        switch download.phase {
        case .ready: nil
        case .downloading: "Baixando o modelo · \(Int(download.fraction * 100))%"
        case .verifying: "Verificando o download do modelo…"
        case .retrying: "Download do modelo: aguardando a rede"
        case .failed: "⚠︎ O download do modelo parou"
        case .needed: status.pending > 0 ? "O modelo ainda não foi baixado" : nil
        }
    }

    /// 0…1 for the menubar ring and progress bars: the model download, then an indexing pass or the rest of long files.
    var progress: Double? {
        if download.isActive { return download.fraction }
        switch status.activity {
        case .indexing(let done, let total) where total > 0: return Double(done) / Double(total)
        case .finishing(let done, let total, _) where total > 0: return Double(done) / Double(total)
        case .idle:
            guard let code = status.code.indexing, code.total > 0 else { return nil }
            return Double(code.done) / Double(code.total)
        default: return nil
        }
    }

    /// One line about the code index, for Settings → Code: "812 code files indexed", "Indexing code 42%…".
    var codeStatusLine: String {
        let code = status.code
        guard hasCode else { return "A busca de código está desativada" }
        if !download.isReady { return "O código é lido após o download do modelo" }
        if let indexing = code.indexing, indexing.total > 0 {
            let percent = Int((Double(indexing.done) / Double(indexing.total) * 100).rounded(.down))
            return "Indexando código \(percent)% · \(indexing.done.formatted()) de \(indexing.total.formatted())"
        }
        let waiting = code.pending > 0 ? " · \(code.pending.formatted()) aguardando" : ""
        if code.pending > 0, status.paused { return "Pausado · \(code.pending.formatted()) arquivos de código aguardando" }
        if code.pending > 0, let reason = status.waitingFor { return "\(code.pending.formatted()) arquivos de código aguardando · \(reason)" }
        if code.pending > 0, let until = status.heldUntil {
            return "\(code.pending.formatted()) arquivos de código aguardando · indexação a partir de "
                + until.formatted(date: .omitted, time: .shortened)
        }
        // Code is read once the other folders have nothing waiting (the helper's order).
        if code.pending > 0, status.pending > 0 {
            let files = "\(code.pending.formatted()) \(code.pending == 1 ? "arquivo de código" : "arquivos de código")"
            return files + " aguardando · lidos após seus outros arquivos"
        }
        return "\(code.searchable.formatted()) \(code.searchable == 1 ? "arquivo de código indexado" : "arquivos de código indexados")" + waiting
    }

    /// A few words for the search bar while results may be incomplete: "Indexing 42%", "Downloading model · 42%".
    var activityBadge: String? {
        if download.isActive { return "Baixando modelo · \(Int(download.fraction * 100))%" }
        if case .indexing(let done, let total) = status.activity, total > 0 {
            return "Indexando \(Int(Double(done) / Double(total) * 100))%"
        }
        if status.paused, status.pending > 0 { return "Indexação pausada" }
        return nil
    }

    /// Why meaning search can't run yet (words still match), or nil.
    var meaningUnavailable: String? {
        guard !download.isReady else { return nil }
        if download.isActive {
            return "Correspondências por palavras apenas até o download do modelo (\(Int(download.fraction * 100))%)"
        }
        return "Apenas palavras: o modelo não foi baixado"
    }

    /// Why results may be incomplete right now, or nil.
    var resultsCaveat: String? {
        if let meaningUnavailable { return meaningUnavailable }
        if case .indexing(let done, let total) = status.activity, total > 0 {
            return "Ainda indexando (\(Int(Double(done) / Double(total) * 100))%): alguns arquivos ainda não entraram"
        }
        if status.pending > 0 {
            return "\(status.pending.formatted()) \(status.pending == 1 ? "arquivo ainda não foi indexado" : "arquivos ainda não foram indexados")"
        }
        return nil
    }
}
