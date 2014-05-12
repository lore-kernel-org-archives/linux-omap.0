From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH v4 3/6] ARM: dts: dra7: add support for parallel NAND flash
Date: Mon, 12 May 2014 10:49:58 +0200
Message-ID: <CABxcv==SGZ1fReXkgT769Z70ek_guMVn6nSK0FFgzjoksLGBrw@mail.gmail.com>
References: <1399668412-10818-1-git-send-email-pekon@ti.com>
	<CABxcv=nNuMLDCbNimWWR6yBbq3dHV6i87vBu69ZXGcYE-c9bmA@mail.gmail.com>
	<20980858CB6D3A4BAE95CA194937D5E73EACC26A@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:46536 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754366AbaELIuA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 May 2014 04:50:00 -0400
Received: by mail-wg0-f43.google.com with SMTP id l18so6383557wgh.2
        for <linux-omap@vger.kernel.org>; Mon, 12 May 2014 01:49:59 -0700 (PDT)
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EACC26A@DBDE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Pekon" <pekon@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>, linux-omap <linux-omap@vger.kernel.org>, Minal Shah <minalkshah@gmail.com>

Hello Pekon,

On Mon, May 12, 2014 at 9:03 AM, Gupta, Pekon <pekon@ti.com> wrote:
> Hello,
>
> From: Javier Martinez Canillas [mailto:javier@dowhile0.org]
>>On Fri, May 9, 2014 at 10:46 PM, Pekon Gupta <pekon@ti.com> wrote:
>>> From: Minal Shah <minalkshah@gmail.com>
> [...]
>>> +&gpmc {
>>> +       status = "okay";
>>> +       pinctrl-names = "default";
>>> +       pinctrl-0 = <&nand_flash_x16>;
>>> +       ranges = <0 0 0 0x1000000>;
>>> +       nand@0,0 {
>>> +               reg = <0 0 0x380>;
> [...]
>
>>> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
>>> index 37a0595..6af775a 100644
>>> --- a/arch/arm/boot/dts/dra7.dtsi
>>> +++ b/arch/arm/boot/dts/dra7.dtsi
>>> @@ -776,6 +776,26 @@
>>>                         interrupts = <0 343 0x4>;
>>>                         status = "disabled";
>>>                 };
>>> +
>>> +               elm: elm@48078000 {
>>> +                       compatible = "ti,am3352-elm";
>>> +                       reg = <0x48078000 0x2000>;
>>
>>It is really necessary to map all this 8 KB address space for GPMC registers?
>>
>>I don't have access to the DRA7 TRM but for example the OMAP3 TRM says
>>that the GPMC module register address space size is 16 MB while in
>>practice the registers use less than 1 KB (0..0x02d0 to be exact) so
>>in arch/arm/boot/dts/omap3.dtsi we have:
>>
> These are not GPMC registers. Platforms from OMAP4 and beyond
> (like AM335x, OMAP5) have another small hardware engine called ELM [1]
> (Error Locater Module) in addition to GPMC, which is used for detecting
> ECC errors in hardware. ELM Driver $KERNEL/drivers/mtd/devices/elm.c
>

Yes, I know what ELM is, I just made a mistake when adding my comments
inline. I actually meant the 8KB from the following device node:

> +               gpmc: gpmc@50000000 {
> +                       compatible = "ti,am3352-gpmc";
> +                       ti,hwmods = "gpmc";
> +                       reg = <0x50000000 0x2000>;
> +                       interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
> +                       gpmc,num-cs = <8>;
> +                       gpmc,num-waitpins = <2>;
> +                       #address-cells = <2>;
> +                       #size-cells = <1>;
> +                       status = "disabled";
> +               };

> However, thanks for pointing out, this address-space for ELM is incorrect.
> Last ELM register offset is 0xFC0 (ELM_ERROR_LOCATION_15_7) [1].
>

And yes, comments applies to ELM register address space as well.

>>gpmc: gpmc@6e000000 {
>>...
>>                        reg = <0x6e000000 0x02d0>;
>>...
>>};
>>
>>Shouldn't this be similar (the same?) for DRA7 GPMC device node?
>>
> Newer platforms have upgraded version of GPMC engine which supports
> BCH16 ECC scheme in hardware. Thus the GPMC address space was
> expanded to include some extra registers required for BCH16 ECC [2].
>
>

I see and did the GPMC register space became that big to need to map 8KB?

Although the smallest unit for ioremap is PAGE_SIZE and using any of
these reg sizes:

reg = <0x6e000000 0x02d0>;
reg = <0x6e000000 0x0400>;
reg = <0x6e000000 0x1000>;

in practice have the same effect, DTS should describe the hardware and
not an implementation detail so I think that we should use only the
register size that is defined in the TRM.

>
> [1] http://www.ti.com/lit/gpn/am3359    (Section 7.4 to 7.4.5)
>
> [2] http://www.ti.com/lit/gpn/am3359    (Section 7.1 to 7.1.5)
> (Though the AM335x address space mentions 0x368 as last address,
>  it should be 0x378. I have raised documentation bug for it).
>
>
> with regards, pekon

Best regards,
Javier

[0]: http://lxr.free-electrons.com/source/arch/arm/mm/ioremap.c#L334
