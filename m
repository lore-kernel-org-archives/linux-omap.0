From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 8/8] OMAP2430/34xx HSMMC: add basic omap_hwmod entries for
	OMAP2430/34xx
Date: Fri, 05 Jun 2009 04:19:46 -0600
Message-ID: <20090605101945.32500.66350.stgit@localhost.localdomain>
References: <20090605101635.32500.63083.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47684 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753326AbZFEKUe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Jun 2009 06:20:34 -0400
In-Reply-To: <20090605101635.32500.63083.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Add basic HSMMC hardware modules for OMAP2430 and OMAP34xx.

The integration data is so similar between 2430 and 34xx in this
case that these entries could almost be shared; that is probably worth
investigating.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_2430.h     |  143 ++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_34xx.h     |  236 +++++++++++++++++++++++++++++
 arch/arm/mach-omap2/prm-regbits-34xx.h    |    8 +
 arch/arm/plat-omap/include/mach/l4_3xxx.h |   24 +++
 arch/arm/plat-omap/include/mach/mmc.h     |    8 +
 5 files changed, 415 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/mach/l4_3xxx.h

diff --git a/arch/arm/mach-omap2/omap_hwmod_2430.h b/arch/arm/mach-omap2/omap_hwmod_2430.h
index 24e3521..0ae23f3 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430.h
+++ b/arch/arm/mach-omap2/omap_hwmod_2430.h
@@ -21,6 +21,9 @@
 #include <mach/cpu.h>
 #include <mach/dma.h>
 
+#include <mach/mmc.h>
+
+#include "cm-regbits-24xx.h"
 #include "prm-regbits-24xx.h"
 
 static struct omap_hwmod omap2430_mpu_hwmod;
