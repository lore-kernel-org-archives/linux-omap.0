From: Sriramakrishnan <srk@ti.com>
Subject: [PATCH v2 1/2] can:ti_hecc: board specific hookup on AM3517EVM
Date: Fri, 26 Feb 2010 17:37:14 +0530
Message-ID: <1267186035-8146-2-git-send-email-srk@ti.com>
References: <1267186035-8146-1-git-send-email-srk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44435 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935815Ab0BZMHV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Feb 2010 07:07:21 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o1QC7HLG028546
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 26 Feb 2010 06:07:19 -0600
In-Reply-To: <1267186035-8146-1-git-send-email-srk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: anantgole@ti.com, Sriramakrishnan <srk@ti.com>

Add board specific hookup for TI HECC driver on
AM3517 EVM

Signed-off-by: Sriramakrishnan <srk@ti.com>
---
Addressed review comments about formatting and patch ordering.

 arch/arm/mach-omap2/board-am3517evm.c     |   38 +++++++++++++++++++++++++++++
 arch/arm/mach-omap2/include/mach/am35xx.h |    9 +++++++
 2 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index e6b8967..ddcfa07 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -21,6 +21,7 @@
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
 #include <linux/i2c/pca953x.h>
+#include <linux/can/platform/ti_hecc.h>
 
 #include <mach/hardware.h>
 #include <mach/am35xx.h>
@@ -292,6 +293,42 @@ static struct omap_board_mux board_mux[] __initdata = {
 #define board_mux	NULL
 #endif
 
+
+static struct resource am3517_hecc_resources[] = {
+	{
+		.start	= AM35XX_IPSS_HECC_BASE,
+		.end	= AM35XX_IPSS_HECC_BASE + 0x3FFF,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= INT_35XX_HECC0_IRQ,
+		.end	= INT_35XX_HECC0_IRQ,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device am3517_hecc_device = {
+	.name		= "ti_hecc",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(am3517_hecc_resources),
+	.resource	= am3517_hecc_resources,
+};
+
+static struct ti_hecc_platform_data am3517_evm_hecc_pdata = {
+	.scc_hecc_offset	= AM35XX_HECC_SCC_HECC_OFFSET,
+	.scc_ram_offset		= AM35XX_HECC_SCC_RAM_OFFSET,
+	.hecc_ram_offset	= AM35XX_HECC_RAM_OFFSET,
+	.mbx_offset		= AM35XX_HECC_MBOX_OFFSET,
+	.int_line		= AM35XX_HECC_INT_LINE,
+	.version		= AM35XX_HECC_VERSION,
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
@@ -302,6 +339,7 @@ static void __init am3517_evm_init(void)
 
 	omap_serial_init();
 	usb_ehci_init(&ehci_pdata);
+	am3517_evm_hecc_init(&am3517_evm_hecc_pdata);
 	/* DSS */
 	am3517_evm_display_init();
 
diff --git a/arch/arm/mach-omap2/include/mach/am35xx.h b/arch/arm/mach-omap2/include/mach/am35xx.h
index a705f94..0636263 100644
--- a/arch/arm/mach-omap2/include/mach/am35xx.h
+++ b/arch/arm/mach-omap2/include/mach/am35xx.h
@@ -23,4 +23,13 @@
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
 #endif /*  __ASM_ARCH_AM35XX_H */
-- 
1.6.2.4

