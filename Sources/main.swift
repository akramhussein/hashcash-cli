import Foundation
import Hashcash
import CommandLineKit

let cli = CommandLineKit.CommandLine()

// Operations

enum Operation: String {
  case create  = "create"
  case validate  = "validate"
}

let op = EnumOption<Operation>(shortFlag: "o",
								longFlag: "operation",
								required: true,
  							 helpMessage: "Hashcash operation - `create` or `validate`.")

// Parameters

let bits = IntOption(shortFlag: "b",
					  longFlag: "bits",
					  required: true,
				   helpMessage: "Required collision bits.")

let resource = StringOption(shortFlag: "r",
					  longFlag: "resource",
					  required: false,
				   helpMessage: "Resource string for `create` (required) and stamp for `validate` (optional).")

let stamp = StringOption(shortFlag: "s",
					  	  longFlag: "stamp",
					  	  required: false,
				   	   helpMessage: "Stamp to validate.")

let timestamp = IntOption(shortFlag: "t",
					  	   longFlag: "timestamp",
					  	   required: false,
				   		helpMessage: "Check a timestamp for validity.")

cli.addOptions(op, bits, resource, stamp, timestamp)

do {
  try cli.parse()
} catch {
  cli.printUsage(error)
  exit(EX_USAGE)
}

let collisionBits = UInt(bits.value!)

switch op.value! {
	case .create:
		guard let r = resource.value else {
			print("Resource required to mint stamp")
			exit(EX_USAGE)
		}

		if let stamp = mint(resource: resource.value!, bits: collisionBits) {
			print(stamp)
		} else {
			print("Unable to mint stamp")
			exit(EX_USAGE)
		}
	case .validate:
		guard let s = stamp.value else {
			print("Stamp required to validate")
			exit(EX_USAGE)
		}

		if let ts = timestamp.value {
			print(check(stamp: s, resource: resource.value, bits: collisionBits, expiration: UInt(ts)))
		} else {
			print(check(stamp: s, resource: resource.value, bits: collisionBits))
		}
}
