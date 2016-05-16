From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH v2 omap 5/6] arm: Add _rcuidle suffix to allow rpm_resume() to
 be called from idle
Date: Mon, 16 May 2016 11:50:07 -0700
Message-ID: <1463424608-20237-5-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20160516184844.GA20144@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160516184844.GA20144@linux.vnet.ibm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-clk@vger.kernel.org
Cc: Russell King <linux@arm.linux.org.uk>, tony@atomide.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, rostedt@goodmis.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, mingo@kernel.org, linux@roeck-us.net
List-Id: linux-omap@vger.kernel.org

This commit applies another _rcuidle suffix to fix an RCU use from
idle.

> ===============================
> [ INFO: suspicious RCU usage. ]
> 4.6.0-rc5-next-20160426+ #1122 Not tainted
> -------------------------------
> include/trace/events/rpm.h:69 suspicious rcu_dereference_check() usage!
>
> other info that might help us debug this:
>
>
> RCU used illegally from idle CPU!
> rcu_scheduler_active = 1, debug_locks = 0
> RCU used illegally from extended quiescent state!
> 1 lock held by swapper/0/0:
>  #0:  (&(&dev->power.lock)->rlock){-.-...}, at: [<c052e3dc>] __pm_runtime_resume+0x3c/0x64
>
> stack backtrace:
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.6.0-rc5-next-20160426+ #1122
> Hardware name: Generic OMAP36xx (Flattened Device Tree)
> [<c0110290>] (unwind_backtrace) from [<c010c3a8>] (show_stack+0x10/0x14)
> [<c010c3a8>] (show_stack) from [<c047fd68>] (dump_stack+0xb0/0xe4)
> [<c047fd68>] (dump_stack) from [<c052e178>] (rpm_resume+0x5cc/0x7f4)
> [<c052e178>] (rpm_resume) from [<c052e3ec>] (__pm_runtime_resume+0x4c/0x64)
> [<c052e3ec>] (__pm_runtime_resume) from [<c04bf2c4>] (omap2_gpio_resume_after_idle+0x54/0x68)
> [<c04bf2c4>] (omap2_gpio_resume_after_idle) from [<c01269dc>] (omap3_enter_idle_bm+0xfc/0x1ec)
> [<c01269dc>] (omap3_enter_idle_bm) from [<c060198c>] (cpuidle_enter_state+0x80/0x3d4)
> [<c060198c>] (cpuidle_enter_state) from [<c0183b08>] (cpu_startup_entry+0x198/0x3a0)
> [<c0183b08>] (cpu_startup_entry) from [<c0b00c0c>] (start_kernel+0x354/0x3c8)
> [<c0b00c0c>] (start_kernel) from [<8000807c>] (0x8000807c)

Reported-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Tested-by: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: <linux-omap@vger.kernel.org>
Cc: <linux-arm-kernel@lists.infradead.org>
Cc: <linux-pm@vger.kernel.org>
---
 drivers/base/power/runtime.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index e4c2b8fdeff3..15b6d5b199d4 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -601,7 +601,7 @@ static int rpm_resume(struct device *dev, int rpmflags)
 	struct device *parent = NULL;
 	int retval = 0;
 
-	trace_rpm_resume(dev, rpmflags);
+	trace_rpm_resume_rcuidle(dev, rpmflags);
 
  repeat:
 	if (dev->power.runtime_error)
@@ -764,7 +764,7 @@ static int rpm_resume(struct device *dev, int rpmflags)
 		spin_lock_irq(&dev->power.lock);
 	}
 
-	trace_rpm_return_int(dev, _THIS_IP_, retval);
+	trace_rpm_return_int_rcuidle(dev, _THIS_IP_, retval);
 
 	return retval;
 }
-- 
2.5.2
