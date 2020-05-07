# Denies a tag

This policy denies a tag. This is useful in scenarios where you'd like to use tags to implement certain aspects of governance.

For example, perhaps you'd like implement a policy that enforces all Storage Account NetworkRuleSet defaultAction is set to deny except if a particular tag is present. To prevent everyone from applying this tag on their Storage Accounts, you need control deny this tag unless approval for the exception has been granted.