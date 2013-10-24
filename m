From: NeilBrown <neilb@suse.de>
Subject: [PATCH/RFC] pwm: omap: Add PWM support using dual-mode timers
Date: Thu, 24 Oct 2013 17:36:20 +1100
Message-ID: <20131024173620.0cbbefcf@notabene.brown>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/iB8V.l4nKTechWX_0MLwxCd"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:43001 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752036Ab3JXGgf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Oct 2013 02:36:35 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thierry Reding <thierry.reding@avionic-design.de>, Grant Erickson <marathon96@gmail.com>, Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap@vger.kernel.org, linux-pwm@vger.kernel.org

--Sig_/iB8V.l4nKTechWX_0MLwxCd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable


I submitted this in December last year.  I got lots of good feedback
and fixed some things, but it never got accepted.  Not entirely sure
why, maybe I dropped the ball.

Anyway, here is again with device-tree support added.

This is only an RFC and not a real submission for two reasons, both of which
are really directed as Jon.

1/ I have to=20

#include <../arch/arm/plat-omap/include/plat/dmtimer.h>

which is incredibly ugly.
Is there any reason this cannot be moved to include/linux/omap-dmtimer.h?

2/ I found that I need to call

	omap_dm_timer_write_counter(omap->dm_timer, DM_TIMER_LOAD_MIN);

 when using device-tree.  This is because with devicetree
 omap_timer_restore_context() is called much more often and it sets the cou=
nter
 register to 0 .. it takes a long time to count up to DM_TIMER_LOAD_MIN fro=
m there.

 Now I don't object to calling omap_dm_timer_write_counter (though it might=
 be nice if
 omap_dm_timer_set_load wrote the one value to both LOAD_REG and COUNTER_RE=
G).
 However it seems wrong that I have to call it *after* starting the counter.
 Currently _write_counter refuses to run if the timer hasn't been started.

 So Jon:=20
   a/ can we change omap_dm_timer_write_counter to work when the timer isn't
      running?
   b/ can we have omap_dm_timer_set_load also set the counter?


For anyone else generous enough to read my code: is this otherwise acceptab=
le?

Thanks,
NeilBrown

-------------------------------------------------
This patch is based on an earlier patch by Grant Erickson
which provided PWM devices using the 'legacy' interface.

This driver instead uses the new framework interface.

The choice of dmtimer to be used can be made through platform_data
by requesting a specific timer, or though devicetree by giving
the appropriate device-tree node.

Lots of clean-ups and improvements thanks to Thierry Reding
and Jon Hunter.

Cc: Grant Erickson <marathon96@gmail.com>
Signed-off-by: NeilBrown <neilb@suse.de>

diff --git a/Documentation/devicetree/bindings/pwm/pwm-omap.txt b/Documenta=
tion/devicetree/bindings/pwm/pwm-omap.txt
new file mode 100644
index 0000000..5f03048
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-omap.txt
@@ -0,0 +1,32 @@
+* PWM for OMAP using dmtimers
+
+TI's OMAP SoCs contains dual mode timers (dmtimers), some of
+which can driver output pins and so provide services as
+a PWM.  When using this driver it will normally be necessary
+to programmer an appropriate pin to server as a timer output.
+
+Required properties:
+- compatible: must be
+   "ti,omap-pwm"
+
+- timers: a device-tree node for the dmtimer to use
+
+- #pwm-cells: must be <2>.
+
+Example:
+
+ pwm: omap-pwm {
+   compatible =3D "ti,omap-pwm";
+   timers =3D <&timer11>;
+   #pwm-cells =3D <2>;
+
+   pinctrl-names =3D "default";
+   pinctrl-0 =3D <&pwm-pins>;
+ };
+
+...
+ pwm-pins: pinmux_pwm_pins {
+   pinctrl-single,pins =3D <
+     0x08a (PIN_OUTPUT | MUX_MODE3) /* gpmc_ncs6.gpt11_pwm_evt */
+   >;
+ };
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 75840b5..0e3cf83 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -110,6 +110,15 @@ config PWM_PCA9685
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-pca9685.
=20
+config PWM_OMAP
+	tristate "OMAP PWM support"
+	depends on ARCH_OMAP && OMAP_DM_TIMER
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
index 77a8c18..322ddf0 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_PWM_JZ4740)	+=3D pwm-jz4740.o
 obj-$(CONFIG_PWM_LPC32XX)	+=3D pwm-lpc32xx.o
 obj-$(CONFIG_PWM_MXS)		+=3D pwm-mxs.o
 obj-$(CONFIG_PWM_PCA9685)	+=3D pwm-pca9685.o
