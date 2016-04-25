From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH arm 1/1] arm: Use _rcuidle tracepoint to allow use from idle
Date: Mon, 25 Apr 2016 13:48:55 -0700
Message-ID: <1461617335-22372-1-git-send-email-paulmck@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Steven Rostedt <rostedt@goodmis.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Testing on ARM encountered the following pair of lockdep-RCU splats:

------------------------------------------------------------------------

===============================
[ INFO: suspicious RCU usage. ]
4.6.0-rc4-next-20160422 #1 Not tainted
-------------------------------
include/trace/events/power.h:328 suspicious rcu_dereference_check() usage!

other info that might help us debug this:

RCU used illegally from idle CPU!
rcu_scheduler_active = 1, debug_locks = 0
RCU used illegally from extended quiescent state!
no locks held by swapper/0/0.

stack backtrace:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.6.0-rc4-next-20160422 #1
Hardware name: Generic OMAP3-GP (Flattened Device Tree)
[<c010f55c>] (unwind_backtrace) from [<c010b64c>] (show_stack+0x10/0x14)
[<c010b64c>] (show_stack) from [<c047acbc>] (dump_stack+0xa8/0xe0)
[<c047acbc>] (dump_stack) from [<c012bc10>] (pwrdm_set_next_pwrst+0xf8/0x1cc)
[<c012bc10>] (pwrdm_set_next_pwrst) from [<c01269fc>] (omap3_enter_idle_bm+0x1b8/0x1e8)
[<c01269fc>] (omap3_enter_idle_bm) from [<c05fa0b8>] (cpuidle_enter_state+0x84/0x408)
[<c05fa0b8>] (cpuidle_enter_state) from [<c0182c1c>] (cpu_startup_entry+0x1c8/0x3f0)
[<c0182c1c>] (cpu_startup_entry) from [<c0b00c20>] (start_kernel+0x354/0x3cc)

------------------------------------------------------------------------

[<c010f55c>] (unwind_backtrace) from [<c010b64c>] (show_stack+0x10/0x14)
[<c010b64c>] (show_stack) from [<c047ac3c>] (dump_stack+0xa8/0xe0)
[<c047ac3c>] (dump_stack) from [<c012c340>] (_pwrdm_state_switch+0x188/0x32c)
[<c012c340>] (_pwrdm_state_switch) from [<c012c4f0>] (_pwrdm_post_transition_cb+0xc/0x14)
[<c012c4f0>] (_pwrdm_post_transition_cb) from [<c012ba74>] (pwrdm_for_each+0x30/0x5c)
[<c012ba74>] (pwrdm_for_each) from [<c012c72c>] (pwrdm_post_transition+0x24/0x30)
[<c012c72c>] (pwrdm_post_transition) from [<c012548c>] (omap_sram_idle+0xfc/0x240)
[<c012548c>] (omap_sram_idle) from [<c0126934>] (omap3_enter_idle_bm+0xf0/0x1e8)
[<c0126934>] (omap3_enter_idle_bm) from [<c05fa038>] (cpuidle_enter_state+0x84/0x408)
[<c05fa038>] (cpuidle_enter_state) from [<c0182b90>] (cpu_startup_entry+0x1c8/0x3f0)
[<c0182b90>] (cpu_startup_entry) from [<c0b00c20>] (start_kernel+0x354/0x3cc)

------------------------------------------------------------------------

These are caused by event tracing from the idle loop.  This commit
therefore adds the _rcuidle suffix to make RCU aware of this implicit
use of RCU by event tracing, thus preventing both splats.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: <linux-omap@vger.kernel.org>
Cc: <linux-arm-kernel@lists.infradead.org>
---
 arch/arm/mach-omap2/powerdomain.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 78af6d8cf2e2..daf2753de7aa 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -186,8 +186,9 @@ static int _pwrdm_state_switch(struct powerdomain *pwrdm, int flag)
 			trace_state = (PWRDM_TRACE_STATES_FLAG |
 				       ((next & OMAP_POWERSTATE_MASK) << 8) |
 				       ((prev & OMAP_POWERSTATE_MASK) << 0));
-			trace_power_domain_target(pwrdm->name, trace_state,
-						  smp_processor_id());
+			trace_power_domain_target_rcuidle(pwrdm->name,
+							  trace_state,
+							  smp_processor_id());
 		}
 		break;
 	default:
@@ -523,8 +524,8 @@ int pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
 
 	if (arch_pwrdm && arch_pwrdm->pwrdm_set_next_pwrst) {
 		/* Trace the pwrdm desired target state */
-		trace_power_domain_target(pwrdm->name, pwrst,
-					  smp_processor_id());
+		trace_power_domain_target_rcuidle(pwrdm->name, pwrst,
+						  smp_processor_id());
 		/* Program the pwrdm desired target state */
 		ret = arch_pwrdm->pwrdm_set_next_pwrst(pwrdm, pwrst);
 	}
-- 
2.5.2
