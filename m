From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH omap 4/6] arm: Whack another event-trace-from-idle mole
Date: Mon,  2 May 2016 07:22:14 -0700
Message-ID: <1462198936-3496-4-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20160502142117.GA2911@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160502142117.GA2911@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: tony@atomide.com, mingo@kernel.org, linux@arm.linux.org.uk, rostedt@goodmis.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: linux-omap@vger.kernel.org

This commit appends a few _rcuidle suffixes to fix the following
RCU-used-from-idle bug:

> ===============================
> [ INFO: suspicious RCU usage. ]
> 4.6.0-rc5-next-20160426+ #1116 Not tainted
> -------------------------------
> include/trace/events/rpm.h:95 suspicious rcu_dereference_check() usage!
>
> other info that might help us debug this:
>
>
> RCU used illegally from idle CPU!
> rcu_scheduler_active = 1, debug_locks = 0
> RCU used illegally from extended quiescent state!
> 1 lock held by swapper/0/0:
>  #0:  (&(&dev->power.lock)->rlock){-.-...}, at: [<c052cc2c>] __rpm_callback+0x58/0x60
>
> stack backtrace:
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.6.0-rc5-next-20160426+ #1116
> Hardware name: Generic OMAP36xx (Flattened Device Tree)
> [<c0110290>] (unwind_backtrace) from [<c010c3a8>] (show_stack+0x10/0x14)
> [<c010c3a8>] (show_stack) from [<c047fd68>] (dump_stack+0xb0/0xe4)
> [<c047fd68>] (dump_stack) from [<c052d5d0>] (rpm_suspend+0x580/0x768)
> [<c052d5d0>] (rpm_suspend) from [<c052ec58>] (__pm_runtime_suspend+0x64/0x84)
> [<c052ec58>] (__pm_runtime_suspend) from [<c04bf25c>] (omap2_gpio_prepare_for_idle+0x5c/0x70)
> [<c04bf25c>] (omap2_gpio_prepare_for_idle) from [<c0125568>] (omap_sram_idle+0x140/0x244)
> [<c0125568>] (omap_sram_idle) from [<c01269dc>] (omap3_enter_idle_bm+0xfc/0x1ec)
> [<c01269dc>] (omap3_enter_idle_bm) from [<c0601bdc>] (cpuidle_enter_state+0x80/0x3d4)
> [<c0601bdc>] (cpuidle_enter_state) from [<c0183b08>] (cpu_startup_entry+0x198/0x3a0)
> [<c0183b08>] (cpu_startup_entry) from [<c0b00c0c>] (start_kernel+0x354/0x3c8)
> [<c0b00c0c>] (start_kernel) from [<8000807c>] (0x8000807c)

In the immortal words of Steven Rostedt, "*Whack* *Whack* *Whack*!!!"

Reported-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Tested-by: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@arm.linux.org.uk>
WhACKED-by: Steven Rostedt <rostedt@goodmis.org>
Cc: <linux-omap@vger.kernel.org>
Cc: <linux-arm-kernel@lists.infradead.org>
---
 drivers/base/power/runtime.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index ad115568ce58..e4c2b8fdeff3 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -301,7 +301,7 @@ static int rpm_idle(struct device *dev, int rpmflags)
 	int (*callback)(struct device *);
 	int retval;
 
-	trace_rpm_idle(dev, rpmflags);
+	trace_rpm_idle_rcuidle(dev, rpmflags);
 	retval = rpm_check_suspend_allowed(dev);
 	if (retval < 0)
 		;	/* Conditions are wrong. */
@@ -337,7 +337,7 @@ static int rpm_idle(struct device *dev, int rpmflags)
 			dev->power.request_pending = true;
 			queue_work(pm_wq, &dev->power.work);
 		}
-		trace_rpm_return_int(dev, _THIS_IP_, 0);
+		trace_rpm_return_int_rcuidle(dev, _THIS_IP_, 0);
 		return 0;
 	}
 
@@ -352,7 +352,7 @@ static int rpm_idle(struct device *dev, int rpmflags)
 	wake_up_all(&dev->power.wait_queue);
 
  out:
-	trace_rpm_return_int(dev, _THIS_IP_, retval);
+	trace_rpm_return_int_rcuidle(dev, _THIS_IP_, retval);
 	return retval ? retval : rpm_suspend(dev, rpmflags | RPM_AUTO);
 }
 
-- 
2.5.2
