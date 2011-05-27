From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RFC][PATCH 3/9] OMAP4460: HWMOD: DO not reset GPIO1 during HWMOD
 init
Date: Fri, 27 May 2011 09:10:05 +0200
Message-ID: <4DDF4E4D.6060008@ti.com>
References: <1306375016-707-1-git-send-email-nm@ti.com>	<1306375016-707-4-git-send-email-nm@ti.com> <87oc2p82q0.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44930 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753018Ab1E0HKJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 May 2011 03:10:09 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p4R7A89k023988
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 27 May 2011 02:10:08 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep34.itg.ti.com (8.13.7/8.13.8) with ESMTP id p4R7A8IY004666
	for <linux-omap@vger.kernel.org>; Fri, 27 May 2011 02:10:08 -0500 (CDT)
In-Reply-To: <87oc2p82q0.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "Menon, Nishanth" <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "Sonasath, Moiz" <m-sonasath@ti.com>

On 5/27/2011 1:24 AM, Hilman, Kevin wrote:
> Nishanth Menon<nm@ti.com>  writes:
>
>> From: Moiz Sonasath<m-sonasath@ti.com>
>>
>> For OMAP4460, GPIO-7 of bank1 is used for controling
>> the TPS modes, hence GPIO1 should not be reset
>> during init as reset will cause the TPS voltage to
>> drop to 0.9 V.
>
> ouch.  I knew one of these days something like this was going to happen
> with GPIO resets.

BTW, don't we have the same kind of issue with the debug UART? I 
remember that you had to do some hacks at some point to change these 
hwmod flags in the UART code.

In general we do not want to reset nor idle an IP that was potentially 
already properly configured by bootloader or early Linux boot code.

Regards,
Benoit

>
> Re: $SUBJECT, hwmod is not an acronym.  Please use lower case.
>
>> Originally from:
>> http://git.omapzoom.org/?p=kernel/omap.git;a=commitdiff;h=52ae4f0de03b17c064d9ce90a580230f1a596ec1
>>
>> [nm@ti.com: upstream version]
>> Signed-off-by: Nishanth Menon<nm@ti.com>
>> Signed-off-by: Moiz Sonasath<m-sonasath@ti.com>
>> ---
>>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   27 ++++++++++++++++++++++++---
>>   1 files changed, 24 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> index 2f51a5a..27319c4 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> @@ -1745,7 +1745,7 @@ static struct omap_hwmod_opt_clk gpio1_opt_clks[] = {
>>   	{ .role = "dbclk", .clk = "gpio1_dbclk" },
>>   };
>>
>> -static struct omap_hwmod omap44xx_gpio1_hwmod = {
>> +static struct omap_hwmod omap443x_gpio1_hwmod = {
>>   	.name		= "gpio1",
>>   	.class		=&omap44xx_gpio_hwmod_class,
>>   	.mpu_irqs	= omap44xx_gpio1_irqs,
>> @@ -1761,7 +1761,27 @@ static struct omap_hwmod omap44xx_gpio1_hwmod = {
>>   	.dev_attr	=&gpio_dev_attr,
>>   	.slaves		= omap44xx_gpio1_slaves,
>>   	.slaves_cnt	= ARRAY_SIZE(omap44xx_gpio1_slaves),
>> -	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
>> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
>> +};
>> +
>> +static struct omap_hwmod omap446x_gpio1_hwmod = {
>> +	.name		= "gpio1",
>> +	.class		=&omap44xx_gpio_hwmod_class,
>> +	.flags          = HWMOD_INIT_NO_RESET,
>> +	.mpu_irqs	= omap44xx_gpio1_irqs,
>> +	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_gpio1_irqs),
>> +	.main_clk	= "gpio1_ick",
>> +	.prcm = {
>> +		.omap4 = {
>> +			.clkctrl_reg = OMAP4430_CM_WKUP_GPIO1_CLKCTRL,
>> +		},
>> +	},
>> +	.opt_clks	= gpio1_opt_clks,
>> +	.opt_clks_cnt	= ARRAY_SIZE(gpio1_opt_clks),
>> +	.dev_attr	=&gpio_dev_attr,
>> +	.slaves		= omap44xx_gpio1_slaves,
>> +	.slaves_cnt	= ARRAY_SIZE(omap44xx_gpio1_slaves),
>> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4460),
>>   };
>
> This is a board-specific problem that you've "fixed" in a way that
> affects every 4460-based device.
>
> Rather than setting the flag in the hwmod data, you need to fix this
> in a board-specific way.
>
> The hwmod layer provides an API for this: omap_hwmod_no_setup_reset()
> which should be called by board-specific code.
>
> Kevin
>
>>   /* gpio2 */
>> @@ -5079,7 +5099,8 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
>>   	&omap44xx_dss_venc_hwmod,
>>
>>   	/* gpio class */
>> -	&omap44xx_gpio1_hwmod,
>> +	&omap443x_gpio1_hwmod,
>> +	&omap446x_gpio1_hwmod,
>>   	&omap44xx_gpio2_hwmod,
>>   	&omap44xx_gpio3_hwmod,
>>   	&omap44xx_gpio4_hwmod,
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

