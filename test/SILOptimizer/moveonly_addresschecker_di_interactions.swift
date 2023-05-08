// RUN: %target-swift-emit-sil -sil-verify-all -verify -enable-experimental-feature NoImplicitCopy %s

// This testStruct specifically testStructs how DI and the move checkers interact with each other

func testStructSimpleNoInit() {
    struct M: ~Copyable {
        private let i: Int // expected-note {{'self.i' not initialized}}

        // No initialization. Should get DI error and no crash.
        init() {
        } // expected-error {{return from initializer without initializing all stored properties}}
    }
}

func testStructSimplePartialInit() {
    struct M: ~Copyable {
        private let i: Int
        private let i2: Int // expected-note {{'self.i2' not initialized}}

        init() {
            i = 5
        } // expected-error {{return from initializer without initializing all stored properties}}
    }
}

func testStructSimplePartialInit2() {
    struct M: ~Copyable {
        private let i: Int = 5
        private let i2: Int // expected-note {{'self.i2' not initialized}}

        init() {
        } // expected-error {{return from initializer without initializing all stored properties}}
    }
}

func testStructGenericNoInit() {
    struct M<T>: ~Copyable {
        private let i: T // expected-note {{'self.i' not initialized}}

        init() {
        } // expected-error {{return from initializer without initializing all stored properties}}
    }
}

func testStructGenericPartialInit() {
    struct M<T>: ~Copyable {
        private let i: T
        private let i2: T // expected-note {{'self.i2' not initialized}}

        init(_ t: T) {
            self.i = t
        } // expected-error {{return from initializer without initializing all stored properties}}
    }
}

func testEnumNoInit() {
    enum E : ~Copyable {
        case first
        case second

        init() {
        } // expected-error {{'self.init' isn't called on all paths before returning from initializer}}
    }
}

func testEnumNoInitWithPayload() {
    @_moveOnly struct Empty {}

    enum E : ~Copyable {
        case first(Empty)
        case second

        init() {
        } // expected-error {{'self.init' isn't called on all paths before returning from initializer}}
    }
}

func testEnumNoInitWithGenericPayload() {
    @_moveOnly struct Empty {}

    enum E<T> : ~Copyable {
        case first(Empty)
        case second(T)

        init() {
        } // expected-error {{'self.init' isn't called on all paths before returning from initializer}}
    }
}
