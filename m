From: Joachim Eastwood <manabian@gmail.com>
Subject: [PATCH RFC] pwm: omap: Add PWM driver for OMAP using dual-mode timers
Date: Fri,  2 May 2014 15:50:38 +0200
Message-ID: <1399038638-27036-1-git-send-email-manabian@gmail.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
To: joelf@ti.com, tony@atomide.com, thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Joachim Eastwood <manabian@gmail.com>, Grant Erickson <marathon96@gmail.com>, NeilBrown <neilb@suse.de>
List-Id: linux-omap@vger.kernel.org

Adds support for using a OMAP dual-mode timer with PWM capability
as a Linux PWM device. The driver controls the timer by using the
dmtimer API.

Cc: Grant Erickson <marathon96@gmail.com>
Cc: NeilBrown <neilb@suse.de>
Not-Yet-Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---

Hello,

First of all this is a RFC patch not to be merged in it's current state.

There are two problems with the driver now as I see.
* I don't think this hack will fly on mainline.
  #include <../arch/arm/plat-omap/include/plat/dmtimer.h>
  I use the above include path for testing now since the plat include doesn't
  work with DT multiplatform build.
  Joel Fernandes is working on moving the dmtimer driver into
  drivers/clocksource so eventually this will be fixed.

* The drivers calls omap_dm_timer_set_source() to set the source. This should
  decided in DT on the timer node itself. There is also work in this area by
  Tero Kristo and Joel has said that this function will become a no-op when
  this work is done.

So for now it be nice if people could look at the dmtimer API usage, the DT
bindings and the PWM part of the driver to see if that looks okay.

Joel: I have tested this driver on top of your last dmtimer cleanup patches
and it works nicely. It would be nice if you could take a look at the dmtimer
API usage. I think you might be the one who knows dmtimer best now.

A bit of history on this driver.
First version made by Grant Erickson for the old PWM API back in 2010. Later
NeilBrown converted the driver to the new PWM API and submitted [1] it to the
mail list back in 2012. The driver was then reviewed by Thierry Reding and Jon
Hunter. NeilBrown also later added DT support to the driver. I have since made
some fixes, removed platform data support and added DT documentation.


[1]: https://lkml.org/lkml/2012/12/12/51

regards
Joachim Eastwood


 Documentation/devicetree/bindings/pwm/pwm-omap.txt |  15 ++
 drivers/pwm/Kconfig                                |   9 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-omap.c                             | 273 +++++++++++++++++++++
 4 files changed, 298 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-omap.txt
 create mode 100644 drivers/pwm/pwm-omap.c

diff --git a/Documentation/devicetree/bindings/pwm/pwm-omap.txt b/Documentation/devicetree/bindings/pwm/pwm-omap.txt
new file mode 100644
index 000000000000..e254874e5eee
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-omap.txt
@@ -0,0 +1,15 @@
+* OMAP PWM for dual-mode timers
+
+Required properties:
+- compatible: Shall contain "ti,omap-pwm".
+- ti,timers: phandle to PWM capable OMAP timer. See arm/omap/timer.txt for info
+  about these timers.
+- #pwm-cells: Should be 3. See pwm.txt in this directory for a description of
+  the cells format.
+
+Example:
+	pwm: omap-pwm {
+		compatible = "ti,omap-pwm";
+		ti,timers = <&timer9>;
+		#pwm-cells = <3>;
+	};
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 5b34ff29ea38..15b64aa14990 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -168,6 +168,15 @@ config PWM_PCA9685
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-pca9685.
 
+config PWM_OMAP
+	tristate "OMAP PWM support"
+	depends on OF && ARCH_OMAP && OMAP_DM_TIMER
+	help
+	  Generic PWM framework driver for OMAP
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-omap
+
 config PWM_PUV3
 	tristate "PKUnity NetBook-0916 PWM support"
 	depends on ARCH_PUV3
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index e57d2c38a794..db52650d65e9 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_PWM_LP3943)	+= pwm-lp3943.o
 obj-$(CONFIG_PWM_LPC32XX)	+= pwm-lpc32xx.o
 obj-$(CONFIG_PWM_LPSS)		+= pwm-lpss.o
 obj-$(CONFIG_PWM_MXS)		+= pwm-mxs.o
+obj-$(CONFIG_PWM_OMAP)		+= pwm-omap.o
 obj-$(CONFIG_PWM_PCA9685)	+= pwm-pca9685.o
 obj-$(CONFIG_PWM_PUV3)		+= pwm-puv3.o
 obj-$(CONFIG_PWM_PXA)		+= pwm-pxa.o
