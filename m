From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 2/2] ARM: OMAP2+: sleep43xx: Add RTC-Mode support
Date: Wed, 4 Jul 2018 15:35:57 +0530
Message-ID: <1530698757-29807-2-git-send-email-j-keerthy@ti.com>
References: <1530698757-29807-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1530698757-29807-1-git-send-email-j-keerthy@ti.com>
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

Add support for RTC mode to low level suspend code. This includes
providing the rtc base address for the assembly code to configuring the
PMIC_PWR_EN line late in suspend to enter RTC+DDR mode.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/mach-omap2/pm-asm-offsets.c |  2 ++
 arch/arm/mach-omap2/pm33xx-core.c    | 10 +++++++
 arch/arm/mach-omap2/sleep33xx.S      |  8 +++--
 arch/arm/mach-omap2/sleep43xx.S      | 57 ++++++++++++++++++++++++++++++++++--
 drivers/soc/ti/pm33xx.c              |  1 +
 include/linux/platform_data/pm33xx.h |  3 ++
 6 files changed, 77 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-asm-offsets.c b/arch/arm/mach-omap2/pm-asm-offsets.c
index b9846b1..d202306 100644
--- a/arch/arm/mach-omap2/pm-asm-offsets.c
+++ b/arch/arm/mach-omap2/pm-asm-offsets.c
@@ -27,6 +27,8 @@ int main(void)
 	       offsetof(struct am33xx_pm_ro_sram_data, amx3_pm_sram_data_virt));
 	DEFINE(AMX3_PM_RO_SRAM_DATA_PHYS_OFFSET,
 	       offsetof(struct am33xx_pm_ro_sram_data, amx3_pm_sram_data_phys));
+	DEFINE(AMX3_PM_RTC_BASE_VIRT_OFFSET,
+		offsetof(struct am33xx_pm_ro_sram_data, rtc_base_virt));
 	DEFINE(AMX3_PM_RO_SRAM_DATA_SIZE,
 	       sizeof(struct am33xx_pm_ro_sram_data));
 
diff --git a/arch/arm/mach-omap2/pm33xx-core.c b/arch/arm/mach-omap2/pm33xx-core.c
index e363b97..f4971e4 100644
--- a/arch/arm/mach-omap2/pm33xx-core.c
+++ b/arch/arm/mach-omap2/pm33xx-core.c
@@ -26,6 +26,7 @@
 static struct powerdomain *cefuse_pwrdm, *gfx_pwrdm, *per_pwrdm, *mpu_pwrdm;
 static struct clockdomain *gfx_l4ls_clkdm;
 static void __iomem *scu_base;
+static struct omap_hwmod *rtc_oh;
 
 static int __init am43xx_map_scu(void)
 {
@@ -153,16 +154,25 @@ static struct am33xx_pm_sram_addr *amx3_get_sram_addrs(void)
 		return NULL;
 }
 
+void __iomem *am43xx_get_rtc_base_addr(void)
+{
+	rtc_oh = omap_hwmod_lookup("rtc");
+
+	return omap_hwmod_get_mpu_rt_va(rtc_oh);
+}
+
 static struct am33xx_pm_platform_data am33xx_ops = {
 	.init = am33xx_suspend_init,
 	.soc_suspend = am33xx_suspend,
 	.get_sram_addrs = amx3_get_sram_addrs,
+	.get_rtc_base_addr = am43xx_get_rtc_base_addr,
 };
 
 static struct am33xx_pm_platform_data am43xx_ops = {
 	.init = am43xx_suspend_init,
 	.soc_suspend = am43xx_suspend,
 	.get_sram_addrs = amx3_get_sram_addrs,
+	.get_rtc_base_addr = am43xx_get_rtc_base_addr,
 };
 
 static struct am33xx_pm_platform_data *am33xx_pm_get_pdata(void)
diff --git a/arch/arm/mach-omap2/sleep33xx.S b/arch/arm/mach-omap2/sleep33xx.S
index 3ef469f..47a8164 100644
--- a/arch/arm/mach-omap2/sleep33xx.S
+++ b/arch/arm/mach-omap2/sleep33xx.S
@@ -20,6 +20,9 @@
 #define AM33XX_CM_CLKCTRL_MODULEMODE_DISABLE			0x0003
 #define AM33XX_CM_CLKCTRL_MODULEMODE_ENABLE			0x0002
 
