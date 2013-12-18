From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH] ARM: dts: Add support for sbc-3xxx with cm-t3730
Date: Wed, 18 Dec 2013 10:45:00 +0200
Message-ID: <52B1608C.3010709@compulab.co.il>
References: <1386962541-18498-1-git-send-email-tony@atomide.com> <52AF065A.4010205@compulab.co.il> <20131216191754.GD26293@atomide.com> <52AFF9D0.5080400@compulab.co.il> <20131217193134.GB27438@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:34111 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752915Ab3LRIps (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Dec 2013 03:45:48 -0500
In-Reply-To: <20131217193134.GB27438@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Dmitry Lifshitz <lifshitz@compulab.co.il>, Nikita Kiryanov <nikita@compulab.co.il>

On 12/17/13 21:31, Tony Lindgren wrote:
> * Igor Grinberg <grinberg@compulab.co.il> [131216 23:16]:
>> On 12/16/13 21:17, Tony Lindgren wrote:
>>> * Igor Grinberg <grinberg@compulab.co.il> [131216 05:57]:
>>>> On 12/13/13 21:22, Tony Lindgren wrote:

[...]

>  
>> I think we can drop the different memory sizes and
>> let boot loader adjust the blob. This will make the list shorter:
>> omap3-cm-t3x.dtsi	- common to cm-t3x cpu boards
>> omap3-cm-t3x30.dtsi	- common to cm-t3730 and cm-t3530
>> omap3-cm-t3730.dtsi	- cm-t3730 specific
>> omap3-cm-t3530.dtsi	- cm-t3530 specific
>> omap3-cm-t3517.dtsi	- cm-t3517 specific
>> omap3-sb-t35.dtsi	- sb-t35 specific
>> omap3-cb-t3.dtsi	- cb-t3 specific
>> omap3-sbc-t3730.dts	- sb-t35 with cm-t3730 and default memory size
>> omap3-sbc-t3530.dts	- sb-t35 with cm-t3530 and default memory size
>> omap3-sbc-t3517.dts	- sb-t35 with cm-t3517 and default memory size
>> omap3-em-t3730.dts	- cb-t3 with cm-t3730 and default memory size
>> omap3-em-t3530.dts	- cb-t3 with cm-t3530 and default memory size
>>
>> So what do you think?
>  
> Makes sense to me. I've updated the patch below to use the following:
> 
> omap3-cm-t3x30.dtsi	- common to cm-t3730 and cm-t3530
> omap3-cm-t3730.dts	- cm-t3730 specific, should work on it's own too, not a .dtsi
> omap3-sb-t35.dtsi	- sb-t35 specific
> omap3-sbc-t3730.dts	- sb-t35 with cm-t3730 and default memory size
> 
> So the only changes compared to your naming are to not use .dtsi
> extension for omap3-cm-t3730.dts, and I did not add omap3-cm-t3x.dtsi
> as I don't know the details.

Ok.

> 
> It's probably best that you guys take over this patch from here and
> add omap3-cm-t3x30.dtsi if needed.

Ok.

> 
> I got the basic stuff working for what I need right now for my router
> to work, which is MMC, both Ethernet controllers and wl12xx. So I'm
> not going to tweak this patch further. Of course having the battery
> charging working would be nice for a router to have a backup battery :)
> 
> There are still some issues I've noticed:
> 
> 1. Removing and reinserting the wl12xx modules seems to kill the
>    WLAN
> 
> 2. Ethernet interfaces only come up if there's a cable connected

I see. Ok then, we'll try to figure those things out.

[...]

