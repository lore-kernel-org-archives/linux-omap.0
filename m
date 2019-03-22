From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 5/5] soc: ti: pm33xx: AM437X: Add rtc_only with ddr in
 self-refresh support
Date: Fri, 22 Mar 2019 22:46:19 +0530
Message-ID: <20190322171619.4180-6-j-keerthy@ti.com>
References: <20190322171619.4180-1-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190322171619.4180-1-j-keerthy@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tony@atomide.com, alexandre.belloni@bootlin.com, a.zummo@towertech.it, t-kristo@ti.com
Cc: linux-rtc@vger.kernel.org, d-gerlach@ti.com, j-keerthy@ti.com, ssantosh@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

During RTC-only suspend, power is lost to the wkup domain, so we need to
save and restore the state of that domain. We also need to store some
information within the RTC registers so that u-boot can do the right thing
at powerup.

The state is entered by getting the RTC to bring the pmic_power_en line low
which will instruct the PMIC to disable the appropriate power rails after
putting DDR into self-refresh mode. To bring pmic_power_en low, we need to
get an ALARM2 event. Since we are running from SRAM at that point, it means
calculating what the next second is (via ASM) and programming that into the
RTC. This patch also adds support for wake up source detection.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 drivers/soc/ti/Kconfig  |   5 +-
 drivers/soc/ti/pm33xx.c | 190 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 184 insertions(+), 11 deletions(-)

diff --git a/drivers/soc/ti/Kconfig b/drivers/soc/ti/Kconfig
index be4570baad96..57960e92ebe0 100644
--- a/drivers/soc/ti/Kconfig
+++ b/drivers/soc/ti/Kconfig
@@ -45,11 +45,12 @@ config KEYSTONE_NAVIGATOR_DMA
 config AMX3_PM
 	tristate "AMx3 Power Management"
 	depends on SOC_AM33XX || SOC_AM43XX
-	depends on WKUP_M3_IPC && TI_EMIF_SRAM && SRAM
+	depends on WKUP_M3_IPC && TI_EMIF_SRAM && SRAM && RTC_DRV_OMAP
 	help
 	  Enable power management on AM335x and AM437x. Required for suspend to mem
 	  and standby states on both AM335x and AM437x platforms and for deeper cpuidle
-	  c-states on AM335x.
+	  c-states on AM335x. Also required for rtc and ddr in self-refresh low
+	  power mode on AM437x platforms.
 
 config WKUP_M3_IPC
 	tristate "TI AMx3 Wkup-M3 IPC Driver"
diff --git a/drivers/soc/ti/pm33xx.c b/drivers/soc/ti/pm33xx.c
index 69128993776d..15b1414d3465 100644
--- a/drivers/soc/ti/pm33xx.c
+++ b/drivers/soc/ti/pm33xx.c
@@ -6,6 +6,7 @@
  *	Vaibhav Bedia, Dave Gerlach
  */
 
+#include <linux/clk.h>
 #include <linux/cpu.h>
 #include <linux/err.h>
 #include <linux/genalloc.h>
@@ -13,9 +14,11 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/nvmem-consumer.h>
 #include <linux/of.h>
 #include <linux/platform_data/pm33xx.h>
 #include <linux/platform_device.h>
+#include <linux/rtc.h>
 #include <linux/sizes.h>
 #include <linux/sram.h>
 #include <linux/suspend.h>
@@ -29,20 +32,47 @@
 #define AMX3_PM_SRAM_SYMBOL_OFFSET(sym) ((unsigned long)(sym) - \
 					 (unsigned long)pm_sram->do_wfi)
 
+#define RTC_SCRATCH_RESUME_REG	0
+#define RTC_SCRATCH_MAGIC_REG	1
+#define RTC_REG_BOOT_MAGIC	0x8cd0 /* RTC */
+#define GIC_INT_SET_PENDING_BASE 0x200
+#define AM43XX_GIC_DIST_BASE	0x48241000
+
+static u32 rtc_magic_val;
+
 static int (*am33xx_do_wfi_sram)(unsigned long unused);
 static phys_addr_t am33xx_do_wfi_sram_phys;
 
 static struct gen_pool *sram_pool, *sram_pool_data;
 static unsigned long ocmcram_location, ocmcram_location_data;
 
+static struct rtc_device *omap_rtc;
+static void __iomem *gic_dist_base;
+
 static struct am33xx_pm_platform_data *pm_ops;
 static struct am33xx_pm_sram_addr *pm_sram;
 
 static struct device *pm33xx_dev;
 static struct wkup_m3_ipc *m3_ipc;
 
+#ifdef CONFIG_SUSPEND
+static int rtc_only_idle;
+static int retrigger_irq;
 static unsigned long suspend_wfi_flags;
 
