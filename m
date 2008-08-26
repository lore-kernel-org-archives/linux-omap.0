From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 03/06] scratchpad populate
Date: Tue, 26 Aug 2008 18:34:21 +0530 (IST)
Message-ID: <65457.192.168.10.89.1219755861.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37538 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754124AbYHZNE1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Aug 2008 09:04:27 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id m7QD4Lpl020358
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 26 Aug 2008 08:04:26 -0500
Received: from webmail.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id m7QD4JSn025282
	for <linux-omap@vger.kernel.org>; Tue, 26 Aug 2008 08:04:20 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch populates the scratchpad contents
as expected by the bootROM code.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>

---
 arch/arm/mach-omap2/control.c             |  129 ++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/pm34xx.c              |    2
 arch/arm/plat-omap/include/mach/control.h |   69 ++++++++++++++++
 3 files changed, 200 insertions(+)

Index: linux-omap-2.6/arch/arm/mach-omap2/control.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/control.c	2008-08-26
15:47:52.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/control.c	2008-08-26 17:02:55.000000000
+0530
@@ -17,6 +17,13 @@

 #include <mach/common.h>
 #include <mach/control.h>
+#include <mach/sdrc.h>
+#include "cm-regbits-34xx.h"
+#include "prm-regbits-34xx.h"
+#include "cm.h"
+#include "prm.h"
+#include "clock34xx.h"
+#include "sdrc.h"

 static void __iomem *omap2_ctrl_base;

@@ -62,3 +69,125 @@ void omap_ctrl_writel(u32 val, u16 offse
 	__raw_writel(val, OMAP_CTRL_REGADDR(offset));
 }

