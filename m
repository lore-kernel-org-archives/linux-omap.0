From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 02/11] omap: musb: Remove #ifdef from board-omap3evm.c
Date: Fri, 19 Feb 2010 15:30:08 -0800
Message-ID: <20100219233008.10559.28756.stgit@baageli.muru.com>
References: <20100219232648.10559.380.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63183 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755751Ab0BSX3Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Feb 2010 18:29:25 -0500
In-Reply-To: <20100219232648.10559.380.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Olof Johansson <olof@lixom.net>, Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, Maulik Mankad <x0082077@ti.com>

From: Maulik Mankad <x0082077@ti.com>

This patch removes #ifdef around usb_nop_xceiv_register()
from board-omap3evm.c

Signed-off-by: Maulik Mankad <x0082077@ti.com>
Acked-by: Olof Johansson <olof@lixom.net>
Acked-by: Felipe Balbi <felipe.balbi@nokia.com>
Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-omap3evm.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index fa1f9d5..57506da 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -675,10 +675,10 @@ static void __init omap3_evm_init(void)
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