@@ -72,6 +75,43 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__l4_wkup = {
 	.user	= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+/* L4 CORE -> MMC1 interface */
+static struct omap_hwmod_addr_space omap2430_mmc1_addr_space[] = {
+	{
+		.pa_start	= OMAP2_MMC1_BASE,
+		.pa_end		= OMAP2_MMC1_BASE + 512 - 1,
+		.flags		= ADDR_TYPE_RT,
+	},
+};
+
+static struct omap_hwmod_ocp_if omap2430_l4_core__mmc1 = {
+	.master		= &omap2430_l4_core_hwmod,
+	.slave		= &omap2430_mmc1_hwmod,
+	.interface_clk	= { .name = "mmchs1_ick" },
+	.addr		= omap2430_mmc1_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap2430_mmc1_addr_space),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* L4 CORE -> MMC2 interface */
+static struct omap_hwmod_addr_space omap2430_mmc2_addr_space[] = {
+	{
+		.pa_start	= OMAP2_MMC2_BASE,
+		.pa_end		= OMAP2_MMC2_BASE + 512 - 1,
+		.flags		= ADDR_TYPE_RT,
+	},
+};
+
+static struct omap_hwmod_ocp_if omap2430_l4_core__mmc2 = {
+	.master		= &omap2430_l4_core_hwmod,
+	.slave		= &omap2430_mmc2_hwmod,
+	.interface_clk	= { .name = "mmchs2_ick" },
+	.addr		= omap2430_mmc2_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap2430_mmc2_addr_space),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+
 /* Slave interfaces on the L4_CORE interconnect */
 static struct omap_hwmod_ocp_if *omap2430_l4_core_slaves[] = {
 	&omap2430_l3__l4_core,
@@ -80,6 +120,8 @@ static struct omap_hwmod_ocp_if *omap2430_l4_core_slaves[] = {
 /* Master interfaces on the L4_CORE interconnect */
 static struct omap_hwmod_ocp_if *omap2430_l4_core_masters[] = {
 	&omap2430_l4_core__l4_wkup,
+	&omap2430_l4_core__mmc1,
+	&omap2430_l4_core__mmc2,
 };
 
 /* L4 CORE */
@@ -125,6 +167,107 @@ static struct omap_hwmod omap2430_mpu_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 };
 
+/* MMC/SD/SDIO common */
+
+static struct omap_hwmod_sysconfig mmc_if_ctrl = {
+	.rev_offs	= 0x10,
+	.sysc_offs	= 0x14,
+	.sysc_flags	= (SYSC_HAS_CLOCKACTIVITY | SYSC_HAS_SIDLEMODE |
+			   SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
+			   SYSC_HAS_AUTOIDLE | SYSS_MISSING),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+};
+
+/* MMC/SD/SDIO1 */
+
+static struct mmc_dev_attr mmc1_dev_attr = {
+	.flags = MMC_INTERNAL_XCVR,
+};
+
+static u8 mmc1_mpu_irqs[] = {
+	INT_24XX_MMC_IRQ,
+};
+
+static struct omap_hwmod_dma_info mmc1_sdma_chs[] = {
+	{ .name = "tx",	.dma_ch = OMAP24XX_DMA_MMC1_TX, },
+	{ .name = "rx",	.dma_ch = OMAP24XX_DMA_MMC1_RX, },
+};
+
+static struct omap_hwmod_opt_clk mmc1_opt_clks[] = {
+	{ .role = "dbck", .clk = { .name = "mmchsdb1_fck" } },
+};
+
+static struct omap_hwmod_ocp_if *omap2430_mmc1_slaves[] = {
+	&omap2430_l4_core__mmc1,
+};
+
+static struct omap_hwmod omap2430_mmc1_hwmod = {
+	.name		= "mmc1_hwmod",
+	.mpu_irqs	= mmc1_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(mmc1_mpu_irqs),
+	.sdma_chs	= mmc1_sdma_chs,
+	.sdma_chs_cnt	= ARRAY_SIZE(mmc1_sdma_chs),
+	.opt_clks	= mmc1_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(mmc1_opt_clks),
+	.main_clk	= { .name = "mmchs1_fck" },
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 2,
+			.module_bit  = OMAP2430_EN_MMCHS1_SHIFT,
+		},
+	},
+	.slaves		= omap2430_mmc1_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2430_mmc1_slaves),
+	.sysconfig	= &mmc_if_ctrl,
+	.dev_attr	= &mmc1_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
+};
+
+/* MMC/SD/SDIO2 */
+
+static struct mmc_dev_attr mmc2_dev_attr = {
+	.flags = MMC_SUPPORTS_EXTERNAL_XCVR,
+};
+
+static u8 mmc2_mpu_irqs[] = {
+	INT_24XX_MMC2_IRQ,
+};
+
+static struct omap_hwmod_dma_info mmc2_sdma_chs[] = {
+	{ .name = "tx",	.dma_ch = OMAP24XX_DMA_MMC2_TX, },
+	{ .name = "rx",	.dma_ch = OMAP24XX_DMA_MMC2_RX, },
+};
+
+static struct omap_hwmod_opt_clk mmc2_opt_clks[] = {
+	{ .role = "dbck", .clk = { .name = "mmchsdb2_fck" } },
+};
+
+static struct omap_hwmod_ocp_if *omap2430_mmc2_slaves[] = {
+	&omap2430_l4_core__mmc2,
+};
+
+static struct omap_hwmod omap2430_mmc2_hwmod = {
+	.name		= "mmc2_hwmod",
+	.mpu_irqs	= mmc2_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(mmc2_mpu_irqs),
+	.sdma_chs	= mmc2_sdma_chs,
+	.sdma_chs_cnt	= ARRAY_SIZE(mmc2_sdma_chs),
+	.opt_clks	= mmc2_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(mmc2_opt_clks),
+	.main_clk	= { .name = "mmchs2_fck" },
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 2,
+			.module_bit  = OMAP2430_EN_MMCHS2_SHIFT,
+		},
+	},
+	.slaves		= omap2430_mmc2_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap2430_mmc2_slaves),
+	.sysconfig	= &mmc_if_ctrl,
+	.dev_attr	= &mmc2_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
+};
+
 static __initdata struct omap_hwmod *omap2430_hwmods[] = {
 	&omap2430_l3_hwmod,
 	&omap2430_l4_core_hwmod,
diff --git a/arch/arm/mach-omap2/omap_hwmod_34xx.h b/arch/arm/mach-omap2/omap_hwmod_34xx.h
index f936e11..afc3cd4 100644
--- a/arch/arm/mach-omap2/omap_hwmod_34xx.h
+++ b/arch/arm/mach-omap2/omap_hwmod_34xx.h
@@ -17,8 +17,11 @@
 #include <mach/omap_hwmod.h>
 #include <mach/irqs.h>
 #include <mach/cpu.h>
+#include <mach/l4_3xxx.h>
 #include <mach/dma.h>
 
+#include <mach/mmc.h>
+
 #include "prm-regbits-34xx.h"
 
 static struct omap_hwmod omap34xx_mpu_hwmod;
@@ -69,6 +72,9 @@ static struct omap_hwmod omap34xx_l3_hwmod = {
 };
 
 static struct omap_hwmod omap34xx_l4_wkup_hwmod;
+static struct omap_hwmod omap34xx_mmc1_hwmod;
+static struct omap_hwmod omap34xx_mmc2_hwmod;
+static struct omap_hwmod omap34xx_mmc3_hwmod;
 
 /* L4_CORE -> L4_WKUP interface */
 static struct omap_hwmod_ocp_if omap34xx_l4_core__l4_wkup = {
@@ -77,14 +83,92 @@ static struct omap_hwmod_ocp_if omap34xx_l4_core__l4_wkup = {
 	.user	= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-/* Slave interfaces on the L4_CORE interconnect */
+/* L4 CORE -> MMC1 interface */
+static struct omap_hwmod_addr_space omap34xx_mmc1_addr_space[] = {
+	{
+		.pa_start	= OMAP2_MMC1_BASE,
+		.pa_end		= OMAP2_MMC1_BASE + 512 - 1,
+		.flags		= ADDR_TYPE_RT,
+	},
+};
+
+static struct omap_hwmod_ocp_if omap34xx_l4_core__mmc1 = {
+	.master		= &omap34xx_l4_core_hwmod,
+	.slave		= &omap34xx_mmc1_hwmod,
+	.interface_clk	= { .name = "mmchs1_ick" },
+	.addr		= omap34xx_mmc1_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap34xx_mmc1_addr_space),
+	.fw = {
+		.omap2 = {
+			.l4_fw_region = OMAP3_L4_CORE_FW_MMC1_REGION,
+			.l4_prot_group = 7,
+		}
+	},
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+	.flags		= OMAP_FIREWALL_L4
+};
+
+/* L4 CORE -> MMC2 interface */
+static struct omap_hwmod_addr_space omap34xx_mmc2_addr_space[] = {
+	{
+		.pa_start	= OMAP2_MMC2_BASE,
+		.pa_end		= OMAP2_MMC2_BASE + 512 - 1,
+		.flags		= ADDR_TYPE_RT,
+	},
+};
+
+static struct omap_hwmod_ocp_if omap34xx_l4_core__mmc2 = {
+	.master		= &omap34xx_l4_core_hwmod,
+	.slave		= &omap34xx_mmc2_hwmod,
+	.interface_clk	= { .name = "mmchs2_ick" },
+	.addr		= omap34xx_mmc2_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap34xx_mmc2_addr_space),
+	.fw = {
+		.omap2 = {
+			.l4_fw_region = OMAP3_L4_CORE_FW_MMC2_REGION,
+			.l4_prot_group = 7,
+		}
+	},
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+	.flags		= OMAP_FIREWALL_L4
+};
+
+/* L4 CORE -> MMC3 interface */
+static struct omap_hwmod_addr_space omap34xx_mmc3_addr_space[] = {
+	{
+		.pa_start	= OMAP3_MMC3_BASE,
+		.pa_end		= OMAP3_MMC3_BASE + 512 - 1,
+		.flags		= ADDR_TYPE_RT,
+	},
+};
+
+static struct omap_hwmod_ocp_if omap34xx_l4_core__mmc3 = {
+	.master		= &omap34xx_l4_core_hwmod,
+	.slave		= &omap34xx_mmc3_hwmod,
+	.interface_clk	= { .name = "mmchs3_ick" },
+	.addr		= omap34xx_mmc3_addr_space,
+	.addr_cnt	= ARRAY_SIZE(omap34xx_mmc3_addr_space),
+	.fw = {
+		.omap2 = {
+			.l4_fw_region  = OMAP3_L4_CORE_FW_MMC3_REGION,
+			.l4_prot_group = 7,
+		}
+	},
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+	.flags		= OMAP_FIREWALL_L4
+};
+
+/* Slave interfaces on the L4 CORE interconnect */
 static struct omap_hwmod_ocp_if *omap34xx_l4_core_slaves[] = {
 	&omap34xx_l3__l4_core,
 };
 
-/* Master interfaces on the L4_CORE interconnect */
+/* Master interfaces on the L4 CORE interconnect */
 static struct omap_hwmod_ocp_if *omap34xx_l4_core_masters[] = {
 	&omap34xx_l4_core__l4_wkup,
+	&omap34xx_l4_core__mmc1,
+	&omap34xx_l4_core__mmc2,
+	&omap34xx_l4_core__mmc3,
 };
 
 /* L4 CORE */
@@ -149,12 +233,160 @@ static struct omap_hwmod omap34xx_mpu_hwmod = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
 
+/* MMC/SD/SDIO common */
+
+static struct omap_hwmod_sysconfig mmc_if_ctrl = {
+	.rev_offs	= 0x10,
+	.sysc_offs	= 0x14,
+	.sysc_flags	= (SYSC_HAS_CLOCKACTIVITY | SYSC_HAS_SIDLEMODE |
+			   SYSC_HAS_ENAWAKEUP | SYSC_HAS_SOFTRESET |
+			   SYSC_HAS_AUTOIDLE),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+};
+
+/* MMC/SD/SDIO1 */
+
+static struct mmc_dev_attr mmc1_dev_attr = {
+	.flags = MMC_INTERNAL_XCVR,
+};
+
+static u8 mmc1_mpu_irqs[] = {
+	INT_24XX_MMC_IRQ,
+};
+
+static struct omap_hwmod_dma_info mmc1_sdma_chs[] = {
+	{ .name = "tx",	.dma_ch = OMAP24XX_DMA_MMC1_TX, },
+	{ .name = "rx",	.dma_ch = OMAP24XX_DMA_MMC1_RX, },
+};
+
+static struct omap_hwmod_opt_clk mmc1_opt_clks[] = {
+	{ .role = "dbck", .clk = { .name = "omap_32k_fck" } },
+};
+
+static struct omap_hwmod_ocp_if *omap34xx_mmc1_slaves[] = {
+	&omap34xx_l4_core__mmc1,
+};
+
+static struct omap_hwmod omap34xx_mmc1_hwmod = {
+	.name		= "mmc1_hwmod",
+	.mpu_irqs	= mmc1_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(mmc1_mpu_irqs),
+	.sdma_chs	= mmc1_sdma_chs,
+	.sdma_chs_cnt	= ARRAY_SIZE(mmc1_sdma_chs),
+	.opt_clks	= mmc1_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(mmc1_opt_clks),
+	.main_clk	= { .name = "mmchs1_fck" },
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_GRPSEL_MMC1_SHIFT,
+		},
+	},
+	.slaves		= omap34xx_mmc1_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap34xx_mmc1_slaves),
+	.sysconfig	= &mmc_if_ctrl,
+	.dev_attr	= &mmc1_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
+/* MMC/SD/SDIO2 */
+
+static struct mmc_dev_attr mmc2_dev_attr = {
+	.flags = MMC_SUPPORTS_EXTERNAL_XCVR,
+};
+
+static u8 mmc2_mpu_irqs[] = {
+	INT_24XX_MMC2_IRQ,
+};
+
+static struct omap_hwmod_dma_info mmc2_sdma_chs[] = {
+	{ .name = "tx",	.dma_ch = OMAP24XX_DMA_MMC2_TX, },
+	{ .name = "rx",	.dma_ch = OMAP24XX_DMA_MMC2_RX, },
+};
+
+static struct omap_hwmod_opt_clk mmc2_opt_clks[] = {
+	{ .role = "dbck", .clk = { .name = "omap_32k_fck" } },
+};
+
+static struct omap_hwmod_ocp_if *omap34xx_mmc2_slaves[] = {
+	&omap34xx_l4_core__mmc2,
+};
+
+static struct omap_hwmod omap34xx_mmc2_hwmod = {
+	.name		= "mmc2_hwmod",
+	.mpu_irqs	= mmc2_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(mmc2_mpu_irqs),
+	.sdma_chs	= mmc2_sdma_chs,
+	.sdma_chs_cnt	= ARRAY_SIZE(mmc2_sdma_chs),
+	.opt_clks	= mmc2_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(mmc2_opt_clks),
+	.main_clk	= { .name = "mmchs2_fck" },
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_GRPSEL_MMC2_SHIFT,
+		},
+	},
+	.slaves		= omap34xx_mmc2_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap34xx_mmc2_slaves),
+	.sysconfig	= &mmc_if_ctrl,
+	.dev_attr	= &mmc2_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
+/* MMC/SD/SDIO3 */
+
+static struct mmc_dev_attr mmc3_dev_attr;
+
+static u8 mmc3_mpu_irqs[] = {
+	INT_24XX_MMC_IRQ,
+};
+
+static struct omap_hwmod_dma_info mmc3_sdma_chs[] = {
+	{ .name = "tx",	.dma_ch = OMAP34XX_DMA_MMC3_TX, },
+	{ .name = "rx",	.dma_ch = OMAP34XX_DMA_MMC3_RX, },
+};
+
+static struct omap_hwmod_opt_clk mmc3_opt_clks[] = {
+	{ .role = "dbck", .clk = { .name = "omap_32k_fck" } },
+};
+
+static struct omap_hwmod_ocp_if *omap34xx_mmc3_slaves[] = {
+	&omap34xx_l4_core__mmc3,
+};
+
+static struct omap_hwmod omap34xx_mmc3_hwmod = {
+	.name		= "mmc3_hwmod",
+	.mpu_irqs	= mmc3_mpu_irqs,
+	.mpu_irqs_cnt	= ARRAY_SIZE(mmc3_mpu_irqs),
+	.sdma_chs	= mmc3_sdma_chs,
+	.sdma_chs_cnt	= ARRAY_SIZE(mmc3_sdma_chs),
+	.opt_clks	= mmc3_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(mmc3_opt_clks),
+	.main_clk	= { .name = "mmchs3_fck" },
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430ES2_GRPSEL_MMC3_SHIFT,
+		},
+	},
+	.slaves		= omap34xx_mmc3_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap34xx_mmc3_slaves),
+	.sysconfig	= &mmc_if_ctrl,
+	.dev_attr	= &mmc3_dev_attr,
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+};
+
+
 static __initdata struct omap_hwmod *omap34xx_hwmods[] = {
 	&omap34xx_l3_hwmod,
 	&omap34xx_l4_core_hwmod,
 	&omap34xx_l4_per_hwmod,
 	&omap34xx_l4_wkup_hwmod,
 	&omap34xx_mpu_hwmod,
+	&omap34xx_mmc1_hwmod,
+	&omap34xx_mmc2_hwmod,
+	&omap34xx_mmc3_hwmod,
 	NULL,
 };
 
