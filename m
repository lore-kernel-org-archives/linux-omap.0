From: Maulik Mankad <x0082077@ti.com>
Subject: [PATCH v4 2/4] ARM : OMAP : Remove #ifdef from board-omap3evm.c
Date: Tue,  2 Feb 2010 17:10:30 +0530
Message-ID: <1265110830-27071-1-git-send-email-x0082077@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34376 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755716Ab0BBLkn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Feb 2010 06:40:43 -0500
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
Index: linux-2.6/arch/arm/mach-omap2/board-omap3evm.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-omap2/board-omap3evm.c
+++ linux-2.6/arch/arm/mach-omap2/board-omap3evm.c
@@ -443,10 +443,10 @@ static void __init omap3_evm_init(void)
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
