From: Sriramakrishnan <srk@ti.com>
Subject: [PATCH 2/2] can:ti_hecc: board specific hookup on AM3517EVM
Date: Tue, 23 Feb 2010 12:07:48 +0530
Message-ID: <1266907068-6210-3-git-send-email-srk@ti.com>
References: <1266907068-6210-1-git-send-email-srk@ti.com>
 <1266907068-6210-2-git-send-email-srk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33855 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751254Ab0BWGhz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Feb 2010 01:37:55 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o1N6bp67005600
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 23 Feb 2010 00:37:53 -0600
In-Reply-To: <1266907068-6210-2-git-send-email-srk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: anantgole@ti.com, Sriramakrishnan <srk@ti.com>

Add board specific hookup for TI HECC driver on
AM3517 EVM

Signed-off-by: Sriramakrishnan <srk@ti.com>
Acked-by: Anant Gole <anantgole@ti.com>
---
The driver requires that CAN_STB signal be driven low to enable
CAN PHY. Currently this is being managed from U-boot. Will submit a patch
for handling this as part of board init sequence.

 arch/arm/mach-omap2/board-am3517evm.c     |   38 +++++++++++++++++++++++++++++
 arch/arm/mach-omap2/include/mach/am35xx.h |   10 +++++++
 2 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index af99faf..42013b5 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -20,6 +20,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
+#include <linux/can/platform/ti_hecc.h>
 
 #include <mach/hardware.h>
 #include <mach/am35xx.h>
@@ -223,6 +224,42 @@ static struct omap_board_mux board_mux[] __initdata = {
 #define board_mux	NULL
 #endif
 
+
+static struct resource am3517_hecc_resources[] = {
+	{
+		.start  = AM35XX_IPSS_HECC_BASE,
+		.end    = AM35XX_IPSS_HECC_BASE + 0x3FFF,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		.start  = INT_35XX_HECC0_IRQ,
+		.end    = INT_35XX_HECC0_IRQ,
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device am3517_hecc_device = {
+	.name           = "ti_hecc",
+	.id             = -1,
+	.num_resources  = ARRAY_SIZE(am3517_hecc_resources),
+	.resource       = am3517_hecc_resources,
+};
+
+static struct ti_hecc_platform_data am3517_evm_hecc_pdata = {
+	.scc_hecc_offset        = AM35XX_HECC_SCC_HECC_OFFSET,
+	.scc_ram_offset         = AM35XX_HECC_SCC_RAM_OFFSET,
+	.hecc_ram_offset        = AM35XX_HECC_RAM_OFFSET,
+	.mbx_offset            = AM35XX_HECC_MBOX_OFFSET,
+	.int_line               = AM35XX_HECC_INT_LINE,
+	.version                = AM35XX_HECC_VERSION,
+};
+
+static void am3517_evm_hecc_init(struct ti_hecc_platform_data *pdata)
+{
+	am3517_hecc_device.dev.platform_data = pdata;
+	platform_device_register(&am3517_hecc_device);
+}
+
 static void __init am3517_evm_init(void)
 {
 	am3517_evm_i2c_init();
@@ -233,6 +270,7 @@ static void __init am3517_evm_init(void)
 
 	omap_serial_init();
 	usb_ehci_init(&ehci_pdata);
+	am3517_evm_hecc_init(&am3517_evm_hecc_pdata);
 	/* DSS */
 	am3517_evm_display_init();
 }
diff --git a/arch/arm/mach-omap2/include/mach/am35xx.h b/arch/arm/mach-omap2/include/mach/am35xx.h
index a705f94..6d5429b 100644
--- a/arch/arm/mach-omap2/include/mach/am35xx.h
+++ b/arch/arm/mach-omap2/include/mach/am35xx.h
@@ -23,4 +23,14 @@
 #define AM35XX_IPSS_HECC_BASE		0x5C050000
 #define AM35XX_IPSS_VPFE_BASE		0x5C060000
 
+
+/* HECC module specifc offset definitions */
+#define AM35XX_HECC_SCC_HECC_OFFSET	(0x0)
+#define AM35XX_HECC_SCC_RAM_OFFSET	(0x3000)
+#define AM35XX_HECC_RAM_OFFSET		(0x3000)
+#define AM35XX_HECC_MBOX_OFFSET		(0x2000)
+#define AM35XX_HECC_INT_LINE		(0x0)
+#define AM35XX_HECC_VERSION		(0x1)
+
+
 #endif /*  __ASM_ARCH_AM35XX_H */
-- 
1.6.2.4

