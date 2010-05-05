From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 08/18] can:ti_hecc: board specific hookup on AM3517EVM
Date: Wed, 05 May 2010 12:32:57 -0700
Message-ID: <20100505193257.21568.27937.stgit@baageli.muru.com>
References: <20100505192957.21568.19569.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:56552 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752176Ab0EETc6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 15:32:58 -0400
In-Reply-To: <20100505192957.21568.19569.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Sriramakrishnan <srk@ti.com>, linux-omap@vger.kernel.org

From: Sriram <srk@ti.com>

Add board specific hookup for TI HECC driver on
AM3517 EVM

Signed-off-by: Sriramakrishnan <srk@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-am3517evm.c     |   38 +++++++++++++++++++++++++++++
 arch/arm/mach-omap2/include/mach/am35xx.h |    9 +++++++
 2 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index c1c4389..6ca0075 100644
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
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
@@ -305,6 +342,7 @@ static void __init am3517_evm_init(void)
 	/* Configure GPIO for EHCI port */
 	omap_mux_init_gpio(57, OMAP_PIN_OUTPUT);
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