+/* replicated define because linux/bitops.h cannot be included in assembly */
+#define BIT(nr)			(1 << (nr))
+
 	.arm
 	.align 3
 
@@ -225,8 +228,6 @@ ENDPROC(am33xx_resume_from_deep_sleep)
  * Local variables
  */
 	.align
-resume_addr:
-	.word	cpu_resume - PAGE_OFFSET + 0x80000000
 kernel_flush:
 	.word   v7_flush_dcache_all
 virt_mpu_clkctrl:
@@ -249,6 +250,9 @@ ENTRY(am33xx_pm_sram)
 	.word am33xx_emif_sram_table
 	.word am33xx_pm_ro_sram_data
 
+resume_addr:
+.word  cpu_resume - PAGE_OFFSET + 0x80000000
+
 .align 3
 ENTRY(am33xx_pm_ro_sram_data)
 	.space AMX3_PM_RO_SRAM_DATA_SIZE
diff --git a/arch/arm/mach-omap2/sleep43xx.S b/arch/arm/mach-omap2/sleep43xx.S
index 0553adb..5b9343b 100644
--- a/arch/arm/mach-omap2/sleep43xx.S
+++ b/arch/arm/mach-omap2/sleep43xx.S
@@ -22,6 +22,9 @@
 #include "prm33xx.h"
 #include "prcm43xx.h"
 
+/* replicated define because linux/bitops.h cannot be included in assembly */
+#define BIT(nr)			(1 << (nr))
+
 #define AM33XX_CM_CLKCTRL_MODULESTATE_DISABLED		0x00030000
 #define AM33XX_CM_CLKCTRL_MODULEMODE_DISABLE		0x0003
 #define AM33XX_CM_CLKCTRL_MODULEMODE_ENABLE		0x0002
@@ -45,6 +48,13 @@
 					AM43XX_CM_PER_EMIF_CLKCTRL_OFFSET)
 #define AM43XX_PRM_EMIF_CTRL_OFFSET			0x0030
 
+#define RTC_SECONDS_REG					0x0
+#define RTC_PMIC_REG					0x98
+#define RTC_PMIC_POWER_EN				BIT(16)
+#define RTC_PMIC_EXT_WAKEUP_STS				BIT(12)
+#define RTC_PMIC_EXT_WAKEUP_POL				BIT(4)
+#define RTC_PMIC_EXT_WAKEUP_EN				BIT(0)
+
 	.arm
 	.align 3
 