diff --git a/arch/arm/mach-omap2/prm-regbits-34xx.h b/arch/arm/mach-omap2/prm-regbits-34xx.h
index 9fd03a2..8533d74 100644
--- a/arch/arm/mach-omap2/prm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/prm-regbits-34xx.h
@@ -95,8 +95,12 @@
 #define OMAP3430_WKUP_EN					(1 << 0)
 
 /* PM_MPUGRPSEL1_CORE, PM_IVA2GRPSEL1_CORE shared bits */
-#define OMAP3430_GRPSEL_MMC2				(1 << 25)
-#define OMAP3430_GRPSEL_MMC1				(1 << 24)
+#define OMAP3430ES2_GRPSEL_MMC3_SHIFT			30
+#define OMAP3430ES2_GRPSEL_MMC3_MASK			(1 << 30)
+#define OMAP3430_GRPSEL_MMC2_SHIFT			25
+#define OMAP3430_GRPSEL_MMC2_MASK			(1 << 25)
+#define OMAP3430_GRPSEL_MMC1_SHIFT			24
+#define OMAP3430_GRPSEL_MMC1_MASK			(1 << 24)
 #define OMAP3430_GRPSEL_MCSPI4				(1 << 21)
 #define OMAP3430_GRPSEL_MCSPI3				(1 << 20)
 #define OMAP3430_GRPSEL_MCSPI2				(1 << 19)
