From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/3] ARM: OMAP AM35xx: clock and hwmod data: fix UART4 data
Date: Thu, 10 May 2012 11:29:18 -0600
Message-ID: <20120510172917.13418.14437.stgit@dusk>
References: <20120510172449.13418.66815.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47643 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757731Ab2EJRdV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 May 2012 13:33:21 -0400
In-Reply-To: <20120510172449.13418.66815.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kyle Manna <kyle.manna@fuel7.com>, "Mark A. Greer" <mgreer@animalcreek.com>, Ranjith Lohithakshan <ranjithl@ti.com>

Add missing terminators to the arrays of IRQ, DMA, and address space
structure records in the AM35xx UART4 hwmod data.  Without these
terminators, the following warnings appear on boot:

omap_uart.3: failed to claim resource 58
omap_device: omap_uart: build failed (-16)
WARNING: at /home/paul/linux/arch/arm/mach-omap2/serial.c:375 omap_serial_init_port+0x198/0x284()
Could not build omap_device for omap_uart: uart4.

Also, AM35xx uart4_fck has an incorrect parent clock pointer.  Fix it
and clean up a whitespace issue.

Fix some incorrectly-named macros related to AM35xx UART4.

Cc: Kyle Manna <kyle.manna@fuel7.com>
Cc: Mark A. Greer <mgreer@animalcreek.com>
Cc: Ranjith Lohithakshan <ranjithl@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock3xxx_data.c       |   14 +++++++-------
 arch/arm/mach-omap2/cm-regbits-34xx.h      |    4 ++--
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    7 +++++--
 arch/arm/mach-omap2/prcm-common.h          |    4 ++--
 4 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 13102b9..11644bf 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -2490,13 +2490,13 @@ static struct clk uart4_fck = {
 };
 
 static struct clk uart4_fck_am35xx = {
-	.name           = "uart4_fck",
-	.ops            = &clkops_omap2_dflt_wait,
-	.parent         = &per_48m_fck,
-	.enable_reg     = OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
-	.enable_bit     = OMAP3430_EN_UART4_SHIFT,
-	.clkdm_name     = "core_l4_clkdm",
-	.recalc         = &followparent_recalc,
+	.name		= "uart4_fck",
+	.ops		= &clkops_omap2_dflt_wait,
+	.parent		= &core_48m_fck,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= AM35XX_EN_UART4_SHIFT,
+	.clkdm_name	= "core_l4_clkdm",
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk gpt2_fck = {
diff --git a/arch/arm/mach-omap2/cm-regbits-34xx.h b/arch/arm/mach-omap2/cm-regbits-34xx.h
index 8083a8c..766338f 100644
--- a/arch/arm/mach-omap2/cm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/cm-regbits-34xx.h
@@ -169,8 +169,6 @@
 /* AM35XX specific CM_ICLKEN1_CORE bits */
 #define AM35XX_EN_IPSS_MASK				(1 << 4)
 #define AM35XX_EN_IPSS_SHIFT				4
-#define AM35XX_EN_UART4_MASK				(1 << 23)
-#define AM35XX_EN_UART4_SHIFT				23
 
 /* CM_ICLKEN2_CORE */
 #define OMAP3430_EN_PKA_MASK				(1 << 4)
@@ -207,6 +205,8 @@
 #define OMAP3430_ST_DES2_MASK				(1 << 26)
 #define OMAP3430_ST_MSPRO_SHIFT				23
 #define OMAP3430_ST_MSPRO_MASK				(1 << 23)
+#define AM35XX_ST_UART4_SHIFT				23
+#define AM35XX_ST_UART4_MASK				(1 << 23)
 #define OMAP3430_ST_HDQ_SHIFT				22
 #define OMAP3430_ST_HDQ_MASK				(1 << 22)
 #define OMAP3430ES1_ST_FAC_SHIFT			8
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 678a3aa..c939131 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -526,11 +526,13 @@ static struct omap_hwmod omap36xx_uart4_hwmod = {
 
 static struct omap_hwmod_irq_info am35xx_uart4_mpu_irqs[] = {
 	{ .irq = INT_35XX_UART4_IRQ, },
+	{ .irq = -1 }
 };
 
 static struct omap_hwmod_dma_info am35xx_uart4_sdma_reqs[] = {
 	{ .name = "rx", .dma_req = AM35XX_DMA_UART4_RX, },
 	{ .name = "tx", .dma_req = AM35XX_DMA_UART4_TX, },
+	{ .dma_req = -1 }
 };
 
 static struct omap_hwmod am35xx_uart4_hwmod = {
@@ -542,9 +544,9 @@ static struct omap_hwmod am35xx_uart4_hwmod = {
 		.omap2 = {
 			.module_offs = CORE_MOD,
 			.prcm_reg_id = 1,
-			.module_bit = OMAP3430_EN_UART4_SHIFT,
+			.module_bit = AM35XX_EN_UART4_SHIFT,
 			.idlest_reg_id = 1,
-			.idlest_idle_bit = OMAP3430_EN_UART4_SHIFT,
+			.idlest_idle_bit = AM35XX_ST_UART4_SHIFT,
 		},
 	},
 	.class		= &omap2_uart_class,
@@ -2188,6 +2190,7 @@ static struct omap_hwmod_addr_space am35xx_uart4_addr_space[] = {
 		.pa_end		= OMAP3_UART4_AM35XX_BASE + SZ_1K - 1,
 		.flags		= ADDR_MAP_ON_INIT | ADDR_TYPE_RT,
 	},
+	{ }
 };
 
 static struct omap_hwmod_ocp_if am35xx_l4_core__uart4 = {
diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
index 6da3ba4..cc1398e 100644
--- a/arch/arm/mach-omap2/prcm-common.h
+++ b/arch/arm/mach-omap2/prcm-common.h
@@ -203,8 +203,8 @@
 #define OMAP3430_EN_MMC2_SHIFT				25
 #define OMAP3430_EN_MMC1_MASK				(1 << 24)
 #define OMAP3430_EN_MMC1_SHIFT				24
-#define OMAP3430_EN_UART4_MASK				(1 << 23)
-#define OMAP3430_EN_UART4_SHIFT				23
+#define AM35XX_EN_UART4_MASK				(1 << 23)
+#define AM35XX_EN_UART4_SHIFT				23
 #define OMAP3430_EN_MCSPI4_MASK				(1 << 21)
 #define OMAP3430_EN_MCSPI4_SHIFT			21
 #define OMAP3430_EN_MCSPI3_MASK				(1 << 20)


