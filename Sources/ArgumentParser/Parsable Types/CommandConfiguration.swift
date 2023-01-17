//===----------------------------------------------------------*- swift -*-===//
//
// This source file is part of the Swift Argument Parser open source project
//
// Copyright (c) 2020 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
//
//===----------------------------------------------------------------------===//

/// The configuration for a command.
public struct CommandConfiguration {
  /// The name of the command to use on the command line.
  ///
  /// If `nil`, the command name is derived by converting the name of
  /// the command type to hyphen-separated lowercase words.
  public var commandName: String?

  /// The name of this command's "super-command". (experimental)
  ///
  /// Use this when a command is part of a group of commands that are installed
  /// with a common dash-prefix, like `git`'s and `swift`'s constellation of
  /// independent commands.
  public var _superCommandName: String?
  
  /// A one-line description of this command.
  public var abstract: String
  
  /// A customized usage string to be shown in the help display and error
  /// messages.
  ///
  /// If `usage` is `nil`, the help display and errors show the autogenerated
  /// usage string. To hide the usage string entirely, set `usage` to the empty
  /// string.
  public var usage: String?

  /// A longer description of this command, to be shown in the extended help
  /// display.
  public var discussion: String
  
  /// Version information for this command.
  public var version: String

  /// A Boolean value indicating whether this command should be shown in
  /// the extended help display.
  public var shouldDisplay: Bool
  
  /// An array of the types that define subcommands for this command.
  public var subcommands: [ParsableCommand.Type]
  
  /// The default command type to run if no subcommand is given.
  public var defaultSubcommand: ParsableCommand.Type?
  
  /// Flag names to be used for help.
  public var helpNames: NameSpecification?
  
  /// Number of spaces to use as indentation in the help message
  public var helpMessageIndent: Int = 2
  
  /// The width (in characters) of the left argument label column in the help message
  public var helpMessageLabelColumnWidth: Int = 26
  
  /// A Boolean value indicating whether the options in the usage string
  /// should always be shown in a compact form
  public var alwaysCompactUsageOptions: Bool
  
  public struct Example {
    var arguments: String
    var description: String
    public static func example(arguments: String, description: String = "") -> Self {
      return Self(arguments: arguments, description: description)
    }
  }
  /// An array of examples to show in the examples section of the help message
  public var examples: [Example]
  
  /// Creates the configuration for a command.
  ///
  /// - Parameters:
  ///   - commandName: The name of the command to use on the command line. If
  ///     `commandName` is `nil`, the command name is derived by converting
  ///     the name of the command type to hyphen-separated lowercase words.
  ///   - abstract: A one-line description of the command.
  ///   - usage: A custom usage description for the command. When you provide
  ///     a non-`nil` string, the argument parser uses `usage` instead of
  ///     automatically generating a usage description. Passing an empty string
  ///     hides the usage string altogether.
  ///   - discussion: A longer description of the command.
  ///   - version: The version number for this command. When you provide a
  ///     non-empty string, the argument parser prints it if the user provides
  ///     a `--version` flag.
  ///   - shouldDisplay: A Boolean value indicating whether the command
  ///     should be shown in the extended help display.
  ///   - subcommands: An array of the types that define subcommands for the
  ///     command.
  ///   - defaultSubcommand: The default command type to run if no subcommand
  ///     is given.
  ///   - helpNames: The flag names to use for requesting help, when combined
  ///     with a simulated Boolean property named `help`. If `helpNames` is
  ///     `nil`, the names are inherited from the parent command, if any, or
  ///     are `-h` and `--help`.
  public init(
    commandName: String? = nil,
    abstract: String = "",
    usage: String? = nil,
    discussion: String = "",
    version: String = "",
    shouldDisplay: Bool = true,
    subcommands: [ParsableCommand.Type] = [],
    defaultSubcommand: ParsableCommand.Type? = nil,
    helpNames: NameSpecification? = nil,
    helpMessageIndent: Int? = nil,
    helpMessageLabelColumnWidth: Int? = nil,
    alwaysCompactUsageOptions: Bool = false,
    examples: [Example] = []
  ) {
    self.commandName = commandName
    self.abstract = abstract
    self.usage = usage
    self.discussion = discussion
    self.version = version
    self.shouldDisplay = shouldDisplay
    self.subcommands = subcommands
    self.defaultSubcommand = defaultSubcommand
    self.helpNames = helpNames
    if let helpMessageIndent = helpMessageIndent { self.helpMessageIndent = helpMessageIndent }
    if let helpMessageLabelColumnWidth = helpMessageLabelColumnWidth { self.helpMessageLabelColumnWidth = helpMessageLabelColumnWidth }
    self.alwaysCompactUsageOptions = alwaysCompactUsageOptions
    self.examples = examples
  }

  /// Creates the configuration for a command with a "super-command".
  /// (experimental)
  public init(
    commandName: String? = nil,
    _superCommandName: String,
    abstract: String = "",
    usage: String? = nil,
    discussion: String = "",
    version: String = "",
    shouldDisplay: Bool = true,
    subcommands: [ParsableCommand.Type] = [],
    defaultSubcommand: ParsableCommand.Type? = nil,
    helpNames: NameSpecification? = nil,
    helpMessageIndent: Int? = nil,
    helpMessageLabelColumnWidth: Int? = nil,
    alwaysCompactUsageOptions: Bool = false,
    examples: [Example] = []
  ) {
    self.commandName = commandName
    self._superCommandName = _superCommandName
    self.abstract = abstract
    self.usage = usage
    self.discussion = discussion
    self.version = version
    self.shouldDisplay = shouldDisplay
    self.subcommands = subcommands
    self.defaultSubcommand = defaultSubcommand
    self.helpNames = helpNames
    if let helpMessageIndent = helpMessageIndent { self.helpMessageIndent = helpMessageIndent }
    if let helpMessageLabelColumnWidth = helpMessageLabelColumnWidth { self.helpMessageLabelColumnWidth = helpMessageLabelColumnWidth }
    self.alwaysCompactUsageOptions = alwaysCompactUsageOptions
    self.examples = examples
  }
}

extension CommandConfiguration {
  @available(*, deprecated, message: "Use the memberwise initializer with the usage parameter.")
  public init(
    commandName: String?,
    abstract: String,
    discussion: String,
    version: String,
    shouldDisplay: Bool,
    subcommands: [ParsableCommand.Type],
    defaultSubcommand: ParsableCommand.Type?,
    helpNames: NameSpecification?,
    helpMessageIndent: Int?,
    helpMessageLabelColumnWidth: Int?,
    alwaysCompactUsageOptions: Bool = false,
    examples: [Example]
  ) {
    self.init(
      commandName: commandName,
      abstract: abstract,
      usage: "",
      discussion: discussion,
      version: version,
      shouldDisplay: shouldDisplay,
      subcommands: subcommands,
      defaultSubcommand: defaultSubcommand,
      helpNames: helpNames,
      helpMessageIndent: helpMessageIndent,
      helpMessageLabelColumnWidth: helpMessageLabelColumnWidth,
      alwaysCompactUsageOptions: alwaysCompactUsageOptions,
      examples: examples)
  }
}
