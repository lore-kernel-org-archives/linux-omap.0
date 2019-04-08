From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2] bus: ti-sysc: Add generic enable/disable functions
Date: Mon, 8 Apr 2019 12:52:39 +0300
Message-ID: <20190408095239.30378-1-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: s-anna@ti.com, t-kristo@ti.com, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

For non legacy cases, add generic sysc_enable_module()
and sysc_disable_module() functions.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
Boot tested on
- beagle-x15 (AM5728 GP EVM)
- AM571x IDK
- DRA7 EVM

Changelog:
v2:
- Add helper to get best idle mode.
- Add comment about not preventing clockdomain autoidle
  during enable/disable.
- Omit PRU-ICSS specific handling. PRU-ICSS moudle can re-use omap4-simple.
  The STANDBY_INIT and SUB_MWAIT bits are specific to PRUSS application
  usage and should be managed by the PRUSS driver.

cheers,
-roger

 drivers/bus/ti-sysc.c | 129 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index 5c8796276828..c37b3be1e3e2 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -793,6 +793,127 @@ static void sysc_show_registers(struct sysc *ddata)
 		buf);
 }
 
+#define SYSC_IDLE_MASK	(SYSC_NR_IDLEMODES - 1)
+
+static int sysc_enable_module(struct device *dev)
+{
+	struct sysc *ddata;
+	const struct sysc_regbits *regbits;
+	u32 reg, idlemodes, best_mode;
+
+	ddata = dev_get_drvdata(dev);
+	if (ddata->offsets[SYSC_SYSCONFIG] == -ENODEV)
+		return 0;
+
+	/*
+	 * TODO: Need to prevent clockdomain autoidle?
+	 * See clkdm_deny_idle() in arch/mach-omap2/omap_hwmod.c
+	 */
+
+	regbits = ddata->cap->regbits;
+	reg = sysc_read(ddata, ddata->offsets[SYSC_SYSCONFIG]);
+
+	/* Set SIDLE mode */
+	idlemodes = ddata->cfg.sidlemodes;
+	if (!idlemodes || regbits->sidle_shift < 0)
+		goto set_midle;
+
+	best_mode = fls(ddata->cfg.sidlemodes) - 1;
+	if (best_mode > SYSC_IDLE_MASK) {
+		dev_err(dev, "%s: invalid sidlemode\n", __func__);
+		return -EINVAL;
+	}
+
+	reg &= ~(SYSC_IDLE_MASK << regbits->sidle_shift);
+	reg |= best_mode << regbits->sidle_shift;
+	sysc_write(ddata, ddata->offsets[SYSC_SYSCONFIG], reg);
+
+set_midle:
+	/* Set MIDLE mode */
+	idlemodes = ddata->cfg.midlemodes;
+	if (!idlemodes || regbits->midle_shift < 0)
+		return 0;
+
+	best_mode = fls(ddata->cfg.midlemodes) - 1;
+	if (best_mode > SYSC_IDLE_MASK) {
+		dev_err(dev, "%s: invalid midlemode\n", __func__);
+		return -EINVAL;
+	}
+
+	reg &= ~(SYSC_IDLE_MASK << regbits->midle_shift);
+	reg |= best_mode << regbits->midle_shift;
+	sysc_write(ddata, ddata->offsets[SYSC_SYSCONFIG], reg);
+
+	return 0;
+}
+
+static int sysc_best_idle_mode(u32 idlemodes, u32 *best_mode)
+{
+	if (idlemodes & BIT(SYSC_IDLE_SMART_WKUP))
+		*best_mode = SYSC_IDLE_SMART_WKUP;
+	else if (idlemodes & BIT(SYSC_IDLE_SMART))
+		*best_mode = SYSC_IDLE_SMART;
+	else if (idlemodes & SYSC_IDLE_FORCE)
+		*best_mode = SYSC_IDLE_FORCE;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
+static int sysc_disable_module(struct device *dev)
+{
+	struct sysc *ddata;
+	const struct sysc_regbits *regbits;
+	u32 reg, idlemodes, best_mode;
+	int ret;
+
+	ddata = dev_get_drvdata(dev);
+	if (ddata->offsets[SYSC_SYSCONFIG] == -ENODEV)
+		return 0;
+
+	/*
+	 * TODO: Need to prevent clockdomain autoidle?
+	 * See clkdm_deny_idle() in arch/mach-omap2/omap_hwmod.c
+	 */
+
+	regbits = ddata->cap->regbits;
+	reg = sysc_read(ddata, ddata->offsets[SYSC_SYSCONFIG]);
+
+	/* Set MIDLE mode */
+	idlemodes = ddata->cfg.midlemodes;
+	if (!idlemodes || regbits->midle_shift < 0)
+		goto set_sidle;
+
+	ret = sysc_best_idle_mode(idlemodes, &best_mode);
+	if (ret) {
+		dev_err(dev, "%s: invalid midlemode\n", __func__);
+		return ret;
+	}
+
+	reg &= ~(SYSC_IDLE_MASK << regbits->midle_shift);
+	reg |= best_mode << regbits->midle_shift;
+	sysc_write(ddata, ddata->offsets[SYSC_SYSCONFIG], reg);
+
+set_sidle:
+	/* Set SIDLE mode */
+	idlemodes = ddata->cfg.sidlemodes;
+	if (!idlemodes || regbits->sidle_shift < 0)
+		return 0;
+
+	ret = sysc_best_idle_mode(idlemodes, &best_mode);
+	if (ret) {
+		dev_err(dev, "%s: invalid sidlemode\n", __func__);
+		return ret;
+	}
+
+	reg &= ~(SYSC_IDLE_MASK << regbits->sidle_shift);
+	reg |= best_mode << regbits->sidle_shift;
+	sysc_write(ddata, ddata->offsets[SYSC_SYSCONFIG], reg);
+
+	return 0;
+}
+
 static int __maybe_unused sysc_runtime_suspend_legacy(struct device *dev,
 						      struct sysc *ddata)
 {
@@ -849,6 +970,10 @@ static int __maybe_unused sysc_runtime_suspend(struct device *dev)
 		error = sysc_runtime_suspend_legacy(dev, ddata);
 		if (error)
 			return error;
+	} else {
+		error = sysc_disable_module(dev);
+		if (error)
+			return error;
 	}
 
 	sysc_disable_main_clocks(ddata);
@@ -885,6 +1010,10 @@ static int __maybe_unused sysc_runtime_resume(struct device *dev)
 		error = sysc_runtime_resume_legacy(dev, ddata);
 		if (error)
 			goto err_main_clocks;
+	} else {
+		error = sysc_enable_module(dev);
+		if (error)
+			goto err_main_clocks;
 	}
 
 	ddata->enabled = true;
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
