//
//  rdarBugImplementation.swift
//  rdarForDidSetSwiftBug
//
//  Created by Oleo, Pierre on 2015-09-15.
//  Copyright © 2015 La Presse. All rights reserved.
//

import Foundation

// Test Class used to show that didSet is called when unwrapping a var declared as a protocol
// didSet should only be called when setting the variable. However when unwrapping the variable, didSet will be called which could cause unexpected behaviour
//
// When running the app, output is as follows (expected results is the same without didSet protocolImplementation is being called)
// didSet protocolImplementation is being called
// didSet classWithNoProtocol is being called
//
// Trying to access varWithoutDidSetProblem?.title. didSet should not be called
// Done. ClassWithNoProtocol title
//
// Trying to access varWithoutDidSetProblem via let ?.title. didSet should not be called
// Done. ClassWithNoProtocol title
//
// Trying to access varWithDidSetProblem?.title. didSet should not be called
// didSet protocolImplementation is being called
// Done. ProtocolImplementation title
//
// Trying to access varWithDidSetProblem via let ?.title. didSet should not be called
// Done. ProtocolImplementation title

protocol ProtocolThatCausesProblem {
    var title: String {get}
}

class ProtocolImplementation: ProtocolThatCausesProblem {
    var title: String
    init() {
        self.title = "ProtocolImplementation title"
    }
}

class ClassWithNoProtocol {
    var title: String
    
    init() {
        self.title = "ClassWithNoProtocol title"
    }
}

class DidSetValidator {
    var protocolDidSetCount = 0
    var classDidSetCount = 0
    
    init(){
        self.varWithDidSetProblem = ProtocolImplementation()
        self.varWithoutDidSetProblem = ClassWithNoProtocol()
    }
    
    var varWithDidSetProblem: ProtocolThatCausesProblem? {
        didSet {
            protocolDidSetCount = protocolDidSetCount + 1
            print("didSet protocolImplementation is being called")
        }
    }
    
    var varWithoutDidSetProblem: ClassWithNoProtocol? {
        didSet {
            classDidSetCount = protocolDidSetCount + 1
            print("didSet classWithNoProtocol is being called")
        }
    }
    
    func validateDirectClassWithUnwrap() {
        print("Trying to access varWithoutDidSetProblem via let unwrappedVar = varWithoutDidSetProblem, let _ = unwrappedVar.title. didSet should not be called")
        if let unwrappedVar = varWithoutDidSetProblem {
            let varTitle = unwrappedVar.title
            print("Done. \(varTitle) \n")
        }
    }
    
    func validateDirectClassWithOptional() {
        print("\nTrying to access varWithoutDidSetProblem?.title. didSet should not be called")
        if let varTitle = varWithoutDidSetProblem?.title {
            print("Done. \(varTitle) \n")
        }
    }
    
    func validateProtocolImplementationWithUnwrap() {
        print("Trying to access varWithDidSetProblem via let unwrappedVar = varWithDidSetProblem, let varTitle = unwrappedVar.title. didSet should not be called")
        if let unwrappedVar = varWithDidSetProblem {
            let varTitle = unwrappedVar.title
            print("Done. \(varTitle) \n")
        }
    }
    
    // ------- Bug is here ------
    func validateProtocolImplementationWithOptional() {
        print("Trying to access varWithDidSetProblem?.title. didSet should not be called")
        if let varTitle = varWithDidSetProblem?.title {
            print("Done. \(varTitle) \n")
        }
    }
    // ------- Bug was here ------
}
