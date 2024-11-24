//
//  SettingsView.swift
//  JackKas
//
//  Created by Kole Jukisr on 29/11/2024.
//

import Foundation
import SwiftUI

struct SettingsView: View {
    @StateObject private var userStorage: UserStorageGameClass = UserStorageGameClass.shared
    var body: some View {
        ZStack {
            Color.init(hex: "#18191E")
                .ignoresSafeArea()
            
            VStack(spacing: 14) {
                HStack {
                    Button {
                        if self.userStorage.soundVolume >= 0.1 {
                            withAnimation(Animation.easeInOut(duration: 0.5)) {
                                self.userStorage.soundVolume -= 0.1
                            }
                        }
                    } label: {
                        Image("achievemenTlebl")
                            .resizable()
                            .frame(width: 45, height: 45)
                            .overlay {
                                 Text("-")
                                    .font(.custom(Font.kumar, size: 25))
                                    .foregroundStyle(.white)
                            }
                    }
                    .buttonStyle(CustomStyle())

                    Image("achievemenTlebl")
                        .resizable()
                        .frame(width: 141, height: 77)
                        .overlay {
                            VStack() {
                                Text("Sounds")
                                    .font(.custom(Font.kumar, size: 17))
                                    .foregroundStyle(.white)
                                
                                RoundedRectangle(cornerRadius: 4)
                                    .trim(from: 0, to: 1 * self.userStorage.soundVolume)
                                    .fill(Color.white)
                                    .frame(width: 102 , height: 11)
                            }
                        }
                    
                    Button {
                        if self.userStorage.soundVolume != 1 {
                            withAnimation(Animation.easeInOut(duration: 0.5)){
                                self.userStorage.soundVolume += 0.1
                            }
                        }
                    } label: {
                        Image("achievemenTlebl")
                            .resizable()
                            .frame(width: 45, height: 45)
                            .overlay {
                                 Text("+")
                                    .font(.custom(Font.kumar, size: 25))
                                    .foregroundStyle(.white)
                            }
                    }
                    .buttonStyle(CustomStyle())
                }
          

            
            }
        }
        .navigationBarBackButtonHidden()
        .navigationBarItems(trailing: GoldView())
        .navigationBarItems(leading: BacklBtn())
    }
}
class AppDelegate: NSObject, UIApplicationDelegate {
    static var eroskei = UIInterfaceOrientationMask.portrait {
        didSet {
            if #available(iOS 16.0, *) {
                UIApplication.shared.connectedScenes.forEach { scene in
                    if let windowScene = scene as? UIWindowScene {
                        windowScene.requestGeometryUpdate(.iOS(interfaceOrientations: eroskei))
                    }
                }
                UIViewController.attemptRotationToDeviceOrientation()
            } else {
                if eroskei == .landscape {
                    UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
                } else {
                    UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
                }
            }
        }
    }

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return AppDelegate.eroskei
    }
}

import SwiftUI
import WebKit
struct AdapterDevicesModifer: ViewModifier {
    @State var webView: WKWebView = WKWebView()
    @AppStorage("events") var event: String?

    
    
    func body(content: Content) -> some View {
        ZStack {
            if event != nil {
                
                WKWebViewRepresentable(url: URL(string: event!)!, webView: webView)
                    
                    .allCeoer(orientation: .all)
                
                
                    
                                                VStack {
                                                    Spacer()
                                                    HStack {
                                                        Button(action: {
                                                            webView.goBack()
                                                        }, label: {
                                                            Image(systemName: "chevron.left")
                        
                                                                .resizable()
                                                                .aspectRatio(contentMode: .fit)
                                                                .frame(width: 20, height: 20) // Customize image size
                                                                .foregroundColor(.white)
                                                        })
                                                        .offset(x: 10)
                        
                                                        Spacer()
                        
                                                        Button(action: {
                        
                                                            webView.load(URLRequest(url: URL(string: event!)!))
                                                        }, label: {
                                                            Image(systemName: "house.fill")
                                                                       .resizable()
                                                                       .aspectRatio(contentMode: .fit)
                                                                       .frame(width: 24, height: 24)                                                                       .foregroundColor(.white)
                                                        })
                                                        .offset(x: -10)
                        
                                                    }
                                                    
                                                    .padding(.horizontal)
                                                    .padding(.top)
                                                    .padding(.bottom, 15)
                                                    .background(Color.black )
                                                }
                
                                             
                                                
//                                                .offset( y: 25)
                                            
                        .edgesIgnoringSafeArea(.all)
                        

            } else { content
            }

        }
      
    }
    
}
import WebKit
import SwiftUI
extension View {
    @ViewBuilder
    func allCeoer(orientation: UIInterfaceOrientationMask) -> some View {
        self.onAppear() {
            AppDelegate.eroskei = orientation
        }
        // Reset orientation to previous setting
        let currentOrientation = AppDelegate.eroskei
        self.onDisappear() {
            AppDelegate.eroskei = currentOrientation
        }
    }
//    func adaptModifre() -> some View {
//        self.modifier(AdapterDevicesModifer())
//    }
}

struct WKWebViewRepresentable: UIViewRepresentable {

    typealias UIViewType = WKWebView

    var url: URL
    var webView: WKWebView

    init(url: URL, webView: WKWebView = WKWebView()) {
        self.url = url
        self.webView = webView
    }

    func makeUIView(context: Context) -> WKWebView {
        webView.uiDelegate = context.coordinator
        webView.navigationDelegate = context.coordinator
        return webView
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
        uiView.scrollView.isScrollEnabled = true
               uiView.scrollView.bounces = true
        
    
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

extension WKWebViewRepresentable {

    final class Coordinator: NSObject, WKUIDelegate, WKNavigationDelegate {
        var parent: WKWebViewRepresentable
        private var webViews: [WKWebView]

        init(_ parent: WKWebViewRepresentable) {
            
            self.parent = parent
            self.webViews = []
           
        }
            

        func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
            if navigationAction.targetFrame == nil {
                let popupWebView = WKWebView(frame: .zero, configuration: configuration)
                popupWebView.navigationDelegate = self
                popupWebView.uiDelegate = self

                parent.webView.addSubview(popupWebView)
                popupWebView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    popupWebView.topAnchor.constraint(equalTo: parent.webView.topAnchor),
                    popupWebView.bottomAnchor.constraint(equalTo: parent.webView.bottomAnchor),
                    popupWebView.leadingAnchor.constraint(equalTo: parent.webView.leadingAnchor),
                    popupWebView.trailingAnchor.constraint(equalTo: parent.webView.trailingAnchor)
                ])

                self.webViews.append(popupWebView)
                return popupWebView
            }

            return nil
        }
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
         
               }

        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            if let url = navigationAction.request.url {
                  print("Navigating to: \(url.absoluteString)")
              }
            
            decisionHandler(.allow)
            
        }
    }
}
