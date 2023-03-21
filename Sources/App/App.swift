import ArgumentParser
import Hummingbird

public protocol AppArguments {
    
}

@main
struct App: ParsableCommand, AppArguments {
    
    @Option(name: .shortAndLong)
    var hostname: String = "127.0.0.1"

    @Option(name: .shortAndLong)
    var port: Int = 8080

    func run() throws {
        let app = HBApplication(
            configuration: .init(
                address: .hostname(hostname, port: port),
                serverName: "Hummingbird"
            )
        )
        try app.configure(self)
        try app.start()
        app.wait()
    }
}
