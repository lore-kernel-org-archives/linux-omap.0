From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.28-rc4-omap-git] beagle: warning fix
Date: Thu, 13 Nov 2008 18:38:06 -0800
Message-ID: <200811131838.06494.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp120.sbc.mail.sp1.yahoo.com ([69.147.64.93]:34312 "HELO
	smtp120.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751206AbYKNCiJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Nov 2008 21:38:09 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Fix a section warning for Beagle.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -116,7 +116,7 @@ static struct twl4030_usb_data beagle_us
 	.usb_mode	= T2_USB_MODE_ULPI,
 };
 
-static struct twl4030_hsmmc_info mmc[] __initdata = {
+static struct twl4030_hsmmc_info mmc[] = {
 	{
 		.mmc		= 1,
 		.wires		= 8,