@@ -144,6 +154,20 @@ sync:
 	ldr	r4, [r2, #AMX3_PM_WFI_FLAGS_OFFSET]
 
 cache_skip_flush:
+	/*
+	 * If we are trying to enter RTC+DDR mode we must perform
+	 * a read from the rtc address space to ensure translation
+	 * presence in the TLB to avoid page table walk after DDR
+	 * is unavailable.
+	 */
+	tst	r4, #WFI_FLAG_RTC_ONLY
+	beq	skip_rtc_va_refresh
+
+	adr	r3, am43xx_pm_ro_sram_data
+	ldr	r1, [r3, #AMX3_PM_RTC_BASE_VIRT_OFFSET]
+	ldr	r0, [r1]
+
+skip_rtc_va_refresh:
 	/* Check if we want self refresh */
 	tst	r4, #WFI_FLAG_SELF_REFRESH
 	beq	emif_skip_enter_sr
@@ -179,6 +203,34 @@ wait_emif_disable:
 	bne	wait_emif_disable
 
 emif_skip_disable:
+	tst	r4, #WFI_FLAG_RTC_ONLY
+	beq	skip_rtc_only
+
+	adr	r3, am43xx_pm_ro_sram_data
+	ldr	r1, [r3, #AMX3_PM_RTC_BASE_VIRT_OFFSET]
+
+	ldr	r0, [r1, #RTC_PMIC_REG]
+	orr	r0, r0, #RTC_PMIC_POWER_EN
+	orr	r0, r0, #RTC_PMIC_EXT_WAKEUP_STS
+	orr	r0, r0, #RTC_PMIC_EXT_WAKEUP_EN
+	orr	r0, r0, #RTC_PMIC_EXT_WAKEUP_POL
+	str	r0, [r1, #RTC_PMIC_REG]
+	ldr	r0, [r1, #RTC_PMIC_REG]
+	/* Wait for 2 seconds to lose power */
+	mov	r3, #2
+	ldr	r2, [r1, #RTC_SECONDS_REG]
+rtc_loop:
+	ldr	r0, [r1, #RTC_SECONDS_REG]
+	cmp	r0, r2
+	beq	rtc_loop
+	mov	r2, r0
+	subs	r3, r3, #1
+	bne	rtc_loop
+
+	b	re_enable_emif
+
+skip_rtc_only:
+
 	tst	r4, #WFI_FLAG_WAKE_M3
 	beq	wkup_m3_skip
 
@@ -244,6 +296,7 @@ wkup_m3_skip:
 	mov	r2, #AM33XX_CM_CLKCTRL_MODULEMODE_ENABLE
 	str	r2, [r1]
 
+re_enable_emif:
 	/* Re-enable EMIF */
 	ldr	r1, am43xx_virt_emif_clkctrl
 	mov	r2, #AM33XX_CM_CLKCTRL_MODULEMODE_ENABLE
@@ -378,8 +431,6 @@ ENDPROC(am43xx_resume_from_deep_sleep)
  * Local variables
  */
 	.align
-resume_addr:
-	.word	cpu_resume - PAGE_OFFSET + 0x80000000
 kernel_flush:
 	.word   v7_flush_dcache_all
 ddr_start:
@@ -426,6 +477,8 @@ ENTRY(am43xx_pm_sram)
 	.word am43xx_emif_sram_table
 	.word am43xx_pm_ro_sram_data
 
+resume_addr:
+	.word   cpu_resume - PAGE_OFFSET + 0x80000000
 .align 3
 
 ENTRY(am43xx_pm_ro_sram_data)
diff --git a/drivers/soc/ti/pm33xx.c b/drivers/soc/ti/pm33xx.c
index 0011c8f..d0dab32 100644
--- a/drivers/soc/ti/pm33xx.c
+++ b/drivers/soc/ti/pm33xx.c
@@ -229,6 +229,7 @@ static int am33xx_push_sram_idle(void)
 	ro_sram_data.amx3_pm_sram_data_virt = ocmcram_location_data;
 	ro_sram_data.amx3_pm_sram_data_phys =
 		gen_pool_virt_to_phys(sram_pool_data, ocmcram_location_data);
+	ro_sram_data.rtc_base_virt = pm_ops->get_rtc_base_addr();
 
 	/* Save physical address to calculate resume offset during pm init */
 	am33xx_do_wfi_sram_phys = gen_pool_virt_to_phys(sram_pool,
diff --git a/include/linux/platform_data/pm33xx.h b/include/linux/platform_data/pm33xx.h
index d231265..fbf5ed7 100644
--- a/include/linux/platform_data/pm33xx.h
+++ b/include/linux/platform_data/pm33xx.h
@@ -42,6 +42,7 @@ struct am33xx_pm_sram_addr {
 	unsigned long *resume_offset;
 	unsigned long *emif_sram_table;
 	unsigned long *ro_sram_data;
+	unsigned long resume_address;
 };
 
 struct am33xx_pm_platform_data {
@@ -49,6 +50,7 @@ struct am33xx_pm_platform_data {
 	int	(*soc_suspend)(unsigned int state, int (*fn)(unsigned long),
 			       unsigned long args);
 	struct  am33xx_pm_sram_addr *(*get_sram_addrs)(void);
+	void __iomem *(*get_rtc_base_addr)(void);
 };
 
 struct am33xx_pm_sram_data {
@@ -60,6 +62,7 @@ struct am33xx_pm_sram_data {
 struct am33xx_pm_ro_sram_data {
 	u32 amx3_pm_sram_data_virt;
 	u32 amx3_pm_sram_data_phys;
+	void __iomem *rtc_base_virt;
 } __packed __aligned(8);
 
 #endif /* __ASSEMBLER__ */
-- 
1.9.1
