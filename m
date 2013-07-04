From: Ruchika Kharwar <ruchika@ti.com>
Subject: [PATCH] usb: phy: omap-usb3: fix dpll clock index
Date: Thu, 4 Jul 2013 00:21:19 -0500
Message-ID: <1372915279-14565-1-git-send-email-ruchika@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49017 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752364Ab3GDFWA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Jul 2013 01:22:00 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Felipe Balbi <balbi@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ruchika Kharwar <ruchika@ti.com>, Nikhil Devshatwar <nikhil.nd@ti.com>

Correction of the omap_usb3_dpll_params array when the sys_clk_rate is
20MHz.

Signed-off-by: Nikhil Devshatwar <nikhil.nd@ti.com>
Signed-off-by: Ruchika Kharwar <ruchika@ti.com>
---
 drivers/usb/phy/phy-omap-usb3.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/phy/phy-omap-usb3.c b/drivers/usb/phy/phy-omap-usb3.c
index efe6e14..a2fb30b 100644
--- a/drivers/usb/phy/phy-omap-usb3.c
+++ b/drivers/usb/phy/phy-omap-usb3.c
@@ -71,9 +71,9 @@ static struct usb_dpll_params omap_usb3_dpll_params[NUM_SYS_CLKS] = {
 	{1250, 5, 4, 20, 0},		/* 12 MHz */
 	{3125, 20, 4, 20, 0},		/* 16.8 MHz */
 	{1172, 8, 4, 20, 65537},	/* 19.2 MHz */
+	{1000, 7, 4, 10, 0},            /* 20 MHz */
 	{1250, 12, 4, 20, 0},		/* 26 MHz */
 	{3125, 47, 4, 20, 92843},	/* 38.4 MHz */
-	{1000, 7, 4, 10, 0},            /* 20 MHz */
 
 };
 
-- 
1.7.9.5

