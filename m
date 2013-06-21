From: Ruchika Kharwar <ruchika@ti.com>
Subject: [PATCH] jacinto6 : usb3_phy: Updated dpll M,N values.
Date: Fri, 21 Jun 2013 10:46:10 -0500
Message-ID: <1371829570-15011-1-git-send-email-ruchika@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41067 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161367Ab3FUPqP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 21 Jun 2013 11:46:15 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-doc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Felipe Balbi <balbi@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Landley <rob@landley.net>, Ruchika Kharwar <ruchika@ti.com>, Nikhil Devshatwar <nikhil.nd@ti.com>

Addition of the M and N recommended values for the USB3 PHY DPLL.
Sysclk for DRA7xx is 20MHz.
This yields:
Clk = 20MHz * M/(N+1) = 20MHz * 1000 /(7+1) = 2.5 Ghz

Signed-off-by: Nikhil Devshatwar <nikhil.nd@ti.com>
Signed-off-by: Ruchika Kharwar <ruchika@ti.com>
---
 drivers/usb/phy/phy-omap-usb3.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/phy/phy-omap-usb3.c b/drivers/usb/phy/phy-omap-usb3.c
index a6e60b1..a2fb30b 100644
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
@@ -70,8 +71,10 @@ static struct usb_dpll_params omap_usb3_dpll_params[NUM_SYS_CLKS] = {
 	{1250, 5, 4, 20, 0},		/* 12 MHz */
 	{3125, 20, 4, 20, 0},		/* 16.8 MHz */
 	{1172, 8, 4, 20, 65537},	/* 19.2 MHz */
+	{1000, 7, 4, 10, 0},            /* 20 MHz */
 	{1250, 12, 4, 20, 0},		/* 26 MHz */
 	{3125, 47, 4, 20, 92843},	/* 38.4 MHz */
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
1.7.9.5

