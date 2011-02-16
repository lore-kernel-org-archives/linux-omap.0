From: Hema HK <hemahk@ti.com>
Subject: [4/7 v3] usb: otg: OMAP4430: Add phy_suspend function pointer to twl4030_usb_data
Date: Wed, 16 Feb 2011 17:20:46 +0530
Message-ID: <1297857049-27367-4-git-send-email-hemahk@ti.com>
References: <1297857049-27367-1-git-send-email-hemahk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58180 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758952Ab1BPLvP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Feb 2011 06:51:15 -0500
In-Reply-To: <1297857049-27367-1-git-send-email-hemahk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, "Kalliguddi, Hema" <hemahk@ti.com>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>

From: Kalliguddi, Hema <hemahk@ti.com>

Introduce the .phy_suspend function pointer to twl4030_usb_data structure.
assign the function to it for both sdp board and panda boards.
This will be used by the twl6030-usb transceiver driver.

Signed-off-by: Hema HK <hemahk@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>

---
arch/arm/mach-omap2/board-4430sdp.c    |    1 +
 arch/arm/mach-omap2/board-omap4panda.c |    1 +
 arch/arm/plat-omap/include/plat/usb.h  |    1 +
 include/linux/i2c/twl.h                |    2 ++
 4 files changed, 5 insertions(+)

Index: linux-2.6/arch/arm/mach-omap2/board-4430sdp.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-omap2/board-4430sdp.c
+++ linux-2.6/arch/arm/mach-omap2/board-4430sdp.c
@@ -272,6 +272,7 @@ static struct twl4030_usb_data omap4_usb
 	.phy_exit	= omap4430_phy_exit,
 	.phy_power	= omap4430_phy_power,
 	.phy_set_clock	= omap4430_phy_set_clk,
+	.phy_suspend	= omap4430_phy_suspend,
 };
 
 static struct omap2_hsmmc_info mmc[] = {
Index: linux-2.6/arch/arm/mach-omap2/board-omap4panda.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-omap2/board-omap4panda.c
+++ linux-2.6/arch/arm/mach-omap2/board-omap4panda.c
@@ -153,6 +153,7 @@ static struct twl4030_usb_data omap4_usb
 	.phy_exit	= omap4430_phy_exit,
 	.phy_power	= omap4430_phy_power,
 	.phy_set_clock	= omap4430_phy_set_clk,
+	.phy_suspend	= omap4430_phy_suspend,
 };
 
 static struct omap2_hsmmc_info mmc[] = {
Index: linux-2.6/include/linux/i2c/twl.h
===================================================================
--- linux-2.6.orig/include/linux/i2c/twl.h
+++ linux-2.6/include/linux/i2c/twl.h
@@ -600,6 +600,8 @@ struct twl4030_usb_data {
 	int		(*phy_power)(struct device *dev, int iD, int on);
 	/* enable/disable  phy clocks */
 	int		(*phy_set_clock)(struct device *dev, int on);
+	/* suspend/resume of phy */
+	int		(*phy_suspend)(struct device *dev, int suspend);
 };
 
 struct twl4030_ins {
