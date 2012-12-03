From: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: Re: [PATCH v2 1/3] ARM/dts: omap3: Add generic DT support for IGEP
 devices
Date: Mon, 03 Dec 2012 13:16:51 +0100
Message-ID: <50BC9833.6060205@collabora.co.uk>
References: <1354270137-31538-1-git-send-email-javier.martinez@collabora.co.uk>
 <1354270137-31538-2-git-send-email-javier.martinez@collabora.co.uk>
 <50BC8685.20105@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <50BC8685.20105-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: Matthias Brugger <matthias.bgg-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Enric Balletbo i Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Enrico Butera <ebutera-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 12/03/2012 12:01 PM, Benoit Cousson wrote:
> On 11/30/2012 11:08 AM, Javier Martinez Canillas wrote:
>> Add a generic .dtsi device tree source file for the
>> common characteristics across IGEP Technology devices.
>> 
>> Signed-off-by: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
>> Acked-by: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>>  arch/arm/boot/dts/omap3-igep.dtsi |   93 +++++++++++++++++++++++++++++++++++++
>>  1 files changed, 93 insertions(+), 0 deletions(-)
>>  create mode 100644 arch/arm/boot/dts/omap3-igep.dtsi
>> 
>> diff --git a/arch/arm/boot/dts/omap3-igep.dtsi b/arch/arm/boot/dts/omap3-igep.dtsi
>> new file mode 100644
>> index 0000000..a093bff
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/omap3-igep.dtsi
>> @@ -0,0 +1,93 @@
>> +/*
>> + * Device Tree Source for IGEP Technology devices
>> + *
>> + * Copyright (C) 2012 Javier Martinez Canillas <javier-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
>> + * Copyright (C) 2012 Enric Balletbo i Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +/dts-v1/;
>> +
>> +/include/ "omap3.dtsi"
>> +
>> +/ {
>> +	memory {
>> +		device_type = "memory";
>> +		reg = <0x80000000 0x20000000>; /* 512 MB */
>> +	};
>> +
>> +	sound {
>> +		compatible = "ti,omap-twl4030";
>> +		ti,model = "igep2";
>> +		ti,mcbsp = <&mcbsp2>;
>> +		ti,codec = <&twl_audio>;
>> +	};
>> +};
>> +
>> +&omap3_pmx_core {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <
>> +		  &mcbsp2_pins
>> +	>;
> 
> Tony made a comment to avoid associating these data inside the pmx_core
> and instead do that in the dedicated device part.
>

Hi Benoit,

Thanks a lot for your feedback.

I didn't know about this convention, the OMAP mcspi1_cs2 pin is configured in
gpio_176 mode (OMAP_MUX_MODE4) because this GPIO line is used as the SMSC9221
LAN Ethernet controller IRQ.

But since the ethernet chip is connected to the OMAP3 processor thourgh its GPMC
and the DT support for GPMC is still not merged in mainline, DT support this
this pheripheral is still missing on this initial DT.

So, I'll just removes mcbsp2_pins for now and this can be added again on the
ethernet device part once support for this pheripheral is added.

>> +
>> +	uart3_pins: pinmux_uart3_pins {
>> +		pinctrl-single,pins = <
>> +			0x16e 0x100	/* uart3_rx.uart3_rx INPUT | MODE0 */
>> +			0x170 0		/* uart3_tx.uart3_tx OUTPUT | MODE0 */
>> +		>;
>> +	};
>> +
>> +	mcbsp2_pins: pinmux_mcbsp2_pins {
>> +		pinctrl-single,pins = <
>> +			0x1a2 0x0104	/* mcspi1_cs2.gpio_176 INPUT | MODE4 */
>> +		>;
>> +	};
> 
> BTW, in this case, the UART3 does not seems to have any connection with
> the pins settings. Sine your don't have it in the pmx_core you should
> have it in side the UART3 node.
> 
> &uart3 {
> 	pinctrl-names = "default";
> 	pinctrl-0 = <&uart3_pins>;
> };
> 

Yes, I missed that. Thanks for pointing this out.

> The rational is that, the mux will be done only if the driver is probed
> and not unconditionally during pmx_core probe like it will be the case
> otherwise.
> 
> Regards,
> Benoit
> 
> 

I'll post a v3 with your suggestions.

Thanks a lot and best regards,
Javier
