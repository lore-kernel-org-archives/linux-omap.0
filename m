From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 2/4] bus: ti-sysc: Add support for PRUSS SYSC type
Date: Mon, 4 Feb 2019 17:53:55 +0200
Message-ID: <1549295637-24890-3-git-send-email-rogerq@ti.com>
References: <1549295637-24890-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1549295637-24890-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: s-anna@ti.com, nsekhar@ti.com, linux-omap@vger.kernel.org, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, david@lechnology.com, woods.technical@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

The PRUSS module has a SYSCFG which is unique. Add
support for it.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/bus/ti-sysc.c                 | 77 +++++++++++++++++++++++++++++++++++
 include/dt-bindings/bus/ti-sysc.h     | 11 -----
 include/linux/platform_data/ti-sysc.h |  1 +
 3 files changed, 78 insertions(+), 11 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index f94d335..5b9c81a 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -622,6 +622,50 @@ static void sysc_show_registers(struct sysc *ddata)
 		buf);
 }
 
+static int sysc_enable_pruss(struct sysc *sysc)
+{
+	int i;
+	u32 reg;
+	bool ready;
+
+	/* configure for Smart Idle & Smart Standby */
+	reg = sysc_read(sysc, sysc->offsets[SYSC_SYSCONFIG]);
+	reg &= ~(SYSC_PRUSS_STANDBY_MASK | SYSC_PRUSS_IDLE_MASK);
+	reg |= SYSC_PRUSS_STANDBY_SMART | SYSC_IDLE_SMART;
+	sysc_write(sysc, sysc->offsets[SYSC_SYSCONFIG], reg);
+
+	/* bring out of Standby */
+	reg = sysc_read(sysc, sysc->offsets[SYSC_SYSCONFIG]);
+	reg &= ~SYSC_PRUSS_STANDBY_INIT;
+	sysc_write(sysc, sysc->offsets[SYSC_SYSCONFIG], reg);
+
+	/* wait till we are ready for transactions - delay is arbitrary */
+	for (i = 0; i < 10; i++) {
+		reg = sysc_read(sysc, sysc->offsets[SYSC_SYSCONFIG]);
+		ready = !(reg & SYSC_PRUSS_SUB_MWAIT);
+		if (ready)
+			break;
+		udelay(5);
+	}
+
+	if (!ready) {
+		dev_err(sysc->dev, "not ready for transaction\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static void sysc_disable_pruss(struct sysc *sysc)
+{
+	u32 reg;
+
+	/* initiate Standby */
+	reg = sysc_read(sysc, sysc->offsets[SYSC_SYSCONFIG]);
+	reg |= SYSC_PRUSS_STANDBY_INIT;
+	sysc_write(sysc, sysc->offsets[SYSC_SYSCONFIG], reg);
+}
+
 static int __maybe_unused sysc_runtime_suspend(struct device *dev)
 {
 	struct ti_sysc_platform_data *pdata;
@@ -649,6 +693,9 @@ static int __maybe_unused sysc_runtime_suspend(struct device *dev)
 		goto idled;
 	}
 
+	if (ddata->cap->type == TI_SYSC_PRUSS)
+		sysc_disable_pruss(ddata);
+
 	for (i = 0; i < ddata->nr_clocks; i++) {
 		if (IS_ERR_OR_NULL(ddata->clocks[i]))
 			continue;
@@ -704,6 +751,9 @@ static int __maybe_unused sysc_runtime_resume(struct device *dev)
 			return error;
 	}
 
+	if (ddata->cap->type == TI_SYSC_PRUSS)
+		sysc_enable_pruss(ddata);
+
 awake:
 	ddata->enabled = true;
 
@@ -1573,6 +1623,26 @@ static const struct sysc_capabilities sysc_dra7_mcan = {
 	.regbits = &sysc_regbits_dra7_mcan,
 };
 
+/*
+ * PRUSS on AM33x and later
+ */
+static const struct sysc_regbits sysc_regbits_pruss = {
+	.midle_shift = -ENODEV,
+	.clkact_shift = -ENODEV,
+	.sidle_shift = -ENODEV,
+	.enwkup_shift = -ENODEV,
+	.srst_shift = -ENODEV,
+	.autoidle_shift = -ENODEV,
+	.dmadisable_shift = -ENODEV,
+	.emufree_shift = -ENODEV,
+};
+
+static const struct sysc_capabilities sysc_pruss = {
+	.type = TI_SYSC_PRUSS,
+	.sysc_mask = SYSC_PRUSS_STANDBY_INIT | SYSC_PRUSS_SUB_MWAIT,
+	.regbits = &sysc_regbits_pruss,
+};
+
 static int sysc_init_pdata(struct sysc *ddata)
 {
 	struct ti_sysc_platform_data *pdata = dev_get_platdata(ddata->dev);
@@ -1702,6 +1772,10 @@ static int sysc_probe(struct platform_device *pdev)
 
 	INIT_DELAYED_WORK(&ddata->idle_work, ti_sysc_idle);
 
+	/* FIXME: how to ensure PRUSS stays enabled? */
+	if (ddata->cap->type == TI_SYSC_PRUSS)
+		goto skip_pm_put;
+
 	/* At least earlycon won't survive without deferred idle */
 	if (ddata->cfg.quirks & (SYSC_QUIRK_NO_IDLE_ON_INIT |
 				 SYSC_QUIRK_NO_RESET_ON_INIT)) {
@@ -1710,6 +1784,8 @@ static int sysc_probe(struct platform_device *pdev)
 		pm_runtime_put(&pdev->dev);
 	}
 
+skip_pm_put:
+
 	if (!of_get_available_child_count(ddata->dev->of_node))
 		reset_control_assert(ddata->rsts);
 
@@ -1766,6 +1842,7 @@ static const struct of_device_id sysc_match[] = {
 	{ .compatible = "ti,sysc-usb-host-fs",
 	  .data = &sysc_omap4_usb_host_fs, },
 	{ .compatible = "ti,sysc-dra7-mcan", .data = &sysc_dra7_mcan, },
+	{ .compatible = "ti,sysc-pruss", .data = &sysc_pruss, },
 	{  },
 };
 MODULE_DEVICE_TABLE(of, sysc_match);
diff --git a/include/dt-bindings/bus/ti-sysc.h b/include/dt-bindings/bus/ti-sysc.h
index 8ec78e8..7138384 100644
--- a/include/dt-bindings/bus/ti-sysc.h
+++ b/include/dt-bindings/bus/ti-sysc.h
@@ -17,17 +17,6 @@
 
 #define SYSC_DRA7_MCAN_ENAWAKEUP	(1 << 4)
 
-/* SYSCONFIG specific to PRUSS */
-#define SYSC_PRUSS_SUB_MWAIT		(1 << 5)
-#define SYSC_PRUSS_STANDBY_INIT		(1 << 4)
-
-#define SYSC_PRUSS_STANDBY_FORCE	(0 << 2)
-#define SYSC_PRUSS_STANDBY_NO		(1 << 2)
-#define SYSC_PRUSS_STANDBY_SMART	(2 << 2)
-#define SYSC_PRUSS_STANDBY_MASK		(3 << 2)
-
-#define SYSC_PRUSS_IDLE_MASK		3
-
 /* SYSCONFIG STANDBYMODE/MIDLEMODE/SIDLEMODE supported by hardware */
 #define SYSC_IDLE_FORCE			0
 #define SYSC_IDLE_NO			1
diff --git a/include/linux/platform_data/ti-sysc.h b/include/linux/platform_data/ti-sysc.h
index 1ea3aab..56098e7 100644
--- a/include/linux/platform_data/ti-sysc.h
+++ b/include/linux/platform_data/ti-sysc.h
@@ -15,6 +15,7 @@ enum ti_sysc_module_type {
 	TI_SYSC_OMAP4_MCASP,
 	TI_SYSC_OMAP4_USB_HOST_FS,
 	TI_SYSC_DRA7_MCAN,
+	TI_SYSC_PRUSS,
 };
 
 struct ti_sysc_cookie {
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