+static struct wkup_m3_wakeup_src wakeup_src = {.irq_nr = 0,
+	.src = "Unknown",
+};
+
+static struct wkup_m3_wakeup_src rtc_alarm_wakeup = {
+	.irq_nr = 108, .src = "RTC Alarm",
+};
+
+static struct wkup_m3_wakeup_src rtc_ext_wakeup = {
+	.irq_nr = 0, .src = "Ext wakeup",
+};
+#endif
+
 static u32 sram_suspend_address(unsigned long addr)
 {
 	return ((unsigned long)am33xx_do_wfi_sram +
@@ -99,13 +129,65 @@ static int am33xx_push_sram_idle(void)
 	return 0;
 }
 
+static int __init am43xx_map_gic(void)
+{
+	gic_dist_base = ioremap(AM43XX_GIC_DIST_BASE, SZ_4K);
+
+	if (!gic_dist_base)
+		return -ENOMEM;
+
+	return 0;
+}
+
 #ifdef CONFIG_SUSPEND
+struct wkup_m3_wakeup_src rtc_wake_src(void)
+{
+	u32 i;
+
+	i = __raw_readl(pm_ops->get_rtc_base_addr() + 0x44) & 0x40;
+
+	if (i) {
+		retrigger_irq = rtc_alarm_wakeup.irq_nr;
+		return rtc_alarm_wakeup;
+	}
+
+	retrigger_irq = rtc_ext_wakeup.irq_nr;
+
+	return rtc_ext_wakeup;
+}
+
+int am33xx_rtc_only_idle(unsigned long wfi_flags)
+{
+	rtc_power_off_program(omap_rtc);
+	am33xx_do_wfi_sram(wfi_flags);
+	return 0;
+}
+
 static int am33xx_pm_suspend(suspend_state_t suspend_state)
 {
 	int i, ret = 0;
 
-	ret = pm_ops->soc_suspend((unsigned long)suspend_state,
-				  am33xx_do_wfi_sram, suspend_wfi_flags);
+	if (suspend_state == PM_SUSPEND_MEM &&
+	    pm_ops->check_off_mode_enable()) {
+		pm_ops->prepare_rtc_suspend();
+		pm_ops->save_context();
+		suspend_wfi_flags |= WFI_FLAG_RTC_ONLY;
+		clk_save_context();
+		ret = pm_ops->soc_suspend(suspend_state, am33xx_rtc_only_idle,
+					  suspend_wfi_flags);
+
+		suspend_wfi_flags &= ~WFI_FLAG_RTC_ONLY;
+
+		if (!ret) {
+			clk_restore_context();
+			pm_ops->restore_context();
+			m3_ipc->ops->set_rtc_only(m3_ipc);
+			am33xx_push_sram_idle();
+		}
+	} else {
+		ret = pm_ops->soc_suspend(suspend_state, am33xx_do_wfi_sram,
+					  suspend_wfi_flags);
+	}
 
 	if (ret) {
 		dev_err(pm33xx_dev, "PM: Kernel suspend failure\n");
@@ -127,8 +209,20 @@ static int am33xx_pm_suspend(suspend_state_t suspend_state)
 				"PM: CM3 returned unknown result = %d\n", i);
 			ret = -1;
 		}
+
+		/* print the wakeup reason */
+		if (rtc_only_idle) {
+			wakeup_src = rtc_wake_src();
+			pr_info("PM: Wakeup source %s\n", wakeup_src.src);
+		} else {
+			pr_info("PM: Wakeup source %s\n",
+				m3_ipc->ops->request_wake_src(m3_ipc));
+		}
 	}
 
+	if (suspend_state == PM_SUSPEND_MEM && pm_ops->check_off_mode_enable())
+		pm_ops->prepare_rtc_resume();
+
 	return ret;
 }
 
