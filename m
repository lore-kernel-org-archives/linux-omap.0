From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 1/8] i2c: omap: no need to access platform_device
Date: Mon, 22 Oct 2012 12:46:51 +0300
Message-ID: <1350899218-13624-2-git-send-email-balbi@ti.com>
References: <1350899218-13624-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52805 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752597Ab2JVJxB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Oct 2012 05:53:01 -0400
In-Reply-To: <1350899218-13624-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, w.sang@pengutronix.de, ben-linux@fluff.org, Shubhrajyoti Datta <shubhrajyoti@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Felipe Balbi <balbi@ti.com>

PM callbacks pass our device pointer as argument
and we don't need to access the platform_device
just to dereference that down to dev->drvdata.

instead, just use dev_get_drvdata() directly.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/i2c/busses/i2c-omap.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index db31eae..c07d9c4 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1239,8 +1239,7 @@ static int __devexit omap_i2c_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM_RUNTIME
 static int omap_i2c_runtime_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct omap_i2c_dev *_dev = platform_get_drvdata(pdev);
+	struct omap_i2c_dev *_dev = dev_get_drvdata(dev);
 	u16 iv;
 
 	_dev->iestate = omap_i2c_read_reg(_dev, OMAP_I2C_IE_REG);
@@ -1261,8 +1260,7 @@ static int omap_i2c_runtime_suspend(struct device *dev)
 
 static int omap_i2c_runtime_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct omap_i2c_dev *_dev = platform_get_drvdata(pdev);
+	struct omap_i2c_dev *_dev = dev_get_drvdata(dev);
 
 	if (_dev->flags & OMAP_I2C_FLAG_RESET_REGS_POSTIDLE) {
 		omap_i2c_write_reg(_dev, OMAP_I2C_CON_REG, 0);
-- 
1.8.0.rc0

