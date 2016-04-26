From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH arm 1/1] arm: Use _rcuidle tracepoint to allow use from
 idle
Date: Tue, 26 Apr 2016 10:52:14 -0700
Message-ID: <20160426175214.GJ3715@linux.vnet.ibm.com>
References: <1461617335-22372-1-git-send-email-paulmck@linux.vnet.ibm.com>
 <20160426150031.GP5995@atomide.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160426150031.GP5995@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, Russell King <linux@arm.linux.org.uk>, Steven Rostedt <rostedt@goodmis.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, Apr 26, 2016 at 08:00:31AM -0700, Tony Lindgren wrote:
> Hi,
> 
> * Paul E. McKenney <paulmck@linux.vnet.ibm.com> [160425 13:49]:
> > Testing on ARM encountered the following pair of lockdep-RCU splats:
> > 
> > ------------------------------------------------------------------------
> > 
> > ===============================
> > [ INFO: suspicious RCU usage. ]
> > 4.6.0-rc4-next-20160422 #1 Not tainted
> > -------------------------------
> > include/trace/events/power.h:328 suspicious rcu_dereference_check() usage!
> > 
> > other info that might help us debug this:
> > 
> > RCU used illegally from idle CPU!
> > rcu_scheduler_active = 1, debug_locks = 0
> > RCU used illegally from extended quiescent state!
> > no locks held by swapper/0/0.
> > 
> > stack backtrace:
> > CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.6.0-rc4-next-20160422 #1
> > Hardware name: Generic OMAP3-GP (Flattened Device Tree)
> > [<c010f55c>] (unwind_backtrace) from [<c010b64c>] (show_stack+0x10/0x14)
> > [<c010b64c>] (show_stack) from [<c047acbc>] (dump_stack+0xa8/0xe0)
> > [<c047acbc>] (dump_stack) from [<c012bc10>] (pwrdm_set_next_pwrst+0xf8/0x1cc)
> > [<c012bc10>] (pwrdm_set_next_pwrst) from [<c01269fc>] (omap3_enter_idle_bm+0x1b8/0x1e8)
> > [<c01269fc>] (omap3_enter_idle_bm) from [<c05fa0b8>] (cpuidle_enter_state+0x84/0x408)
> > [<c05fa0b8>] (cpuidle_enter_state) from [<c0182c1c>] (cpu_startup_entry+0x1c8/0x3f0)
> > [<c0182c1c>] (cpu_startup_entry) from [<c0b00c20>] (start_kernel+0x354/0x3cc)
> > 
> > ------------------------------------------------------------------------
> > 
> > [<c010f55c>] (unwind_backtrace) from [<c010b64c>] (show_stack+0x10/0x14)
> > [<c010b64c>] (show_stack) from [<c047ac3c>] (dump_stack+0xa8/0xe0)
> > [<c047ac3c>] (dump_stack) from [<c012c340>] (_pwrdm_state_switch+0x188/0x32c)
> > [<c012c340>] (_pwrdm_state_switch) from [<c012c4f0>] (_pwrdm_post_transition_cb+0xc/0x14)
> > [<c012c4f0>] (_pwrdm_post_transition_cb) from [<c012ba74>] (pwrdm_for_each+0x30/0x5c)
> > [<c012ba74>] (pwrdm_for_each) from [<c012c72c>] (pwrdm_post_transition+0x24/0x30)
> > [<c012c72c>] (pwrdm_post_transition) from [<c012548c>] (omap_sram_idle+0xfc/0x240)
> > [<c012548c>] (omap_sram_idle) from [<c0126934>] (omap3_enter_idle_bm+0xf0/0x1e8)
> > [<c0126934>] (omap3_enter_idle_bm) from [<c05fa038>] (cpuidle_enter_state+0x84/0x408)
> > [<c05fa038>] (cpuidle_enter_state) from [<c0182b90>] (cpu_startup_entry+0x1c8/0x3f0)
> > [<c0182b90>] (cpu_startup_entry) from [<c0b00c20>] (start_kernel+0x354/0x3cc)
> > 
> > ------------------------------------------------------------------------
> > 
> > These are caused by event tracing from the idle loop.  This commit
> > therefore adds the _rcuidle suffix to make RCU aware of this implicit
> > use of RCU by event tracing, thus preventing both splats.
> 
> Maybe also mention which patch in the RCU tree caused these?

Or, more accurately, the patch that removed the false negatives that
suppressed them.  These lockdep-RCU splats were bugs all along, just
not reported.

> I'm still seeing the following warnings with next with your patch applied.

Does the following patch help?

It is quite possible that there are quite a few more of these.  If this
is the case, then one way to make the kernel list more of them on a
given boot is to build with CONFIG_PROVE_RCU_REPEATEDLY=y.

							Thanx, Paul

------------------------------------------------------------------------

commit 99cd56ad86d2d5fbe7ceab303b47f34e4156e5e7
Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Date:   Tue Apr 26 10:42:25 2016 -0700

    rm: Use more _rcuidle tracepoints to allow use from idle
    
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
    Cc: Tony Lindgren <tony@atomide.com>
    Cc: Russell King <linux@arm.linux.org.uk>
    Cc: Steven Rostedt <rostedt@goodmis.org>
    Cc: <linux-omap@vger.kernel.org>
    Cc: <linux-arm-kernel@lists.infradead.org>

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
index 4c7055009bd6..d9358c202763 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -419,7 +419,7 @@ static int rpm_suspend(struct device *dev, int rpmflags)
 	struct device *parent = NULL;
 	int retval;
 
-	trace_rpm_suspend(dev, rpmflags);
+	trace_rpm_suspend_rcuidle(dev, rpmflags);
 
  repeat:
 	retval = rpm_check_suspend_allowed(dev);
