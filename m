From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 22/22] mfd: omap-usb-host: Don't spam console on clk_set_parent failure
Date: Wed, 28 Nov 2012 16:49:10 +0200
Message-ID: <1354114150-11941-23-git-send-email-rogerq@ti.com>
References: <1354114150-11941-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34794 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932343Ab2K1Oto (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Nov 2012 09:49:44 -0500
In-Reply-To: <1354114150-11941-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: keshava_mgowda@ti.com, rogerq@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

clk_set_parent is expected to fail on OMAP3 platforms. We don't
consider that as fatal so don't spam console.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/mfd/omap-usb-host.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 6ede319..493e010 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -653,17 +653,17 @@ static int __devinit usbhs_omap_probe(struct platform_device *pdev)
 	}
 
 	if (is_ehci_phy_mode(pdata->port_mode[0])) {
-		/* for OMAP3 , the clk set paretn fails */
+		/* for OMAP3 , the clk set parent fails */
 		ret = clk_set_parent(omap->utmi_clk[0],
 					omap->xclk60mhsp1_ck);
 		if (ret != 0)
-			dev_err(dev, "xclk60mhsp1_ck set parent"
+			dev_dbg(dev, "xclk60mhsp1_ck set parent"
 				"failed error:%d\n", ret);
 	} else if (is_ehci_tll_mode(pdata->port_mode[0])) {
 		ret = clk_set_parent(omap->utmi_clk[0],
 					omap->init_60m_fclk);
 		if (ret != 0)
-			dev_err(dev, "init_60m_fclk set parent"
+			dev_dbg(dev, "init_60m_fclk set parent"
 				"failed error:%d\n", ret);
 	}
 
@@ -671,13 +671,13 @@ static int __devinit usbhs_omap_probe(struct platform_device *pdev)
 		ret = clk_set_parent(omap->utmi_clk[1],
 					omap->xclk60mhsp2_ck);
 		if (ret != 0)
-			dev_err(dev, "xclk60mhsp2_ck set parent"
+			dev_dbg(dev, "xclk60mhsp2_ck set parent"
 					"failed error:%d\n", ret);
 	} else if (is_ehci_tll_mode(pdata->port_mode[1])) {
 		ret = clk_set_parent(omap->utmi_clk[1],
 						omap->init_60m_fclk);
 		if (ret != 0)
-			dev_err(dev, "init_60m_fclk set parent"
+			dev_dbg(dev, "init_60m_fclk set parent"
 				"failed error:%d\n", ret);
 	}
 
-- 
1.7.4.1

