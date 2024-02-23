Grant Contract
This contract allows for the allocation and claiming of grants by users.

Overview
The Grant contract manages the allocation and claiming of grants. Users can allocate grants to themselves or other addresses, specifying the duration for which the grant is valid. After the specified duration has elapsed, the recipient can claim the allocated amount.

Usage
Allocation
To allocate a grant, use the allocateGrant function, specifying the recipient address and the duration for which the grant is valid. The function requires a non-zero value to be sent along with the transaction, which will be added to the grant amount.

Claiming
To claim a grant, use the claim function, specifying the allocation number of the grant to be claimed. The function will transfer the allocated amount to the caller if the grant has matured (i.e., the duration has elapsed).

Checking Allocations
You can check the allocated amount for a specific user and allocation number using the checkAllocations function.

Checking Maturity Time Left
You can check the time left for a grant to mature using the checkMaturityTimeLeft function. If the duration has elapsed, the function will return that the allocation has matured.

Events
allocationGranted: Fired when a grant is allocated.
allocationClaimed: Fired when a grant is claimed.
License
This project is licensed under the MIT License - see the LICENSE file for details.
