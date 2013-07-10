From: Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Re: [PATCH] ARM: dts: igep00x0: Add pinmux configuration for MCBSP2.
Date: Wed, 10 Jul 2013 10:07:22 +0200
Message-ID: <CAFqH_50ud=SFEe=9ctfdMPV5XP5HuS5068yiea0BSFZqEiOf6g@mail.gmail.com>
References: <CABxcv=mfOhZFG4yE7LG9FdGyz0bhN0qPB4ZTD4hTknAygWGs8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:52526 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751087Ab3GJIHX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Jul 2013 04:07:23 -0400
Received: by mail-wi0-f172.google.com with SMTP id c10so11123061wiw.5
        for <linux-omap@vger.kernel.org>; Wed, 10 Jul 2013 01:07:22 -0700 (PDT)
In-Reply-To: <CABxcv=mfOhZFG4yE7LG9FdGyz0bhN0qPB4ZTD4hTknAygWGs8A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: =?UTF-8?Q?Beno=C3=AEt_Cousson?= <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

Hi Benoit,

2013/7/6 Javier Martinez Canillas <javier@dowhile0.org>:
> On Fri, Jul 5, 2013 at 11:38 PM, Enric Balletbo i Serra
> <eballetbo@gmail.com> wrote:
>> IGEP Processor Boards based on OMAP3 have the MCBSP2 connected to the TDM
>> interface. The kernel should configure the pinmux for these pins in order
>> to get TWL4030 codec working. Without this, for example, playing a wav file
>> doesn't work.
>>
>> Signed-off-by: Enric Balletbo i Serra <eballetbo@gmail.com>
>> ---
>>  arch/arm/boot/dts/omap3-igep.dtsi | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/omap3-igep.dtsi b/arch/arm/boot/dts/omap3-igep.dtsi
>> index bc48b11..2326d11 100644
>> --- a/arch/arm/boot/dts/omap3-igep.dtsi
>> +++ b/arch/arm/boot/dts/omap3-igep.dtsi
>> @@ -48,6 +48,15 @@
>>                 >;
>>         };
>>
>> +       mcbsp2_pins: pinmux_mcbsp2_pins {
>> +               pinctrl-single,pins = <
>> +                       0x10c (PIN_INPUT | MUX_MODE0)           /* mcbsp2_fsx.mcbsp2_fsx */
>> +                       0x10e (PIN_INPUT | MUX_MODE0)           /* mcbsp2_clkx.mcbsp2_clkx */
>> +                       0x110 (PIN_INPUT | MUX_MODE0)           /* mcbsp2_dr.mcbsp2.dr */
>> +                       0x112 (PIN_OUTPUT | MUX_MODE0)          /* mcbsp2_dx.mcbsp2_dx */
>> +               >;
>> +       };
>> +
>>         mmc1_pins: pinmux_mmc1_pins {
>>                 pinctrl-single,pins = <
>>                         0x114 (PIN_INPUT_PULLUP | MUX_MODE0)    /* sdmmc1_clk.sdmmc1_clk */
>> @@ -93,6 +102,11 @@
>>         clock-frequency = <400000>;
>>  };
>>
>> +&mcbsp2 {
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&mcbsp2_pins>;
>> +};
>> +
>>  &mmc1 {
>>        pinctrl-names = "default";
>>        pinctrl-0 = <&mmc1_pins>;
>> --
>> 1.8.1.2
>>
>
> Acked-by: Javier Martinez Canillas <javier@dowhile0.org>

As this is a fix and without this the audio interface doesn't work,
it's possible to add this patch  for v3.11 merge window ?

Thanks,
    Enric
