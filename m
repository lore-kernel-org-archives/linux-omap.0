From: Kalle Jokiniemi <kalle.jokiniemi-4y2FMlU5MS8onNqTyK5kxQ@public.gmane.org>
Subject: [PATCH v2] ARM: OMAP: i2c: fix interrupt flood during resume
Date: Wed, 10 Oct 2012 14:46:06 +0300
Message-ID: <1349869566-21756-1-git-send-email-kalle.jokiniemi@jollamobile.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org, shubhrajyoti-l0cyMroinI0@public.gmane.org, Kalle Jokiniemi <kalle.jokiniemi-4y2FMlU5MS8onNqTyK5kxQ@public.gmane.org>
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
 drivers/i2c/busses/i2c-omap.c |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index a0e49f6..991341b 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1132,6 +1132,36 @@ static int __devexit omap_i2c_remove(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
+static int omap_i2c_suspend_noirq(struct device *dev)
+{
+
+	struct platform_device *pdev = to_platform_device(dev);
+	struct omap_i2c_dev *_dev = platform_get_drvdata(pdev);
+
+	/* Disabling irq here to balance the enable in resume_early */
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
+	/*
+	 * The noirq_resume enables the interrupts one by one,
+	 * this causes a interrupt flood if the SW irq actually reading
+	 * event from i2c device is enabled only after i2c bus irq, as the
+	 * irq that should clear the event is still disabled. We have to
+	 * keep the bus irq disabled until all other irqs have been enabled.
+	 */
+	enable_irq(_dev->irq);
+
+	return 0;
+}
+#endif
 #ifdef CONFIG_PM_RUNTIME
 static int omap_i2c_runtime_suspend(struct device *dev)
 {
@@ -1183,6 +1213,10 @@ static int omap_i2c_runtime_resume(struct device *dev)
 #endif /* CONFIG_PM_RUNTIME */
 
 static struct dev_pm_ops omap_i2c_pm_ops = {
+#ifdef CONFIG_PM_SLEEP
+	.suspend_noirq = omap_i2c_suspend_noirq,
+	.resume_early = omap_i2c_resume_early,
+#endif
 	SET_RUNTIME_PM_OPS(omap_i2c_runtime_suspend,
 			   omap_i2c_runtime_resume, NULL)
 };
-- 
1.7.4.1
