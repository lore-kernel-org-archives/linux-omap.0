From: <grygorii.strashko@linaro.org>
Subject: [PATCH 1/3] PM / Sleep: Add macro to define common noirq system PM callbacks
Date: Mon, 27 Apr 2015 21:24:30 +0300
Message-ID: <1430159072-31440-2-git-send-email-grygorii.strashko@linaro.org>
References: <1430159072-31440-1-git-send-email-grygorii.strashko@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430159072-31440-1-git-send-email-grygorii.strashko@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Cc: ulf.hansson@linaro.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Grygorii Strashko <Grygorii.Strashko@linaro.org>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@linaro.org>, Santosh Shilimkar <ssantosh@kernel.org>
List-Id: linux-omap@vger.kernel.org

From: Grygorii Strashko <Grygorii.Strashko@linaro.org>

The same approach is used as for the existing SET_SYSTEM_SLEEP_PM_OPS,
but for noirq callbacks.

New SET_NOIRQ_SYSTEM_SLEEP_PM_OPS, defined for CONFIG_PM_SLEEP, will
point ->suspend_noirq, ->freeze_noirq and ->poweroff_noirq to the same
function. Vice versa happens for ->resume_noirq, ->thaw_noirq and
->restore_noirq.

Cc: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Kevin Hilman <khilman@linaro.org>
Cc: Santosh Shilimkar <ssantosh@kernel.org>
Signed-off-by: Grygorii Strashko <Grygorii.Strashko@linaro.org>
---
 include/linux/pm.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index 2d29c64..4890743 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -342,6 +342,18 @@ struct dev_pm_ops {
 #define SET_LATE_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
 #endif
 
+#ifdef CONFIG_PM_SLEEP
+#define SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
+	.suspend_noirq = suspend_fn, \
+	.resume_noirq = resume_fn, \
+	.freeze_noirq = suspend_fn, \
+	.thaw_noirq = resume_fn, \
+	.poweroff_noirq = suspend_fn, \
+	.restore_noirq = resume_fn,
+#else
+#define SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
+#endif
+
 #ifdef CONFIG_PM
 #define SET_RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
 	.runtime_suspend = suspend_fn, \
-- 
1.9.1