>>>>> +	mmc2_pins: pinmux_mmc2_pins {
>>>>> +		pinctrl-single,pins = <
>>>>> +			0x128 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_clk.sdmmc2_clk */
>>>>> +			0x12a (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_cmd.sdmmc2_cmd */
>>>>> +			0x12c (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat0.sdmmc2_dat0 */
>>>>> +			0x12e (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat1.sdmmc2_dat1 */
>>>>> +			0x130 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat2.sdmmc2_dat2 */
>>>>> +			0x132 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc2_dat3.sdmmc2_dat3 */
>>>>
>>>> Here the following is missing:
>>>> 0x134 (PIN_OUTPUT | MUX_MODE1)	/* sdmmc2_dat4.sdmmc2_dir_dat0 */
>>>
>>> That seems to be used for the wl12xx GPIO, so it's listed at
>>> wl12xx_gpio below.
>>
>> Yes, but only on cm-t3730 (and actually starting from revision 1.2),
>> not cm-t3530...
> 
> Sounds like that needs another set of .dts files, or patching in the
> bootloader. 

Yep, IMO, .dts will be better, as I think pinmux is something
the kernel should be aware of...

[...]

> 8< ----------------------------------
> From: Tony Lindgren <tony@atomide.com>
> Date: Tue, 10 Dec 2013 15:03:34 -0800
> Subject: [PATCH] ARM: dts: Add support for sbc-3xxx with cm-t3730
> 
> This adds support for CompuLab SBC-T3530, also known as cm-t3730:
> 
> http://compulab.co.il/products/sbcs/sbc-t3530/
> 
> It seems that with the sbc-3xxx mainboard is also used on
> SBC-T3517 and SBC-T3730 with just a different CPU module:
> 
> http://compulab.co.il/products/sbcs/sbc-t3517/
> http://compulab.co.il/products/sbcs/sbc-t3730/
> 
> So let's add a common omap3-sb-t35.dtsi and then separate SoC
> specific omap3-sbc-t3730.dts, omap3-sbc-t3530.dts and
> omap3-sbc-t3517.dts.
> 
> I've tested this with SBC-T3730 as that's the only one I have.
> At least serial, both Ethernet controllers, MMC, and wl12xx WLAN
> work.
> 
> Note that WLAN seems to be different for SBC-T3530. And SBC-T3517
> may need some changes for the EMAC Ethernet if that's used
> instead of the smsc911x.
> 
> Cc: devicetree@vger.kernel.org
> Cc: Igor Grinberg <grinberg@compulab.co.il>
> Cc: Mike Rapoport <mike@compulab.co.il>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Acked-by: Igor Grinberg <grinberg@compulab.co.il>

This one looks great!
Really minor comments below (we can fix those later)

[...]

> diff --git a/arch/arm/boot/dts/omap3-cm-t3730.dts b/arch/arm/boot/dts/omap3-cm-t3730.dts
> new file mode 100644
> index 0000000..80cf668
> --- /dev/null
> +++ b/arch/arm/boot/dts/omap3-cm-t3730.dts

[...]

> +&mmc1 {
> +	vmmc-supply = <&vmmc1>;
> +	vmmc_aux-supply = <&vsim>;

vsim is not present in TPS65930...
can be just left empty or set to a fixed voltage regulator.

> +	bus-width = <4>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc1_pins>;
> +};

[...]

> diff --git a/arch/arm/boot/dts/omap3-cm-t3x30.dtsi b/arch/arm/boot/dts/omap3-cm-t3x30.dtsi
> new file mode 100644
> index 0000000..bf1b72c
> --- /dev/null
> +++ b/arch/arm/boot/dts/omap3-cm-t3x30.dtsi

[...]

> +&i2c1 {
> +	clock-frequency = <2600000>;

There is also an EEPROM on this bus, although we still don't
have it registered in the dts, but it can be registered from
userspace and is also accessible using i2c-tools.
This should be 400KHz max for the EEPROM to work.

> +
> +	twl: twl@48 {
> +		reg = <0x48>;
> +		interrupts = <7>; /* SYS_NIRQ cascaded to intc */
> +		interrupt-parent = <&intc>;
> +	};
> +};

[...]


-- 
Regards,
Igor.
