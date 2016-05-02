From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH omap 6/6] arm: Whack an expected event-trace-from-idle mole
Date: Mon,  2 May 2016 07:22:16 -0700
Message-ID: <1462198936-3496-6-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20160502142117.GA2911@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160502142117.GA2911@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: tony@atomide.com, mingo@kernel.org, linux@arm.linux.org.uk, rostedt@goodmis.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: linux-omap@vger.kernel.org

This commit fixes the RCU use-from-idle bug corresponding the following
splat:

> [ INFO: suspicious RCU usage. ]
> 4.6.0-rc5-next-20160426+ #1127 Not tainted
> -------------------------------
> include/trace/events/clk.h:45 suspicious rcu_dereference_check() usage!
>
> other info that might help us debug this:
>
>
> RCU used illegally from idle CPU!
> rcu_scheduler_active = 1, debug_locks = 0
> RCU used illegally from extended quiescent state!
> 2 locks held by swapper/0/0:
>  #0:  (&oh->hwmod_key#30){......}, at: [<c0121afc>] omap_hwmod_enable+0x18/0x44
>  #1:  (enable_lock){......}, at: [<c0630684>] clk_enable_lock+0x18/0x124
>
> stack backtrace:
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.6.0-rc5-next-20160426+ #1127
> Hardware name: Generic OMAP36xx (Flattened Device Tree)
> [<c0110290>] (unwind_backtrace) from [<c010c3a8>] (show_stack+0x10/0x14)
> [<c010c3a8>] (show_stack) from [<c047fd68>] (dump_stack+0xb0/0xe4)
> [<c047fd68>] (dump_stack) from [<c06315c0>] (clk_core_enable+0x1e0/0x36c)
> [<c06315c0>] (clk_core_enable) from [<c0632298>] (clk_enable+0x1c/0x38)
> [<c0632298>] (clk_enable) from [<c01204e0>] (_enable_clocks+0x18/0x7c)
> [<c01204e0>] (_enable_clocks) from [<c012137c>] (_enable+0x114/0x2ec)
> [<c012137c>] (_enable) from [<c0121b08>] (omap_hwmod_enable+0x24/0x44)
> [<c0121b08>] (omap_hwmod_enable) from [<c0122ad0>] (omap_device_enable+0x3c/0x90)
> [<c0122ad0>] (omap_device_enable) from [<c0122b34>] (_od_runtime_resume+0x10/0x38)
> [<c0122b34>] (_od_runtime_resume) from [<c052cc00>] (__rpm_callback+0x2c/0x60)
> [<c052cc00>] (__rpm_callback) from [<c052cc54>] (rpm_callback+0x20/0x80)
> [<c052cc54>] (rpm_callback) from [<c052df7c>] (rpm_resume+0x3d0/0x6f0)
> [<c052df7c>] (rpm_resume) from [<c052e2e8>] (__pm_runtime_resume+0x4c/0x64)
> [<c052e2e8>] (__pm_runtime_resume) from [<c04bf2c4>] (omap2_gpio_resume_after_idle+0x54/0x68)
> [<c04bf2c4>] (omap2_gpio_resume_after_idle) from [<c01269dc>] (omap3_enter_idle_bm+0xfc/0x1ec)
> [<c01269dc>] (omap3_enter_idle_bm) from [<c0601888>] (cpuidle_enter_state+0x80/0x3d4)
> [<c0601888>] (cpuidle_enter_state) from [<c0183b08>] (cpu_startup_entry+0x198/0x3a0)
> [<c0183b08>] (cpu_startup_entry) from [<c0b00c0c>] (start_kernel+0x354/0x3c8)
> [<c0b00c0c>] (start_kernel) from [<8000807c>] (0x8000807c)

Reported-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Tested-by: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: <linux-omap@vger.kernel.org>
Cc: <linux-arm-kernel@lists.infradead.org>
---
 drivers/clk/clk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 4fa43c02d682..ec83f404c1d2 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -735,12 +735,12 @@ static int clk_core_enable(struct clk_core *core)
 		if (ret)
 			return ret;
 
-		trace_clk_enable(core);
+		trace_clk_enable_rcuidle(core);
 
 		if (core->ops->enable)
 			ret = core->ops->enable(core->hw);
 
-		trace_clk_enable_complete(core);
+		trace_clk_enable_complete_rcuidle(core);
 
 		if (ret) {
 			clk_core_disable(core->parent);
-- 
2.5.2