@@ -151,6 +245,18 @@ static int am33xx_pm_enter(suspend_state_t suspend_state)
 static int am33xx_pm_begin(suspend_state_t state)
 {
 	int ret = -EINVAL;
+	struct nvmem_device *nvmem;
+
+	if (state == PM_SUSPEND_MEM && pm_ops->check_off_mode_enable()) {
+		nvmem = devm_nvmem_device_get(&omap_rtc->dev,
+					      "omap_rtc_scratch0");
+		if (nvmem)
+			nvmem_device_write(nvmem, RTC_SCRATCH_MAGIC_REG * 4, 4,
+					   (void *)&rtc_magic_val);
+		rtc_only_idle = 1;
+	} else {
+		rtc_only_idle = 0;
+	}
 
 	switch (state) {
 	case PM_SUSPEND_MEM:
@@ -166,7 +272,28 @@ static int am33xx_pm_begin(suspend_state_t state)
 
 static void am33xx_pm_end(void)
 {
+	u32 val = 0;
+	struct nvmem_device *nvmem;
+
+	nvmem = devm_nvmem_device_get(&omap_rtc->dev, "omap_rtc_scratch0");
 	m3_ipc->ops->finish_low_power(m3_ipc);
+	if (rtc_only_idle) {
+		if (retrigger_irq)
+			/*
+			 * 32 bits of Interrupt Set-Pending correspond to 32
+			 * 32 interrupts. Compute the bit offset of the
+			 * Interrupt and set that particular bit
+			 * Compute the register offset by dividing interrupt
+			 * number by 32 and mutiplying by 4
+			 */
+			writel_relaxed(1 << (retrigger_irq & 31),
+				       gic_dist_base + GIC_INT_SET_PENDING_BASE
+				       + retrigger_irq / 32 * 4);
+			nvmem_device_write(nvmem, RTC_SCRATCH_MAGIC_REG * 4, 4,
+					   (void *)&val);
+	}
+
+	rtc_only_idle = 0;
 }
 
 static int am33xx_pm_valid(suspend_state_t state)
@@ -269,6 +396,42 @@ static int am33xx_pm_alloc_sram(void)
 	return ret;
 }
 
+static int am33xx_pm_rtc_setup(void)
+{
+	struct device_node *np;
+	unsigned long val = 0;
+	struct nvmem_device *nvmem;
+
+	np = of_find_node_by_name(NULL, "rtc");
+
+	if (of_device_is_available(np)) {
+		omap_rtc = rtc_class_open("rtc0");
+		if (!omap_rtc) {
+			pr_warn("PM: rtc0 not available");
+			return -EPROBE_DEFER;
+		}
+
+		nvmem = devm_nvmem_device_get(&omap_rtc->dev,
+					      "omap_rtc_scratch0");
+		if (nvmem) {
+			nvmem_device_read(nvmem, RTC_SCRATCH_MAGIC_REG * 4,
+					  4, (void *)&rtc_magic_val);
+			if ((rtc_magic_val & 0xffff) != RTC_REG_BOOT_MAGIC)
+				pr_warn("PM: bootloader does not support rtc-only!\n");
+
+			nvmem_device_write(nvmem, RTC_SCRATCH_MAGIC_REG * 4,
+					   4, (void *)&val);
+			val = pm_sram->resume_address;
+			nvmem_device_write(nvmem, RTC_SCRATCH_RESUME_REG * 4,
+					   4, (void *)&val);
+		}
+	} else {
+		pr_warn("PM: no-rtc available, rtc-only mode disabled.\n");
+	}
+
+	return 0;
+}
+
 static int am33xx_pm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -284,34 +447,42 @@ static int am33xx_pm_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	ret = am43xx_map_gic();
+	if (ret) {
+		pr_err("PM: Could not ioremap GIC base\n");
+		return ret;
+	}
+
 	pm_sram = pm_ops->get_sram_addrs();
 	if (!pm_sram) {
 		dev_err(dev, "PM: Cannot get PM asm function addresses!!\n");
 		return -ENODEV;
 	}
 
+	m3_ipc = wkup_m3_ipc_get();
+	if (!m3_ipc) {
+		pr_err("PM: Cannot get wkup_m3_ipc handle\n");
+		return -EPROBE_DEFER;
+	}
+
 	pm33xx_dev = dev;
 
 	ret = am33xx_pm_alloc_sram();
 	if (ret)
 		return ret;
 
-	ret = am33xx_push_sram_idle();
+	ret = am33xx_pm_rtc_setup();
 	if (ret)
 		goto err_free_sram;
 
-	m3_ipc = wkup_m3_ipc_get();
-	if (!m3_ipc) {
-		dev_dbg(dev, "PM: Cannot get wkup_m3_ipc handle\n");
-		ret = -EPROBE_DEFER;
+	ret = am33xx_push_sram_idle();
+	if (ret)
 		goto err_free_sram;
-	}
 
 	am33xx_pm_set_ipc_ops();
 
 #ifdef CONFIG_SUSPEND
 	suspend_set_ops(&am33xx_pm_ops);
-#endif /* CONFIG_SUSPEND */
 
 	/*
 	 * For a system suspend we must flush the caches, we want
@@ -323,6 +494,7 @@ static int am33xx_pm_probe(struct platform_device *pdev)
 	suspend_wfi_flags |= WFI_FLAG_SELF_REFRESH;
 	suspend_wfi_flags |= WFI_FLAG_SAVE_EMIF;
 	suspend_wfi_flags |= WFI_FLAG_WAKE_M3;
+#endif /* CONFIG_SUSPEND */
 
 	ret = pm_ops->init();
 	if (ret) {
-- 
2.17.1
