From: Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: [PATCHv2 3/8] omap3: Add platform init code for EHCI driver on IGEP v2
Date: Wed, 18 Nov 2009 21:20:35 +0100
Message-ID: <1258575640-8169-4-git-send-email-eballetbo@gmail.com>
References: <1258575640-8169-1-git-send-email-eballetbo@gmail.com>
 <1258575640-8169-2-git-send-email-eballetbo@gmail.com>
 <1258575640-8169-3-git-send-email-eballetbo@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:2646 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755412Ab0AMLCu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jan 2010 06:02:50 -0500
Received: by ey-out-2122.google.com with SMTP id 22so2376928eye.19
        for <linux-omap@vger.kernel.org>; Wed, 13 Jan 2010 03:02:48 -0800 (PST)
In-Reply-To: <1258575640-8169-3-git-send-email-eballetbo@gmail.com>
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
index 5beea22..6088d65 100644
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

