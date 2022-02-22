// Copyright (c) 2021 Spotify AB.
//
// Licensed to the Apache Software Foundation (ASF) under one
// or more contributor license agreements.  See the NOTICE file
// distributed with this work for additional information
// regarding copyright ownership.  The ASF licenses this file
// to you under the Apache License, Version 2.0 (the
// "License"); you may not use this file except in compliance
// with the License.  You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import Foundation

protocol URLSessionFactory {
    /// Builds URLSession specific to the current XCRemoteCache configuration
    func build() -> URLSession
}

/// URLSession factory that appends extra headers and uses default configuration
class DefaultURLSessionFactory: URLSessionFactory {
    private let config: XCRemoteCacheConfig

    init(config: XCRemoteCacheConfig) {
        self.config = config
    }

    func build() -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = config.requestCustomHeaders
        configuration.timeoutIntervalForRequest = config.timeoutResponseDataChunksInterval
        configuration.urlCache?.memoryCapacity = 0
        configuration.urlCache?.diskCapacity = 0
        switch config.disableCertificateVerification {
        case true:
            return URLSession(
                configuration: configuration,
                delegate: IgnoringCertificatesTrustManager(),
                delegateQueue: nil
            )
        case false:
            return URLSession(configuration: configuration)
        }
    }
}
