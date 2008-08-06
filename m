From: "Arun KS" <arunks@mistralsolutions.com>
Subject: [PATCH] OMAP2EVM: Adding hsmmc support
Date: Wed, 6 Aug 2008 16:49:08 +0530
Message-ID: <dfeb90390808060419j61356353jeeec1b7c95cfd3f2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.190]:1288 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755756AbYHFLTK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Aug 2008 07:19:10 -0400
Received: by ti-out-0910.google.com with SMTP id b6so952471tic.23
        for <linux-omap@vger.kernel.org>; Wed, 06 Aug 2008 04:19:08 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch enables high speed MMC support for OMAP2EVM board

Signed-off-by: Arun KS <arunks@mistralsolutions.com>
---
 arch/arm/mach-omap2/Makefile         |    3 ++-
 arch/arm/mach-omap2/board-omap2evm.c |   10 ++++++++++
 2 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 10dc68f..0e982d3 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -49,7 +49,8 @@ obj-$(CONFIG_MACH_OMAP_2430SDP)		+= board-2430sdp.o \
 					   hsmmc.o \
 					   usb-musb.o \
 					   usb-ehci.o
-obj-$(CONFIG_MACH_OMAP2EVM)		+= board-omap2evm.o
+obj-$(CONFIG_MACH_OMAP2EVM)		+= board-omap2evm.o \
+					   hsmmc.o
 obj-$(CONFIG_MACH_OMAP_3430SDP)		+= board-3430sdp.o \
 					   hsmmc.o \
 					   usb-musb.o \
diff --git a/arch/arm/mach-omap2/board-omap2evm.c
b/arch/arm/mach-omap2/board-omap2evm.c
index 13c53cc..b6354e3 100644
--- a/arch/arm/mach-omap2/board-omap2evm.c
+++ b/arch/arm/mach-omap2/board-omap2evm.c
@@ -26,6 +26,7 @@
 #include <asm/arch/gpio.h>
 #include <asm/arch/board.h>
 #include <asm/arch/common.h>
+#include <asm/arch/hsmmc.h>

 static struct resource omap2evm_smc911x_resources[] = {
 	[0] =   {
@@ -83,9 +84,17 @@ static struct omap_uart_config
omap2_evm_uart_config __initdata = {
 	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
 };

+static struct omap_mmc_config omap2_evm_mmc_config __initdata = {
+	.mmc [0] = {
+		.enabled        = 1,
+		.wire4          = 1,
+	},
+};
+
 static struct omap_board_config_kernel omap2_evm_config[] __initdata = {
 	{ OMAP_TAG_UART,	&omap2_evm_uart_config },
 	{ OMAP_TAG_LCD,		&omap2_evm_lcd_config },
+	{ OMAP_TAG_MMC,		&omap2_evm_mmc_config },
 };

 static int __init omap2_evm_i2c_init(void)
@@ -110,6 +119,7 @@ static void __init omap2_evm_init(void)
 	omap_board_config = omap2_evm_config;
 	omap_board_config_size = ARRAY_SIZE(omap2_evm_config);
 	omap_serial_init();
+	hsmmc_init();
 }

 static void __init omap2_evm_map_io(void)
-- 
1.5.3.4
