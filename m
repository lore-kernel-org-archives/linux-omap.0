From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 03/14] ARM: OMAP2+: omap_hwmod: Introduce HWMOD_NEEDS_REIDLE
Date: Thu, 12 Apr 2018 09:23:48 +0530
Message-ID: <1523505239-16229-4-git-send-email-j-keerthy@ti.com>
References: <1523505239-16229-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1523505239-16229-1-git-send-email-j-keerthy@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linus.walleij@linaro.org, grygorii.strashko@ti.com, tony@atomide.com
Cc: d-gerlach@ti.com, j-keerthy@ti.com, linux-kernel@vger.kernel.org, t-kristo@ti.com, Russ.Dill@ti.com, haojian.zhuang@linaro.org, ssantosh@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: Dave Gerlach <d-gerlach@ti.com>

Some hwmods will not properly assert signals to the PRCM after a
context loss if no driver is present which leads to issues with suspend.
This can be caused by the SYSCONFIG register not being programmed
correctly by default or a softreset being needed before the module will
idle. omap_hwmod will program the SYSCONFIG, idle and softreset them
properly after boot but after the first context loss they will be in
the wrong state once again so suspend will no longer work as there
is no driver associated with the hwmod.

Introduce a new flag, HWMOD_NEEDS_REIDLE, to allow these modules to be
tracked and properly handled. omap_hwmod maintains a list of these
modules and uses a PM notifier to enable and then idle and softreset the
hwmods immediately after resume. omap_device will remove hwmods from this
list when a driver is bound and add the hwmods back if the driver is
removed to avoid any conflicts and allow the proper pm layer to handle
things when a driver is present.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/mach-omap2/omap_device.c                  |  50 ++++++++
 arch/arm/mach-omap2/omap_device.h                  |   1 +
 arch/arm/mach-omap2/omap_hwmod.c                   | 135 +++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod.h                   |  17 +++
 .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c |  14 ++-
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |   3 +-
 6 files changed, 214 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
index 3b829a5..d1e7942 100644
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -208,6 +208,27 @@ static int omap_device_build_from_dt(struct platform_device *pdev)
 	return ret;
 }
 
+/**
+ * _omap_device_check_reidle_hwmods - check all hwmods in device for reidle flag
+ * @od: struct omap_device *od
+ *
+ * Checks underlying hwmods for reidle flag, if present, remove from hwmod
+ * list and set flag in omap_device to keep track.  Returns 0.
+ */
+static int _omap_device_check_reidle_hwmods(struct omap_device *od)
+{
+	int i;
+
+	for (i = 0; i < od->hwmods_cnt; i++) {
+		if (od->hwmods[i]->flags & HWMOD_NEEDS_REIDLE) {
+			od->flags |= OMAP_DEVICE_HAS_REIDLE_HWMODS;
+			omap_hwmod_disable_reidle(od->hwmods[i]);
+		}
+	}
+
+	return 0;
+}
+
 static int _omap_device_notifier_call(struct notifier_block *nb,
 				      unsigned long event, void *dev)
 {
@@ -237,6 +258,13 @@ static int _omap_device_notifier_call(struct notifier_block *nb,
 			pm_runtime_set_active(dev);
 		}
 		break;
+	case BUS_NOTIFY_BOUND_DRIVER:
+		od = to_omap_device(pdev);
+		if (od) {
+			od->_driver_status = BUS_NOTIFY_BOUND_DRIVER;
+			_omap_device_check_reidle_hwmods(od);
+		}
+		break;
 	case BUS_NOTIFY_ADD_DEVICE:
 		if (pdev->dev.of_node)
 			omap_device_build_from_dt(pdev);
@@ -285,6 +313,24 @@ static int _omap_device_idle_hwmods(struct omap_device *od)
 	return ret;
 }
 
