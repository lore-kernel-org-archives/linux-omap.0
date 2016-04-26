From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH arm 1/1] arm: Use _rcuidle tracepoint to allow use from
 idle
Date: Tue, 26 Apr 2016 12:47:37 -0700
Message-ID: <20160426194737.GM3715@linux.vnet.ibm.com>
References: <1461617335-22372-1-git-send-email-paulmck@linux.vnet.ibm.com>
 <20160426150031.GP5995@atomide.com>
 <20160426175214.GJ3715@linux.vnet.ibm.com>
 <20160426182939.GO5995@atomide.com>
 <20160426190755.GK3715@linux.vnet.ibm.com>
 <20160426193949.GP5995@atomide.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160426193949.GP5995@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, Russell King <linux@arm.linux.org.uk>, Steven Rostedt <rostedt@goodmis.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, Apr 26, 2016 at 12:39:50PM -0700, Tony Lindgren wrote:
> * Paul E. McKenney <paulmck@linux.vnet.ibm.com> [160426 12:08]:
> > On Tue, Apr 26, 2016 at 11:29:39AM -0700, Tony Lindgren wrote:
> > > * Paul E. McKenney <paulmck@linux.vnet.ibm.com> [160426 10:53]:
> > > > Does the following patch help?
> > > 
> > > It just changes the output.. See below.
> > 
> > Ah -- you need both patches.
> 
> Oops sorry, I though I had the first one already from next..
> 
> > These are on -rcu at:
> > 
> > 501889db6fee (arm: Use _rcuidle tracepoint to allow use from idle)
> > 99cd56ad86d2 (rm: Use more _rcuidle tracepoints to allow use from idle)
> 
> With these omap4 is now OK. But omap3 produces yet another warning,
> See below :)

As Steven Rostedt said, whack-a-mole time...

The previous two patches are still needed.

							Thanx, Paul

------------------------------------------------------------------------

commit c7ab21af6d959e3541ea52427472fc5dece75023
Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Date:   Tue Apr 26 12:43:57 2016 -0700

    arm: Additional _rcuidle tracepoints to allow use from idle
    
    This commit adds an _rcuidle suffix to a pair of trace events to
    prevent the following splat:
    
    > ===============================
    > [ INFO: suspicious RCU usage. ]
    > 4.6.0-rc5-next-20160426+ #1114 Not tainted
    > -------------------------------
    > include/trace/events/clk.h:59 suspicious rcu_dereference_check() usage!
    >
    > other info that might help us debug this:
    >
    >
    > RCU used illegally from idle CPU!
    > rcu_scheduler_active = 1, debug_locks = 0
    > RCU used illegally from extended quiescent state!
    > 2 locks held by swapper/0/0:
    >  #0:  (&oh->hwmod_key#30){......}, at: [<c0121b40>] omap_hwmod_idle+0x18/0x44
    >  #1:  (enable_lock){......}, at: [<c0630998>] clk_enable_lock+0x18/0x124
    >
    > stack backtrace:
    > CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.6.0-rc5-next-20160426+ #1114
    > Hardware name: Generic OMAP36xx (Flattened Device Tree)
    > [<c0110290>] (unwind_backtrace) from [<c010c3a8>] (show_stack+0x10/0x14)
    > [<c010c3a8>] (show_stack) from [<c047fd68>] (dump_stack+0xb0/0xe4)
    > [<c047fd68>] (dump_stack) from [<c0631618>] (clk_core_disable+0x17c/0x348)
    > [<c0631618>] (clk_core_disable) from [<c0632774>] (clk_disable+0x24/0x30)
    > [<c0632774>] (clk_disable) from [<c0120590>] (_disable_clocks+0x18/0x7c)
    > [<c0120590>] (_disable_clocks) from [<c0121680>] (_idle+0x12c/0x230)
    > [<c0121680>] (_idle) from [<c0121b4c>] (omap_hwmod_idle+0x24/0x44)
    > [<c0121b4c>] (omap_hwmod_idle) from [<c0122c24>] (omap_device_idle+0x3c/0x90)
    > [<c0122c24>] (omap_device_idle) from [<c052cc00>] (__rpm_callback+0x2c/0x60)
    > [<c052cc00>] (__rpm_callback) from [<c052cc54>] (rpm_callback+0x20/0x80)
    > [<c052cc54>] (rpm_callback) from [<c052d150>] (rpm_suspend+0x100/0x768)
    > [<c052d150>] (rpm_suspend) from [<c052ec58>] (__pm_runtime_suspend+0x64/0x84)
    > [<c052ec58>] (__pm_runtime_suspend) from [<c04bf25c>] (omap2_gpio_prepare_for_idle+0x5
    > c/0x70)
    > [<c04bf25c>] (omap2_gpio_prepare_for_idle) from [<c0125568>] (omap_sram_idle+0x140/0x2
    > 44)
    > [<c0125568>] (omap_sram_idle) from [<c01269dc>] (omap3_enter_idle_bm+0xfc/0x1ec)
    > [<c01269dc>] (omap3_enter_idle_bm) from [<c0601bdc>] (cpuidle_enter_state+0x80/0x3d4)
    > [<c0601bdc>] (cpuidle_enter_state) from [<c0183b08>] (cpu_startup_entry+0x198/0x3a0)
    > [<c0183b08>] (cpu_startup_entry) from [<c0b00c0c>] (start_kernel+0x354/0x3c8)
    > [<c0b00c0c>] (start_kernel) from [<8000807c>] (0x8000807c)
    
    Reported-by: Tony Lindgren <tony@atomide.com>
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
    Cc: Tony Lindgren <tony@atomide.com>
    Cc: Russell King <linux@arm.linux.org.uk>
    Cc: Steven Rostedt <rostedt@goodmis.org>
    Cc: <linux-omap@vger.kernel.org>
    Cc: <linux-arm-kernel@lists.infradead.org>

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index fb74dc1f7520..4fa43c02d682 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -682,12 +682,12 @@ static void clk_core_disable(struct clk_core *core)
 	if (--core->enable_count > 0)
 		return;
 
-	trace_clk_disable(core);
+	trace_clk_disable_rcuidle(core);
 
 	if (core->ops->disable)
 		core->ops->disable(core->hw);
 
-	trace_clk_disable_complete(core);
+	trace_clk_disable_complete_rcuidle(core);
 
 	clk_core_disable(core->parent);
 }
