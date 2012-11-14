From: Nishanth Menon <nm@ti.com>
Subject: Re: AM335x: Beaglebone stops to boot with current git kernel
Date: Wed, 14 Nov 2012 10:54:31 -0600
Message-ID: <50A3CCC7.5070506@ti.com>
References: <k80da6$61d$1@ger.gmane.org> <CAORVsuV7y_A4m+pHPoQ9a=Q7b4j-fCutJAFA1L+bqp4BV3kmFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54348 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422826Ab2KNQyd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Nov 2012 11:54:33 -0500
In-Reply-To: <CAORVsuV7y_A4m+pHPoQ9a=Q7b4j-fCutJAFA1L+bqp4BV3kmFg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: i.mazanov@gmail.com, linux-omap@vger.kernel.org

On 11/14/2012 10:41 AM, Jean Pihet wrote:
> Hi,
>
> On Wed, Nov 14, 2012 at 4:28 PM, Igor Mazanov <i.mazanov@gmail.com> wrote:
>> Hello,
>>
>> Beaglebone boot process is broken with the current git kernel. I use
>> omap2plus_defconfig for tests.
>>
>> It looks like the boot process stops due to the last changes in the AM33xx
>> clock sysbsystem. A following patch resolves this issue:
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
>> b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
>> index ad8d43b..858e180 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
>> @@ -586,7 +586,7 @@ static struct omap_hwmod am33xx_smartreflex0_hwmod = {
>>          .class          = &am33xx_smartreflex_hwmod_class,
>>          .clkdm_name     = "l4_wkup_clkdm",
>>          .mpu_irqs       = am33xx_smartreflex0_irqs,
>> -       .main_clk       = "smartreflex0_fck",
>> +       .main_clk       = "smartreflex_mpu_fck",
>>          .prcm           = {
>>                  .omap4  = {
>>                          .clkctrl_offs   =
>> AM33XX_CM_WKUP_SMARTREFLEX0_CLKCTRL_OFFSET,
>> @@ -606,7 +606,7 @@ static struct omap_hwmod am33xx_smartreflex1_hwmod = {
>>          .class          = &am33xx_smartreflex_hwmod_class,
>>          .clkdm_name     = "l4_wkup_clkdm",
>>          .mpu_irqs       = am33xx_smartreflex1_irqs,
>> -       .main_clk       = "smartreflex1_fck",
>> +       .main_clk       = "smartreflex_core_fck",
>>          .prcm           = {
>>                  .omap4  = {
>>                          .clkctrl_offs   =
>> AM33XX_CM_WKUP_SMARTREFLEX1_CLKCTRL_OFFSET,
>>
>
> About the name field in the hwmod entry: the SR code checks on the
> value of "smartreflex_mpu_iva" to differentiate the SR IP blocks and
> to apply the correct parameters to each of them. Cf. the function
> sr_set_regfields in drivers/power/avs/smartreflex.c.
>
> The patch should change the name of the hwmod entry as well, can you
> fold this change in the current patch?
>
> Note: I know the name "smartreflex_mpu_iva" is not perfect since it
> does not apply to all OMAP3 variants, maybe we could change the SR
> code to be more generic.
>
> Nishant, what do you think?
>
Might be an better idea to remove the entire function sr_set_regfields 
instead provide the err_weight, max_limit, accum_data, avgweights to 
platform_data.
--
Regards,
Nishanth Menon
