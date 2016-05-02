From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH omap 2/6] arm: Use more _rcuidle tracepoints to allow use from idle
Date: Mon,  2 May 2016 07:22:12 -0700
Message-ID: <1462198936-3496-2-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20160502142117.GA2911@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160502142117.GA2911@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: tony@atomide.com, mingo@kernel.org, linux@arm.linux.org.uk, rostedt@goodmis.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: linux-omap@vger.kernel.org

Further testing with false negatives suppressed by commit 293e2421fe25
("rcu: Remove superfluous versions of rcu_read_lock_sched_held()")
identified a few more unprotected uses of RCU from the idle loop.
Because RCU actively ignores idle-loop code (for energy-efficiency
reasons, among other things), using RCU from the idle loop can result
in too-short grace periods, in turn resulting in arbitrary misbehavior.

The resulting lockdep-RCU splats are as follows:

------------------------------------------------------------------------

===============================
[ INFO: suspicious RCU usage. ]
4.6.0-rc5-next-20160426+ #1112 Not tainted
-------------------------------
include/trace/events/ipi.h:35 suspicious rcu_dereference_check() usage!

other info that might help us debug this:

RCU used illegally from idle CPU!
rcu_scheduler_active = 1, debug_locks = 0
RCU used illegally from extended quiescent state!
no locks held by swapper/0/0.

stack backtrace:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.6.0-rc5-next-20160426+ #1112
Hardware name: Generic OMAP4 (Flattened Device Tree)
[<c0110308>] (unwind_backtrace) from [<c010c3a8>] (show_stack+0x10/0x14)
[<c010c3a8>] (show_stack) from [<c047fec8>] (dump_stack+0xb0/0xe4)
[<c047fec8>] (dump_stack) from [<c010dcfc>] (smp_cross_call+0xbc/0x188)
[<c010dcfc>] (smp_cross_call) from [<c01c9e28>] (generic_exec_single+0x9c/0x15c)
[<c01c9e28>] (generic_exec_single) from [<c01ca0a0>] (smp_call_function_single_async+0 x38/0x9c)
[<c01ca0a0>] (smp_call_function_single_async) from [<c0603728>] (cpuidle_coupled_poke_others+0x8c/0xa8)
[<c0603728>] (cpuidle_coupled_poke_others) from [<c0603c10>] (cpuidle_enter_state_coupled+0x26c/0x390)
[<c0603c10>] (cpuidle_enter_state_coupled) from [<c0183c74>] (cpu_startup_entry+0x198/0x3a0)
[<c0183c74>] (cpu_startup_entry) from [<c0b00c0c>] (start_kernel+0x354/0x3c8)
[<c0b00c0c>] (start_kernel) from [<8000807c>] (0x8000807c)

------------------------------------------------------------------------

Warning from omap3
===============================
[ INFO: suspicious RCU usage. ]
4.6.0-rc5-next-20160426+ #1112 Not tainted
-------------------------------
include/trace/events/rpm.h:63 suspicious rcu_dereference_check() usage!

other info that might help us debug this:

RCU used illegally from idle CPU!
rcu_scheduler_active = 1, debug_locks = 0
RCU used illegally from extended quiescent state!
1 lock held by swapper/0/0:
 #0:  (&(&dev->power.lock)->rlock){-.-...}, at: [<c052ee24>] __pm_runtime_suspend+0x54/0x84

stack backtrace:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.6.0-rc5-next-20160426+ #1112
Hardware name: Generic OMAP36xx (Flattened Device Tree)
[<c0110308>] (unwind_backtrace) from [<c010c3a8>] (show_stack+0x10/0x14)
[<c010c3a8>] (show_stack) from [<c047fec8>] (dump_stack+0xb0/0xe4)
[<c047fec8>] (dump_stack) from [<c052d7b4>] (rpm_suspend+0x604/0x7e4)
[<c052d7b4>] (rpm_suspend) from [<c052ee34>] (__pm_runtime_suspend+0x64/0x84)
[<c052ee34>] (__pm_runtime_suspend) from [<c04bf3bc>] (omap2_gpio_prepare_for_idle+0x5c/0x70)
[<c04bf3bc>] (omap2_gpio_prepare_for_idle) from [<c01255e8>] (omap_sram_idle+0x140/0x244)
[<c01255e8>] (omap_sram_idle) from [<c0126b48>] (omap3_enter_idle_bm+0xfc/0x1ec)
[<c0126b48>] (omap3_enter_idle_bm) from [<c0601db8>] (cpuidle_enter_state+0x80/0x3d4)
[<c0601db8>] (cpuidle_enter_state) from [<c0183c74>] (cpu_startup_entry+0x198/0x3a0)
[<c0183c74>] (cpu_startup_entry) from [<c0b00c0c>] (start_kernel+0x354/0x3c8)
[<c0b00c0c>] (start_kernel) from [<8000807c>] (0x8000807c)

------------------------------------------------------------------------

Reported-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Tested-by: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: <linux-omap@vger.kernel.org>
Cc: <linux-arm-kernel@lists.infradead.org>
---
 arch/arm/kernel/smp.c        | 2 +-
 drivers/base/power/runtime.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index baee70267f29..7afe48ae5d76 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -486,7 +486,7 @@ static const char *ipi_types[NR_IPI] __tracepoint_string = {
 
 static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
 {
-	trace_ipi_raise(target, ipi_types[ipinr]);
+	trace_ipi_raise_rcuidle(target, ipi_types[ipinr]);
 	__smp_cross_call(target, ipinr);
 }
 
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 4c7055009bd6..ad115568ce58 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -419,7 +419,7 @@ static int rpm_suspend(struct device *dev, int rpmflags)
 	struct device *parent = NULL;
 	int retval;
 
-	trace_rpm_suspend(dev, rpmflags);
+	trace_rpm_suspend_rcuidle(dev, rpmflags);
 
  repeat:
 	retval = rpm_check_suspend_allowed(dev);
@@ -549,7 +549,7 @@ static int rpm_suspend(struct device *dev, int rpmflags)
 	}
 
  out:
-	trace_rpm_return_int(dev, _THIS_IP_, retval);
+	trace_rpm_return_int_rcuidle(dev, _THIS_IP_, retval);
 
 	return retval;
 
-- 
2.5.2
