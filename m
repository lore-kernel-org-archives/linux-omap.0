From: Maulik Mankad <x0082077@ti.com>
Subject: [PATCH v2 2/2] ARM : OMAP : Remove #ifdef from board-omap3evm.c
Date: Mon,  4 Jan 2010 16:41:04 +0530
Message-ID: <1262603464-13117-1-git-send-email-x0082077@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36770 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753366Ab0ADLL0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Jan 2010 06:11:26 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-usb@vger.kernel.org, Maulik Mankad <x0082077@ti.com>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>, Greg Kroah-Hartman <gregkh@suse.de>, Olof Johansson <olof@lixom.net>, "Gupta, Ajay Kumar" <ajay.gupta@ti.com>

ARM : OMAP : Remove #ifdef from board-omap3evm.c

Remove #ifdef around usb_nop_xceiv_register()from 
board-omap3evm.c

Signed-off-by: Maulik Mankad <x0082077@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Olof Johansson <olof@lixom.net>
Cc: Gupta, Ajay Kumar <ajay.gupta@ti.com>
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
