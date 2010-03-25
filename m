From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [patch-2.6.35 (v2) 10/11] musb: Add extvbus in musb_board_data
Date: Thu, 25 Mar 2010 13:25:27 +0200
Message-ID: <1269516328-28267-11-git-send-email-felipe.balbi@nokia.com>
References: <1269516328-28267-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:38543 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754518Ab0CYL0n (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Mar 2010 07:26:43 -0400
In-Reply-To: <1269516328-28267-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Ajay Kumar Gupta <ajay.gupta@ti.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: Ajay Kumar Gupta <ajay.gupta@ti.com>

EXTVBUS programming is required by OMAP3EVM REV >=E to supply 500mA
power so adding a flag which can be used by musb driver to program
EXTVBUS.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap2/board-omap3evm.c  |    3 +++
 arch/arm/mach-omap2/usb-musb.c        |    1 +
 arch/arm/plat-omap/include/plat/usb.h |    1 +
 3 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 017bb2f..7d7b5bc 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -702,6 +702,9 @@ static void __init omap3_evm_init(void)
 		omap_mux_init_gpio(21, OMAP_PIN_INPUT_PULLUP);
 		ehci_pdata.reset_gpio_port[1] = 21;
 
+		/* EVM REV >= E can supply 500mA with EXTVBUS programming */
+		musb_board_data.power = 500;
+		musb_board_data.extvbus = 1;
 	} else {
 		/* setup EHCI phy reset on MDC */
 		omap_mux_init_gpio(135, OMAP_PIN_OUTPUT);
diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 6d41fa7..96f6787 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -107,6 +107,7 @@ void __init usb_musb_init(struct omap_musb_board_data *board_data)
 	musb_plat.board_data = board_data;
 	musb_plat.power = board_data->power >> 1;
 	musb_plat.mode = board_data->mode;
+	musb_plat.extvbus = board_data->extvbus;
 
 	if (platform_device_register(&musb_device) < 0)
 		printk(KERN_ERR "Unable to register HS-USB (MUSB) device\n");
diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-omap/include/plat/usb.h
index 876ca8d..60c734f 100644
--- a/arch/arm/plat-omap/include/plat/usb.h
+++ b/arch/arm/plat-omap/include/plat/usb.h
@@ -47,6 +47,7 @@ struct omap_musb_board_data {
 	u8	interface_type;
 	u8	mode;
 	u16	power;
+	unsigned extvbus:1;
 };
 
 enum musb_interface    {MUSB_INTERFACE_ULPI, MUSB_INTERFACE_UTMI};
-- 
1.7.0.rc0.33.g7c3932

