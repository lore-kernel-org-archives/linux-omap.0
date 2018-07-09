From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v2 1/2] ARM: OMAP2+: sleep33/43xx: Make sleep actions
 configurable
Date: Mon, 9 Jul 2018 13:03:16 +0530
Message-ID: <1531121597-19150-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tony@atomide.com
Cc: Dave Gerlach <d-gerlach@ti.com>, j-keerthy@ti.com, linux-kernel@vger.kernel.org, t-kristo@ti.com, ssantosh@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: Dave Gerlach <d-gerlach@ti.com>

Add an argument to the sleep33xx and sleep43xx code to allow us to set
flags to determine which portions of the code get called in order to use
the same code for multiple power saving modes. This patch allows us to
decide whether or not we flush and disable caches, save EMIF context,
put the memory into self refresh and disable the EMIF, and/or invoke
the wkup_m3 when entering into WFI.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
---

Changes in v2:

  * Swapped the bit definitons from patch 2 to 1.

 arch/arm/mach-omap2/pm33xx-core.c    | 10 ++++---
 arch/arm/mach-omap2/sleep33xx.S      | 47 ++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/sleep43xx.S      | 56 +++++++++++++++++++++++++++++++++---
 drivers/soc/ti/pm33xx.c              | 15 +++++++++-
 include/linux/platform_data/pm33xx.h | 26 ++++++++++++++++-
 5 files changed, 144 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/pm33xx-core.c b/arch/arm/mach-omap2/pm33xx-core.c
index 9b3755a..e363b97 100644
--- a/arch/arm/mach-omap2/pm33xx-core.c
+++ b/arch/arm/mach-omap2/pm33xx-core.c
@@ -106,12 +106,13 @@ static void amx3_post_suspend_common(void)
 		pr_err("PM: GFX domain did not transition: %x\n", status);
 }
 
