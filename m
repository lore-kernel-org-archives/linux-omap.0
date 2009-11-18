From: Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: [PATCH 3/3] omap3: Add platform init code for EHCI driver on IGEP v2
Date: Wed, 18 Nov 2009 19:13:24 +0100
Message-ID: <1258568004-6993-3-git-send-email-eballetbo@gmail.com>
References: <1258568004-6993-1-git-send-email-eballetbo@gmail.com>
 <1258568004-6993-2-git-send-email-eballetbo@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:59112 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756047AbZLNR6q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Dec 2009 12:58:46 -0500
Received: by mail-ew0-f219.google.com with SMTP id 19so3657006ewy.21
        for <linux-omap@vger.kernel.org>; Mon, 14 Dec 2009 09:58:46 -0800 (PST)
In-Reply-To: <1258568004-6993-2-git-send-email-eballetbo@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Enric Balletbo i Serra <eballetbo@iseebcn.com>

From: Enric Balletbo i Serra <eballetbo@iseebcn.com>


Signed-off-by: Enric Balletbo i Serra <eballetbo@iseebcn.com>
---
 arch/arm/mach-omap2/board-igep0020.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 221b497..76f0208 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -213,6 +213,17 @@ static int __init igep2_i2c_init(void)
 	return 0;
 }
 
+static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
+	.port_mode[0] = EHCI_HCD_OMAP_MODE_UNKNOWN,
+	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
+	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
+
+	.phy_reset = true,
+	.reset_gpio_port[0] = -EINVAL,
+	.reset_gpio_port[1] = IGEP2_GPIO_USBH_NRESET,
+	.reset_gpio_port[2] = -EINVAL,
+};
+
 #ifdef CONFIG_OMAP_MUX
 static struct omap_board_mux board_mux[] __initdata = {
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
@@ -227,6 +238,7 @@ static void __init igep2_init(void)
 	igep2_i2c_init();
 	omap_serial_init();
 	usb_musb_init();
+	usb_ehci_init(&ehci_pdata);
 
 	igep2_init_smsc911x();
 
-- 
1.5.4.3

