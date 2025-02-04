import class Foundation.Bundle

private class BundleFinder {}

extension Foundation.Bundle {
    /// Returns the resource bundle associated with the current Swift module.
    static var resourceBundle: Bundle = {
        let bundleName = "WalletConnect_WalletConnectRelay"
        let nicegramBundleName = "WalletConnectRelay_WalletConnectRelay"

        let candidates = [
            // Bundle should be present here when the package is linked into an App.
            Bundle.main.resourceURL,

            // Bundle should be present here when the package is linked into a framework.
            Bundle(for: BundleFinder.self).resourceURL,

            // For command-line tools.
            Bundle.main.bundleURL,
            
            // One of these should be used when building SwiftUI Previews
            Bundle(for: BundleFinder.self).resourceURL?
                .deletingLastPathComponent()
                .deletingLastPathComponent()
                .deletingLastPathComponent(),
            Bundle(for: BundleFinder.self).resourceURL?
                .deletingLastPathComponent()
                .deletingLastPathComponent()
        ]

        for candidate in candidates {
            let bundlePath = candidate?.appendingPathComponent(bundleName + ".bundle")
            if let bundle = bundlePath.flatMap(Bundle.init(url:)) {
                return bundle
            }
            
            let nicegramBundlePath = candidate?.appendingPathComponent(nicegramBundleName + ".bundle")
            if let bundle = nicegramBundlePath.flatMap(Bundle.init(url:)) {
                return bundle
            }
        }
        fatalError("unable to find bundle named WalletConnect_WalletConnectRelay")
    }()
}
