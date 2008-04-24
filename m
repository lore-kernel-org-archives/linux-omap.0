From: Felipe Balbi <me@felipebalbi.com>
Subject: [PATCH] USB: BEAGLE: Add usb support for omap3beagle
Date: Fri, 25 Apr 2008 00:46:00 +0300
Message-ID: <1209073560-9355-1-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:35987 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752530AbYDXVoa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Apr 2008 17:44:30 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Koen Kooi <koen@openembedded.org>, Felipe Balbi <felipe.balbi@nokia.com>, Felipe Balbi <me@felipebalbi.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

This patch is based on previous patch by
Koen Kooi <koen@openembedded.org>. It uses
the new generic usb init calls for omap3-
and omap2430-based boards.

Signed-off-by: Felipe Balbi <me@felipebalbi.com>
---
 arch/arm/mach-omap2/Makefile            |    1 +
 arch/arm/mach-omap2/board-omap3beagle.c |    4 ++++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 9b6f60e..725dae5 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_MACH_OMAP_3430SDP)		+= board-3430sdp.o \
 					   board-3430sdp-flash.o
 obj-$(CONFIG_MACH_OMAP3EVM)		+= board-omap3evm.o
 obj-$(CONFIG_MACH_OMAP3_BEAGLE)		+= board-omap3beagle.o \
+					   usb-musb.o usb-ehci.o \
 					   board-sdp-hsmmc.o
 obj-$(CONFIG_MACH_OMAP_APOLLON)		+= board-apollon.o \
 					   board-apollon-mmc.o	\
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index c03bb26..ad5ad2e 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -27,6 +27,8 @@
 
 #include <asm/arch/gpio.h>
 #include <asm/arch/board.h>
+#include <asm/arch/usb-musb.h>
+#include <asm/arch/usb-ehci.h>
 #include <asm/arch/common.h>
 
 static struct omap_uart_config omap3_beagle_uart_config __initdata = {
@@ -66,6 +68,8 @@ static void __init omap3_beagle_init(void)
 	omap_board_config_size = ARRAY_SIZE(omap3_beagle_config);
 	omap_serial_init();
 	sdp_mmc_init();
+	usb_musb_init();
+	usb_ehci_init();
 }
 
 arch_initcall(omap3_beagle_i2c_init);
-- 
1.5.4.3.447.gc95b3

