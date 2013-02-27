From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [PATCH 3/5] gpio/omap: Add DT support to GPIO driver
Date: Wed, 27 Feb 2013 04:33:48 +0100
Message-ID: <CAAwP0s3oNaALFfLvEQnZ1m90BXh5pF2_-8FUyi6pQMzb0_FSVQ@mail.gmail.com>
References: <1329321854-24490-1-git-send-email-b-cousson@ti.com>
 <1329321854-24490-4-git-send-email-b-cousson@ti.com> <4F44FA56.7020000@gmail.com>
 <4F44FC37.2000701@ti.com> <4F452484.5080503@gmail.com> <74CDBE0F657A3D45AFBB94109FB122FF17BD8BC6C1@HQMAIL01.nvidia.com>
 <4F47AD08.4030504@ti.com> <CAAwP0s0cB368R2mtbJpTZJreR-5GSRLfxC+8DJLo5nw3_OwBuA@mail.gmail.com>
 <512D39DA.7020306@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:56625 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755666Ab3B0DeI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Feb 2013 22:34:08 -0500
Received: by mail-ie0-f174.google.com with SMTP id k10so114137iea.19
        for <linux-omap@vger.kernel.org>; Tue, 26 Feb 2013 19:34:08 -0800 (PST)
In-Reply-To: <512D39DA.7020306@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, Stephen Warren <swarren@nvidia.com>, Rob Herring <robherring2@gmail.com>, Kevin Hilman <khilman@deeprootsystems.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Grant Likely <grant.likely@secretlab.ca>

On Tue, Feb 26, 2013 at 11:40 PM, Jon Hunter <jon-hunter@ti.com> wrote:
>
> On 02/26/2013 04:01 AM, Javier Martinez Canillas wrote:
>
> [snip]
>
>> I was wondering if the level/edge settings for gpios is working on OMAP.
>>
>> I'm adding DT support for an SMSC911x ethernet chip connected to the
>> GPMC for an OMAP3 SoC based board.
>>
>> In the smsc911x driver probe function (smsc911x_drv_probe() in
>> drivers/net/ethernet/smsc/smsc911x.c), a call to request_irq() with
>> the flag IRQF_TRIGGER_LOW is needed because of the wiring on my board.
>>
>> Reading the gpio-omap.txt documentation it says that #interrupt-cells
>> should be <2> and that a value of 8 is "active low level-sensitive".
>>
>> So I tried this:
>>
>> &gpmc {
>>       ethernet@5,0 {
>>               pinctrl-names = "default";
>>               pinctrl-0 = <&smsc911x_pins>;
>>               compatible = "smsc,lan9221", "smsc,lan9115";
>>               reg = <5 0 0xff>; /* CS5 */
>>               interrupt-parent = <&gpio6>;
>>               interrupts = <16 8>; /* gpio line 176 */
>>               interrupt-names = "smsc911x irq";
>>               vmmc-supply = <&vddvario>;
>>               vmmc_aux-supply = <&vdd33a>;
>>               reg-io-width = <4>;
>>
>>               smsc,save-mac-address;
>>       };
>> };
>
> Are you requesting the gpio anywhere? If not then this is not going to
> work as-is. This was discussed fairly recently [1] and the conclusion
> was that the gpio needs to be requested before we can use as an interrupt.
>
> I have not seen your latest smsc code for omap, but when you are
> requesting the gpmc chip-select you should also request the gpio.
>

Yes, I realized that requesting the gpio was necessary so what I did
is to use the "regulator-fixed" optional property "gpio" and define
the GPIO used as an IRQ in a regulator used by the SMSC chip. So, I
have this on my board DT:

vddvario: regulator-vddvario {
	compatible = "regulator-fixed";
	regulator-name = "vddvario";
	regulator-always-on;
	gpio = <&gpio6 16 8>;  /* gpio line 176 */
	enable-active-high;
	gpio-open-drain;
	regulator-boot-on;
};

&gpmc {
	ethernet@5,0 {
		pinctrl-names = "default";
		pinctrl-0 = <&smsc911x_pins>;
		compatible = "smsc,lan9221", "smsc,lan9115";
		reg = <5 0 0xff>;
		interrupt-parent = <&gpio6>;
		interrupts = <16 8>; /* gpio line 176 */
		interrupt-names = "smsc911x irq";
		vmmc-supply = <&vddvario>;
		vmmc_aux-supply = <&vdd33a>;
		reg-io-width = <4>;

		smsc,save-mac-address;
      };
};

That way a call to gpio_request_one() is made and the GPIO is requested.

This look a little hack-ish for me but I've seen this in other
DeviceTrees like omap4-sdp.dts so I thought it was a common DT
pattern.

>> But in the smsc911x probe function:
>>
>> irq_res->flags & IRQF_TRIGGER_MASK;
>>
>> returns 0 which means that no trigger flags where set.
>>
>> I took a look to the GPIOs device node definition on omap{3,4,5}.dtsi
>> and all look like this:
>>
>> e.g from omap3.dtsi:
>>
>>                 gpio6: gpio@49058000 {
>>                         compatible = "ti,omap3-gpio";
>>                         ti,hwmods = "gpio6";
>>                         gpio-controller;
>>                         #gpio-cells = <2>;
>>                         interrupt-controller;
>>                         #interrupt-cells = <1>;
>>                 };
>>
>> So, even when the documentation says that all the GPIO device nodes in
>> OMAP2+ should use a #interrupt-cells property value of <2>, they are
>> only using <1>. Changing that value to 2 makes hangs the kernel and it
>> does not boot.
>
> I will need to take a look at that. Is your code available anywhere so I
> can test?
>

Of course, I pushed a gpmc-smsc911x branch to my github linux repository [2].

The branch is latest Linus' master + Benoit's linux-omap-dt/for_3.9/dts +
"ARM: OMAP2+: Prevent potential crash if GPMC probe fails" [3] +
"ARM: dts: OMAP3: Add GPMC controller" [4] + my patches:

Javier Martinez Canillas (5):
      ARM: dts: OMAP3: reduce GPMC mapped registers address space
      ARM: dts: OMAP3: make GPMC node compatible with simple-bus
      ARM: dts: OMAP3: add ranges property for GPMC chip-select 5
      ARM: dts: omap3-igep0020: Add SMSC911x LAN chip support
      smsc: smc911x: (HACK) force "active low" polarity for IRQ

The last patch is just an ugly hack that forces the IRQ flags to
active low level-sensitive so the SMSC911x IRQ is triggered on my
board (IGEPv2).

I just added for testing purposes since the omap3-gpio
interrupt-controller #interrupt-cells = <2> seems to not be working
and I can't pass this flag when defining the IRQ in the smsc911x
ethernet device node.

> Cheers
> Jon
>

Thanks a lot for your help and best regards,
Javier

[1]: http://permalink.gmane.org/gmane.linux.ports.arm.omap/92192
[2]: https://github.com/martinezjavier/linux.git
[3]: https://patchwork.kernel.org/patch/2118831/
[4]: https://patchwork.kernel.org/patch/2057111/
