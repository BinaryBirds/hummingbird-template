import Hummingbird

public protocol AppArguments {
    
}

extension HBApplication {

    func configure(_ args: AppArguments) throws {
        
        router.get("/") { _ in
            "Hello, world!"
        }

        router.get("/health") { _ -> HTTPResponseStatus in
            .ok
        }
    }
}