+obj-$(CONFIG_PWM_OMAP)		+=3D pwm-omap.o
 obj-$(CONFIG_PWM_PUV3)		+=3D pwm-puv3.o
 obj-$(CONFIG_PWM_PXA)		+=3D pwm-pxa.o
 obj-$(CONFIG_PWM_RENESAS_TPU)	+=3D pwm-renesas-tpu.o
diff --git a/drivers/pwm/pwm-omap.c b/drivers/pwm/pwm-omap.c
new file mode 100644
index 0000000..5ff2b17
--- /dev/null
+++ b/drivers/pwm/pwm-omap.c
@@ -0,0 +1,283 @@
+/*
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
+#include <linux/export.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/pwm.h>
+#include <linux/module.h>
+#include <linux/platform_data/omap-pwm.h>
+
+#include <../arch/arm/plat-omap/include/plat/dmtimer.h>
+
+#define DM_TIMER_LOAD_MIN		0xFFFFFFFE
+
+struct omap_chip {
+	struct omap_dm_timer	*dm_timer;
+	enum pwm_polarity	polarity;
+	unsigned int		duty_ns, period_ns;
+	struct pwm_chip		chip;
+};
+
+#define to_omap_chip(chip)	container_of(chip, struct omap_chip, chip)
+
+/**
+ * pwm_calc_value - Determine the counter value for a clock rate and perio=
d.
+ * @clk_rate: The clock rate, in Hz, of the PWM's clock source to compute =
the
+ *            counter value for.
+ * @ns: The period, in nanoseconds, to compute the counter value for.
+ *
+ * Returns the PWM counter value for the specified clock rate and period.
+ */
+static inline int pwm_calc_value(unsigned long clk_rate, int ns)
+{
+	u64 c;
+
+	c =3D (u64)clk_rate * ns;
+	do_div(c, NSEC_PER_SEC);
+
+	return DM_TIMER_LOAD_MIN - c;
+}
+
+static int omap_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct omap_chip *omap =3D to_omap_chip(chip);
+
+	omap_dm_timer_start(omap->dm_timer);
+	omap_dm_timer_write_counter(omap->dm_timer, DM_TIMER_LOAD_MIN);
+
+	return 0;
+}
+
+static void omap_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct omap_chip *omap =3D to_omap_chip(chip);
+
+	omap_dm_timer_stop(omap->dm_timer);
+}
+
+static int omap_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
+			   int duty_ns, int period_ns)
+{
+	struct omap_chip *omap =3D to_omap_chip(chip);
+	int load_value, match_value;
+	unsigned long clk_rate;
+
+	dev_dbg(chip->dev, "duty cycle: %d, period %d\n", duty_ns, period_ns);
+
+	if (omap->duty_ns =3D=3D duty_ns &&
+	    omap->period_ns =3D=3D period_ns)
+		/* No change - don't cause any transients. */
+		return 0;
+
+	clk_rate =3D clk_get_rate(omap_dm_timer_get_fclk(omap->dm_timer));
+
+	/*
+	 * Calculate the appropriate load and match values based on the
+	 * specified period and duty cycle. The load value determines the
+	 * cycle time and the match value determines the duty cycle.
+	 */
+
+	load_value =3D pwm_calc_value(clk_rate, period_ns);
+	match_value =3D pwm_calc_value(clk_rate, period_ns - duty_ns);
+
+	/*
+	 * We MUST enable yet stop the associated dual-mode timer before
+	 * attempting to write its registers.  Hopefully it is already
+	 * disabled, but call the (idempotent) pwm_disable just in case.
+	 */
+
+	pwm_disable(pwm);
+
+	omap_dm_timer_set_load(omap->dm_timer, true, load_value);
+	omap_dm_timer_set_match(omap->dm_timer, true, match_value);
+
+	dev_dbg(chip->dev, "load value: %#08x (%d), match value: %#08x (%d)\n",
+		load_value, load_value,	match_value, match_value);
+
+	omap_dm_timer_set_pwm(omap->dm_timer,
+			      omap->polarity =3D=3D PWM_POLARITY_INVERSED,
+			      true,
+			      OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE);
+
+	omap->duty_ns =3D duty_ns;
+	omap->period_ns =3D period_ns;
+
+	return 0;
+}
+
+static int omap_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device =
*pwm,
+				 enum pwm_polarity polarity)
+{
+	struct omap_chip *omap =3D to_omap_chip(chip);
+
+	if (omap->polarity =3D=3D polarity)
+		return 0;
+
+	omap->polarity =3D polarity;
+
+	omap_dm_timer_set_pwm(omap->dm_timer,
+			      omap->polarity =3D=3D PWM_POLARITY_INVERSED,
+			      true,
+			      OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE);
+	return 0;
+}
+
+static struct pwm_ops omap_pwm_ops =3D {
+	.enable		=3D omap_pwm_enable,
+	.disable	=3D omap_pwm_disable,
+	.config		=3D omap_pwm_config,
+	.set_polarity	=3D omap_pwm_set_polarity,
+	.owner		=3D THIS_MODULE,
+};
+
+static int omap_pwm_from_pdata(struct omap_chip *omap,
+			       struct omap_pwm_pdata *pdata)
+{
+
+	/*
+	 * Request the OMAP dual-mode timer that will be bound to and
+	 * associated with this generic PWM.
+	 */
+
+	omap->dm_timer =3D omap_dm_timer_request_specific(pdata->timer_id);
+	if (omap->dm_timer =3D=3D NULL)
+		return -EPROBE_DEFER;
+
+	/*
+	 * Configure the source for the dual-mode timer backing this
+	 * generic PWM device. The clock source will ultimately determine
+	 * how small or large the PWM frequency can be.
+	 *
+	 * At some point, it's probably worth revisiting moving this to
+	 * the configure method and choosing either the slow- or
+	 * system-clock source as appropriate for the desired PWM period.
+	 */
+
+	return 0;
+}
+
+#ifdef CONFIG_OF
+static inline int omap_pwm_from_dt(struct omap_chip *omap,
+				  struct device *dev)
+{
+	struct device_node *np =3D dev->of_node;
+	struct device_node *timer;
+	if (!np)
+		return -ENODEV;
+	timer =3D of_parse_phandle(np, "timers", 0);
+	if (!timer)
+		return -ENODEV;
+
+	omap->dm_timer =3D omap_dm_timer_request_by_node(timer);
+	if (!omap->dm_timer)
+		return -EPROBE_DEFER;
+	return 0;
+}
+#else
+static inline in omap_pwm_from_dt(struct omap_chip *omap,
+				  struct device *dev)
+{
+	return -ENODEV;
+}
+#endif
+
+static int omap_pwm_probe(struct platform_device *pdev)
+{
+	struct device *dev =3D &pdev->dev;
+	struct omap_chip *omap;
+	int status =3D 0;
+	struct omap_pwm_pdata *pdata =3D dev->platform_data;
+
+	omap =3D devm_kzalloc(dev, sizeof(*omap), GFP_KERNEL);
+	if (omap =3D=3D NULL) {
+		dev_err(dev, "Could not allocate memory.\n");
+		return -ENOMEM;
+	}
+	if (pdata)
+		status =3D omap_pwm_from_pdata(omap, pdata);
+	else
+		status =3D omap_pwm_from_dt(omap, dev);
+	if (status)
+		return status;
+
+	omap_dm_timer_set_source(omap->dm_timer, OMAP_TIMER_SRC_SYS_CLK);
+	/*
+	 * Cache away other miscellaneous driver-private data and state
+	 * information and add the driver-private data to the platform
+	 * device.
+	 */
+
+	omap->chip.dev =3D dev;
+	omap->chip.ops =3D &omap_pwm_ops;
+	omap->chip.base =3D -1;
+	omap->chip.npwm =3D 1;
+	omap->polarity =3D PWM_POLARITY_NORMAL;
+
+	status =3D pwmchip_add(&omap->chip);
+	if (status < 0) {
+		dev_err(dev, "failed to register PWM\n");
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
+	struct omap_chip *omap =3D platform_get_drvdata(pdev);
+	int status;
+
+	omap_dm_timer_stop(omap->dm_timer);
+	status =3D pwmchip_remove(&omap->chip);
+	if (status < 0)
+		return status;
+
+	omap_dm_timer_free(omap->dm_timer);
+
+	return 0;
+}
+
+static const struct of_device_id omap_pwm_of_match[] =3D {
+	{.compatible =3D "ti,omap-pwm"},
+	{}
+};
+MODULE_DEVICE_TABLE(of, omap_pwm_of_match);
+
+static struct platform_driver omap_pwm_driver =3D {
+	.driver =3D {
+		.name	=3D "omap-pwm",
+		.owner	=3D THIS_MODULE,
+		.of_match_table =3D of_match_ptr(omap_pwm_of_match),
+	},
+	.probe		=3D omap_pwm_probe,
+	.remove		=3D omap_pwm_remove,
+};
+module_platform_driver(omap_pwm_driver);
+
+MODULE_AUTHOR("Grant Erickson <marathon96@gmail.com>");
+MODULE_AUTHOR("NeilBrown <neilb@suse.de>");
+MODULE_LICENSE("GPL v2");
+MODULE_VERSION("2012-12-01");
+MODULE_DESCRIPTION("OMAP PWM Driver using Dual-mode Timers");
diff --git a/include/linux/platform_data/omap-pwm.h b/include/linux/platfor=
m_data/omap-pwm.h
new file mode 100644
index 0000000..169fc3c
--- /dev/null
+++ b/include/linux/platform_data/omap-pwm.h
@@ -0,0 +1,20 @@
+/*
+ * omap-pwm.h
+ *
+ *    Copyright (c) 2012 NeilBrown <neilb@suse.de>
+ *
+ *    This program is free software; you can redistribute it and/or
+ *    modify it under the terms of the GNU General Public License
+ *    version 2 as published by the Free Software Foundation.
+ *
+ * Set the timer id to use for a PWM
+ */
+
+#ifndef _OMAP_PWM_H_
+#define _OMAP_PWM_H_
+
+struct omap_pwm_pdata {
+	int	timer_id;
+};
+
+#endif /* _OMAP_PWM_H_ */

--Sig_/iB8V.l4nKTechWX_0MLwxCd
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIVAwUBUmi/5Dnsnt1WYoG5AQLL9xAApol9HtuWYmS8M4wjES/PypVLFjnAvel9
XHUIecrfl39/Q+XtIpcneETNnt1lMxwOiSDmS1PphVsvlYrwUxn4wwj38F7tKzoP
8weYpv30a8i+GbE1sMU6IlYEqVn3WwUpwAc0RuseuQ83gjXvkWEyR59V7IdaXhKY
QXh06SmpO2EH+ZSVyut09Bh6w6k8U+xbY3t13DSiQQCyC8j3LcFPwnpP0QZu6MQx
tJtcxcI0NhW4PG1IzggQFetKwdZsz5auSG7EEwvmUfvvztHLAfTnHXqLZjiU/nLA
TqC0vn6up/UhC1brufQn9rDZvMEZ50Qz6KtJw1ZkzdBFPSCvJbmHSCkSQ31SXLq0
oA0fiqZ6lext6qNeFWKcWBXOUbPCHMJ5WDp9rD0NVep12Ztx7envmadcv/Tsh1xg
HqzWcib3Gziaoq775ItysFo3wIVkpPFH5O7F8/pX+W6LsD7DgVn9yN9FyTuj3/3G
ZGBXZRlMWcMkKikzZpYc8C5ljMQjncUVTkpJz0WSEgxOo91JRU0RK8n7czbniAAt
ApJbitZ4yly3xRYTze84ed56ufens309AffFo0cKcs0MveWk4BZ8qTzSMNTrMTLs
0DX5bxt3xzkiNNnDYTE6vLolcFfKBo88EelqmXOKDTkaCG70IUfI6LK2QLdRQMyM
x4BrKY2p96k=
=bwSc
-----END PGP SIGNATURE-----

--Sig_/iB8V.l4nKTechWX_0MLwxCd--
