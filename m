From: Trinabh Gupta <trinabh@linux.vnet.ibm.com>
Subject: Re: [linux-pm] [RFC PATCH V3 1/4] cpuidle: Move dev->last_residency
 update to driver	enter routine; remove dev->last_state
Date: Thu, 21 Apr 2011 10:12:59 +0530
Message-ID: <4DAFB5D3.1030804@linux.vnet.ibm.com>
References: <20110420065445.332.13688.stgit@tringupt.in.ibm.com> <20110420065523.332.58678.stgit@tringupt.in.ibm.com> <87pqog6dfw.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <87pqog6dfw.fsf@ti.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: arjan@linux.intel.com, peterz@infradead.org, lenb@kernel.org, venki@google.com, ak@linux.intel.com, len.brown@intel.com, davinci-linux-open-source@linux.davincidsp.com, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org



On 04/20/2011 10:57 PM, Kevin Hilman wrote:
> Trinabh Gupta<trinabh@linux.vnet.ibm.com>  writes:
>
>> Cpuidle subsystem only suggests the state to enter and does not
>> guarantee if the suggested state is entered. The actual entered state
>> may be different because of software or hardware demotion. Software
>> demotion is done by the back-end cpuidle driver and can be accounted
>> correctly. Current cpuidle code uses last_state field to capture the
>> actual state entered and based on that updates the statistics for the
>> state entered.
>>
>> Ideally the driver enter routine should update the counters,
>> and it should return the state actually entered rather than the time
>> spent there.
>
> OK, the return type was changed to return the state index instead of the
> time, but since the governors are still relying on dev->last_residency,
> drivers are required to update it.
>
> Because of that, why not keep the update of the  time/usage counters
> in common code rather than duplicating it (9 times in this patch) into
> all the drivers?

Hi Kevin,

Thanks for your review. Yes, we can do like this and it would prevent
duplication of code. I just wanted to make cpuidle handle only selection
and entering of state, and leave everything else to the driver which
knows best about these things.

But both are functionally same and definitely statistics update inside
cpuidle_idle_call() prevents duplication of code.

Thanks,
-Trinabh
