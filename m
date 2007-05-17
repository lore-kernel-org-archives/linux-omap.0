From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 10/18] omap2: convert pm.c to use new PRCM functions and
	symbolic constants
Date: Wed, 16 May 2007 18:11:42 -0600
Message-ID: <20070517005444.132583590@pwsan.com>
References: <20070517001132.652728079@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline;
	filename=0010-omap2-convert-pm.c-to-use-new-PRCM-functions-and-sy.patch
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Replace magic numbers, prcm-regs.h-sourced defines, and local defines
with the new PRCM register and register bit defines.  Also convert
register read/write code to use {cm,prm}_{read,write}_{,mod}_reg().

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/pm.c |  393 ++++++++++++++++++++++-------------------------
 1 file changed, 186 insertions(+), 207 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/pm.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/pm.c
+++ linux-omap/arch/arm/mach-omap2/pm.c
@@ -23,7 +23,6 @@
 #include <linux/pm.h>
 #include <linux/sched.h>
 #include <linux/proc_fs.h>
-#include <linux/pm.h>
 #include <linux/interrupt.h>
 #include <linux/sysfs.h>
 #include <linux/module.h>
@@ -48,116 +47,16 @@
 
 #include "sdrc.h"
 
-#define PRCM_REVISION		0x000
-#define PRCM_SYSCONFIG		0x010
-#define PRCM_IRQSTATUS_MPU	0x018
-#define PRCM_IRQENABLE_MPU	0x01c
-#define PRCM_VOLTCTRL		0x050
-#define		AUTO_EXTVOLT	(1 << 15)
-#define		FORCE_EXTVOLT	(1 << 14)
-#define		SETOFF_LEVEL(x)	(((x) & 0x3) << 12)
-#define		MEMRETCTRL	(1 << 8)
-#define		SETRET_LEVEL(x)	(((x) & 0x3) << 6)
-#define		VOLT_LEVEL(x)	(((x) & 0x3) << 0)
-#define PRCM_CLKSRC_CTRL	0x060
-#define PRCM_CLKOUT_CTRL	0x070
-#define PRCM_CLKEMUL_CTRL	0x078
-#define PRCM_CLKCFG_CTRL	0x080
-#define PRCM_VOLTSETUP		0x090
-#define PRCM_CLKSSETUP		0x094
-
-
-#define CM_CLKSEL_MPU		0x140
-#define CM_CLKSTCTRL_MPU	0x148
-#define		AUTOSTAT_MPU	(1 << 0)
-#define PM_WKDEP_MPU		0x1c8
-#define 	EN_WKUP		(1 << 4)
-#define 	EN_GFX		(1 << 3)
-#define 	EN_DSP		(1 << 2)
-#define 	EN_MPU		(1 << 1)
-#define 	EN_CORE		(1 << 0)
-#define PM_PWSTCTRL_MPU		0x1e0
-#define PM_PWSTST_MPU		0x1e4
-
-
-#define CM_FCLKEN1_CORE		0x200
-#define CM_FCLKEN2_CORE		0x204
-#define CM_ICLKEN1_CORE		0x210
-#define CM_ICLKEN2_CORE		0x214
-#define CM_ICLKEN4_CORE		0x21c
-#define CM_IDLEST1_CORE		0x220
-#define CM_IDLEST2_CORE		0x224
-#define CM_AUTOIDLE1_CORE	0x230
-#define CM_AUTOIDLE2_CORE	0x234
-#define CM_AUTOIDLE3_CORE	0x238
-#define CM_AUTOIDLE4_CORE	0x23c
-#define CM_CLKSEL1_CORE		0x240
-#define CM_CLKSEL2_CORE		0x244
-#define CM_CLKSTCTRL_CORE	0x248
-#define		AUTOSTAT_DSS	(1 << 2)
-#define		AUTOSTAT_L4	(1 << 1)
-#define		AUTOSTAT_L3	(1 << 0)
-#define PM_WKEN1_CORE		0x2a0
-#define PM_WKEN2_CORE		0x2a4
-#define PM_WKST1_CORE		0x2b0
-#define PM_WKST2_CORE		0x2b4
-#define PM_WKDEP_CORE		0x2c8
-#define PM_PWSTCTRL_CORE	0x2e0
-#define PM_PWSTST_CORE		0x2e4
-
-
-#define CM_CLKSTCTRL_GFX	0x348
-#define		AUTOSTAT_GFX	(1 << 0)
-#define PM_WKDEP_GFX    	0x3c8
-#define PM_PWSTCTRL_GFX		0x3e0
-
-
-#define CM_FCLKEN_WKUP		0x400
-#define CM_ICLKEN_WKUP		0x410
-#define CM_AUTOIDLE_WKUP	0x430
-#define PM_WKEN_WKUP		0x4a0
-#define 	EN_GPIOS	(1 << 2)
-#define 	EN_GPT1		(1 << 0)
-#define PM_WKST_WKUP		0x4b0
-
-
-#define CM_CLKEN_PLL		0x500
-#define CM_IDLEST_CKGEN		0x520
-#define CM_AUTOIDLE_PLL		0x530
-#define CM_CLKSEL1_PLL		0x540
-#define CM_CLKSEL2_PLL		0x544
-
-
-#define CM_FCLKEN_DSP		0x800
-#define CM_ICLKEN_DSP		0x810
-#define CM_IDLEST_DSP		0x820
-#define CM_AUTOIDLE_DSP		0x830
-#define CM_CLKSEL_DSP		0x840
-#define CM_CLKSTCTRL_DSP	0x848
-#define		AUTOSTAT_IVA	(1 << 8)
-#define		AUTOSTAT_DSP	(1 << 0)
-#define RM_RSTCTRL_DSP		0x850
-#define RM_RSTST_DSP		0x858
-#define PM_WKDEP_DSP		0x8c8
-#define PM_PWSTCTRL_DSP		0x8e0
-#define PM_PWSTST_DSP		0x8e4
+#include "prm.h"
+#include "prm_regbits_24xx.h"
+#include "cm.h"
+#include "cm_regbits_24xx.h"
+#include "sdrc.h"
 
 static void (*omap2_sram_idle)(void);
