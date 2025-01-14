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

protocol Meta: Codable {
    /// Unique id of the artifact
    var fileKey: String { get }
}

struct MainArtifactMeta: Meta, Equatable {
    /// List of all files used in the compilation
    var dependencies: [String]
    var fileKey: String
    /// Dependencies files raw fingerprint digest
    var rawFingerprint: String
    /// Commit sha that generated a product
    var generationCommit: String
    /// Name of the target
    var targetName: String
    /// Configuration used in the build
    var configuration: String
    /// Platform used in the build
    var platform: String
    /// Xcode build number generated the product
    var xcode: String
    /// All compilation files
    var inputs: [String]
    /// Extra keys added by meta plugins
    var pluginsKeys: [String: String]

    var environments: [[String]]?
}
