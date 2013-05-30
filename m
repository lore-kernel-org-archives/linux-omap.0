From: Ruchika Kharwar <ruchika@ti.com>
Subject: [PATCH] jacinto6 : usb3_phy: Updated dpll M,N values.
Date: Thu, 30 May 2013 14:54:09 -0500
Message-ID: <1369943649-982-1-git-send-email-ruchika@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52639 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752524Ab3E3TyM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 May 2013 15:54:12 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Felipe Balbi <balbi@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ruchika Kharwar <ruchika@ti.com>

Addition of the M and N recommended values for the USB3 PHY DPLL.
Sysclk for DRA7xx is 20MHz.
This yields:
Clk = 20MHz * M/(N+1) = 20MHz * 1000 /(7+1) = 2.5 Ghz

Signed-off-by: Ruchika Kharwar <ruchika@ti.com>
---
 drivers/usb/phy/phy-omap-usb3.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/phy/phy-omap-usb3.c b/drivers/usb/phy/phy-omap-usb3.c
index a6e60b1..efe6e14 100644
--- a/drivers/usb/phy/phy-omap-usb3.c
+++ b/drivers/usb/phy/phy-omap-usb3.c
@@ -27,7 +27,7 @@
 #include <linux/delay.h>
 #include <linux/usb/omap_control_usb.h>
 
-#define	NUM_SYS_CLKS		5
+#define	NUM_SYS_CLKS		6
 #define	PLL_STATUS		0x00000004
 #define	PLL_GO			0x00000008
 #define	PLL_CONFIGURATION1	0x0000000C
@@ -62,6 +62,7 @@ enum sys_clk_rate {
 	CLK_RATE_12MHZ,
 	CLK_RATE_16MHZ,
 	CLK_RATE_19MHZ,
+	CLK_RATE_20MHZ,
 	CLK_RATE_26MHZ,
 	CLK_RATE_38MHZ
 };
@@ -72,6 +73,8 @@ static struct usb_dpll_params omap_usb3_dpll_params[NUM_SYS_CLKS] = {
 	{1172, 8, 4, 20, 65537},	/* 19.2 MHz */
 	{1250, 12, 4, 20, 0},		/* 26 MHz */
 	{3125, 47, 4, 20, 92843},	/* 38.4 MHz */
+	{1000, 7, 4, 10, 0},            /* 20 MHz */
+
 };
 
 static int omap_usb3_suspend(struct usb_phy *x, int suspend)
@@ -122,6 +125,8 @@ static inline enum sys_clk_rate __get_sys_clk_index(unsigned long rate)
 		return CLK_RATE_16MHZ;
 	case 19200000:
 		return CLK_RATE_19MHZ;
+	case 20000000:
+		return CLK_RATE_20MHZ;
 	case 26000000:
 		return CLK_RATE_26MHZ;
 	case 38400000:
-- 
1.7.5.4

