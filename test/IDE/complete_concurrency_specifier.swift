// RUN: %target-swift-ide-test -batch-code-completion -source-filename %s -filecheck %raw-FileCheck -completion-output-dir %t -enable-experimental-concurrency

// SPECIFIER: Begin completions
// SPECIFIER-DAG: Keyword/None:                       async; name=async
// SPECIFIER-DAG: Keyword[throws]/None:               throws; name=throws
// SPECIFIER: End completions

// SPECIFIER_WITHASYNC: Begin completions
// SPECIFIER_WITHASYNC-NOT: async
// SPECIFIER_WITHASYNC-DAG: Keyword[throws]/None:               throws; name=throws
// SPECIFIER_WITHASYNC-NOT: async
// SPECIFIER_WITHASYNC: End completions

// SPECIFIER_WITHTHROWS: Begin completions
// SPECIFIER_WITHTHROWS-NOT: async
// SPECIFIER_WITHTHROWS-DAG: Keyword/None:               async; name=async
// SPECIFIER_WITHTHROWS-NOT: async
// SPECIFIER_WITHTHROWS: End completions

// SPECIFIER_WITHASYNCTHROWS-NOT: Begin completions

func testSpecifier() #^SPECIFIER^#
func testSpecifierWithAsync() async #^SPECIFIER_WITHASYNC^#
func testSpecifierWithThrows() throws #^SPECIFIER_WITHTHROWS^#
func testSpecifierWithAsyncThorws() async throws #^SPECIFIER_WITHASYNCTHROWS^#

func testTypeSpecifier(_: () #^TYPE_SPECIFICER?check=SPECIFIER^#) {}
func testTypeSpecifierWithAsync(_: () async #^TYPE_SPECIFICER_WITHASYNC?check=SPECIFIER_WITHASYNC^#) {}
func testTypeSpecifierWithThrows(_: () throws #^TYPE_SPECIFICER_WITHTHROWS?check=SPECIFIER_WITHTHROWS^#) {}
func testTypeSpecifierWithAsyncThrows(_: () async throws #^TYPE_SPECIFICER_WITHASYNCTHROWS?check=SPECIFIER_WITHASYNCTHROWS^#) {}
func testTypeSpecifierWithArrow(_: () #^TYPE_SPECIFICER_WITHARROW?check=SPECIFIER^#) {}
func testTypeSpecifierWithAsyncArrow(_: () async #^TYPE_SPECIFICER_WITHASYNCARROW?check=SPECIFIER_WITHASYNC^# -> Void) {}
func testTypeSpecifierWithThrowsArrow(_: () throws #^TYPE_SPECIFICER_WITHTHROWSARROW?check=SPECIFIER_WITHTHROWS^# -> Void
func testTypeSpecifierWithAsyncThrowsArrow(_: () async throws #^TYPE_SPECIFICER_WITHASYNCTHROWSARROW?check=SPECIFIER_WITHASYNCTHROWS^# -> Void) {}