+#ifdef CONFIG_ARCH_OMAP3
+
+#define OMAP3430_PRM_RSTST \
+		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, RM_RSTST)
+/* Clears the scratchpad contents in case of cold boot-
+ called during bootup*/
+void omap3_clear_scratchpad_contents(void)
+{
+	u32 max_offset = OMAP343X_SCRATHPAD_ROM_OFFSET;
+	u32 offset = 0;
+	u32 v;
+	u32 v_addr = io_p2v(OMAP343X_SCRATCHPAD_ROM);
+	if (__raw_readl(OMAP3430_PRM_RSTST) & 0x1) {
+		for ( ; offset <= max_offset; offset += 0x4)
+			__raw_writel(0x0, (v_addr + offset));
+		v = __raw_readl(OMAP3430_PRM_RSTST);
+		v |= 0x1;
+		__raw_writel(v, OMAP3430_PRM_RSTST);
+	}
+}
+
+/* Populate the scratchpad structure with restore structure */
+void omap3_save_scratchpad_contents(void)
+{
+	u32 *scratchpad_address;
+	u32 *sdram_context_address;
+	struct omap3_scratchpad scratchpad_contents;
+	struct omap3_scratchpad_prcm_block prcm_block_contents;
+	struct omap3_scratchpad_sdrc_block sdrc_block_contents;
+
+	/* Populate the Scratchpad contents */
+	scratchpad_contents.boot_config_ptr = 0x0;
+	scratchpad_contents.public_restore_ptr =
+			(u32)((u32 *)virt_to_phys(get_restore_pointer()));
+	scratchpad_contents.secure_ram_restore_ptr = 0x0;
+	scratchpad_contents.sdrc_module_semaphore = 0x0;
+	scratchpad_contents.prcm_block_offset = 0x2C;
+	scratchpad_contents.sdrc_block_offset = 0x64;
+
+	/* Populate the PRCM block contents */
+	prcm_block_contents.prm_clksrc_ctrl =
+			__raw_readl(OMAP3430_PRM_CLKSRC_CTRL);
+	prcm_block_contents.prm_clksel =
+			__raw_readl(OMAP3430_PRM_CLKSEL);
+	prcm_block_contents.cm_clksel_core =
+			cm_read_mod_reg(CORE_MOD, CM_CLKSEL);
+	prcm_block_contents.cm_clksel_wkup =
+			cm_read_mod_reg(WKUP_MOD, CM_CLKSEL);
+	prcm_block_contents.cm_clken_pll =
+			cm_read_mod_reg(PLL_MOD, OMAP3430_CM_CLKEN_PLL);
+	prcm_block_contents.cm_autoidle_pll =
+			cm_read_mod_reg(PLL_MOD, OMAP3430_CM_AUTOIDLE_PLL);
+	prcm_block_contents.cm_clksel1_pll =
+			cm_read_mod_reg(PLL_MOD, OMAP3430_CM_CLKSEL1_PLL);
+	prcm_block_contents.cm_clksel2_pll =
+			cm_read_mod_reg(PLL_MOD, OMAP3430_CM_CLKSEL2_PLL);
+	prcm_block_contents.cm_clksel3_pll =
+			cm_read_mod_reg(PLL_MOD, OMAP3430_CM_CLKSEL3);
+	prcm_block_contents.cm_clken_pll_mpu =
+			cm_read_mod_reg(MPU_MOD, OMAP3430_CM_CLKEN_PLL);
+	prcm_block_contents.cm_autoidle_pll_mpu =
+			cm_read_mod_reg(MPU_MOD, OMAP3430_CM_AUTOIDLE_PLL);
+	prcm_block_contents.cm_clksel1_pll_mpu =
+			cm_read_mod_reg(MPU_MOD, OMAP3430_CM_CLKSEL1_PLL);
+	prcm_block_contents.cm_clksel2_pll_mpu =
+			cm_read_mod_reg(MPU_MOD, OMAP3430_CM_CLKSEL2_PLL);
+	prcm_block_contents.prcm_block_size = 0x0;
+
+	/* Populate the SDRC block contents */
+	sdrc_block_contents.sdrc_sysconfig =
+			(sdrc_read_reg(SDRC_SYSCONFIG) & 0xFFFF);
+	sdrc_block_contents.sdrc_cs_cfg =
+			(sdrc_read_reg(SDRC_CS_CFG) & 0xFFFF);
+	sdrc_block_contents.sdrc_sharing =
+			(sdrc_read_reg(SDRC_SHARING) & 0xFFFF);
+	sdrc_block_contents.sdrc_err_type =
+			(sdrc_read_reg(SDRC_ERR_TYPE) & 0xFFFF);
+	sdrc_block_contents.sdrc_dll_a_ctrl = sdrc_read_reg(SDRC_DLLA_CTRL);
+	sdrc_block_contents.sdrc_dll_b_ctrl = 0x0;
+	sdrc_block_contents.sdrc_power = sdrc_read_reg(SDRC_POWER);
+	sdrc_block_contents.sdrc_cs_0 = 0x0;
+	sdrc_block_contents.sdrc_mcfg_0 = sdrc_read_reg(SDRC_MCFG_0);
+	sdrc_block_contents.sdrc_mr_0 = (sdrc_read_reg(SDRC_MR_0) & 0xFFFF);
+	sdrc_block_contents.sdrc_emr_1_0 = 0x0;
+	sdrc_block_contents.sdrc_emr_2_0 = 0x0;
+	sdrc_block_contents.sdrc_emr_3_0 = 0x0;
+	sdrc_block_contents.sdrc_actim_ctrla_0 =
+			sdrc_read_reg(SDRC_ACTIM_CTRL_A_0);
+	sdrc_block_contents.sdrc_actim_ctrlb_0 =
+			sdrc_read_reg(SDRC_ACTIM_CTRL_B_0);
+	sdrc_block_contents.sdrc_rfr_ctrl_0 =
+			sdrc_read_reg(SDRC_RFR_CTRL_0);
+	sdrc_block_contents.sdrc_cs_1 = 0x0;
+	sdrc_block_contents.sdrc_mcfg_1 = sdrc_read_reg(SDRC_MCFG_1);
+	sdrc_block_contents.sdrc_mr_1 = sdrc_read_reg(SDRC_MR_1) & 0xFFFF;
+	sdrc_block_contents.sdrc_emr_1_1 = 0x0;
+	sdrc_block_contents.sdrc_emr_2_1 = 0x0;
+	sdrc_block_contents.sdrc_emr_3_1 = 0x0;
+	sdrc_block_contents.sdrc_actim_ctrla_1 =
+			sdrc_read_reg(SDRC_ACTIM_CTRL_A_1);
+	sdrc_block_contents.sdrc_actim_ctrlb_1 =
+			sdrc_read_reg(SDRC_ACTIM_CTRL_B_1);
+	sdrc_block_contents.sdrc_rfr_ctrl_1 =
+			sdrc_read_reg(SDRC_RFR_CTRL_1);
+	sdrc_block_contents.sdrc_dcdl_1_ctrl = 0x0;
+	sdrc_block_contents.sdrc_dcdl_2_ctrl = 0x0;
+	sdrc_block_contents.sdrc_flags = 0x0;
+	sdrc_block_contents.sdrc_block_size = 0x0;
+	sdrc_block_contents.sdrc_context_addr =
+			(u32)((u32 *)io_v2p(context_mem));
+
+	/* Copy all the contents to the scratchpad location*/
+	scratchpad_address = (u32 *)io_p2v(OMAP343X_SCRATCHPAD);
+	memcpy(scratchpad_address, &scratchpad_contents,
+		 sizeof(scratchpad_contents));
+	memcpy(scratchpad_address + scratchpad_contents.prcm_block_offset/4,
+		 &prcm_block_contents, sizeof(prcm_block_contents));
+	memcpy(scratchpad_address + scratchpad_contents.sdrc_block_offset/4,
+		 &sdrc_block_contents, sizeof(sdrc_block_contents));
+}
+
+#endif /* CONFIG_ARCH_OMAP3 */
Index: linux-omap-2.6/arch/arm/plat-omap/include/mach/control.h
===================================================================
--- linux-omap-2.6.orig/arch/arm/plat-omap/include/mach/control.h	2008-08-26
15:47:52.000000000 +0530
+++ linux-omap-2.6/arch/arm/plat-omap/include/mach/control.h	2008-08-26
17:07:02.000000000 +0530
@@ -191,6 +191,10 @@
 #define OMAP343X_SR1_SENPENABLE_MASK	(0x3 << 0)
 #define OMAP343X_SR1_SENPENABLE_SHIFT	0

