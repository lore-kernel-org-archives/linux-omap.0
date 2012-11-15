From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 01/16] mfd: omap-usb-tll: Avoid creating copy of platform data
Date: Thu, 15 Nov 2012 16:33:59 +0200
Message-ID: <1352990054-14680-2-git-send-email-rogerq@ti.com>
References: <1352990054-14680-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45637 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767923Ab2KOOeR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Nov 2012 09:34:17 -0500
In-Reply-To: <1352990054-14680-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: keshava_mgowda@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, rogerq@ti.com

Just a pointer to the platform data should suffice.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/mfd/omap-usb-tll.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
index 4b7757b..d1750a4 100644
--- a/drivers/mfd/omap-usb-tll.c
+++ b/drivers/mfd/omap-usb-tll.c
@@ -98,7 +98,7 @@
 struct usbtll_omap {
 	struct clk				*usbtll_p1_fck;
 	struct clk				*usbtll_p2_fck;
-	struct usbtll_omap_platform_data	platdata;
+	struct usbtll_omap_platform_data	*pdata;
 	/* secure the register updates */
 	spinlock_t				lock;
 };
@@ -223,8 +223,7 @@ static int __devinit usbtll_omap_probe(struct platform_device *pdev)
 
 	spin_lock_init(&tll->lock);
 
-	for (i = 0; i < OMAP3_HS_USB_PORTS; i++)
-		tll->platdata.port_mode[i] = pdata->port_mode[i];
+	tll->pdata = pdata;
 
 	tll->usbtll_p1_fck = clk_get(dev, "usb_tll_hs_usb_ch0_clk");
 	if (IS_ERR(tll->usbtll_p1_fck)) {
@@ -362,7 +361,7 @@ static int __devexit usbtll_omap_remove(struct platform_device *pdev)
 static int usbtll_runtime_resume(struct device *dev)
 {
 	struct usbtll_omap			*tll = dev_get_drvdata(dev);
-	struct usbtll_omap_platform_data	*pdata = &tll->platdata;
+	struct usbtll_omap_platform_data	*pdata = tll->pdata;
 	unsigned long				flags;
 
 	dev_dbg(dev, "usbtll_runtime_resume\n");
@@ -388,7 +387,7 @@ static int usbtll_runtime_resume(struct device *dev)
 static int usbtll_runtime_suspend(struct device *dev)
 {
 	struct usbtll_omap			*tll = dev_get_drvdata(dev);
-	struct usbtll_omap_platform_data	*pdata = &tll->platdata;
+	struct usbtll_omap_platform_data	*pdata = tll->pdata;
 	unsigned long				flags;
 
 	dev_dbg(dev, "usbtll_runtime_suspend\n");
-- 
1.7.4.1

