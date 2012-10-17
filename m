From: Felipe Balbi <balbi@ti.com>
Subject: [RFC/NOT FOR MERGING 5/5] i2c: omap: introduce suspend/resume methods
Date: Wed, 17 Oct 2012 18:34:03 +0300
Message-ID: <1350488043-5053-6-git-send-email-balbi@ti.com>
References: <1350488043-5053-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44414 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932331Ab2JQPjw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Oct 2012 11:39:52 -0400
In-Reply-To: <1350488043-5053-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

during system-wide (static) suspend, we also
want to save our context and restore it when
waking up.

Let's introduce new suspend/resume methods so
that we can survive a suspend-to-ram transition.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/i2c/busses/i2c-omap.c | 60 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 50 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 7eeae11..ceab138 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1236,13 +1236,8 @@ static int __devexit omap_i2c_remove(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_PM
-#ifdef CONFIG_PM_RUNTIME
-static int omap_i2c_runtime_suspend(struct device *dev)
+static int omap_i2c_low_level_suspend(struct omap_i2c_dev *_dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct omap_i2c_dev *_dev = platform_get_drvdata(pdev);
-	u16 iv;
-
 	_dev->iestate = omap_i2c_read_reg(_dev, OMAP_I2C_IE_REG);
 
 	omap_i2c_write_reg(_dev, OMAP_I2C_IE_REG, 0);
@@ -1253,11 +1248,8 @@ static int omap_i2c_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int omap_i2c_runtime_resume(struct device *dev)
+static int omap_i2c_low_level_resume(struct omap_i2c_dev *_dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct omap_i2c_dev *_dev = platform_get_drvdata(pdev);
-
 	if (_dev->flags & OMAP_I2C_FLAG_RESET_REGS_POSTIDLE) {
 		omap_i2c_write_reg(_dev, OMAP_I2C_CON_REG, 0);
 		omap_i2c_write_reg(_dev, OMAP_I2C_PSC_REG, _dev->pscstate);
@@ -1278,9 +1270,57 @@ static int omap_i2c_runtime_resume(struct device *dev)
 
 	return 0;
 }
+
+static int omap_i2c_suspend(struct device *dev)
+{
+	struct omap_i2c_dev *_dev = dev_get_drvdata(dev);
+
+	if (pm_runtime_suspended(dev))
+		return 0;
+
+	return omap_i2c_low_level_suspend(_dev);
+}
+
+static int omap_i2c_resume(struct device *dev)
+{
+	struct omap_i2c_dev *_dev = dev_get_drvdata(dev);
+	int r;
+
+	r = omap_i2c_low_level_resume(_dev);
+	if (r)
+		return r;
+
+	pm_runtime_disable(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_RUNTIME
+static int omap_i2c_runtime_suspend(struct device *dev)
+{
+	struct omap_i2c_dev *_dev = dev_get_drvdata(dev);
+
+	return omap_i2c_low_level_suspend(_dev);
+}
+
+static int omap_i2c_runtime_resume(struct device *dev)
+{
+	struct omap_i2c_dev *_dev = dev_get_drvdata(dev);
+
+	return omap_i2c_low_level_resume(_dev);
+}
+#else
+#define omap_i2c_runtime_suspend NULL
+#define omap_i2c_runtime_resume NULL
 #endif /* CONFIG_PM_RUNTIME */
 
 static struct dev_pm_ops omap_i2c_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(omap_i2c_suspend,
+			omap_i2c_resume)
 	SET_RUNTIME_PM_OPS(omap_i2c_runtime_suspend,
 			   omap_i2c_runtime_resume, NULL)
 };
-- 
1.8.0.rc0

