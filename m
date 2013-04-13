From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [RFC][BUG] arm/dts: OMAP3: set #interrupt-cells to two
Date: Sat, 13 Apr 2013 23:40:36 +0200
Message-ID: <CAAwP0s2Adjb_e50Gf91zqfXiPDMNRZ=eAmQzJzxfDw8bFfzMrg@mail.gmail.com>
References: <1364631689.3767.7.camel@mars> <CAAwP0s35J-edpvFv08xjjpwaezQBYNvMNhhXL-UacsuUtSt4ZA@mail.gmail.com>
 <1364834508.3939.74.camel@mars> <CAAwP0s1H9zaBZPMDz9=He-E68UK0Ay3jnxZ2frYH9r1xNeQhxQ@mail.gmail.com>
 <1365874936.3812.65.camel@mars> <CAAwP0s1i16coo78cBChyFK78BQq2CG4KKJLQSqeuneLuhg2WUg@mail.gmail.com>
 <1365879596.3812.118.camel@mars>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:48020 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753581Ab3DMVk5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 13 Apr 2013 17:40:57 -0400
Received: by mail-ie0-f181.google.com with SMTP id as1so127081iec.12
        for <linux-omap@vger.kernel.org>; Sat, 13 Apr 2013 14:40:56 -0700 (PDT)
In-Reply-To: <1365879596.3812.118.camel@mars>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: =?UTF-8?Q?Beno=C3=AEt_Cousson?= <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Daniel Mack <daniel@zonque.org>, "Hans J. Koch" <hjk@hansjkoch.de>, Jon Hunter <jon-hunter@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