+#define OMAP343X_SCRATCHPAD_ROM		0x48002860
+#define OMAP343X_SCRATCHPAD		0x48002910
+#define OMAP343X_SCRATHPAD_ROM_OFFSET	0x19C
+
 #ifndef __ASSEMBLY__
 #if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 extern void __iomem *omap_ctrl_base_get(void);
@@ -200,6 +204,71 @@ extern u32 omap_ctrl_readl(u16 offset);
 extern void omap_ctrl_writeb(u8 val, u16 offset);
 extern void omap_ctrl_writew(u16 val, u16 offset);
 extern void omap_ctrl_writel(u32 val, u16 offset);
+
+extern void omap3_save_scratchpad_contents(void);
+extern void omap3_clear_scratchpad_contents(void);
+extern u32 *get_restore_pointer(void);
+extern u32 context_mem[128];
+
+struct omap3_scratchpad {
+	u32 boot_config_ptr;
+	u32 public_restore_ptr;
+	u32 secure_ram_restore_ptr;
+	u32 sdrc_module_semaphore;
+	u32 prcm_block_offset;
+	u32 sdrc_block_offset;
+};
+
+struct omap3_scratchpad_prcm_block {
+	u32 prm_clksrc_ctrl;
+	u32 prm_clksel;
+	u32 cm_clksel_core;
+	u32 cm_clksel_wkup;
+	u32 cm_clken_pll;
+	u32 cm_autoidle_pll;
+	u32 cm_clksel1_pll;
+	u32 cm_clksel2_pll;
+	u32 cm_clksel3_pll;
+	u32 cm_clken_pll_mpu;
+	u32 cm_autoidle_pll_mpu;
+	u32 cm_clksel1_pll_mpu;
+	u32 cm_clksel2_pll_mpu;
+	u32 prcm_block_size;
+};
+
+struct omap3_scratchpad_sdrc_block {
+	u16 sdrc_sysconfig;
+	u16 sdrc_cs_cfg;
+	u16 sdrc_sharing;
+	u16 sdrc_err_type;
+	u32 sdrc_dll_a_ctrl;
+	u32 sdrc_dll_b_ctrl;
+	u32 sdrc_power;
+	u32 sdrc_cs_0;
+	u32 sdrc_mcfg_0;
+	u16 sdrc_mr_0;
+	u16 sdrc_emr_1_0;
+	u16 sdrc_emr_2_0;
+	u16 sdrc_emr_3_0;
+	u32 sdrc_actim_ctrla_0;
+	u32 sdrc_actim_ctrlb_0;
+	u32 sdrc_rfr_ctrl_0;
+	u32 sdrc_cs_1;
+	u32 sdrc_mcfg_1;
+	u16 sdrc_mr_1;
+	u16 sdrc_emr_1_1;
+	u16 sdrc_emr_2_1;
+	u16 sdrc_emr_3_1;
+	u32 sdrc_actim_ctrla_1;
+	u32 sdrc_actim_ctrlb_1;
+	u32 sdrc_rfr_ctrl_1;
+	u16 sdrc_dcdl_1_ctrl;
+	u16 sdrc_dcdl_2_ctrl;
+	u32 sdrc_flags;
+	u32 sdrc_block_size;
+	u32 sdrc_context_addr;
+};
+
 #else
 #define omap_ctrl_base_get()		0
 #define omap_ctrl_readb(x)		0
Index: linux-omap-2.6/arch/arm/mach-omap2/pm34xx.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/pm34xx.c	2008-08-26
16:50:30.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/pm34xx.c	2008-08-26 17:00:21.000000000
+0530
@@ -57,6 +57,8 @@ static struct powerdomain *core_pwrdm, *

 int set_pwrdm_state(struct powerdomain *pwrdm, u32 state);

+u32 context_mem[128];
+
 /* XXX This is for gpio fclk hack. Will be removed as gpio driver
  * handles fcks correctly */
 #define NUM_OF_PERGPIOS 5


