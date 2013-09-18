From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH] ARM: dts: igep00x0: Add pinmux configuration for MCBSP2.
Date: Wed, 18 Sep 2013 14:33:35 +0200
Message-ID: <52399D9F.6020501@baylibre.com>
References: <1378827323-15433-1-git-send-email-eballetbo@gmail.com> <CAFqH_503dztqH0XEohTyV8VCZiNHsrwk1ahKFXgz6DzKDc-fAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f48.google.com ([209.85.214.48]:62792 "EHLO
	mail-bk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752189Ab3IRMdj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Sep 2013 08:33:39 -0400
Received: by mail-bk0-f48.google.com with SMTP id my13so2752841bkb.35
        for <linux-omap@vger.kernel.org>; Wed, 18 Sep 2013 05:33:38 -0700 (PDT)
In-Reply-To: <CAFqH_503dztqH0XEohTyV8VCZiNHsrwk1ahKFXgz6DzKDc-fAQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Enric Balletbo Serra <eballetbo@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <martinez.javier@gmail.com>

Hi Enric,

On 10/09/2013 17:38, Enric Balletbo Serra wrote:
> 2013/9/10 Enric Balletbo i Serra <eballetbo@gmail.com>:
>> Add pinmux configuration for MCBSP2 connected to the TDM interface. With
>> this configuration the Headset modules works as expected.
>>
>> Signed-off-by: Enric Balletbo i Serra <eballetbo@gmail.com>
>> Acked-by: Javier Martinez Canillas <javier@dowhile0.org>
>> ---
>>   arch/arm/boot/dts/omap3-igep.dtsi | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/omap3-igep.dtsi b/arch/arm/boot/dts/omap3-igep.dtsi
>> index bc48b11..2326d11 100644
>> --- a/arch/arm/boot/dts/omap3-igep.dtsi
>> +++ b/arch/arm/boot/dts/omap3-igep.dtsi
>> @@ -48,6 +48,15 @@
>>                  >;
>>          };
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
>>          mmc1_pins: pinmux_mmc1_pins {
>>                  pinctrl-single,pins = <
>>                          0x114 (PIN_INPUT_PULLUP | MUX_MODE0)    /* sdmmc1_clk.sdmmc1_clk */
>> @@ -93,6 +102,11 @@
>>          clock-frequency = <400000>;
>>   };
>>
>> +&mcbsp2 {
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&mcbsp2_pins>;
>> +};
>> +
>>   &mmc1 {
>>         pinctrl-names = "default";
>>         pinctrl-0 = <&mmc1_pins>;
>> --
>> 1.8.1.2
>>
>
> Hi Benoit,
>
> I sent this patch some time ago to be merged as a fix for 3.11, but
> seems was not merged. Would be possible include this patch in these
> series ?

I'm really sorry I missed that one :-(
I'm applying it right now, and will update my pull request.

Thanks,
Benoit


