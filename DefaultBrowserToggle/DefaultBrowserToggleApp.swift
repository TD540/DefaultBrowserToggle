//
//  DefaultBrowserToggleApp.swift
//  DefaultBrowserToggle
//
//  Created by thomas on 02/01/2024.
//

import SwiftUI

@main
struct DefaultBrowserToggleApp: App {
    @State var currentBrowser: String = getCurrentDefaultBrowser()
    @State var installedBrowsers: [String: String] = getInstalledBrowsers()

    var body: some Scene {
        MenuBarExtra(currentBrowser, image: iconName(for: currentBrowser)) {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(installedBrowsers.keys.sorted(), id: \.self) { browser in
                    MenuBarButton {
                        if let bundleID = installedBrowsers[browser] {
                            DefaultBrowserHandler.setDefaultBrowser(bundleID)
                            currentBrowser = browser
                        }
                    } label: {
                        HStack(spacing: 5) {
                            Image(iconName(for: browser))
                                .renderingMode(.template)
                            Text(browser)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                Divider()
                    .padding(6)
                MenuBarButton {
                    NSApplication.shared.terminate(nil)
                } label: {
                    Text("Quit")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 35)
                }
            }
            .padding(5)
        }
        .menuBarExtraStyle(.window)
    }
}

func getInstalledBrowsers() -> [String: String] {
    guard let schemeURL = URL(string: "https:") else {
        return [:]
    }
    let htmlHandlerAppsURLs = NSWorkspace.shared.urlsForApplications(toOpen: .html)
    let httpsHandlerAppsURLs = NSWorkspace.shared.urlsForApplications(toOpen: schemeURL)
    let intersectedURLs = Set(htmlHandlerAppsURLs).intersection(httpsHandlerAppsURLs)

    var browsers: [String: String] = [:]
    intersectedURLs.forEach { url in
        let browserName = url.deletingPathExtension().lastPathComponent
        let bundleID = Bundle(url: url)?.bundleIdentifier ?? ""
        browsers[browserName] = bundleID
    }
    return browsers
}

func getCurrentDefaultBrowser() -> String {
    let httpsURL = URL(string: "https:")!
    guard let defaultBrowserURL = NSWorkspace.shared.urlForApplication(toOpen: httpsURL) else {
        return "Unknown"
    }
    return defaultBrowserURL.deletingPathExtension().lastPathComponent
}

func iconName(for browser: String) -> String {
    let browserIcons = ["Arc", "Brave Browser", "Google Chrome", "Microsoft Edge", "Firefox", "Opera", "Safari", "Vivaldi"]
    for icon in browserIcons {
        if browser.lowercased().contains(icon.lowercased()) {
            return icon
        }
    }
    return "other"
}
