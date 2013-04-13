From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: [RFC][BUG] arm/dts: OMAP3: set #interrupt-cells to two
Date: Sat, 13 Apr 2013 20:59:56 +0200
Message-ID: <1365879596.3812.118.camel@mars>
References: <1364631689.3767.7.camel@mars>
	 <CAAwP0s35J-edpvFv08xjjpwaezQBYNvMNhhXL-UacsuUtSt4ZA@mail.gmail.com>
	 <1364834508.3939.74.camel@mars>
	 <CAAwP0s1H9zaBZPMDz9=He-E68UK0Ay3jnxZ2frYH9r1xNeQhxQ@mail.gmail.com>
	 <1365874936.3812.65.camel@mars>
	 <CAAwP0s1i16coo78cBChyFK78BQq2CG4KKJLQSqeuneLuhg2WUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f44.google.com ([209.85.214.44]:40371 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751772Ab3DMTAC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 13 Apr 2013 15:00:02 -0400
Received: by mail-bk0-f44.google.com with SMTP id jk13so1830623bkc.31
        for <linux-omap@vger.kernel.org>; Sat, 13 Apr 2013 12:00:00 -0700 (PDT)
In-Reply-To: <CAAwP0s1i16coo78cBChyFK78BQq2CG4KKJLQSqeuneLuhg2WUg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: =?ISO-8859-1?Q?Beno=EEt?= Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Daniel Mack <daniel@zonque.org>, "Hans J. Koch" <hjk@hansjkoch.de>, Jon Hunter <jon-hunter@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

On Sat, 2013-04-13 at 20:30 +0200, Javier Martinez Canillas wrote:
> On Sat, Apr 13, 2013 at 7:42 PM, Christoph Fritz
> <chf.fritz@googlemail.com> wrote:

> Yes, my last approach to solve the IRQ flags not saved on the
> IORESOURCE_IRQ struct resource issue is to add a new
> irq_get_trigger_type() function to get the edge/level flags from an
> IRQ number and use that function on the smsc911x driver probe function
> to get the IRQ flags.
> 
> The patch-set is composed of these patches:
> 
> [PATCH v2 1/2] genirq: add function to get IRQ edge/level flags [1]
> [PATCH 2/2] net: smsc911x: get IRQ flags from chip if not present in
> IORESOURCE_IRQ [2]
> 
> and the cover letter is this [3]
> 
> It would be great if you can test these patches and give some feedback.
> 
> > For me it works when doing this in the device tree:
> >
> > +&omap3_pmx_wkup {
> > +       pinctrl-names = "default";
> > +
> > +       lan9221_pins: pinmux_lan9221_pins {
> > +               pinctrl-single,pins = <
> > +                       0x5A 0x104      /* gpio_129, INPUT | MODE4 */
> > +               >;
> > +       };
> > +};
> > +
> > <SNIP>
> > +       lan9221@15000000 {
> > +               compatible = "smsc,lan9221", "smsc,lan9115";
> > +               reg = <0x15000000 0x400>;
> 
> If I understood correctly your smsc ethernet chip is connected to the
> OMAP through the GPMC, then you should use a chip-select, base address
> and size instead of the physical address and size.

Yes, it's connected with GPMC.

> Do you have commit 5330dc161 ("ARM: OMAP2+: Add GPMC DT support for
> Ethernet child nodes") already on your tree? [4]

No I haven't.

> 
> > +               phy-mode = "mii";
> > +               interrupt-parent = <&gpio5>;
> > +               interrupts = <1 0x2>;   /* gpio_129, trigger: falling-edge */
> 
> I'm confused here, do you get the IRQ_TYPE_EDGE_FALLING (0x2) trigger
> type flag on the smsc911x driver probe function?

I added printks for irq_res->flags and irq_flags:
[    1.259857] smsc911x_drv_probe, 2396, irq_res->flags 0x00000400
[    1.266113] smsc911x_drv_probe, 2397, irq_flags 0x00000000

So the answer is no. But weird that the smsc911x works nevertheless.

> 
> > +               reg-io-width = <4>;
> > +               vdd33a-supply = <&reg_vcc3>;
> > +               vddvario-supply = <&reg_vcc3>;
> > +               pinctrl-names = "default";
> > +               pinctrl-0 = <&lan9221_pins>;
> > +       };
> >
> > but in arch/arm/mach-omap2/gpmc.c gpmc_probe_dt() I still need this
> > hack:
> >
> > +       ret = gpio_request_one(129, GPIOF_IN, "lan9221 irq");
> > +       if (ret) {
> > +               pr_err("Failed to request IRQ GPIO%d\n", 129);
> > +               return ret;
> > +       }
> >
> 
> Yes, this hack is still needed until we figure out how to enable the
> GPIO bank before a call to request_irq() is made.
> 
> > The following patches (already sent mainline) are also applied:
> >  "arm/dts: OMAP3: fix pinctrl-single configuration"
> >  "net: smsc911x: adopt pinctrl support"
> >
> 
> Yes, but that patch is not needed anymore from 3.9, look at this [5]
> 
> [1]: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg88241.html
> [2]: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg88225.html
> [3]: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg88224.html
> [4]: https://patchwork.kernel.org/patch/2273851/
> [5]: http://marc.info/?l=linux-kernel&m=135887740715083&w=2

Thanks
 -- Christoph