-static void (*omap2_sram_suspend)(void __iomem *dllctrl);
+static void (*omap2_sram_suspend)(void __iomem * dllctrl);
 static void (*saved_idle)(void);
 
-static u32 prcm_base = IO_ADDRESS(PRCM_BASE);
-
-static inline void prcm_write_reg(int idx, u32 val)
-{
-	__raw_writel(val, prcm_base + idx);
-}
-
-static inline u32 prcm_read_reg(int idx)
-{
-	return __raw_readl(prcm_base + idx);
-}
-
 static u32 omap2_read_32k_sync_counter(void)
 {
         return omap_readl(OMAP_32KSYNCT_BASE + 0x0010);
@@ -231,18 +130,18 @@ static void serial_console_sleep(int ena
 
 		switch (serial_console_uart)  {
 		case 1:
-			l = prcm_read_reg(PM_WKST1_CORE);
-			if (l & (1 << 21))
+			l = prm_read_mod_reg(CORE_MOD, PM_WKST1);
+			if (l & OMAP24XX_ST_UART1)
 				serial_wakeup = 1;
 			break;
 		case 2:
-			l = prcm_read_reg(PM_WKST1_CORE);
-			if (l & (1 << 22))
+			l = prm_read_mod_reg(CORE_MOD, PM_WKST1);
+			if (l & OMAP24XX_ST_UART2)
 				serial_wakeup = 1;
 			break;
 		case 3:
-			l = prcm_read_reg(PM_WKST2_CORE);
-			if (l & (1 << 2))
+			l = prm_read_mod_reg(CORE_MOD, PM_WKST2);
+			if (l & OMAP24XX_ST_UART3)
 				serial_wakeup = 1;
 			break;
 		}
@@ -283,26 +182,35 @@ static void pm_init_serial_console(void)
 	}
 	switch (serial_console_uart) {
 	case 1:
-		l = prcm_read_reg(PM_WKEN1_CORE);
-		l |= 1 << 21;
-		prcm_write_reg(PM_WKEN1_CORE, l);
+		l = prcm_read_mod_reg(CORE_MOD, PM_WKEN1);
+		l |= OMAP24XX_ST_UART1;
+		prm_write_mod_reg(l, CORE_MOD, PM_WKEN1);
 		break;
 	case 2:
-		l = prcm_read_reg(PM_WKEN1_CORE);
-		l |= 1 << 22;
-		prcm_write_reg(PM_WKEN1_CORE, l);
+		l = prcm_read_mod_reg(CORE_MOD, PM_WKEN1);
+		l |= OMAP24XX_ST_UART2;
+		prm_write_mod_reg(l, CORE_MOD, PM_WKEN1);
 		break;
 	case 3:
-		l = prcm_read_reg(PM_WKEN2_CORE);
-		l |= 1 << 2;
-		prcm_write_reg(PM_WKEN2_CORE, l);
+		l = prcm_read_mod_reg(CORE_MOD, PM_WKEN2);
+		l |= OMAP24XX_ST_UART3;
+		prm_write_mod_reg(l, CORE_MOD, PM_WKEN2);
 		break;
 	}
 }
 