diff --git a/arch/arm/plat-omap/include/mach/l4_3xxx.h b/arch/arm/plat-omap/include/mach/l4_3xxx.h
new file mode 100644
index 0000000..06ead5c
--- /dev/null
+++ b/arch/arm/plat-omap/include/mach/l4_3xxx.h
@@ -0,0 +1,24 @@
+/*
+ * arch/arm/plat-omap/include/mach/l4_3xxx.h - L4 firewall definitions
+ *
+ * Copyright (C) 2009 Nokia Corporation
+ * Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+#ifndef __ARCH_ARM_PLAT_OMAP_INCLUDE_MACH_L4_3XXX_H
+#define __ARCH_ARM_PLAT_OMAP_INCLUDE_MACH_L4_3XXX_H
+
+/* L4 CORE */
+#define OMAP3_L4_CORE_FW_MMC1_REGION				39
+#define OMAP3_L4_CORE_FW_MMC1_TA_REGION				40
+#define OMAP3_L4_CORE_FW_MMC2_REGION				41
+#define OMAP3_L4_CORE_FW_MMC2_TA_REGION				42
+#define OMAP3_L4_CORE_FW_MMC3_REGION				98
+#define OMAP3_L4_CORE_FW_MMC3_TA_REGION				99
+
+#endif
diff --git a/arch/arm/plat-omap/include/mach/mmc.h b/arch/arm/plat-omap/include/mach/mmc.h
index 81d5b36..4996a54 100644
--- a/arch/arm/plat-omap/include/mach/mmc.h
+++ b/arch/arm/plat-omap/include/mach/mmc.h
@@ -36,6 +36,14 @@
 
 #define OMAP_MMC_MAX_SLOTS	2
 
+/* omap_hwmod integration data */
+#define MMC_INTERNAL_XCVR		(1 << 0)
+#define MMC_SUPPORTS_EXTERNAL_XCVR	(1 << 1)
+
+struct mmc_dev_attr {
+	u8 flags;
+};
+
 struct omap_mmc_platform_data {
 	/* back-link to device */
 	struct device *dev;


