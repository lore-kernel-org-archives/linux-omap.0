From: "Steve Sakoman" <sakoman@gmail.com>
Subject: [PATCH 2/7] OMAP3 EVM: add usb support
Date: Mon, 28 Apr 2008 16:28:09 -0700
Message-ID: <5e088bd90804281628m53ec102tda1afdfd5049b2e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:42344 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765946AbYD1X2K (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Apr 2008 19:28:10 -0400
Received: by ug-out-1314.google.com with SMTP id z38so953011ugc.16
        for <linux-omap@vger.kernel.org>; Mon, 28 Apr 2008 16:28:09 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Steve Sakoman <steve@sakoman.com>

Add USB support for OMAP3 EVM

Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 Makefile         |    3 ++-
 board-omap3evm.c |    4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)
diff -uprN -X a/Documentation/dontdiff
a/arch/arm/mach-omap2/board-omap3evm.c
b/arch/arm/mach-omap2/board-omap3evm.c
--- a/arch/arm/mach-omap2/board-omap3evm.c	2008-04-27 21:47:31.000000000 -0700
+++ b/arch/arm/mach-omap2/board-omap3evm.c	2008-04-27 21:53:37.000000000 -0700
@@ -28,6 +28,8 @@
 #include <asm/arch/gpio.h>
 #include <asm/arch/board.h>
 #include <asm/arch/hsmmc.h>
+#include <asm/arch/usb-musb.h>
+#include <asm/arch/usb-ehci.h>
 #include <asm/arch/common.h>

 static struct omap_uart_config omap3_evm_uart_config __initdata = {
@@ -67,6 +69,8 @@ static void __init omap3_evm_init(void)
 	omap_board_config_size = ARRAY_SIZE(omap3_evm_config);
 	omap_serial_init();
 	hsmmc_init();
+	usb_musb_init();
+	usb_ehci_init();
 }

 arch_initcall(omap3_evm_i2c_init);
diff -uprN -X a/Documentation/dontdiff a/arch/arm/mach-omap2/Makefile
b/arch/arm/mach-omap2/Makefile
--- a/arch/arm/mach-omap2/Makefile	2008-04-27 21:47:31.000000000 -0700
+++ b/arch/arm/mach-omap2/Makefile	2008-04-27 21:50:56.000000000 -0700
@@ -38,7 +38,8 @@ obj-$(CONFIG_MACH_OMAP_3430SDP)		+= boar
 					   usb-ehci.o \
 					   board-3430sdp-flash.o
 obj-$(CONFIG_MACH_OMAP3EVM)		+= board-omap3evm.o \
-					   hsmmc.o
+					   hsmmc.o \
+					   usb-musb.o usb-ehci.o
 obj-$(CONFIG_MACH_OMAP3_BEAGLE)		+= board-omap3beagle.o \
 					   usb-musb.o usb-ehci.o \
 					   hsmmc.o
