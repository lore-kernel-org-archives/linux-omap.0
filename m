From: Kalle Jokiniemi <kalle.jokiniemi-4y2FMlU5MS8onNqTyK5kxQ@public.gmane.org>
Subject: [PATCH] i2c: i2c-omap: fix interrupt flood during resume
Date: Fri,  5 Oct 2012 11:55:16 +0300
Message-ID: <1349427316-24990-1-git-send-email-kalle.jokiniemi@jollamobile.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kalle Jokiniemi <kalle.jokiniemi-4y2FMlU5MS8onNqTyK5kxQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The resume_noirq enables interrupts one-by-one starting from
first one. Now if the wake up event for suspend came from i2c
device, the i2c bus irq gets enabled before the threaded
i2c device irq, causing a flood of i2c bus interrupts as the
threaded irq that should clear the event is not enabled yet.

Fixed the issue by adding suspend_late and resume_early
functions that keep i2c bus interrupts disabled until
resume_noirq has run completely.

Issue was detected doing a wake up from autosleep with
twl4030 power key on N9. Patch tested on N9.

Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi-4y2FMlU5MS8onNqTyK5kxQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 801df60..b77b0c2 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1158,6 +1158,35 @@ omap_i2c_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_SUSPEND
+static int omap_i2c_suspend_late(struct device *dev)
+{
+
+	struct platform_device *pdev = to_platform_device(dev);
+	struct omap_i2c_dev *_dev = platform_get_drvdata(pdev);
+
+	/*
+	 * The noirq_resume enables the interrupts one by one,
+	 * this causes a interrupt flood if the SW irq actually reading
+	 * event from i2c device is enabled only after i2c bus irq, as the
+	 * irq that should clear the event is still disabled. We have to
+	 * disable the bus irq until all other irqs have been enabled.
+	 */
+	disable_irq(_dev->irq);
+	return 0;
+}
+
+static int omap_i2c_resume_early(struct device *dev)
+{
+
+	struct platform_device *pdev = to_platform_device(dev);
+	struct omap_i2c_dev *_dev = platform_get_drvdata(pdev);
+
+	enable_irq(_dev->irq);
+
+	return 0;
+}
+#endif
 #ifdef CONFIG_PM_RUNTIME
 static int omap_i2c_runtime_suspend(struct device *dev)
 {
@@ -1178,10 +1207,18 @@ static int omap_i2c_runtime_resume(struct device *dev)
 
 	return 0;
 }
+#endif
 
+#if defined(CONFIG_SUSPEND) || defined(CONFIG_PM_RUNTIME)
 static struct dev_pm_ops omap_i2c_pm_ops = {
+#ifdef CONFIG_SUSPEND
+	.suspend_late = omap_i2c_suspend_late,
+	.resume_early = omap_i2c_resume_early,
+#endif
+#ifdef CONFIG_PM_RUNTIME
 	.runtime_suspend = omap_i2c_runtime_suspend,
 	.runtime_resume = omap_i2c_runtime_resume,
+#endif
 };
 #define OMAP_I2C_PM_OPS (&omap_i2c_pm_ops)
 #else
-- 
1.7.4.1