diff --git a/drivers/pwm/pwm-omap.c b/drivers/pwm/pwm-omap.c
new file mode 100644
index 000000000000..1ad45f8a03ab
--- /dev/null
+++ b/drivers/pwm/pwm-omap.c
@@ -0,0 +1,273 @@
+/*
+ *    Copyright (c) 2014 Joachim Eastwood <manabian@gmail.com>
+ *    Copyright (c) 2012 NeilBrown <neilb@suse.de>
+ *    Heavily based on earlier code which is:
+ *    Copyright (c) 2010 Grant Erickson <marathon96@gmail.com>
+ *
+ *    Also based on pwm-samsung.c
+ *
+ *    This program is free software; you can redistribute it and/or
+ *    modify it under the terms of the GNU General Public License
+ *    version 2 as published by the Free Software Foundation.
+ *
+ *    Description:
+ *      This file is the core OMAP support for the generic, Linux
+ *      PWM driver / controller, using the OMAP's dual-mode timers.
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/pwm.h>
+#include <linux/slab.h>
+#include <linux/time.h>
+
+#include <../arch/arm/plat-omap/include/plat/dmtimer.h>
+
+#define DM_TIMER_LOAD_MIN		0xFFFFFFFE
+
+struct omap_chip {
+	struct omap_dm_timer	*dm_timer;
+	unsigned int		duty_ns, period_ns;
+	struct mutex		mutex;
+	struct pwm_chip		chip;
+};
+
+#define to_omap_chip(chip)	container_of(chip, struct omap_chip, chip)
+
+static int omap_pwm_calc_value(unsigned long clk_rate, int ns)
+{
+	u64 c;
+
+	c = (u64)clk_rate * ns;
+	do_div(c, NSEC_PER_SEC);
+
+	return DM_TIMER_LOAD_MIN - c;
+}
+
+static void omap_pwm_start(struct omap_chip *omap)
+{
+	/*
+	 * According to OMAP 4 TRM section 22.2.4.10 the counter should be
+	 * started at 0xFFFFFFFE when overflow and match is used to ensure
+	 * that the PWM line is toggled on the first event.
+	 *
+	 * Note that omap_dm_timer_enable/disable is for register access and
+	 * not the timer counter itself.
+	 */
+	omap_dm_timer_enable(omap->dm_timer);
+	omap_dm_timer_write_counter(omap->dm_timer, DM_TIMER_LOAD_MIN);
+	omap_dm_timer_disable(omap->dm_timer);
+
+	omap_dm_timer_start(omap->dm_timer);
+}
+
+static int omap_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct omap_chip *omap = to_omap_chip(chip);
+
+	mutex_lock(&omap->mutex);
+	omap_pwm_start(omap);
+	mutex_unlock(&omap->mutex);
+
+	return 0;
+}
+
+static void omap_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct omap_chip *omap = to_omap_chip(chip);
+
+	mutex_lock(&omap->mutex);
+	omap_dm_timer_stop(omap->dm_timer);
+	mutex_unlock(&omap->mutex);
+}
+
+static int omap_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
+			   int duty_ns, int period_ns)
+{
+	struct omap_chip *omap = to_omap_chip(chip);
+	int load_value, match_value;
+	unsigned long clk_rate;
+	bool timer_active;
+
+	dev_dbg(chip->dev, "duty cycle: %d, period %d\n", duty_ns, period_ns);
+
+	mutex_lock(&omap->mutex);
+	if (omap->duty_ns == duty_ns &&
+	    omap->period_ns == period_ns) {
+		/* No change - don't cause any transients. */
+		mutex_unlock(&omap->mutex);
+		return 0;
+	}
+
+	clk_rate = clk_get_rate(omap_dm_timer_get_fclk(omap->dm_timer));
+
+	/*
+	 * Calculate the appropriate load and match values based on the
+	 * specified period and duty cycle. The load value determines the
+	 * cycle time and the match value determines the duty cycle.
+	 */
+	load_value = omap_pwm_calc_value(clk_rate, period_ns);
+	match_value = omap_pwm_calc_value(clk_rate, period_ns - duty_ns);
+
+	/*
+	 * We MUST stop the associated dual-mode timer before attempting to
+	 * write its registers, but calls to omap_dm_timer_start/stop must
+	 * be balanced so check if timer is active before calling timer_stop.
+	 */
+	timer_active = pm_runtime_active(&omap->dm_timer->pdev->dev);
+	if (timer_active)
+		omap_dm_timer_stop(omap->dm_timer);
+
+	omap_dm_timer_set_load(omap->dm_timer, true, load_value);
+	omap_dm_timer_set_match(omap->dm_timer, true, match_value);
+
+	dev_dbg(chip->dev, "load value: %#08x (%d), match value: %#08x (%d)\n",
+		load_value, load_value,	match_value, match_value);
+
+	omap_dm_timer_set_pwm(omap->dm_timer,
+			      pwm->polarity == PWM_POLARITY_INVERSED,
+			      true,
+			      OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE);
+
+	/* If config was called while timer was running it must be reenabled. */
+	if (timer_active)
+		omap_pwm_start(omap);
+
+	omap->duty_ns = duty_ns;
+	omap->period_ns = period_ns;
+	mutex_unlock(&omap->mutex);
+
+	return 0;
+}
+
+static int omap_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
+				 enum pwm_polarity polarity)
+{
+	struct omap_chip *omap = to_omap_chip(chip);
+
+	/*
+	 * PWM core will not call set_polarity while PWM is enabled so it's
+	 * safe to reconfigure the timer here without stopping it first.
+	 */
+	mutex_lock(&omap->mutex);
+	omap_dm_timer_set_pwm(omap->dm_timer,
+			      polarity == PWM_POLARITY_INVERSED,
+			      true,
+			      OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE);
+	mutex_unlock(&omap->mutex);
+
+	return 0;
+}
+
+static struct pwm_ops omap_pwm_ops = {
+	.enable		= omap_pwm_enable,
+	.disable	= omap_pwm_disable,
+	.config		= omap_pwm_config,
+	.set_polarity	= omap_pwm_set_polarity,
+	.owner		= THIS_MODULE,
+};
+
+static int omap_pwm_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct omap_dm_timer *dm_timer;
+	struct device_node *timer;
+	struct omap_chip *omap;
+	int status;
+
+	timer = of_parse_phandle(np, "ti,timers", 0);
+	if (!timer)
+		return -ENODEV;
+
+	dm_timer = omap_dm_timer_request_by_node(timer);
+	if (!dm_timer)
+		return -EPROBE_DEFER;
+
+	if (!(dm_timer->capability & OMAP_TIMER_HAS_PWM)) {
+		dev_err(&pdev->dev, "timer has no PWM capability\n");
+		return -ENODEV;
+	}
+
+	omap = devm_kzalloc(&pdev->dev, sizeof(*omap), GFP_KERNEL);
+	if (omap == NULL)
+		return -ENOMEM;
+
+	omap->dm_timer = dm_timer;
+	omap_dm_timer_set_source(omap->dm_timer, OMAP_TIMER_SRC_SYS_CLK);
+
+	omap->chip.dev = &pdev->dev;
+	omap->chip.ops = &omap_pwm_ops;
+	omap->chip.base = -1;
+	omap->chip.npwm = 1;
+	omap->chip.of_xlate = of_pwm_xlate_with_flags;
+	omap->chip.of_pwm_n_cells = 3;
+
+	mutex_init(&omap->mutex);
+
+	/*
+	 * Ensure that the timer is stopped before we allow PWM core to call
+	 * pwm_enable.
+	 */
+	if (pm_runtime_active(&omap->dm_timer->pdev->dev))
+		omap_dm_timer_stop(omap->dm_timer);
+
+	status = pwmchip_add(&omap->chip);
+	if (status < 0) {
+		dev_err(&pdev->dev, "failed to register PWM\n");
+		omap_dm_timer_free(omap->dm_timer);
+		return status;
+	}
+
+	platform_set_drvdata(pdev, omap);
+
+	return 0;
+}
+
+static int omap_pwm_remove(struct platform_device *pdev)
+{
+	struct omap_chip *omap = platform_get_drvdata(pdev);
+	int status;
+
+	status = pwmchip_remove(&omap->chip);
+	if (status < 0)
+		return status;
+
+	if (pm_runtime_active(&omap->dm_timer->pdev->dev))
+		omap_dm_timer_stop(omap->dm_timer);
+
+	omap_dm_timer_free(omap->dm_timer);
+
+	mutex_destroy(&omap->mutex);
+
+	return 0;
+}
+
+static const struct of_device_id omap_pwm_of_match[] = {
+	{.compatible = "ti,omap-pwm"},
+	{}
+};
+MODULE_DEVICE_TABLE(of, omap_pwm_of_match);
+
+static struct platform_driver omap_pwm_driver = {
+	.driver = {
+		.name	= "omap-pwm",
+		.owner	= THIS_MODULE,
+		.of_match_table = omap_pwm_of_match,
+	},
+	.probe		= omap_pwm_probe,
+	.remove		= omap_pwm_remove,
+};
+module_platform_driver(omap_pwm_driver);
+
+MODULE_AUTHOR("Grant Erickson <marathon96@gmail.com>");
+MODULE_AUTHOR("NeilBrown <neilb@suse.de>");
+MODULE_LICENSE("GPL v2");
+MODULE_VERSION("2014-20-04");
+MODULE_DESCRIPTION("OMAP PWM Driver using Dual-mode Timers");
-- 
1.8.0

