From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/5] pinctrl: core: Use delayed work for hogs
Date: Tue, 10 Jan 2017 11:19:09 -0800
Message-ID: <20170110191908.GV2630@atomide.com>
References: <20161227172003.6517-1-tony@atomide.com>
 <20161227172003.6517-2-tony@atomide.com>
 <CAMuHMdVLbNXx23-wgLHcvktyHxWf6t75ggU3rM5A-DhtU9hn5w@mail.gmail.com>
 <20170110153045.GS2630@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170110153045.GS2630@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Nishanth Menon <nm@ti.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [170110 07:32]:
> * Geert Uytterhoeven <geert@linux-m68k.org> [170110 06:09]:
> > Hi Tony,
> > 
> > On Tue, Dec 27, 2016 at 6:19 PM, Tony Lindgren <tony@atomide.com> wrote:
> > > Having the pin control framework call pin controller functions
> > > before it's probe has finished is not nice as the pin controller
> > > device driver does not yet have struct pinctrl_dev handle.
> > >
> > > Let's fix this issue by adding deferred work for late init. This is
> > > needed to be able to add pinctrl generic helper functions that expect
> > > to know struct pinctrl_dev handle. Note that we now need to call
> > > create_pinctrl() directly as we don't want to add the pin controller
> > > to the list of controllers until the hogs are claimed. We also need
> > > to pass the pinctrl_dev to the device tree parser functions as they
> > > otherwise won't find the right controller at this point.
> > >
> > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > 
> > I believe this patch causes a regression on r8a7740/armadillo, where the
> > pin controller is also a GPIO controller, and lcd0 needs a hog
> > (cfr. arch/arm/boot/dts/r8a7740-armadillo800eva.dts):
> > 
> > -GPIO line 176 (lcd0) hogged as output/high
> > -sh-pfc e6050000.pfc: r8a7740_pfc handling gpio 0 -> 211
> > +gpiochip_add_data: GPIOs 0..211 (r8a7740_pfc) failed to register
> > +sh-pfc e6050000.pfc: failed to init GPIO chip, ignoring...
> >  sh-pfc e6050000.pfc: r8a7740_pfc support registered
> > 
> > Hence all drivers using GPIOs fail to initialize because their GPIOs never
> > become available.
> > 
> > Adding debug prints to the failure paths shows that the call to
> > of_pinctrl_get() in of_gpiochip_add_pin_range() fails with -EPROBE_DEFER.
> > Adding a debug print to the top of gpiochip_add_data() makes the problem go
> > away, presumably because it introduces a delay that allows the delayed work
> > to kick in...
> 
> OK. What if we added also an optional pinctrl function that the pin
> controller driver could call to initialize hogs? Then the pin controller
> driver could call it during or after probe as needed. That is after
> there's a valid struct pinctrl_dev handle.
...
> We could also pass some flag if should always call pinctrl_late_init()
> directly. But that does not remove the problem of struct pinctrl_dev handle
> being uninitialized when the pin controller driver functionas are called.

Looks like we need both a flag and a way for the pin controller driver
to start things.

Below is an experimental fix to intorduce pinctrl_start() that I've
tested with pinctrl-single. Then we should probably make all pin controller
drivers call pinctrl_start() to properly fix the issue of struct pinctrl_dev
handle not being initialized before driver functions are called.

Or do you guys have any better ideas?

Regards,

Tony

8< --------------------------------
diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -1962,6 +1962,17 @@ static void pinctrl_late_init(struct work_struct *work)
 	pinctrl_init_device_debugfs(pctldev);
 }
 
+int pinctrl_start(struct pinctrl_dev *pctldev)
+{
+       if (!IS_ERR(pctldev->p))
+               return -EEXIST;
+
+       pinctrl_late_init(&pctldev->late_init.work);
+
+       return 0;
+}
+EXPORT_SYMBOL_GPL(pinctrl_start);
+
 /**
  * pinctrl_register() - register a pin controller device
  * @pctldesc: descriptor for this pin controller
@@ -2035,9 +2046,14 @@ struct pinctrl_dev *pinctrl_register(struct pinctrl_desc *pctldesc,
 	/*
 	 * If the device has hogs we want the probe() function of the driver
 	 * to complete before we go in and hog them and add the pin controller
-	 * to the list of controllers. If it has no hogs, we can just complete
-	 * the registration immediately.
+	 * to the list of controllers. If the pin controller driver initializes
+	 * hogs, or the pin controller instance has no hogs, we can just
+	 * complete the registration immediately.
 	 */
