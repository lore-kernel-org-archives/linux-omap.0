From: Zumeng Chen <zumeng.chen@gmail.com>
Subject: [PATCH 4/5] MFD: OMAP3EVM: USB: cosmetic fix to failed parent clk set
Date: Mon, 11 Jun 2012 22:00:15 +0800
Message-ID: <1339423216-1323-5-git-send-email-zumeng.chen@gmail.com>
References: <zumeng.chen@gmail.com>
 <1339423216-1323-1-git-send-email-zumeng.chen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:44338 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754291Ab2FKOAq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jun 2012 10:00:46 -0400
In-Reply-To: <1339423216-1323-1-git-send-email-zumeng.chen@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: khilman@ti.com, khasim@ti.com, ajay.gupta@ti.com, hvaibhav@ti.com, zumeng.chen@gmail.com

A typo fix for this cosmetic change and mute a failed message from
a unnecessary setting of some parent clk for usbhs_omap on OMAP3EVM.

Signed-off-by: Zumeng Chen <zumeng.chen@gmail.com>
---
 drivers/mfd/omap-usb-host.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 7e96bb2..9aaaf3c 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -698,8 +698,9 @@ static int __devinit usbhs_omap_probe(struct platform_device *pdev)
 		goto err_usbtll_p2_fck;
 	}
 
+#ifndef CONFIG_MACH_OMAP3EVM
+	/* for OMAP3 , the clk set parent fails */
 	if (is_ehci_phy_mode(pdata->port_mode[0])) {
-		/* for OMAP3 , the clk set paretn fails */
 		ret = clk_set_parent(omap->utmi_p1_fck,
 					omap->xclk60mhsp1_ck);
 		if (ret != 0)
@@ -726,6 +727,7 @@ static int __devinit usbhs_omap_probe(struct platform_device *pdev)
 			dev_err(dev, "init_60m_fclk set parent"
 				"failed error:%d\n", ret);
 	}
+#endif
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "uhh");
 	if (!res) {
-- 
1.7.5.4

