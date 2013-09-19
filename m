From: Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Re: [PATCH] ARM: dts: igep00x0: Add pinmux configuration for MCBSP2.
Date: Thu, 19 Sep 2013 08:31:50 +0200
Message-ID: <CAFqH_52qd3gLy8A67Xw1wXOBaChsRSMD-0k4JxC8aje7MEgXgw@mail.gmail.com>
References: <1378827323-15433-1-git-send-email-eballetbo@gmail.com>
	<CAFqH_503dztqH0XEohTyV8VCZiNHsrwk1ahKFXgz6DzKDc-fAQ@mail.gmail.com>
	<52399D9F.6020501@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:37677 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752483Ab3ISGbw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Sep 2013 02:31:52 -0400
Received: by mail-wi0-f172.google.com with SMTP id hn9so5115516wib.11
        for <linux-omap@vger.kernel.org>; Wed, 18 Sep 2013 23:31:51 -0700 (PDT)
In-Reply-To: <52399D9F.6020501@baylibre.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <martinez.javier@gmail.com>

Hi Benoit,

2013/9/18 Benoit Cousson <bcousson@baylibre.com>:
> Hi Enric,
>
>
> On 10/09/2013 17:38, Enric Balletbo Serra wrote:
>>
>> 2013/9/10 Enric Balletbo i Serra <eballetbo@gmail.com>:
>>>
>>> Add pinmux configuration for MCBSP2 connected to the TDM interface. With
>>> this configuration the Headset modules works as expected.
>>>
>>> Signed-off-by: Enric Balletbo i Serra <eballetbo@gmail.com>
>>> Acked-by: Javier Martinez Canillas <javier@dowhile0.org>
>>> ---
>>>   arch/arm/boot/dts/omap3-igep.dtsi | 14 ++++++++++++++
>>>   1 file changed, 14 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/omap3-igep.dtsi
>>> b/arch/arm/boot/dts/omap3-igep.dtsi
>>> index bc48b11..2326d11 100644
>>> --- a/arch/arm/boot/dts/omap3-igep.dtsi
>>> +++ b/arch/arm/boot/dts/omap3-igep.dtsi
>>> @@ -48,6 +48,15 @@
>>>                  >;
>>>          };
>>>
>>> +       mcbsp2_pins: pinmux_mcbsp2_pins {
>>> +               pinctrl-single,pins = <
>>> +                       0x10c (PIN_INPUT | MUX_MODE0)           /*
>>> mcbsp2_fsx.mcbsp2_fsx */
>>> +                       0x10e (PIN_INPUT | MUX_MODE0)           /*
>>> mcbsp2_clkx.mcbsp2_clkx */
>>> +                       0x110 (PIN_INPUT | MUX_MODE0)           /*
>>> mcbsp2_dr.mcbsp2.dr */
>>> +                       0x112 (PIN_OUTPUT | MUX_MODE0)          /*
>>> mcbsp2_dx.mcbsp2_dx */
>>> +               >;
>>> +       };
>>> +
>>>          mmc1_pins: pinmux_mmc1_pins {
>>>                  pinctrl-single,pins = <
>>>                          0x114 (PIN_INPUT_PULLUP | MUX_MODE0)    /*
>>> sdmmc1_clk.sdmmc1_clk */
>>> @@ -93,6 +102,11 @@
>>>          clock-frequency = <400000>;
>>>   };
>>>
>>> +&mcbsp2 {
>>> +       pinctrl-names = "default";
>>> +       pinctrl-0 = <&mcbsp2_pins>;
>>> +};
>>> +
>>>   &mmc1 {
>>>         pinctrl-names = "default";
>>>         pinctrl-0 = <&mmc1_pins>;
>>> --
>>> 1.8.1.2
>>>
>>
>> Hi Benoit,
>>
>> I sent this patch some time ago to be merged as a fix for 3.11, but
>> seems was not merged. Would be possible include this patch in these
>> series ?
>
>
> I'm really sorry I missed that one :-(
> I'm applying it right now, and will update my pull request.
>
> Thanks,
> Benoit
>

Many thanks.

Best regards,
    Enric