+
+	if (pctldesc->flags & PINCTRL_DRIVER_START)
+		return pctldev;
+
 	if (pinctrl_dt_has_hogs(pctldev))
 		schedule_delayed_work(&pctldev->late_init, 0);
 	else
diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -1741,6 +1741,7 @@ static int pcs_probe(struct platform_device *pdev)
 	pcs->desc.pmxops = &pcs_pinmux_ops;
 	if (PCS_HAS_PINCONF)
 		pcs->desc.confops = &pcs_pinconf_ops;
+	pcs->desc.flags = PINCTRL_DRIVER_START;
 	pcs->desc.owner = THIS_MODULE;
 
 	ret = pcs_allocate_pin_table(pcs);
@@ -1754,6 +1755,10 @@ static int pcs_probe(struct platform_device *pdev)
 		goto free;
 	}
 
+	ret = pinctrl_start(pcs->pctl);
+	if (ret)
+		goto free;
+
 	ret = pcs_add_gpio_func(np, pcs);
 	if (ret < 0)
 		goto free;
diff --git a/drivers/pinctrl/sh-pfc/pinctrl.c b/drivers/pinctrl/sh-pfc/pinctrl.c
--- a/drivers/pinctrl/sh-pfc/pinctrl.c
+++ b/drivers/pinctrl/sh-pfc/pinctrl.c
@@ -815,7 +815,15 @@ int sh_pfc_register_pinctrl(struct sh_pfc *pfc)
 	pmx->pctl_desc.confops = &sh_pfc_pinconf_ops;
 	pmx->pctl_desc.pins = pmx->pins;
 	pmx->pctl_desc.npins = pfc->info->nr_pins;
+	pmx->pctl_desc.flags = PINCTRL_DRIVER_START;
 
 	pmx->pctl = devm_pinctrl_register(pfc->dev, &pmx->pctl_desc, pmx);
-	return PTR_ERR_OR_ZERO(pmx->pctl);
+	if (IS_ERR(pmx->pctl))
+		return PTR_ERR(pmx->pctl);
+
+	ret = pinctrl_start(pmx->pctl);
+	if (ret)
+		return ret;
+
+	return 0;
 }
diff --git a/include/linux/pinctrl/pinctrl.h b/include/linux/pinctrl/pinctrl.h
--- a/include/linux/pinctrl/pinctrl.h
+++ b/include/linux/pinctrl/pinctrl.h
@@ -104,6 +104,8 @@ struct pinctrl_ops {
 			     struct pinctrl_map *map, unsigned num_maps);
 };
 
+#define PINCTRL_DRIVER_START		BIT(0)
+
 /**
  * struct pinctrl_desc - pin controller descriptor, register this to pin
  * control subsystem
@@ -112,6 +114,8 @@ struct pinctrl_ops {
  *	this pin controller
  * @npins: number of descriptors in the array, usually just ARRAY_SIZE()
  *	of the pins field above
+ * @flags: Optional pin controller feature flags
+ *	handling is needed in the pin controller driver.
  * @pctlops: pin control operation vtable, to support global concepts like
  *	grouping of pins, this is optional.
  * @pmxops: pinmux operations vtable, if you support pinmuxing in your driver
@@ -129,6 +133,7 @@ struct pinctrl_desc {
 	const char *name;
 	const struct pinctrl_pin_desc *pins;
 	unsigned int npins;
+	unsigned int flags;
 	const struct pinctrl_ops *pctlops;
 	const struct pinmux_ops *pmxops;
 	const struct pinconf_ops *confops;
@@ -149,6 +154,7 @@ extern struct pinctrl_dev *devm_pinctrl_register(struct device *dev,
 				void *driver_data);
 extern void devm_pinctrl_unregister(struct device *dev,
 				struct pinctrl_dev *pctldev);
+extern int pinctrl_start(struct pinctrl_dev *pctldev);
 
 extern bool pin_is_valid(struct pinctrl_dev *pctldev, int pin);
 extern void pinctrl_add_gpio_range(struct pinctrl_dev *pctldev,
-- 
2.11.0