-#define DUMP_REG(reg) \
+#define DUMP_PRM_MOD_REG(mod, reg)    \
+	regs[reg_count].name = #mod "." #reg; \
+	regs[reg_count++].val = prm_read_mod_reg(mod, reg)
+#define DUMP_CM_MOD_REG(mod, reg)     \
+	regs[reg_count].name = #mod "." #reg; \
+	regs[reg_count++].val = cm_read_mod_reg(mod, reg)
+#define DUMP_PRM_REG(reg) \
 	regs[reg_count].name = #reg; \
-	regs[reg_count++].val = prcm_read_reg(reg)
+	regs[reg_count++].val = prm_read_reg(reg)
+#define DUMP_CM_REG(reg) \
+	regs[reg_count].name = #reg; \
+	regs[reg_count++].val = cm_read_reg(reg)
 #define DUMP_INTC_REG(reg, off) \
 	regs[reg_count].name = #reg; \
 	regs[reg_count++].val = __raw_readl(IO_ADDRESS(0x480fe000 + (off)))
@@ -319,11 +227,11 @@ static void omap2_pm_dump(int mode, int 
 	if (!resume) {
 #if 0
 		/* MPU */
-		DUMP_REG(PRCM_IRQENABLE_MPU);
-		DUMP_REG(CM_CLKSTCTRL_MPU);
-		DUMP_REG(PM_PWSTCTRL_MPU);
-		DUMP_REG(PM_PWSTST_MPU);
-		DUMP_REG(PM_WKDEP_MPU);
+		DUMP_PRM_REG(OMAP24XX_PRCM_IRQENABLE_MPU);
+		DUMP_CM_MOD_REG(MPU_MOD, CM_CLKSTCTRL);
+		DUMP_PRM_MOD_REG(MPU_MOD, PM_PWSTCTRL);
+		DUMP_PRM_MOD_REG(MPU_MOD, PM_PWSTST);
+		DUMP_PRM_MOD_REG(MPU_MOD, PM_WKDEP);
 #endif
 #if 0
 		/* INTC */
@@ -332,36 +240,36 @@ static void omap2_pm_dump(int mode, int 
 		DUMP_INTC_REG(INTC_MIR2, 0x00c4);
 #endif
 #if 0
-		DUMP_REG(CM_FCLKEN1_CORE);
-		DUMP_REG(CM_FCLKEN2_CORE);
-		DUMP_REG(CM_FCLKEN_WKUP);
-		DUMP_REG(CM_ICLKEN1_CORE);
-		DUMP_REG(CM_ICLKEN2_CORE);
-		DUMP_REG(CM_ICLKEN_WKUP);
-		DUMP_REG(CM_CLKEN_PLL);
-		DUMP_REG(PRCM_CLKEMUL_CTRL);
-		DUMP_REG(CM_AUTOIDLE_PLL);
-		DUMP_REG(PM_PWSTST_CORE);
-		DUMP_REG(PRCM_CLKSRC_CTRL);
+		DUMP_CM_MOD_REG(CORE_MOD, CM_FCLKEN1);
+		DUMP_CM_MOD_REG(CORE_MOD, CM_FCLKEN2);
+		DUMP_CM_MOD_REG(WKUP_MOD, CM_FCLKEN);
+		DUMP_CM_MOD_REG(CORE_MOD, CM_ICLKEN1);
+		DUMP_CM_MOD_REG(CORE_MOD, CM_ICLKEN2);
+		DUMP_CM_MOD_REG(WKUP_MOD, CM_ICLKEN);
+		DUMP_CM_MOD_REG(PLL_MOD, CM_CLKEN_PLL);
+		DUMP_PRM_REG(OMAP24XX_PRCM_CLKEMUL_CTRL);
+		DUMP_CM_MOD_REG(PLL_MOD, CM_AUTOIDLE);
+		DUMP_PRM_MOD_REG(CORE_REG, PM_PWSTST);
+		DUMP_PRM_REG(OMAP24XX_PRCM_CLKSRC_CTRL);
 #endif
 #if 0
 		/* DSP */
-		DUMP_REG(CM_FCLKEN_DSP);
-		DUMP_REG(CM_ICLKEN_DSP);
-		DUMP_REG(CM_IDLEST_DSP);
-		DUMP_REG(CM_AUTOIDLE_DSP);
-		DUMP_REG(CM_CLKSEL_DSP);
-		DUMP_REG(CM_CLKSTCTRL_DSP);
-		DUMP_REG(RM_RSTCTRL_DSP);
-		DUMP_REG(RM_RSTST_DSP);
-		DUMP_REG(PM_PWSTCTRL_DSP);
-		DUMP_REG(PM_PWSTST_DSP);
+		DUMP_CM_MOD_REG(OMAP24XX_DSP_MOD, CM_FCLKEN);
+		DUMP_CM_MOD_REG(OMAP24XX_DSP_MOD, CM_ICLKEN);
+		DUMP_CM_MOD_REG(OMAP24XX_DSP_MOD, CM_IDLEST);
+		DUMP_CM_MOD_REG(OMAP24XX_DSP_MOD, CM_AUTOIDLE);
+		DUMP_CM_MOD_REG(OMAP24XX_DSP_MOD, CM_CLKSEL);
+		DUMP_CM_MOD_REG(OMAP24XX_DSP_MOD, CM_CLKSTCTRL);
+		DUMP_PRM_MOD_REG(OMAP24XX_DSP_MOD, RM_RSTCTRL);
+		DUMP_PRM_MOD_REG(OMAP24XX_DSP_MOD, RM_RSTST);
+		DUMP_PRM_MOD_REG(OMAP24XX_DSP_MOD, PM_PWSTCTRL);
+		DUMP_PRM_MOD_REG(OMAP24XX_DSP_MOD, PM_PWSTST);
 #endif
 	} else {
-		DUMP_REG(PM_WKST1_CORE);
-		DUMP_REG(PM_WKST2_CORE);
-		DUMP_REG(PM_WKST_WKUP);
-		DUMP_REG(PRCM_IRQSTATUS_MPU);
+		DUMP_PRM_MOD_REG(CORE_MOD, PM_WKST1);
+		DUMP_PRM_MOD_REG(CORE_MOD, PM_WKST2);
+		DUMP_PRM_MOD_REG(WKUP_MOD, PM_WKST);
+		DUMP_PRM_REG(OMAP24XX_PRCM_IRQSTATUS_MPU);
 #if 1
 		DUMP_INTC_REG(INTC_PENDING_IRQ0, 0x0098);
 		DUMP_INTC_REG(INTC_PENDING_IRQ1, 0x00b8);
@@ -445,8 +353,8 @@ static int omap2_fclks_active(void)
 {
 	u32 f1, f2;
 
-	f1 = prcm_read_reg(CM_FCLKEN1_CORE);
-	f2 = prcm_read_reg(CM_FCLKEN2_CORE);
+	f1 = cm_read_mod_reg(CORE_MOD, CM_FCLKEN1);
+	f2 = cm_read_mod_reg(CORE_MOD, OMAP24XX_CM_FCLKEN2);
 	serial_console_fclk_mask(&f1, &f2);
 	if (f1 | f2)
 		return 1;
@@ -493,12 +401,14 @@ static void omap2_enter_full_retention(v
 	clk_disable(osc_ck);
 
 	/* Clear old wake-up events */
-	prcm_write_reg(PM_WKST1_CORE, 0xffffffff);
-	prcm_write_reg(PM_WKST2_CORE, 0xffffffff);
-	prcm_write_reg(PM_WKST_WKUP, 0xffffffff);
+	/* REVISIT: These write to reserved bits? */
+	prm_write_mod_reg(0xffffffff, CORE_MOD, PM_WKST1);
+	prm_write_mod_reg(0xffffffff, CORE_MOD, OMAP24XX_PM_WKST2);
+	prm_write_mod_reg(0xffffffff, WKUP_MOD, PM_WKST);
 
 	/* Try to enter retention */
-	prcm_write_reg(PM_PWSTCTRL_MPU, (0x01 << 0) | (1 << 2));
+	prm_write_mod_reg((0x01 << OMAP_POWERSTATE_SHIFT) | OMAP_LOGICRETSTATE,
+			  MPU_MOD, PM_PWSTCTRL);
 
 	/* Workaround to kill USB */
 	CONTROL_DEVCONF |= 0x00008000;
@@ -540,8 +450,8 @@ static int omap2_i2c_active(void)
 {
 	u32 l;
 
-	l = prcm_read_reg(CM_FCLKEN1_CORE);
-	return l & ((1 << 19) | (1 << 20));
+	l = cm_read_mod_reg(CORE_MOD, CM_FCLKEN1);
+	return l & (OMAP2420_EN_I2C2 | OMAP2420_EN_I2C1);
 }
 
 static int sti_console_enabled;
@@ -553,13 +463,15 @@ static int omap2_allow_mpu_retention(voi
 	if (atomic_read(&sleep_block))
 		return 0;
 
-	/* Check for UART2, UART1, McSPI2, McSPI1 and DSS1. */
-	l = prcm_read_reg(CM_FCLKEN1_CORE);
-	if (l & 0x04660001)
+	/* Check for MMC, UART2, UART1, McSPI2, McSPI1 and DSS1. */
+	l = cm_read_mod_reg(CORE_MOD, CM_FCLKEN1);
+	if (l & (OMAP2420_EN_MMC | OMAP24XX_EN_UART2 |
+		 OMAP24XX_EN_UART1 | OMAP24XX_EN_MCSPI2 |
+		 OMAP24XX_EN_MCSPI1 | OMAP24XX_EN_DSS1))
 		return 0;
 	/* Check for UART3. */
-	l = prcm_read_reg(CM_FCLKEN2_CORE);
-	if (l & (1 << 2))
+	l = cm_read_mod_reg(CORE_MOD, OMAP24XX_CM_FCLKEN2);
+	if (l & OMAP24XX_EN_UART3)
 		return 0;
 	if (sti_console_enabled)
 		return 0;
@@ -580,15 +492,19 @@ static void omap2_enter_mpu_retention(vo
 	/* The peripherals seem not to be able to wake up the MPU when
 	 * it is in retention mode. */
 	if (omap2_allow_mpu_retention()) {
-		prcm_write_reg(PM_WKST1_CORE, 0xffffffff);
-		prcm_write_reg(PM_WKST2_CORE, 0xffffffff);
-		prcm_write_reg(PM_WKST_WKUP, 0xffffffff);
+	        /* REVISIT: These write to reserved bits? */
+		prm_write_mod_reg(0xffffffff, CORE_MOD, PM_WKST1);
+		prm_write_mod_reg(0xffffffff, CORE_MOD, OMAP24XX_PM_WKST2);
+		prm_write_mod_reg(0xffffffff, WKUP_MOD, PM_WKST);
 
 		/* Try to enter MPU retention */
-		prcm_write_reg(PM_PWSTCTRL_MPU, (0x01 << 0) | (1 << 2));
+		prm_write_mod_reg((0x01 << OMAP_POWERSTATE_SHIFT) |
+				  OMAP_LOGICRETSTATE,
+				  MPU_MOD, PM_PWSTCTRL);
 	} else {
 		/* Block MPU retention */
-		prcm_write_reg(PM_PWSTCTRL_MPU, 1 << 2);
+
+		prm_write_mod_reg(OMAP_LOGICRETSTATE, MPU_MOD, PM_PWSTCTRL);
 		only_idle = 1;
 	}
 
@@ -688,8 +604,8 @@ static int omap2_pm_suspend(void)
 {
 	u32 wken_wkup, mir1;
 
-	wken_wkup = prcm_read_reg(PM_WKEN_WKUP);
-	prcm_write_reg(PM_WKEN_WKUP, wken_wkup & ~EN_GPT1);
+	wken_wkup = prm_read_mod_reg(WKUP_MOD, PM_WKEN);
+	prm_write_mod_reg(wken_wkup & ~OMAP24XX_EN_GPT1, WKUP_MOD, PM_WKEN);
 
 	/* Mask GPT1 */
 	mir1 = omap_readl(0x480fe0a4);
@@ -698,7 +614,7 @@ static int omap2_pm_suspend(void)
 	omap2_enter_full_retention();
 
 	omap_writel(mir1, 0x480fe0a4);
-	prcm_write_reg(PM_WKEN_WKUP, wken_wkup);
+	prm_write_mod_reg(wken_wkup, WKUP_MOD, PM_WKEN);
 
 	return 0;
 }
@@ -737,58 +653,121 @@ static void __init prcm_setup_regs(void)
 	u32 l;
 
 	/* Enable autoidle */
-	prcm_write_reg(PRCM_SYSCONFIG, 1 << 0);
+	prm_write_reg(OMAP24XX_AUTOIDLE, OMAP24XX_PRCM_SYSCONFIG);
 
 	/* Set all domain wakeup dependencies */
-	prcm_write_reg(PM_WKDEP_MPU, EN_WKUP);
-	prcm_write_reg(PM_WKDEP_DSP, 0);
-	prcm_write_reg(PM_WKDEP_GFX, 0);
+	prm_write_mod_reg(OMAP_EN_WKUP, MPU_MOD, PM_WKDEP);
+	prm_write_mod_reg(0, OMAP24XX_DSP_MOD, PM_WKDEP);
+	prm_write_mod_reg(0, GFX_MOD, PM_WKDEP);
 
-	l = prcm_read_reg(PM_PWSTCTRL_CORE);
+	l = prm_read_mod_reg(CORE_MOD, PM_PWSTCTRL);
 	/* Enable retention for all memory blocks */
-	l |= (1 << 3) | (1 << 4) | (1 << 5);
-	/* Set power state to RETENTION */
-	l &= ~0x03;
-	l |= 0x01 << 0;
-	prcm_write_reg(PM_PWSTCTRL_CORE, l);
+	l |= OMAP24XX_MEM3RETSTATE | OMAP24XX_MEM2RETSTATE |
+		OMAP24XX_MEM1RETSTATE;
 
-	prcm_write_reg(PM_PWSTCTRL_MPU, (0x01 << 0) | (1 << 2));
+	/* Set power state to RETENTION */
+	l &= ~OMAP_POWERSTATE_MASK;
+	l |= 0x01 << OMAP_POWERSTATE_SHIFT;
+	prm_write_mod_reg(l, CORE_MOD, PM_PWSTCTRL);
+
+	prm_write_mod_reg((0x01 << OMAP_POWERSTATE_SHIFT) |
+			  OMAP_LOGICRETSTATE,
+			  MPU_MOD, PM_PWSTCTRL);
 
 	/* Power down DSP and GFX */
-	prcm_write_reg(PM_PWSTCTRL_DSP, (1 << 18) | 0x03);
-	prcm_write_reg(PM_PWSTCTRL_GFX, (1 << 18) | 0x03);
+	prm_write_mod_reg(OMAP24XX_FORCESTATE | (0x3 << OMAP_POWERSTATE_SHIFT),
+			  OMAP24XX_DSP_MOD, PM_PWSTCTRL);
+	prm_write_mod_reg(OMAP24XX_FORCESTATE | (0x3 << OMAP_POWERSTATE_SHIFT),
+			  GFX_MOD, PM_PWSTCTRL);
 
 	/* Enable clock auto control for all domains */
-	prcm_write_reg(CM_CLKSTCTRL_MPU, AUTOSTAT_MPU);
-	prcm_write_reg(CM_CLKSTCTRL_CORE, AUTOSTAT_DSS | AUTOSTAT_L4 | AUTOSTAT_L3);
-	prcm_write_reg(CM_CLKSTCTRL_GFX, AUTOSTAT_GFX);
-	prcm_write_reg(CM_CLKSTCTRL_DSP, AUTOSTAT_IVA | AUTOSTAT_DSP);
+	cm_write_mod_reg(OMAP24XX_AUTOSTATE_MPU, MPU_MOD, CM_CLKSTCTRL);
+	cm_write_mod_reg(OMAP24XX_AUTOSTATE_DSS | OMAP24XX_AUTOSTATE_L4 |
+			 OMAP24XX_AUTOSTATE_L3,
+			 CORE_MOD, CM_CLKSTCTRL);
+	cm_write_mod_reg(OMAP24XX_AUTOSTATE_GFX, GFX_MOD, CM_CLKSTCTRL);
+	cm_write_mod_reg(OMAP2420_AUTOSTATE_IVA | OMAP24XX_AUTOSTATE_DSP,
+			 OMAP24XX_DSP_MOD, CM_CLKSTCTRL);
 
 	/* Enable clock autoidle for all domains */
-	prcm_write_reg(CM_AUTOIDLE1_CORE, 0xfffffff9);
-	prcm_write_reg(CM_AUTOIDLE2_CORE, 0x07);
-	prcm_write_reg(CM_AUTOIDLE3_CORE, 0x07);
-	prcm_write_reg(CM_AUTOIDLE4_CORE, 0x1f);
+	cm_write_mod_reg(OMAP24XX_AUTO_CAM |
+			 OMAP24XX_AUTO_MAILBOXES |
+			 OMAP24XX_AUTO_WDT4 |
+			 OMAP2420_AUTO_WDT3 |
+			 OMAP24XX_AUTO_MSPRO |
+			 OMAP2420_AUTO_MMC |
+			 OMAP24XX_AUTO_FAC |
+			 OMAP2420_AUTO_EAC |
+			 OMAP24XX_AUTO_HDQ |
+			 OMAP24XX_AUTO_UART2 |
+			 OMAP24XX_AUTO_UART1 |
+			 OMAP24XX_AUTO_I2C2 |
+			 OMAP24XX_AUTO_I2C1 |
+			 OMAP24XX_AUTO_MCSPI2 |
+			 OMAP24XX_AUTO_MCSPI1 |
+			 OMAP24XX_AUTO_MCBSP2 |
+			 OMAP24XX_AUTO_MCBSP1 |
+			 OMAP24XX_AUTO_GPT12 |
+			 OMAP24XX_AUTO_GPT11 |
+			 OMAP24XX_AUTO_GPT10 |
+			 OMAP24XX_AUTO_GPT9 |
+			 OMAP24XX_AUTO_GPT8 |
+			 OMAP24XX_AUTO_GPT7 |
+			 OMAP24XX_AUTO_GPT6 |
+			 OMAP24XX_AUTO_GPT5 |
+			 OMAP24XX_AUTO_GPT4 |
+			 OMAP24XX_AUTO_GPT3 |
+			 OMAP24XX_AUTO_GPT2 |
+			 OMAP2420_AUTO_VLYNQ |
+			 OMAP24XX_AUTO_DSS,
+			 CORE_MOD, CM_AUTOIDLE1);
+	cm_write_mod_reg(OMAP24XX_AUTO_UART3 |
+			 OMAP24XX_AUTO_SSI |
+			 OMAP24XX_AUTO_USB,
+			 CORE_MOD, CM_AUTOIDLE2);
+	cm_write_mod_reg(OMAP24XX_AUTO_SDRC |
+			 OMAP24XX_AUTO_GPMC |
+			 OMAP24XX_AUTO_SDMA,
+			 CORE_MOD, OMAP24XX_CM_AUTOIDLE3);
+	cm_write_mod_reg(OMAP24XX_AUTO_PKA |
+			 OMAP24XX_AUTO_AES |
+			 OMAP24XX_AUTO_RNG |
+			 OMAP24XX_AUTO_SHA |
+			 OMAP24XX_AUTO_DES,
+			 CORE_MOD, OMAP24XX_CM_AUTOIDLE4);
 
-	prcm_write_reg(CM_AUTOIDLE_DSP, 0x02);
+	cm_write_mod_reg(OMAP2420_AUTO_DSP_IPI, OMAP24XX_DSP_MOD, CM_AUTOIDLE);
 
 	/* Put DPLL and both APLLs into autoidle mode */
-	prcm_write_reg(CM_AUTOIDLE_PLL, (0x03 << 0) | (0x03 << 2) | (0x03 << 6));
-
-	prcm_write_reg(CM_AUTOIDLE_WKUP, 0x3f);
+	cm_write_mod_reg((0x03 << OMAP24XX_AUTO_DPLL_SHIFT) |
+			 (0x03 << OMAP24XX_AUTO_96M_SHIFT) |
+			 (0x03 << OMAP24XX_AUTO_54M_SHIFT),
+			 PLL_MOD, CM_AUTOIDLE);
+
+	cm_write_mod_reg(OMAP24XX_AUTO_OMAPCTRL |
+			 OMAP24XX_AUTO_WDT1 |
+			 OMAP24XX_AUTO_MPU_WDT |
+			 OMAP24XX_AUTO_GPIOS |
+			 OMAP24XX_AUTO_32KSYNC |
+			 OMAP24XX_AUTO_GPT1,
+			 WKUP_MOD, CM_AUTOIDLE);
 
 	/* REVISIT: Configure number of 32 kHz clock cycles for sys_clk
 	 * stabilisation */
-	prcm_write_reg(PRCM_CLKSSETUP, 15);
+	prm_write_reg(15 << OMAP_SETUP_TIME_SHIFT, OMAP24XX_PRCM_CLKSSETUP);
 
 	/* Configure automatic voltage transition */
-	prcm_write_reg(PRCM_VOLTSETUP, 2);
-	l = AUTO_EXTVOLT | SETOFF_LEVEL(1) | MEMRETCTRL | \
-		SETRET_LEVEL(1) | VOLT_LEVEL(0);
-	prcm_write_reg(PRCM_VOLTCTRL, l);
+	prm_write_reg(2 << OMAP_SETUP_TIME_SHIFT, OMAP24XX_PRCM_VOLTSETUP);
+	prm_write_reg(OMAP24XX_AUTO_EXTVOLT |
+		      (0x1 << OMAP24XX_SETOFF_LEVEL_SHIFT) |
+		      OMAP24XX_MEMRETCTRL |
+		      (0x1 << OMAP24XX_SETRET_LEVEL_SHIFT) |
+		      (0x0 << OMAP24XX_VOLT_LEVEL_SHIFT),
+		      OMAP24XX_PRCM_VOLTCTRL);
 
 	/* Enable wake-up events */
-	prcm_write_reg(PM_WKEN_WKUP, EN_GPIOS | EN_GPT1);
+	prm_write_mod_reg(OMAP24XX_EN_GPIOS | OMAP24XX_EN_GPT1,
+			  WKUP_MOD, PM_WKEN);
 }
 
 int __init omap2_pm_init(void)
@@ -796,7 +775,7 @@ int __init omap2_pm_init(void)
 	u32 l;
 
 	printk(KERN_INFO "Power Management for OMAP2 initializing\n");
-	l = prcm_read_reg(PRCM_REVISION);
+	l = prm_read_reg(OMAP24XX_PRCM_REVISION);
 	printk(KERN_INFO "PRCM revision %d.%d\n", (l >> 4) & 0x0f, l & 0x0f);
 
 	osc_ck = clk_get(NULL, "osc_ck");

-- 