On Sat, Apr 13, 2013 at 8:59 PM, Christoph Fritz
<chf.fritz@googlemail.com> wrote:
> On Sat, 2013-04-13 at 20:30 +0200, Javier Martinez Canillas wrote:
>> On Sat, Apr 13, 2013 at 7:42 PM, Christoph Fritz
>> <chf.fritz@googlemail.com> wrote:
>
>> Yes, my last approach to solve the IRQ flags not saved on the
>> IORESOURCE_IRQ struct resource issue is to add a new
>> irq_get_trigger_type() function to get the edge/level flags from an
>> IRQ number and use that function on the smsc911x driver probe function
>> to get the IRQ flags.
>>
>> The patch-set is composed of these patches:
>>
>> [PATCH v2 1/2] genirq: add function to get IRQ edge/level flags [1]
>> [PATCH 2/2] net: smsc911x: get IRQ flags from chip if not present in
>> IORESOURCE_IRQ [2]
>>
>> and the cover letter is this [3]
>>
>> It would be great if you can test these patches and give some feedback.
>>
>> > For me it works when doing this in the device tree:
>> >
>> > +&omap3_pmx_wkup {
>> > +       pinctrl-names = "default";
>> > +
>> > +       lan9221_pins: pinmux_lan9221_pins {
>> > +               pinctrl-single,pins = <
>> > +                       0x5A 0x104      /* gpio_129, INPUT | MODE4 */
>> > +               >;
>> > +       };
>> > +};
>> > +
>> > <SNIP>
>> > +       lan9221@15000000 {
>> > +               compatible = "smsc,lan9221", "smsc,lan9115";
>> > +               reg = <0x15000000 0x400>;
>>
>> If I understood correctly your smsc ethernet chip is connected to the
>> OMAP through the GPMC, then you should use a chip-select, base address
>> and size instead of the physical address and size.
>
> Yes, it's connected with GPMC.
>
>> Do you have commit 5330dc161 ("ARM: OMAP2+: Add GPMC DT support for
>> Ethernet child nodes") already on your tree? [4]
>
> No I haven't.
>

In that case you should have that commit on your tree. But the GPMC
driver has changed a lot for 3.9 and 3.10, so I recommend you to base
your work on linux-next that has the latest changes.

And then you will need something like this on your DT (in this example
is using the chip-select 5 but adjust according to your board):

gpmc: gpmc@6e000000 {
        compatible = "ti,omap3430-gpmc";
        ti,hwmods = "gpmc";
        reg = <0x6e000000 0x1000>;
        interrupts = <20>;
        gpmc,num-cs = <8>;
        gpmc,num-waitpins = <4>;
        #address-cells = <2>;
        #size-cells = <1>;

        ranges = <5 0 0x2c000000 0x1000000>;

        ethernet@5,0 {
                pinctrl-names = "default";
                pinctrl-0 = <&lan9221_pins>;
                compatible = "smsc,lan9221", "smsc,lan9115";
                reg = <5 0 0xff>;
                bank-width = <2>;

                gpmc,mux-add-data;
                gpmc,cs-on-ns = <0>;
                gpmc,cs-rd-off-ns = <186>;
                gpmc,cs-wr-off-ns = <186>;
                gpmc,adv-on-ns = <12>;
                gpmc,adv-rd-off-ns = <48>;
                gpmc,adv-wr-off-ns = <48>;
                gpmc,oe-on-ns = <54>;
                gpmc,oe-off-ns = <168>;
                gpmc,we-on-ns = <54>;
                gpmc,we-off-ns = <168>;
                gpmc,rd-cycle-ns = <186>;
                gpmc,wr-cycle-ns = <186>;
                gpmc,access-ns = <114>;
                gpmc,page-burst-access-ns = <6>;
                gpmc,bus-turnaround-ns = <12>;
                gpmc,cycle2cycle-delay-ns = <18>;
                gpmc,wr-data-mux-bus-ns = <90>;
                gpmc,wr-access-ns = <186>;
                gpmc,cycle2cycle-samecsen;
                gpmc,cycle2cycle-diffcsen;

                interrupt-parent = <&gpio5>;
                interrupts = <1 0x2>;
                reg-io-width = <4>;
                vdd33a-supply = <&reg_vcc3>;
                vmmc_aux-supply = <&vdd33a>;
                vddvario-supply = <&reg_vcc3>;
        };
};

>>
>> > +               phy-mode = "mii";
>> > +               interrupt-parent = <&gpio5>;
>> > +               interrupts = <1 0x2>;   /* gpio_129, trigger: falling-edge */
>>
>> I'm confused here, do you get the IRQ_TYPE_EDGE_FALLING (0x2) trigger
>> type flag on the smsc911x driver probe function?
>
> I added printks for irq_res->flags and irq_flags:
> [    1.259857] smsc911x_drv_probe, 2396, irq_res->flags 0x00000400
> [    1.266113] smsc911x_drv_probe, 2397, irq_flags 0x00000000
>
> So the answer is no. But weird that the smsc911x works nevertheless.
>

Yes, that's what I thought. You will need patch [1] and [2] to allow
smsc911x driver to get the GPIO-IRQ trigger type flags.

With those patches + linux-next + the device node I posted above +
your gpio_request_one() hack on gpmc_probe_dt() should be enough to
have your smsc ethernet chip working on your board.

>>
>> > +               reg-io-width = <4>;
>> > +               vdd33a-supply = <&reg_vcc3>;
>> > +               vddvario-supply = <&reg_vcc3>;
>> > +               pinctrl-names = "default";
>> > +               pinctrl-0 = <&lan9221_pins>;
>> > +       };
>> >
>> > but in arch/arm/mach-omap2/gpmc.c gpmc_probe_dt() I still need this
>> > hack:
>> >
>> > +       ret = gpio_request_one(129, GPIOF_IN, "lan9221 irq");
>> > +       if (ret) {
>> > +               pr_err("Failed to request IRQ GPIO%d\n", 129);
>> > +               return ret;
>> > +       }
>> >
>>
>> Yes, this hack is still needed until we figure out how to enable the
>> GPIO bank before a call to request_irq() is made.
>>
>> > The following patches (already sent mainline) are also applied:
>> >  "arm/dts: OMAP3: fix pinctrl-single configuration"
>> >  "net: smsc911x: adopt pinctrl support"
>> >
>>
>> Yes, but that patch is not needed anymore from 3.9, look at this [5]
>>
>> [1]: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg88241.html
>> [2]: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg88225.html
>> [3]: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg88224.html
>> [4]: https://patchwork.kernel.org/patch/2273851/
>> [5]: http://marc.info/?l=linux-kernel&m=135887740715083&w=2
>
> Thanks
>  -- Christoph
>
>

Best regards,
Javier