-static int am33xx_suspend(unsigned int state, int (*fn)(unsigned long))
+static int am33xx_suspend(unsigned int state, int (*fn)(unsigned long),
+			  unsigned long args)
 {
 	int ret = 0;
 
 	amx3_pre_suspend_common();
-	ret = cpu_suspend(0, fn);
+	ret = cpu_suspend(args, fn);
 	amx3_post_suspend_common();
 
 	/*
@@ -128,13 +129,14 @@ static int am33xx_suspend(unsigned int state, int (*fn)(unsigned long))
 	return ret;
 }
 
-static int am43xx_suspend(unsigned int state, int (*fn)(unsigned long))
+static int am43xx_suspend(unsigned int state, int (*fn)(unsigned long),
+			  unsigned long args)
 {
 	int ret = 0;
 
 	amx3_pre_suspend_common();
 	scu_power_mode(scu_base, SCU_PM_POWEROFF);
-	ret = cpu_suspend(0, fn);
+	ret = cpu_suspend(args, fn);
 	scu_power_mode(scu_base, SCU_PM_NORMAL);
 	amx3_post_suspend_common();
 
diff --git a/arch/arm/mach-omap2/sleep33xx.S b/arch/arm/mach-omap2/sleep33xx.S
index 322b3bb..8d0d53b 100644
--- a/arch/arm/mach-omap2/sleep33xx.S
+++ b/arch/arm/mach-omap2/sleep33xx.S
@@ -8,6 +8,7 @@
 
 #include <generated/ti-pm-asm-offsets.h>
 #include <linux/linkage.h>
+#include <linux/platform_data/pm33xx.h>
 #include <linux/ti-emif-sram.h>
 #include <asm/assembler.h>
 #include <asm/memory.h>
@@ -19,12 +20,25 @@
 #define AM33XX_CM_CLKCTRL_MODULEMODE_DISABLE			0x0003
 #define AM33XX_CM_CLKCTRL_MODULEMODE_ENABLE			0x0002
 
+/* replicated define because linux/bitops.h cannot be included in assembly */
+#define BIT(nr)			(1 << (nr))
+
 	.arm
 	.align 3
 
 ENTRY(am33xx_do_wfi)
 	stmfd	sp!, {r4 - r11, lr}	@ save registers on stack
 
+	/* Save wfi_flags arg to data space */
+	mov	r4, r0
+	adr	r3, am33xx_pm_ro_sram_data
+	ldr	r2, [r3, #AMX3_PM_RO_SRAM_DATA_VIRT_OFFSET]
+	str	r4, [r2, #AMX3_PM_WFI_FLAGS_OFFSET]
+
+	/* Only flush cache is we know we are losing MPU context */
+	tst	r4, #WFI_FLAG_FLUSH_CACHE
+	beq	cache_skip_flush
+
 	/*
 	 * Flush all data from the L1 and L2 data cache before disabling
 	 * SCTLR.C bit.
@@ -48,14 +62,33 @@ ENTRY(am33xx_do_wfi)
 	ldr	r1, kernel_flush
 	blx	r1
 
+	adr	r3, am33xx_pm_ro_sram_data
+	ldr	r2, [r3, #AMX3_PM_RO_SRAM_DATA_VIRT_OFFSET]
+	ldr	r4, [r2, #AMX3_PM_WFI_FLAGS_OFFSET]
+
+cache_skip_flush:
+	/* Check if we want self refresh */
+	tst	r4, #WFI_FLAG_SELF_REFRESH
+	beq	emif_skip_enter_sr
+
 	adr	r9, am33xx_emif_sram_table
 
 	ldr	r3, [r9, #EMIF_PM_ENTER_SR_OFFSET]
 	blx	r3
 
+emif_skip_enter_sr:
+	/* Only necessary if PER is losing context */
+	tst	r4, #WFI_FLAG_SAVE_EMIF
+	beq	emif_skip_save
+
 	ldr	r3, [r9, #EMIF_PM_SAVE_CONTEXT_OFFSET]
 	blx	r3
 
+emif_skip_save:
+	/* Only can disable EMIF if we have entered self refresh */
+	tst     r4, #WFI_FLAG_SELF_REFRESH
+	beq     emif_skip_disable
+
 	/* Disable EMIF */
 	ldr     r1, virt_emif_clkctrl
 	ldr     r2, [r1]
@@ -69,6 +102,10 @@ wait_emif_disable:
 	cmp	r2, r3
 	bne	wait_emif_disable
 
+emif_skip_disable:
+	tst	r4, #WFI_FLAG_WAKE_M3
+	beq	wkup_m3_skip
+
 	/*
 	 * For the MPU WFI to be registered as an interrupt
 	 * to WKUP_M3, MPU_CLKCTRL.MODULEMODE needs to be set
@@ -79,6 +116,7 @@ wait_emif_disable:
 	bic	r2, r2, #AM33XX_CM_CLKCTRL_MODULEMODE_DISABLE
 	str	r2, [r1]
 
+wkup_m3_skip:
 	/*
 	 * Execute an ISB instruction to ensure that all of the
 	 * CP15 register changes have been committed.
@@ -132,10 +170,18 @@ wait_emif_enable:
 	cmp	r2, r3
 	bne	wait_emif_enable
 
+	/* Only necessary if PER is losing context */
+	tst	r4, #WFI_FLAG_SELF_REFRESH
+	beq	emif_skip_exit_sr_abt
 
+	adr	r9, am33xx_emif_sram_table
 	ldr	r1, [r9, #EMIF_PM_ABORT_SR_OFFSET]
 	blx	r1
 
+emif_skip_exit_sr_abt:
+	tst	r4, #WFI_FLAG_FLUSH_CACHE
+	beq	cache_skip_restore
+
 	/*
 	 * Set SCTLR.C bit to allow data cache allocation
 	 */
@@ -144,6 +190,7 @@ wait_emif_enable:
 	mcr	p15, 0, r0, c1, c0, 0
 	isb
 
+cache_skip_restore:
 	/* Let the suspend code know about the abort */
 	mov	r0, #1
 	ldmfd	sp!, {r4 - r11, pc}	@ restore regs and return
diff --git a/arch/arm/mach-omap2/sleep43xx.S b/arch/arm/mach-omap2/sleep43xx.S
index 8903814..cd7e95f 100644
--- a/arch/arm/mach-omap2/sleep43xx.S
+++ b/arch/arm/mach-omap2/sleep43xx.S
@@ -9,7 +9,7 @@
 #include <generated/ti-pm-asm-offsets.h>
 #include <linux/linkage.h>
 #include <linux/ti-emif-sram.h>
-
+#include <linux/platform_data/pm33xx.h>
 #include <asm/assembler.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/memory.h>
@@ -22,6 +22,9 @@
 #include "prm33xx.h"
 #include "prcm43xx.h"
 
+/* replicated define because linux/bitops.h cannot be included in assembly */
+#define BIT(nr)			(1 << (nr))
+
 #define AM33XX_CM_CLKCTRL_MODULESTATE_DISABLED		0x00030000
 #define AM33XX_CM_CLKCTRL_MODULEMODE_DISABLE		0x0003
 #define AM33XX_CM_CLKCTRL_MODULEMODE_ENABLE		0x0002
@@ -51,6 +54,12 @@
 ENTRY(am43xx_do_wfi)
 	stmfd	sp!, {r4 - r11, lr}	@ save registers on stack
 
+	/* Save wfi_flags arg to data space */
+	mov	r4, r0
+	adr	r3, am43xx_pm_ro_sram_data
+	ldr	r2, [r3, #AMX3_PM_RO_SRAM_DATA_VIRT_OFFSET]
+	str	r4, [r2, #AMX3_PM_WFI_FLAGS_OFFSET]
+
 #ifdef CONFIG_CACHE_L2X0
 	/* Retrieve l2 cache virt address BEFORE we shut off EMIF */
 	ldr	r1, get_l2cache_base
@@ -58,6 +67,10 @@ ENTRY(am43xx_do_wfi)
 	mov	r8, r0
 #endif
 
+	/* Only flush cache is we know we are losing MPU context */
+	tst	r4, #WFI_FLAG_FLUSH_CACHE
+	beq	cache_skip_flush
+
 	/*
 	 * Flush all data from the L1 and L2 data cache before disabling
 	 * SCTLR.C bit.
@@ -128,13 +141,33 @@ sync:
 	bne	sync
 #endif
 
+	/* Restore wfi_flags */
+	adr	r3, am43xx_pm_ro_sram_data
+	ldr	r2, [r3, #AMX3_PM_RO_SRAM_DATA_VIRT_OFFSET]
+	ldr	r4, [r2, #AMX3_PM_WFI_FLAGS_OFFSET]
+
+cache_skip_flush:
+	/* Check if we want self refresh */
+	tst	r4, #WFI_FLAG_SELF_REFRESH
+	beq	emif_skip_enter_sr
+
 	adr     r9, am43xx_emif_sram_table
 
 	ldr     r3, [r9, #EMIF_PM_ENTER_SR_OFFSET]
 	blx     r3
 
+emif_skip_enter_sr:
+	/* Only necessary if PER is losing context */
+	tst	r4, #WFI_FLAG_SAVE_EMIF
+	beq	emif_skip_save
+
 	ldr     r3, [r9, #EMIF_PM_SAVE_CONTEXT_OFFSET]
-	blx     r3
+	blx	r3
+
+emif_skip_save:
+	/* Only can disable EMIF if we have entered self refresh */
+	tst	r4, #WFI_FLAG_SELF_REFRESH
+	beq	emif_skip_disable
 
 	/* Disable EMIF */
 	ldr	r1, am43xx_virt_emif_clkctrl
@@ -148,6 +181,10 @@ wait_emif_disable:
 	cmp	r2, r3
 	bne	wait_emif_disable
 
+emif_skip_disable:
+	tst	r4, #WFI_FLAG_WAKE_M3
+	beq	wkup_m3_skip
+
 	/*
 	 * For the MPU WFI to be registered as an interrupt
 	 * to WKUP_M3, MPU_CLKCTRL.MODULEMODE needs to be set
@@ -165,6 +202,7 @@ wait_emif_disable:
 	mov	r2, #AM43XX_CM_CLKSTCTRL_CLKTRCTRL_SW_SLEEP
 	str	r2, [r1]
 
+wkup_m3_skip:
 	/*
 	 * Execute a barrier instruction to ensure that all cache,
 	 * TLB and branch predictor maintenance operations issued
@@ -218,6 +256,9 @@ wait_emif_enable:
 	cmp	r2, r3
 	bne	wait_emif_enable
 
+	tst	r4, #WFI_FLAG_FLUSH_CACHE
+	beq	cache_skip_restore
+
 	/*
 	 * Set SCTLR.C bit to allow data cache allocation
 	 */
@@ -226,9 +267,16 @@ wait_emif_enable:
 	mcr	p15, 0, r0, c1, c0, 0
 	isb
 
-	ldr     r1, [r9, #EMIF_PM_ABORT_SR_OFFSET]
-	blx     r1
+cache_skip_restore:
+	/* Only necessary if PER is losing context */
+	tst	r4, #WFI_FLAG_SELF_REFRESH
+	beq	emif_skip_exit_sr_abt
+
+	adr	r9, am43xx_emif_sram_table
+	ldr	r1, [r9, #EMIF_PM_ABORT_SR_OFFSET]
+	blx	r1
 
+emif_skip_exit_sr_abt:
 	/* Let the suspend code know about the abort */
 	mov	r0, #1
 	ldmfd	sp!, {r4 - r11, pc}	@ restore regs and return
diff --git a/drivers/soc/ti/pm33xx.c b/drivers/soc/ti/pm33xx.c
index 652739c..0011c8f 100644
--- a/drivers/soc/ti/pm33xx.c
+++ b/drivers/soc/ti/pm33xx.c
@@ -41,6 +41,8 @@
 static struct device *pm33xx_dev;
 static struct wkup_m3_ipc *m3_ipc;
 
+static unsigned long suspend_wfi_flags;
+
 static u32 sram_suspend_address(unsigned long addr)
 {
 	return ((unsigned long)am33xx_do_wfi_sram +
@@ -53,7 +55,7 @@ static int am33xx_pm_suspend(suspend_state_t suspend_state)
 	int i, ret = 0;
 
 	ret = pm_ops->soc_suspend((unsigned long)suspend_state,
-				  am33xx_do_wfi_sram);
+				  am33xx_do_wfi_sram, suspend_wfi_flags);
 
 	if (ret) {
 		dev_err(pm33xx_dev, "PM: Kernel suspend failure\n");
@@ -310,6 +312,17 @@ static int am33xx_pm_probe(struct platform_device *pdev)
 	suspend_set_ops(&am33xx_pm_ops);
 #endif /* CONFIG_SUSPEND */
 
+	/*
+	 * For a system suspend we must flush the caches, we want
+	 * the DDR in self-refresh, we want to save the context
+	 * of the EMIF, and we want the wkup_m3 to handle low-power
+	 * transition.
+	 */
+	suspend_wfi_flags |= WFI_FLAG_FLUSH_CACHE;
+	suspend_wfi_flags |= WFI_FLAG_SELF_REFRESH;
+	suspend_wfi_flags |= WFI_FLAG_SAVE_EMIF;
+	suspend_wfi_flags |= WFI_FLAG_WAKE_M3;
+
 	ret = pm_ops->init();
 	if (ret) {
 		dev_err(dev, "Unable to call core pm init!\n");
diff --git a/include/linux/platform_data/pm33xx.h b/include/linux/platform_data/pm33xx.h
index f9bed2a..d231265 100644
--- a/include/linux/platform_data/pm33xx.h
+++ b/include/linux/platform_data/pm33xx.h
@@ -12,6 +12,29 @@
 #include <linux/kbuild.h>
 #include <linux/types.h>
 
+/*
+ * WFI Flags for sleep code control
+ *
+ * These flags allow PM code to exclude certain operations from happening
+ * in the low level ASM code found in sleep33xx.S and sleep43xx.S
+ *
+ * WFI_FLAG_FLUSH_CACHE: Flush the ARM caches and disable caching. Only
+ *			 needed when MPU will lose context.
+ * WFI_FLAG_SELF_REFRESH: Let EMIF place DDR memory into self-refresh and
+ *			  disable EMIF.
+ * WFI_FLAG_SAVE_EMIF: Save context of all EMIF registers and restore in
+ *		       resume path. Only needed if PER domain loses context
+ *		       and must also have WFI_FLAG_SELF_REFRESH set.
+ * WFI_FLAG_WAKE_M3: Disable MPU clock or clockdomain to cause wkup_m3 to
+ *		     execute when WFI instruction executes.
+ * WFI_FLAG_RTC_ONLY: Configure the RTC to enter RTC+DDR mode.
+ */
+#define WFI_FLAG_FLUSH_CACHE		BIT(0)
+#define WFI_FLAG_SELF_REFRESH		BIT(1)
+#define WFI_FLAG_SAVE_EMIF		BIT(2)
+#define WFI_FLAG_WAKE_M3		BIT(3)
+#define WFI_FLAG_RTC_ONLY		BIT(4)
+
 #ifndef __ASSEMBLER__
 struct am33xx_pm_sram_addr {
 	void (*do_wfi)(void);
@@ -23,7 +46,8 @@ struct am33xx_pm_sram_addr {
 
 struct am33xx_pm_platform_data {
 	int	(*init)(void);
-	int	(*soc_suspend)(unsigned int state, int (*fn)(unsigned long));
+	int	(*soc_suspend)(unsigned int state, int (*fn)(unsigned long),
+			       unsigned long args);
 	struct  am33xx_pm_sram_addr *(*get_sram_addrs)(void);
 };
 
-- 
1.9.1
