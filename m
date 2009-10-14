From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 05/27] OMAP3: PM: Populate scratchpad contents
Date: Wed, 14 Oct 2009 14:57:48 -0700
Message-ID: <1255557490-16787-6-git-send-email-khilman@deeprootsystems.com>
References: <1255557490-16787-1-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-2-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-3-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-4-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-5-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1255557490-16787-5-git-send-email-khilman@deeprootsystems.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: Rajendra Nayak <rnayak@ti.com>

This patch populates the scratchpad contents as expected by the
bootROM code.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/control.c             |  203 +++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/control.h |    9 ++
 2 files changed, 212 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 5f3aad9..060fc19 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -17,9 +17,81 @@
 
 #include <mach/common.h>
 #include <mach/control.h>
+#include <mach/sdrc.h>
+#include "cm-regbits-34xx.h"
+#include "prm-regbits-34xx.h"
+#include "cm.h"
+#include "prm.h"
+#include "sdrc.h"
 
 static void __iomem *omap2_ctrl_base;
 
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
+	u16 sysconfig;
+	u16 cs_cfg;
+	u16 sharing;
+	u16 err_type;
+	u32 dll_a_ctrl;
+	u32 dll_b_ctrl;
+	u32 power;
+	u32 cs_0;
+	u32 mcfg_0;
+	u16 mr_0;
+	u16 emr_1_0;
+	u16 emr_2_0;
+	u16 emr_3_0;
+	u32 actim_ctrla_0;
+	u32 actim_ctrlb_0;
+	u32 rfr_ctrl_0;
+	u32 cs_1;
+	u32 mcfg_1;
+	u16 mr_1;
+	u16 emr_1_1;
+	u16 emr_2_1;
+	u16 emr_3_1;
+	u32 actim_ctrla_1;
+	u32 actim_ctrlb_1;
+	u32 rfr_ctrl_1;
+	u16 dcdl_1_ctrl;
+	u16 dcdl_2_ctrl;
+	u32 flags;
+	u32 block_size;
+};
+
+/*
+ * This is used to store ARM registers in SDRAM before attempting
+ * an MPU OFF. The save and restore happens from the SRAM sleep code.
+ * The address is stored in scratchpad, so that it can be used
+ * during the restore path.
+ */
+u32 omap3_arm_context[128];
+
 #define OMAP_CTRL_REGADDR(reg)		(omap2_ctrl_base + (reg))
 
 void __init omap2_set_globals_control(struct omap_globals *omap2_globals)
@@ -62,3 +134,134 @@ void omap_ctrl_writel(u32 val, u16 offset)
 	__raw_writel(val, OMAP_CTRL_REGADDR(offset));
 }
 