+/**
+ * _omap_device_reidle_hwmods - call omap_hwmod_enable_reidle on all hwmods
+ * @od: struct omap_device *od
+ *
+ * Add all underlying hwmods to hwmod reidle list.  Returns 0.
+ */
+static int _omap_device_reidle_hwmods(struct omap_device *od)
+{
+	int i;
+
+	for (i = 0; i < od->hwmods_cnt; i++)
+		if (od->hwmods[i]->flags | HWMOD_NEEDS_REIDLE)
+			omap_hwmod_enable_reidle(od->hwmods[i]);
+
+	/* XXX pass along return value here? */
+	return 0;
+}
+
 /* Public functions for use by core code */
 
 /**
@@ -370,6 +416,9 @@ void omap_device_delete(struct omap_device *od)
 	if (!od)
 		return;
 
+	if (od->flags & OMAP_DEVICE_HAS_REIDLE_HWMODS)
+		_omap_device_reidle_hwmods(od);
+
 	od->pdev->archdata.od = NULL;
 	kfree(od->hwmods);
 	kfree(od);
@@ -821,6 +870,7 @@ struct device *omap_device_get_by_hwmod_name(const char *oh_name)
 
 static int __init omap_device_init(void)
 {
+	omap_hwmod_setup_reidle();
 	bus_register_notifier(&platform_bus_type, &platform_nb);
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/omap_device.h b/arch/arm/mach-omap2/omap_device.h
index 786b9c0..5954727 100644
--- a/arch/arm/mach-omap2/omap_device.h
+++ b/arch/arm/mach-omap2/omap_device.h
@@ -39,6 +39,7 @@
 
 /* omap_device.flags values */
 #define OMAP_DEVICE_SUSPENDED		BIT(0)
+#define OMAP_DEVICE_HAS_REIDLE_HWMODS	BIT(1)
 
 /**
  * struct omap_device - omap_device wrapper for platform_devices
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index e7d23e20..90ad8e7 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -141,6 +141,7 @@
 #include <linux/cpu.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/suspend.h>
 #include <linux/bootmem.h>
 
 #include <linux/platform_data/ti-sysc.h>
@@ -236,6 +237,9 @@ struct omap_hwmod_soc_ops {
 /* omap_hwmod_list contains all registered struct omap_hwmods */
 static LIST_HEAD(omap_hwmod_list);
 
+/* oh_reidle_list contains all omap_hwmods with HWMOD_NEEDS_REIDLE set */
+static LIST_HEAD(oh_reidle_list);
+
 /* mpu_oh: used to add/remove MPU initiator from sleepdep list */
 static struct omap_hwmod *mpu_oh;
 
