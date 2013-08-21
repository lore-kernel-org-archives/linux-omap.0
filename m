From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH] arm: omap5: hwmod: add missing ocp2scp hwmod data
Date: Wed, 21 Aug 2013 11:46:15 +0200
Message-ID: <52148C67.3080106@baylibre.com>
References: <1373642066-5235-1-git-send-email-balbi@ti.com> <20130821074728.GV7656@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f171.google.com ([209.85.215.171]:45566 "EHLO
	mail-ea0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751928Ab3HUJqT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Aug 2013 05:46:19 -0400
Received: by mail-ea0-f171.google.com with SMTP id n15so112086ead.16
        for <linux-omap@vger.kernel.org>; Wed, 21 Aug 2013 02:46:18 -0700 (PDT)
In-Reply-To: <20130821074728.GV7656@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

On 21/08/2013 09:47, Tony Lindgren wrote:
> Benoit,
>
> Got this one queued up somewhere?

No yet. That's the only hwmod patch I have so far.
I'll put it in a branch and send you the pull-request ASAP.

Regards,
Benoit

>
> * Felipe Balbi <balbi@ti.com> [130712 08:21]:
>> From: Benoit Cousson <benoit.cousson@linaro.org>
>>
>> without that hwmod data, USB3 will not in OMAP5 boards.
>>
>> While at that, also fix DTS data to pass reg property,
>> otherwise driver won't probe.
>>
>> Signed-off-by: Benoit Cousson <benoit.cousson@linaro.org>
>> Signed-off-by: Felipe Balbi <balbi@ti.com>
>> ---
>>
>> tested on OMAP5 uEVM. Gets rid of a data abort when USB3
>> is enabled. There still some other patches missing to get
>> USB3 working out of the box, but that's on Palmas and will
>> come as soon as I get those ready.
>>
>> This is already on step forward.
>>
>>   arch/arm/boot/dts/omap5.dtsi               |  3 +-
>>   arch/arm/mach-omap2/omap_hwmod_54xx_data.c | 45 ++++++++++++++++++++++++++++++
>>   2 files changed, 47 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
>> index da41d70..a0de586 100644
>> --- a/arch/arm/boot/dts/omap5.dtsi
>> +++ b/arch/arm/boot/dts/omap5.dtsi
>> @@ -654,10 +654,11 @@
>>   			};
>>   		};
>>
>> -		ocp2scp {
>> +		ocp2scp@4a080000 {
>>   			compatible = "ti,omap-ocp2scp";
>>   			#address-cells = <1>;
>>   			#size-cells = <1>;
>> +			reg = <0x4a080000 0x20>;
>>   			ranges;
>>   			ti,hwmods = "ocp2scp1";
>>   			usb2_phy: usb2phy@4a084000 {
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
>> index 2435109..d9118a1 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
>> @@ -1105,6 +1105,42 @@ static struct omap_hwmod omap54xx_mpu_hwmod = {
>>   };
>>
>>   /*
>> + * 'ocp2scp' class
>> + * bridge to transform ocp interface protocol to scp (serial control port)
>> + * protocol
>> + */
>> +
>> +static struct omap_hwmod_class_sysconfig omap54xx_ocp2scp_sysc = {
>> +	.rev_offs	= 0x0000,
>> +	.sysc_offs	= 0x0010,
>> +	.syss_offs	= 0x0014,
>> +	.sysc_flags	= (SYSC_HAS_AUTOIDLE | SYSC_HAS_SIDLEMODE |
>> +			SYSC_HAS_SOFTRESET | SYSS_HAS_RESET_STATUS),
>> +	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
>> +	.sysc_fields	= &omap_hwmod_sysc_type1,
>> +};
>> +
>> +static struct omap_hwmod_class omap54xx_ocp2scp_hwmod_class = {
>> +	.name	= "ocp2scp",
>> +	.sysc	= &omap54xx_ocp2scp_sysc,
>> +};
>> +
>> +/* ocp2scp1 */
>> +static struct omap_hwmod omap54xx_ocp2scp1_hwmod = {
>> +	.name		= "ocp2scp1",
>> +	.class		= &omap54xx_ocp2scp_hwmod_class,
>> +	.clkdm_name	= "l3init_clkdm",
>> +	.main_clk	= "l4_root_clk_div",
>> +	.prcm = {
>> +		.omap4 = {
>> +			.clkctrl_offs = OMAP54XX_CM_L3INIT_OCP2SCP1_CLKCTRL_OFFSET,
>> +			.context_offs = OMAP54XX_RM_L3INIT_OCP2SCP1_CONTEXT_OFFSET,
>> +			.modulemode   = MODULEMODE_HWCTRL,
>> +		},
>> +	},
>> +};
>> +
>> +/*
>>    * 'timer' class
>>    * general purpose timer module with accurate 1ms tick
>>    * This class contains several variants: ['timer_1ms', 'timer']
>> @@ -1900,6 +1936,14 @@ static struct omap_hwmod_ocp_if omap54xx_l4_cfg__mpu = {
>>   	.user		= OCP_USER_MPU | OCP_USER_SDMA,
>>   };
>>
>> +/* l4_cfg -> ocp2scp1 */
>> +static struct omap_hwmod_ocp_if omap54xx_l4_cfg__ocp2scp1 = {
>> +	.master		= &omap54xx_l4_cfg_hwmod,
>> +	.slave		= &omap54xx_ocp2scp1_hwmod,
>> +	.clk		= "l4_root_clk_div",
>> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
>> +};
>> +
>>   /* l4_wkup -> timer1 */
>>   static struct omap_hwmod_ocp_if omap54xx_l4_wkup__timer1 = {
>>   	.master		= &omap54xx_l4_wkup_hwmod,
>> @@ -2102,6 +2146,7 @@ static struct omap_hwmod_ocp_if *omap54xx_hwmod_ocp_ifs[] __initdata = {
>>   	&omap54xx_l4_per__mmc4,
>>   	&omap54xx_l4_per__mmc5,
>>   	&omap54xx_l4_cfg__mpu,
>> +	&omap54xx_l4_cfg__ocp2scp1,
>>   	&omap54xx_l4_wkup__timer1,
>>   	&omap54xx_l4_per__timer2,
>>   	&omap54xx_l4_per__timer3,
>> --
>> 1.8.2.1
>>

