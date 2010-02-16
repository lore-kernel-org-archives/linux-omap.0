From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 18/24] omap4: clocks: Make i2c driver's clock calls OMAP4 compatible
Date: Tue, 16 Feb 2010 21:28:09 +0530
Message-ID: <1266335895-32741-18-git-send-email-santosh.shilimkar@ti.com>
References: <1266335895-32741-1-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-2-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-3-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-4-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-5-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-6-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-7-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-8-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-9-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-10-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-11-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-12-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-13-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-14-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-15-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-16-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-17-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52042 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757015Ab0BPP6g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Feb 2010 10:58:36 -0500
In-Reply-To: <1266335895-32741-17-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, ben@fluff.org.uk, sameo@linux.intel.com, lrg@slimlogic.co.uk, paul@pwsan.com, Abhijit Pagare <abhijitpagare@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: Abhijit Pagare <abhijitpagare@ti.com>

The i2c driver has been adapted for the OMAP4 way of clock calls.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Abhijit Pagare <abhijitpagare@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |   29 ++++++++++++++++-------------
 1 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 89a156a..d4f6eda 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -260,11 +260,14 @@ static int __init omap_i2c_get_clocks(struct omap_i2c_dev *dev)
 {
 	int ret;
 
-	dev->iclk = clk_get(dev->dev, "ick");
-	if (IS_ERR(dev->iclk)) {
-		ret = PTR_ERR(dev->iclk);
-		dev->iclk = NULL;
-		return ret;
+	/* OMAP4 iclk are hw controlled and no sw control is available */
+	if (!cpu_is_omap44xx()) {
+		dev->iclk = clk_get(dev->dev, "ick");
+		if (IS_ERR(dev->iclk)) {
+			ret = PTR_ERR(dev->iclk);
+			dev->iclk = NULL;
+			return ret;
+		}
 	}
 
 	dev->fclk = clk_get(dev->dev, "fck");
@@ -285,15 +288,18 @@ static void omap_i2c_put_clocks(struct omap_i2c_dev *dev)
 {
 	clk_put(dev->fclk);
 	dev->fclk = NULL;
-	clk_put(dev->iclk);
-	dev->iclk = NULL;
+	if (!cpu_is_omap44xx()) {
+		clk_put(dev->iclk);
+		dev->iclk = NULL;
+	}
 }
 
 static void omap_i2c_unidle(struct omap_i2c_dev *dev)
 {
 	WARN_ON(!dev->idle);
 
-	clk_enable(dev->iclk);
+	if (!cpu_is_omap44xx())
+		clk_enable(dev->iclk);
 	clk_enable(dev->fclk);
 	if (cpu_is_omap34xx()) {
 		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
@@ -337,7 +343,8 @@ static void omap_i2c_idle(struct omap_i2c_dev *dev)
 	}
 	dev->idle = 1;
 	clk_disable(dev->fclk);
-	clk_disable(dev->iclk);
+	if (!cpu_is_omap44xx())
+		clk_disable(dev->iclk);
 }
 
 static int omap_i2c_init(struct omap_i2c_dev *dev)
@@ -434,10 +441,6 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 			internal_clk = 9600;
 		else
 			internal_clk = 4000;
-		/* FIXME: Remove this once clock framework is available*/
-		if (dev->rev >= OMAP_I2C_REV_ON_4430)
-			fclk_rate = 96000;
-		else
 			fclk_rate = clk_get_rate(dev->fclk) / 1000;
 
 		/* Compute prescaler divisor */
-- 
1.6.0.4