@@ -2230,6 +2234,28 @@ int omap_hwmod_parse_module_range(struct omap_hwmod *oh,
 }
 
 /**
+ * _setup_reidle- check hwmod @oh and add to reidle list
+ * @oh: struct omap_hwmod *
+ * @n: (unused)
+ *
+ * Check hwmod for HWMOD_NEEDS_REIDLE flag and add to list if
+ * necessary. Return 0 on success.
+ */
+static int _setup_reidle(struct omap_hwmod *oh, void *data)
+{
+	int ret;
+
+	if (oh->flags & HWMOD_NEEDS_REIDLE) {
+		ret = omap_hwmod_enable_reidle(oh);
+
+		if (!ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+/**
  * _init_mpu_rt_base - populate the virtual address for a hwmod
  * @oh: struct omap_hwmod * to locate the virtual address
  * @data: (unused, caller should pass NULL)
@@ -2878,6 +2904,54 @@ static int _am33xx_deassert_hardreset(struct omap_hwmod *oh,
 					   oh->prcm.omap4.rstst_offs);
 }
 
+/**
+ * _reidle - enable then idle a single hwmod
+ *
+ * enables and then immediately reidles an hwmod, as certain hwmods may
+ * not have their sysconfig registers programmed in an idle friendly state
+ * by default
+ */
+static void _reidle(struct omap_hwmod *oh)
+{
+	pr_debug("omap_hwmod: %s: %s\n", oh->name, __func__);
+
+	omap_hwmod_enable(oh);
+	omap_hwmod_softreset(oh);
+	omap_hwmod_idle(oh);
+}
+
+/**
+ * _reidle_all - enable then idle all hwmods in oh_reidle_list
+ *
+ * Called by pm_notifier to make sure flagged modules do not block suspend
+ * after context loss.
+ */
+static int _reidle_all(void)
+{
+	struct omap_hwmod_list *oh_list_item = NULL;
+
+	list_for_each_entry(oh_list_item, &oh_reidle_list, oh_list) {
+		_reidle(oh_list_item->oh);
+	}
+
+	return 0;
+}
+
+static int _omap_device_pm_notifier(struct notifier_block *self,
+				    unsigned long action, void *dev)
+{
+	switch (action) {
+	case PM_POST_SUSPEND:
+		_reidle_all();
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block pm_nb = {
+	.notifier_call = _omap_device_pm_notifier,
+};
+
 /* Public functions */
 
 u32 omap_hwmod_read(struct omap_hwmod *oh, u16 reg_offs)
@@ -3529,6 +3603,52 @@ static int __init omap_hwmod_setup_all(void)
 omap_postcore_initcall(omap_hwmod_setup_all);
 
 /**
+ * omap_hwmod_enable_reidle - add an omap_hwmod to reidle list
+ * @oh: struct omap_hwmod *
+ *
+ * Adds the omap_hwmod to the oh_reidle_list so it will gets enabled then idled
+ * after each suspend cycle. Returns 0 on success.
+ */
+int omap_hwmod_enable_reidle(struct omap_hwmod *oh)
+{
+	struct omap_hwmod_list *oh_list_item = NULL;
+
+	oh_list_item = kzalloc(sizeof(*oh_list_item), GFP_KERNEL);
+
+	if (!oh_list_item)
+		return -ENOMEM;
+
+	oh_list_item->oh = oh;
+	list_add(&oh_list_item->oh_list, &oh_reidle_list);
+
+	pr_debug("omap_hwmod: %s: added to reidle list\n", oh->name);
+
+	return 0;
+}
+
+/**
+ * omap_hwmod_disable_reidle - remove an omap_hwmod from reidle list
+ * @oh: struct omap_hwmod *
+ *
+ * Remove the omap_hwmod from the oh_reidle_list. Returns 0 on success.
+ */
+int omap_hwmod_disable_reidle(struct omap_hwmod *oh)
+{
+	struct omap_hwmod_list *li, *oh_list_item = NULL;
+
+	list_for_each_entry_safe(oh_list_item, li, &oh_reidle_list, oh_list) {
+		if (oh_list_item->oh == oh) {
+			list_del(&oh_list_item->oh_list);
+			pr_debug("omap_hwmod: %s: removed from reidle list\n",
+				 oh->name);
+			kfree(oh_list_item);
+		}
+	}
+
+	return 0;
+}
+
+/**
  * omap_hwmod_enable - enable an omap_hwmod
  * @oh: struct omap_hwmod *
  *
@@ -3948,6 +4068,21 @@ void __init omap_hwmod_init(void)
 }
 
 /**
+ * omap_hwmod_setup_reidle - add hwmods to reidle list and register notifier
+ *
+ * Returns 0 on success.
+ */
+int omap_hwmod_setup_reidle(void)
+{
+	omap_hwmod_for_each(_setup_reidle, NULL);
+
+	if (!list_empty(&oh_reidle_list))
+		register_pm_notifier(&pm_nb);
+
+	return 0;
+}
+
+/**
  * omap_hwmod_get_main_clk - get pointer to main clock name
  * @oh: struct omap_hwmod *
  *
diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
index c7122ab..f35638b 100644
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -445,6 +445,10 @@ struct omap_hwmod_omap4_prcm {
  *     entering HW_AUTO while hwmod is active. This is needed to workaround
  *     some modules which don't function correctly with HW_AUTO. For example,
  *     DCAN on DRA7x SoC needs this to workaround errata i893.
+ * HWMOD_NEEDS_REIDLE: Some devices do not assert their MSTANDBY signal by
+ *     default after losing context if no driver is present and using the
+ *     hwmod. This will break subsequent suspend cycles but can be fixed by
+ *     enabling then idling the unused hwmod after each suspend cycle.
  */
 #define HWMOD_SWSUP_SIDLE			(1 << 0)
 #define HWMOD_SWSUP_MSTANDBY			(1 << 1)
@@ -463,6 +467,7 @@ struct omap_hwmod_omap4_prcm {
 #define HWMOD_OPT_CLKS_NEEDED			(1 << 14)
 #define HWMOD_NO_IDLE				(1 << 15)
 #define HWMOD_CLKDM_NOAUTO			(1 << 16)
+#define HWMOD_NEEDS_REIDLE			(1 << 17)
 
 /*
  * omap_hwmod._int_flags definitions
@@ -611,6 +616,14 @@ struct omap_hwmod {
 
 struct device_node;
 
+/*
+ * omap_hwmod_list - simple generic container for omap_hwmod lists
+ */
+struct omap_hwmod_list {
+	struct omap_hwmod *oh;
+	struct list_head oh_list;
+};
+
 struct omap_hwmod *omap_hwmod_lookup(const char *name);
 int omap_hwmod_for_each(int (*fn)(struct omap_hwmod *oh, void *data),
 			void *data);
@@ -649,6 +662,10 @@ int omap_hwmod_get_resource_byname(struct omap_hwmod *oh, unsigned int type,
 int omap_hwmod_enable_wakeup(struct omap_hwmod *oh);
 int omap_hwmod_disable_wakeup(struct omap_hwmod *oh);
 
+int omap_hwmod_setup_reidle(void);
+int omap_hwmod_enable_reidle(struct omap_hwmod *oh);
+int omap_hwmod_disable_reidle(struct omap_hwmod *oh);
+
 int omap_hwmod_for_each_by_class(const char *classname,
 				 int (*fn)(struct omap_hwmod *oh,
 					   void *user),
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
index 5efe91c..f31ec76 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
@@ -375,7 +375,8 @@ struct omap_hwmod am33xx_cpgmac0_hwmod = {
 	.name		= "cpgmac0",
 	.class		= &am33xx_cpgmac0_hwmod_class,
 	.clkdm_name	= "cpsw_125mhz_clkdm",
-	.flags		= (HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY),
+	.flags		= HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY |
+			  HWMOD_NEEDS_REIDLE,
 	.main_clk	= "cpsw_125mhz_gclk",
 	.mpu_rt_idx	= 1,
 	.prcm		= {
@@ -618,7 +619,7 @@ struct omap_hwmod am33xx_gpmc_hwmod = {
 	.class		= &am33xx_gpmc_hwmod_class,
 	.clkdm_name	= "l3s_clkdm",
 	/* Skip reset for CONFIG_OMAP_GPMC_DEBUG for bootloader timings */
-	.flags		= DEBUG_OMAP_GPMC_HWMOD_FLAGS,
+	.flags		= DEBUG_OMAP_GPMC_HWMOD_FLAGS | HWMOD_NEEDS_REIDLE,
 	.main_clk	= "l3s_gclk",
 	.prcm		= {
 		.omap4	= {
@@ -1094,7 +1095,8 @@ struct omap_hwmod am33xx_tptc0_hwmod = {
 	.name		= "tptc0",
 	.class		= &am33xx_tptc_hwmod_class,
 	.clkdm_name	= "l3_clkdm",
-	.flags		= HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY,
+	.flags		= HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY |
+			  HWMOD_NEEDS_REIDLE,
 	.main_clk	= "l3_gclk",
 	.prcm		= {
 		.omap4	= {
@@ -1108,7 +1110,8 @@ struct omap_hwmod am33xx_tptc1_hwmod = {
 	.name		= "tptc1",
 	.class		= &am33xx_tptc_hwmod_class,
 	.clkdm_name	= "l3_clkdm",
-	.flags		= (HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY),
+	.flags		= HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY |
+			  HWMOD_NEEDS_REIDLE,
 	.main_clk	= "l3_gclk",
 	.prcm		= {
 		.omap4	= {
@@ -1122,7 +1125,8 @@ struct omap_hwmod am33xx_tptc2_hwmod = {
 	.name		= "tptc2",
 	.class		= &am33xx_tptc_hwmod_class,
 	.clkdm_name	= "l3_clkdm",
-	.flags		= (HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY),
+	.flags		= HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY |
+			  HWMOD_NEEDS_REIDLE,
 	.main_clk	= "l3_gclk",
 	.prcm		= {
 		.omap4	= {
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
index 53e1ac3..69f7c52 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -301,7 +301,8 @@
 	.name		= "usb_otg_hs",
 	.class		= &am33xx_usbotg_class,
 	.clkdm_name	= "l3s_clkdm",
-	.flags		= HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY,
+	.flags		= HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY |
+			  HWMOD_NEEDS_REIDLE,
 	.main_clk	= "usbotg_fck",
 	.prcm		= {
 		.omap4	= {
-- 
1.9.1