+#ifdef CONFIG_ARCH_OMAP3
+/*
+ * Clears the scratchpad contents in case of cold boot-
+ * called during bootup
+ */
+void omap3_clear_scratchpad_contents(void)
+{
+	u32 max_offset = OMAP343X_SCRATCHPAD_ROM_OFFSET;
+	u32 *v_addr;
+	u32 offset = 0;
+	v_addr = OMAP2_IO_ADDRESS(OMAP343X_SCRATCHPAD_ROM);
+	if (prm_read_mod_reg(OMAP3430_GR_MOD, OMAP3_PRM_RSTST_OFFSET) &
+		OMAP3430_GLOBAL_COLD_RST) {
+		for ( ; offset <= max_offset; offset += 0x4)
+			__raw_writel(0x0, (v_addr + offset));
+		prm_set_mod_reg_bits(OMAP3430_GLOBAL_COLD_RST, OMAP3430_GR_MOD,
+			OMAP3_PRM_RSTST_OFFSET);
+	}
+}
+
+/* Populate the scratchpad structure with restore structure */
+void omap3_save_scratchpad_contents(void)
+{
+	void * __iomem scratchpad_address;
+	u32 arm_context_addr;
+	struct omap3_scratchpad scratchpad_contents;
+	struct omap3_scratchpad_prcm_block prcm_block_contents;
+	struct omap3_scratchpad_sdrc_block sdrc_block_contents;
+
+	/* Populate the Scratchpad contents */
+	scratchpad_contents.boot_config_ptr = 0x0;
+	scratchpad_contents.public_restore_ptr =
+			 virt_to_phys(get_restore_pointer());
+	scratchpad_contents.secure_ram_restore_ptr = 0x0;
+	scratchpad_contents.sdrc_module_semaphore = 0x0;
+	scratchpad_contents.prcm_block_offset = 0x2C;
+	scratchpad_contents.sdrc_block_offset = 0x64;
+
+	/* Populate the PRCM block contents */
+	prcm_block_contents.prm_clksrc_ctrl = prm_read_mod_reg(OMAP3430_GR_MOD,
+			OMAP3_PRM_CLKSRC_CTRL_OFFSET);
+	prcm_block_contents.prm_clksel = prm_read_mod_reg(OMAP3430_CCR_MOD,
+			OMAP3_PRM_CLKSEL_OFFSET);
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
+	sdrc_block_contents.sysconfig =
+			(sdrc_read_reg(SDRC_SYSCONFIG) & 0xFFFF);
+	sdrc_block_contents.cs_cfg =
+			(sdrc_read_reg(SDRC_CS_CFG) & 0xFFFF);
+	sdrc_block_contents.sharing =
+			(sdrc_read_reg(SDRC_SHARING) & 0xFFFF);
+	sdrc_block_contents.err_type =
+			(sdrc_read_reg(SDRC_ERR_TYPE) & 0xFFFF);
+	sdrc_block_contents.dll_a_ctrl = sdrc_read_reg(SDRC_DLLA_CTRL);
+	sdrc_block_contents.dll_b_ctrl = 0x0;
+	sdrc_block_contents.power = sdrc_read_reg(SDRC_POWER);
+	sdrc_block_contents.cs_0 = 0x0;
+	sdrc_block_contents.mcfg_0 = sdrc_read_reg(SDRC_MCFG_0);
+	sdrc_block_contents.mr_0 = (sdrc_read_reg(SDRC_MR_0) & 0xFFFF);
+	sdrc_block_contents.emr_1_0 = 0x0;
+	sdrc_block_contents.emr_2_0 = 0x0;
+	sdrc_block_contents.emr_3_0 = 0x0;
+	sdrc_block_contents.actim_ctrla_0 =
+			sdrc_read_reg(SDRC_ACTIM_CTRL_A_0);
+	sdrc_block_contents.actim_ctrlb_0 =
+			sdrc_read_reg(SDRC_ACTIM_CTRL_B_0);
+	sdrc_block_contents.rfr_ctrl_0 =
+			sdrc_read_reg(SDRC_RFR_CTRL_0);
+	sdrc_block_contents.cs_1 = 0x0;
+	sdrc_block_contents.mcfg_1 = sdrc_read_reg(SDRC_MCFG_1);
+	sdrc_block_contents.mr_1 = sdrc_read_reg(SDRC_MR_1) & 0xFFFF;
+	sdrc_block_contents.emr_1_1 = 0x0;
+	sdrc_block_contents.emr_2_1 = 0x0;
+	sdrc_block_contents.emr_3_1 = 0x0;
+	sdrc_block_contents.actim_ctrla_1 =
+			sdrc_read_reg(SDRC_ACTIM_CTRL_A_1);
+	sdrc_block_contents.actim_ctrlb_1 =
+			sdrc_read_reg(SDRC_ACTIM_CTRL_B_1);
+	sdrc_block_contents.rfr_ctrl_1 =
+			sdrc_read_reg(SDRC_RFR_CTRL_1);
+	sdrc_block_contents.dcdl_1_ctrl = 0x0;
+	sdrc_block_contents.dcdl_2_ctrl = 0x0;
+	sdrc_block_contents.flags = 0x0;
+	sdrc_block_contents.block_size = 0x0;
+
+	arm_context_addr = virt_to_phys(omap3_arm_context);
+
+	/* Copy all the contents to the scratchpad location */
+	scratchpad_address = OMAP2_IO_ADDRESS(OMAP343X_SCRATCHPAD);
+	memcpy_toio(scratchpad_address, &scratchpad_contents,
+		 sizeof(scratchpad_contents));
+	/* Scratchpad contents being 32 bits, a divide by 4 done here */
+	memcpy_toio(scratchpad_address +
+		scratchpad_contents.prcm_block_offset,
+		&prcm_block_contents, sizeof(prcm_block_contents));
+	memcpy_toio(scratchpad_address +
+		scratchpad_contents.sdrc_block_offset,
+		&sdrc_block_contents, sizeof(sdrc_block_contents));
+	/*
+	 * Copies the address of the location in SDRAM where ARM
+	 * registers get saved during a MPU OFF transition.
+	 */
+	memcpy_toio(scratchpad_address +
+		scratchpad_contents.sdrc_block_offset +
+		sizeof(sdrc_block_contents), &arm_context_addr, 4);
+}
+
+#endif /* CONFIG_ARCH_OMAP3 */
diff --git a/arch/arm/plat-omap/include/mach/control.h b/arch/arm/plat-omap/include/mach/control.h
index 3cdfe31..7297829 100644
--- a/arch/arm/plat-omap/include/mach/control.h
+++ b/arch/arm/plat-omap/include/mach/control.h
@@ -240,6 +240,9 @@
 #define		FEAT_NEON		0
 #define		FEAT_NEON_NONE		1
 
+#define OMAP343X_SCRATCHPAD_ROM		(OMAP343X_CTRL_BASE + 0x860)
+#define OMAP343X_SCRATCHPAD		(OMAP343X_CTRL_BASE + 0x910)
+#define OMAP343X_SCRATCHPAD_ROM_OFFSET	0x19C
 
 #ifndef __ASSEMBLY__
 #if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
@@ -251,6 +254,12 @@ extern u32 omap_ctrl_readl(u16 offset);
 extern void omap_ctrl_writeb(u8 val, u16 offset);
 extern void omap_ctrl_writew(u16 val, u16 offset);
 extern void omap_ctrl_writel(u32 val, u16 offset);
+
+extern void omap3_save_scratchpad_contents(void);
+extern void omap3_clear_scratchpad_contents(void);
+extern u32 *get_restore_pointer(void);
+extern u32 omap3_arm_context[128];
+
 #else
 #define omap_ctrl_base_get()		0
 #define omap_ctrl_readb(x)		0
-- 
1.6.4.3
