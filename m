From: Maulik Mankad <x0082077@ti.com>
Subject: [PATCH 1/2] ARM : OMAP : Remove #ifdef from board-omap3evm.c
Date: Thu, 31 Dec 2009 18:43:02 +0530
Message-ID: <1262265182-16869-1-git-send-email-x0082077@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46970 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751339AbZLaNNQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 Dec 2009 08:13:16 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-usb@vger.kernel.org, Maulik Mankad <x0082077@ti.com>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>, Greg Kroah-Hartman <gregkh@suse.de>, Olof Johansson <olof@lixom.net>

ARM : OMAP : Remove #ifdef from board-omap3evm.c

This patch removes #ifdef around usb_nop_xceiv_register()
from board-omap3evm.c

Signed-off-by: Maulik Mankad <x0082077@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Olof Johansson <olof@lixom.net>
---
Index: felipe_musb/arch/arm/mach-omap2/board-omap3evm.c
===================================================================
--- felipe_musb.orig/arch/arm/mach-omap2/board-omap3evm.c
+++ felipe_musb/arch/arm/mach-omap2/board-omap3evm.c
@@ -444,10 +444,10 @@ static void __init omap3_evm_init(void)
 				ARRAY_SIZE(omap3evm_spi_board_info));
 
 	omap_serial_init();
-#ifdef CONFIG_NOP_USB_XCEIV
+
 	/* OMAP3EVM uses ISP1504 phy and so register nop transceiver */
 	usb_nop_xceiv_register();
-#endif
+
 	if (get_omap3_evm_rev() >= OMAP3EVM_BOARD_GEN_2) {
 		/* enable EHCI VBUS using GPIO22 */
 		omap_mux_init_gpio(22, OMAP_PIN_INPUT_PULLUP);
