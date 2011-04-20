From: Kevin Hilman <khilman@ti.com>
Subject: Re: [linux-pm] [RFC PATCH V3 1/4] cpuidle: Move dev->last_residency update to driver	enter routine; remove dev->last_state
Date: Wed, 20 Apr 2011 10:27:15 -0700
Message-ID: <87pqog6dfw.fsf@ti.com>
References: <20110420065445.332.13688.stgit@tringupt.in.ibm.com>
	<20110420065523.332.58678.stgit@tringupt.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20110420065523.332.58678.stgit@tringupt.in.ibm.com> (Trinabh
	Gupta's message of "Wed, 20 Apr 2011 12:25:34 +0530")
Sender: linux-acpi-owner@vger.kernel.org
To: Trinabh Gupta <trinabh@linux.vnet.ibm.com>
Cc: arjan@linux.intel.com, peterz@infradead.org, lenb@kernel.org, venki@google.com, ak@linux.intel.com, len.brown@intel.com, davinci-linux-open-source@linux.davincidsp.com, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Trinabh Gupta <trinabh@linux.vnet.ibm.com> writes:

> Cpuidle subsystem only suggests the state to enter and does not
> guarantee if the suggested state is entered. The actual entered state
> may be different because of software or hardware demotion. Software
> demotion is done by the back-end cpuidle driver and can be accounted
> correctly. Current cpuidle code uses last_state field to capture the
> actual state entered and based on that updates the statistics for the
> state entered.
>
> Ideally the driver enter routine should update the counters,
> and it should return the state actually entered rather than the time
> spent there. 

OK, the return type was changed to return the state index instead of the
time, but since the governors are still relying on dev->last_residency,
drivers are required to update it.

Because of that, why not keep the update of the  time/usage counters
in common code rather than duplicating it (9 times in this patch) into 
all the drivers?

Something like the patch below should suffice.

Kevin


diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 845d3ef..875d241 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -91,6 +91,11 @@ static void cpuidle_idle_call(void)
 
 	entered_state = target_state->enter(dev, drv, next_state);
 
+	/* Update cpuidle counters */
+	dev->states_usage[entered_state].time += 
+		(unsigned long long)dev->last_residency;
+	dev->states_usage[entered_state].usage++;
+
 	trace_power_end(dev->cpu);
 	trace_cpu_idle(PWR_EVENT_EXIT, dev->cpu);
 
