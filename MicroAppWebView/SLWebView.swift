//
//  SLWebView.swift
//  MicroAppWebView
//
//  Created by Pedro Albuquerque on 28/05/19.
//  Copyright © 2019 Soluevo Solucoes Evolutivas. All rights reserved.
//

import Foundation
import UIKit

open class SLWebView: UIWebView, UIWebViewDelegate{
    //MARK: Typealiasing for Closure Types
    public typealias SLWebViewClosure                                       = (_ webView :SLWebView) -> ()
    public typealias SLWebViewFailClosure                                   = (_ webView :SLWebView, _ error: Error?) -> ()
    public typealias SLWebViewShouldLoadClosure                             = (_ webView :SLWebView, _ request: URLRequest, _ navigationType: UIWebView.NavigationType) -> (Bool)
    
    //MARK: Internal storage for Closures
    fileprivate var didStartLoadingHandler: SLWebViewClosure?               = nil
    fileprivate var didFinishLoadingHandler: SLWebViewClosure?              = nil
    fileprivate var didCompleteLoadingHandler: SLWebViewClosure?            = nil
    fileprivate var didFailLoadingHandler: SLWebViewFailClosure?            = nil
    fileprivate var shouldStartLoadingHandler: SLWebViewShouldLoadClosure?  = nil
    
    //MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        delegate  = self
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        delegate  = self
    }
    
    // URL/String loaders with Chaining-support
    public class func loadURL(_ URL: URL) -> SLWebView {
        let wv = SLWebView()
        wv.loadRequest(URLRequest(url: URL))
        return wv
    }
    
    public class func loadHTML(_ string: String, baseURL: URL) -> SLWebView {
        let wv = SLWebView()
        wv.loadHTMLString(string, baseURL: baseURL)
        return wv
    }
    
    @discardableResult
    public func loadURL(_ URL: URL) -> SLWebView {
        loadRequest(URLRequest(url: URL))
        return self
    }
    
    @discardableResult
    public func loadHTML(_ string: String, baseURL: URL) -> SLWebView {
        loadHTMLString(string, baseURL: baseURL)
        return self
    }
    
    //MARK: Closure methods
    @discardableResult
    public func didStartLoading(handler: @escaping SLWebViewClosure) -> SLWebView {
        didStartLoadingHandler       = handler
        
        return self
    }
    
    @discardableResult
    public func didFinishLoading(handler: @escaping SLWebViewClosure) -> SLWebView {
        didFinishLoadingHandler      = handler
        return self
    }
    
    @discardableResult
    public func didFailLoading(handler: @escaping SLWebViewFailClosure) -> SLWebView {
        didFailLoadingHandler        = handler
        return self
    }
    
    @discardableResult
    public func didCompleteLoading(handler: @escaping SLWebViewClosure) -> SLWebView {
        didCompleteLoadingHandler    = handler
        return self
    }
    
    @discardableResult
    public func shouldStartLoading(handler: @escaping SLWebViewShouldLoadClosure) -> SLWebView {
        shouldStartLoadingHandler    = handler
        return self
    }
    
    //MARK: UIWebView Delegate & Closure Handling
    public func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        didFailLoadingHandler?(self, error)
    }
    
    public func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        guard let handler = shouldStartLoadingHandler,
            shouldStartLoadingHandler != nil else {
                return true
        }
        
        return handler(self, request, navigationType)
    }
    
    public func webViewDidStartLoad(_ webView: UIWebView) {
        didStartLoadingHandler?(self)
    }
    
    public func webViewDidFinishLoad(_ webView: UIWebView) {
        didFinishLoadingHandler?(self)
        
        if !webView.isLoading {
            didCompleteLoadingHandler?(self)
        }
    }
}

