(*
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 *)

open! IStd

val buck_config : BuckMode.t -> string list

val parse_command_and_targets :
     BuckMode.t
  -> filter_kind:[< `Yes | `No | `Auto]
  -> string list
  -> string * string list * string list

type flavored_arguments = {command: string; rev_not_targets: string list; targets: string list}

val add_flavors_to_buck_arguments :
     BuckMode.t
  -> filter_kind:[< `Yes | `No | `Auto]
  -> extra_flavors:string list
  -> string list
  -> flavored_arguments
(** Add infer flavors to the targets in the given buck arguments, depending on the infer analyzer.
    For instance, in capture mode, the buck command: build //foo/bar:baz#some,flavor becomes: build
    //foo/bar:baz#infer-capture-all,some,flavor *)

val store_args_in_file : string list -> string list
(** Given a list of arguments, stores them in a file if needed and returns the new command line *)

val filter_compatible : [> `Targets] -> string list -> string list
(** keep only the options compatible with the given Buck subcommand *)

val clang_flavor_capture : prog:string -> buck_build_cmd:string list -> unit
(** do a buck/clang flavor capture given the prog and build command (buck args) *)
