From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv3] arm: dts: am43x-clock: add tbclk data for ehrpwm.
Date: Mon, 5 May 2014 10:49:38 +0300
Message-ID: <53674292.5050008@ti.com>
References: <1398780946-31453-1-git-send-email-sourav.poddar@ti.com> <535FBC62.9050902@ti.com> <20140501190015.5739.86963@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55918 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754777AbaEEHtb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 May 2014 03:49:31 -0400
In-Reply-To: <20140501190015.5739.86963@quantum>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>, Sourav Poddar <sourav.poddar@ti.com>, tony@atomide.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, balbi@ti.com

On 05/01/2014 10:00 PM, Mike Turquette wrote:
> Quoting Tero Kristo (2014-04-29 07:51:14)
>> On 04/29/2014 05:15 PM, Sourav Poddar wrote:
>>> We need "tbclk" clock data for the functioning of ehrpwm
>>> module. Hence, populating the required clock information
>>> in clock dts file.
>>>
>>> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
>>
>> Acked-by: Tero Kristo <t-kristo@ti.com>
>
> Looks good to me.
>
> Tero, just to be clear, are you planning on batching up OMAPish clock
> patches and sending a pull request (once they have been reviewed on the
> list)?

No, I haven't been planning on sending a pull-req, as I believe you 
still want to ack the TI related clock driver patches yourself also. If 
you want to change the setup I am of course willing to negotiate the 
terms. :)

-Tero

>
> Thanks,
> Mike
>
>>
>>
>>> ---
>>> v2->v3
>>> - correct bitshifting
>>>
>>>    arch/arm/boot/dts/am43xx-clocks.dtsi |   48 ++++++++++++++++++++++++++++++++++
>>>    drivers/clk/ti/clk-43xx.c            |    6 +++++
>>>    2 files changed, 54 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/am43xx-clocks.dtsi b/arch/arm/boot/dts/am43xx-clocks.dtsi
>>> index 142009c..42d7b1f 100644
>>> --- a/arch/arm/boot/dts/am43xx-clocks.dtsi
>>> +++ b/arch/arm/boot/dts/am43xx-clocks.dtsi
>>> @@ -87,6 +87,54 @@
>>>                clock-mult = <1>;
>>>                clock-div = <1>;
>>>        };
>>> +
>>> +     ehrpwm0_tbclk: ehrpwm0_tbclk {
>>> +             #clock-cells = <0>;
>>> +             compatible = "ti,gate-clock";
>>> +             clocks = <&dpll_per_m2_ck>;
>>> +             ti,bit-shift = <0>;
>>> +             reg = <0x0664>;
>>> +     };
>>> +
>>> +     ehrpwm1_tbclk: ehrpwm1_tbclk {
>>> +             #clock-cells = <0>;
>>> +             compatible = "ti,gate-clock";
>>> +             clocks = <&dpll_per_m2_ck>;
>>> +             ti,bit-shift = <1>;
>>> +             reg = <0x0664>;
>>> +     };
>>> +
>>> +     ehrpwm2_tbclk: ehrpwm2_tbclk {
>>> +             #clock-cells = <0>;
>>> +             compatible = "ti,gate-clock";
>>> +             clocks = <&dpll_per_m2_ck>;
>>> +             ti,bit-shift = <2>;
>>> +             reg = <0x0664>;
>>> +     };
>>> +
>>> +     ehrpwm3_tbclk: ehrpwm3_tbclk {
>>> +             #clock-cells = <0>;
>>> +             compatible = "ti,gate-clock";
>>> +             clocks = <&dpll_per_m2_ck>;
>>> +             ti,bit-shift = <4>;
>>> +             reg = <0x0664>;
>>> +     };
>>> +
>>> +     ehrpwm4_tbclk: ehrpwm4_tbclk {
>>> +             #clock-cells = <0>;
>>> +             compatible = "ti,gate-clock";
>>> +             clocks = <&dpll_per_m2_ck>;
>>> +             ti,bit-shift = <5>;
>>> +             reg = <0x0664>;
>>> +     };
>>> +
>>> +     ehrpwm5_tbclk: ehrpwm5_tbclk {
>>> +             #clock-cells = <0>;
>>> +             compatible = "ti,gate-clock";
>>> +             clocks = <&dpll_per_m2_ck>;
>>> +             ti,bit-shift = <6>;
>>> +             reg = <0x0664>;
>>> +     };
>>>    };
>>>    &prcm_clocks {
>>>        clk_32768_ck: clk_32768_ck {
>>> diff --git a/drivers/clk/ti/clk-43xx.c b/drivers/clk/ti/clk-43xx.c
>>> index 67c8de5..527a43d 100644
>>> --- a/drivers/clk/ti/clk-43xx.c
>>> +++ b/drivers/clk/ti/clk-43xx.c
>>> @@ -105,6 +105,12 @@ static struct ti_dt_clk am43xx_clks[] = {
>>>        DT_CLK(NULL, "func_12m_clk", "func_12m_clk"),
>>>        DT_CLK(NULL, "vtp_clk_div", "vtp_clk_div"),
>>>        DT_CLK(NULL, "usbphy_32khz_clkmux", "usbphy_32khz_clkmux"),
>>> +     DT_CLK("48300200.ehrpwm", "tbclk", "ehrpwm0_tbclk"),
>>> +     DT_CLK("48302200.ehrpwm", "tbclk", "ehrpwm1_tbclk"),
>>> +     DT_CLK("48304200.ehrpwm", "tbclk", "ehrpwm2_tbclk"),
>>> +     DT_CLK("48306200.ehrpwm", "tbclk", "ehrpwm3_tbclk"),
>>> +     DT_CLK("48308200.ehrpwm", "tbclk", "ehrpwm4_tbclk"),
>>> +     DT_CLK("4830a200.ehrpwm", "tbclk", "ehrpwm5_tbclk"),
>>>        { .node_name = NULL },
>>>    };
>>>
>>>
>>

