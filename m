From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: [RFC][BUG] arm/dts: OMAP3: set #interrupt-cells to two
Date: Sat, 13 Apr 2013 19:42:16 +0200
Message-ID: <1365874936.3812.65.camel@mars>
References: <1364631689.3767.7.camel@mars>
	 <CAAwP0s35J-edpvFv08xjjpwaezQBYNvMNhhXL-UacsuUtSt4ZA@mail.gmail.com>
	 <1364834508.3939.74.camel@mars>
	 <CAAwP0s1H9zaBZPMDz9=He-E68UK0Ay3jnxZ2frYH9r1xNeQhxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f51.google.com ([209.85.214.51]:54875 "EHLO
	mail-bk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899Ab3DMRmX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 13 Apr 2013 13:42:23 -0400
Received: by mail-bk0-f51.google.com with SMTP id y8so1804346bkt.38
        for <linux-omap@vger.kernel.org>; Sat, 13 Apr 2013 10:42:21 -0700 (PDT)
In-Reply-To: <CAAwP0s1H9zaBZPMDz9=He-E68UK0Ay3jnxZ2frYH9r1xNeQhxQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: =?ISO-8859-1?Q?Beno=EEt?= Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Daniel Mack <daniel@zonque.org>, "Hans J. Koch" <hjk@hansjkoch.de>, Jon Hunter <jon-hunter@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

On Mon, 2013-04-01 at 22:05 +0200, Javier Martinez Canillas wrote:
> On Mon, Apr 1, 2013 at 6:41 PM, Christoph Fritz
> > As a quick-fix (hack) I wrote directly to the registers in gpio_probe()
> > to enable GPIO banks. I now geht this:
> >
> >> > [    0.214630] omap_gpio_probe, 1133, CM_CLKSEL_PER 0x48005040: 0x000000ff
> >> > [    0.214660] omap_gpio_probe, 1136, CM_ICLKEN_PER 0x48005010: 0x0007ffff
> >> > [    0.214660] omap_gpio_probe, 1139, CM_FCLKEN_PER 0x48005000: 0x0007ffff
> >
> > And it works for me. _But_ when I do enable regulator twl4030
> > (CONFIG_REGULATOR_TWL4030=y) in my config these registers get reset:
> >
> > [    2.935455] smsc911x_open, 1537, CM_CLKSEL_PER 0x48005040: 0x000000ff
> > [    2.942291] smsc911x_open, 1540, CM_ICLKEN_PER 0x48005010: 0x00040fff
> > [    2.949066] smsc911x_open, 1543, CM_FCLKEN_PER 0x48005000: 0x00000000
> >
> > And the IRQ source for the network chip (smsc911x) is disabled :-(
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
> makes the kernel to hang. Since I've to configure the IRQ polarity as
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
> 
> >  Thanks
> >   -- Christoph
> >
> 
> I hope to find some time this week to work on this and at least find a
> solution for the second issue (IORESOURCE_IRQ struct resource flags
> not being set).

Any updates on this issue?

For me it works when doing this in the device tree:

+&omap3_pmx_wkup {
+	pinctrl-names = "default";
+
+	lan9221_pins: pinmux_lan9221_pins {
+		pinctrl-single,pins = <
+			0x5A 0x104	/* gpio_129, INPUT | MODE4 */
+		>;
+	};
+};
+
<SNIP>
+	lan9221@15000000 {
+		compatible = "smsc,lan9221", "smsc,lan9115";
+		reg = <0x15000000 0x400>;
+		phy-mode = "mii";
+		interrupt-parent = <&gpio5>;
+		interrupts = <1 0x2>;	/* gpio_129, trigger: falling-edge */
+		reg-io-width = <4>;
+		vdd33a-supply = <&reg_vcc3>;
+		vddvario-supply = <&reg_vcc3>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&lan9221_pins>;
+	};

but in arch/arm/mach-omap2/gpmc.c gpmc_probe_dt() I still need this
hack:

+	ret = gpio_request_one(129, GPIOF_IN, "lan9221 irq");
+	if (ret) {
+		pr_err("Failed to request IRQ GPIO%d\n", 129);
+		return ret;
+	}

The following patches (already sent mainline) are also applied:
 "arm/dts: OMAP3: fix pinctrl-single configuration"
 "net: smsc911x: adopt pinctrl support"

 Thanks
  -- Christoph

