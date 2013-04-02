From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: [RFC][BUG] arm/dts: OMAP3: set #interrupt-cells to two
Date: Tue, 02 Apr 2013 17:55:24 +0200
Message-ID: <1364918124.5935.145.camel@mars>
References: <1364631689.3767.7.camel@mars>
	 <CAAwP0s35J-edpvFv08xjjpwaezQBYNvMNhhXL-UacsuUtSt4ZA@mail.gmail.com>
	 <1364834508.3939.74.camel@mars>
	 <CAAwP0s1H9zaBZPMDz9=He-E68UK0Ay3jnxZ2frYH9r1xNeQhxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f50.google.com ([209.85.214.50]:58355 "EHLO
	mail-bk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761234Ab3DBPza (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Apr 2013 11:55:30 -0400
Received: by mail-bk0-f50.google.com with SMTP id jg1so292813bkc.23
        for <linux-omap@vger.kernel.org>; Tue, 02 Apr 2013 08:55:29 -0700 (PDT)
In-Reply-To: <CAAwP0s1H9zaBZPMDz9=He-E68UK0Ay3jnxZ2frYH9r1xNeQhxQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: =?ISO-8859-1?Q?Beno=EEt?= Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Daniel Mack <daniel@zonque.org>, "Hans J. Koch" <hjk@hansjkoch.de>, Jon Hunter <jon-hunter@ti.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

On Mon, 2013-04-01 at 22:05 +0200, Javier Martinez Canillas wrote:

> > As a quick-fix (hack) I wrote directly to the registers in gpio_probe()
> > to enable GPIO banks. I now geht this:
> >
> >> > [    0.214630] omap_gpio_probe, 1133, CM_CLKSEL_PER 0x48005040: 0x000000ff
> >> > [    0.214660] omap_gpio_probe, 1136, CM_ICLKEN_PER 0x48005010: 0x0007ffff
> >> > [    0.214660] omap_gpio_probe, 1139, CM_FCLKEN_PER 0x48005000: 0x0007ffff

to be more specific on this point, this is the patch to enable the
gpio-clocks:

--
Subject: [PATCH] HACK: enable gpio-clocks in gpio-omap probe()

Without this patch setting trigger value from #interrupt-cell two
(smsc911x) fails.
---
 drivers/gpio/gpio-omap.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 159f5c5..720b2e6 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1098,6 +1098,7 @@ static int omap_gpio_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct gpio_bank *bank;
 	int ret = 0;
+	void __iomem *tmp;
 
 	match = of_match_device(of_match_ptr(omap_gpio_match), dev);
 
@@ -1117,6 +1118,17 @@ static int omap_gpio_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	// TRM: Table 3-242. PER_CM Register Summary
+	tmp = ioremap(0x48005040, 4); //CM_CLKSEL_PER, GPT2 = sys clk
+	writel(0xFF, tmp);
+	iounmap(tmp);
+	tmp = ioremap(0x48005010, 4); //CM_ICLKEN_PER, ICKen GPT2
+	writel(0x7FFFF, tmp);
+	iounmap(tmp);
+	tmp = ioremap(0x48005000, 4); //CM_FCLKEN_PER, GPIOX functional clock is enabled
+	writel(0x7FFFF, tmp);
+	iounmap(tmp);
+
 	bank->irq = res->start;
 	bank->dev = dev;
 	bank->dbck_flag = pdata->dbck_flag;
-- 
1.7.10.4

Is there a better way to do this?


> >
> > And it works for me. _But_ when I do enable regulator twl4030
> > (CONFIG_REGULATOR_TWL4030=y) in my config these registers get reset:
> >
> > [    2.935455] smsc911x_open, 1537, CM_CLKSEL_PER 0x48005040: 0x000000ff
> > [    2.942291] smsc911x_open, 1540, CM_ICLKEN_PER 0x48005010: 0x00040fff
> > [    2.949066] smsc911x_open, 1543, CM_FCLKEN_PER 0x48005000: 0x00000000
> >
> > And the IRQ source for the network chip (smsc911x) is disabled :-(

CONFIG_REGULATOR_TWL4030=y  disables the gpio-clocks. Why is that?

> >
> > Do you have any idea how to ("quick") fix this?
> >
> 
> A quick hack is to call gpio_request() explicitly before calling to
> irq_set_type() is made.
> I've this patch just to make it work until we find a clean solution:
> 
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index 90c15ee..d594e1d 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -14,6 +14,7 @@
>   */
>  #undef DEBUG
> 
> +#include <linux/gpio.h>
>  #include <linux/irq.h>
>  #include <linux/kernel.h>
>  #include <linux/init.h>
> @@ -1528,6 +1529,11 @@ static int gpmc_probe_dt(struct platform_device *pdev)
>                 return ret;
>         }
> 
> +       ret = gpio_request_one(176, GPIOF_IN, "smsc911x irq");
> +       if (ret) {
> +               pr_err("Failed to request IRQ GPIO%d\n", 176);
> +               return ret;
> +       }
> +
>         for_each_node_by_name(child, "nand") {
>                 ret = gpmc_probe_nand_child(pdev, child);
>                 if (ret < 0) {
> 
> This solves the issue of the non-initialized GPIO bank before that
> makes the kernel to hang.

Here it does not. A printk shows that I'm not using gpmc at all.
So I added a gpmc node:

+       gpmc: gpmc@0x6E000000 {
+               compatible = "ti,omap3430-gpmc";
+               ti,hwmods = "ti,gpmc";
+               reg = <0x6E000000 0x2000>;
+               gpmc,num-cs = <8>;
+               gpmc,num-waitpins = <2>;
+               #address-cells = <2>;
+               #size-cells = <1>;
+               ranges = <0 0 0x0 0x3FFFFFFF>;
+
+       };

But still, gpmc_probe_dt() isn't called. I maybe have to define some
child nodes but currently I do configure the gpmc in u-boot and try to
avoid kernel-gpmc-config.

>  Since I've to configure the IRQ polarity as
> active low level-sensitive on my board and the flags are not set by
> the IRQ core, I've another ugly hack that forces this:
> 
> diff --git a/drivers/net/ethernet/smsc/smsc911x.c
> b/drivers/net/ethernet/smsc/smsc
> index da5cc9a..27e46f9 100644
> --- a/drivers/net/ethernet/smsc/smsc911x.c
> +++ b/drivers/net/ethernet/smsc/smsc911x.c
> @@ -2390,6 +2390,9 @@ static int smsc911x_drv_probe(struct
> platform_device *pdev)
>         pdata = netdev_priv(dev);
>         dev->irq = irq_res->start;
> -        irq_flags = irq_res->flags & IRQF_TRIGGER_MASK;
> +       irq_flags = IRQF_TRIGGER_LOW;
>         pdata->ioaddr = ioremap_nocache(res->start, res_size);
> 
>         pdata->dev = dev;

I already did something like that with this patch:

---
Subject: [PATCH] net: smsc911x: adopt pinctrl support

This patch is derived from 2d4b4520a "i2c: omap: adopt pinctrl support":
Some GPIO expanders need some early pin control muxing. Due to
legacy boards sometimes the driver uses subsys_initcall instead of
module_init. This patch takes advantage of defer probe feature
and pin control in order to wait until pin control probing before
GPIO driver probing.

---
 drivers/net/ethernet/smsc/smsc911x.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/smsc/smsc911x.c b/drivers/net/ethernet/smsc/smsc911x.c
index da5cc9a..3e3547c 100644
--- a/drivers/net/ethernet/smsc/smsc911x.c
+++ b/drivers/net/ethernet/smsc/smsc911x.c
@@ -59,6 +59,7 @@
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
 #include <linux/of_net.h>
+#include <linux/pinctrl/consumer.h>
 #include "smsc911x.h"
 
 #define SMSC_CHIPNAME		"smsc911x"
@@ -144,6 +145,8 @@ struct smsc911x_data {
 
 	/* regulators */
 	struct regulator_bulk_data supplies[SMSC911X_NUM_SUPPLIES];
+
+	struct pinctrl *pins;
 };
 
 /* Easy access to information */
@@ -2433,6 +2436,18 @@ static int smsc911x_drv_probe(struct platform_device *pdev)
 	if (retval < 0)
 		goto out_disable_resources;
 
+	pdata->pins = devm_pinctrl_get_select_default(&pdev->dev);
+	if (IS_ERR(pdata->pins)) {
+		if (PTR_ERR(pdata->pins) == -EPROBE_DEFER) {
+			retval = -EPROBE_DEFER;
+			goto out_disable_resources;
+		}
+
+		dev_warn(&pdev->dev, "No pins for smsc911x error: %li\n",
+			 PTR_ERR(pdata->pins));
+		pdata->pins = NULL;
+	}
+
 	/* configure irq polarity and type before connecting isr */
 	if (pdata->config.irq_polarity == SMSC911X_IRQ_POLARITY_ACTIVE_HIGH)
 		intcfg |= INT_CFG_IRQ_POL_;
-- 
1.7.10.4

Now I can specify the "IRQF_TRIGGER_LOW" (which is 0x2) in the device
tree thanks to the first patch in this thread:

        lan9221@15000000 {
                compatible = "smsc,lan9221", "smsc,lan9115";
                reg = <0x15000000 0x400>;
                phy-mode = "mii";
                interrupt-parent = <&gpio5>;
                interrupts = <1 0x2>;   /* gpio_129, trigger: falling-edge */
                reg-io-width = <4>;
                vdd33a-supply = <&reg_vcc3>;
                vddvario-supply = <&reg_vcc3>;
                pinctrl-names = "default";
                pinctrl-0 = <&lan9221_pins>;
        };


 Thanks
  -- Christoph


