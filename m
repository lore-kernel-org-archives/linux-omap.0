From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [GIT PULL] for testing: OMAP hwmod driver conversions: watchdog, UART, i2c
Date: Wed, 29 Sep 2010 13:03:49 -0700
Message-ID: <87vd5owc4a.fsf@deeprootsystems.com>
References: <8762xpenf8.fsf@deeprootsystems.com>
	<20100928201844.GI3117@atomide.com>
	<87d3rxblfu.fsf@deeprootsystems.com>
	<0680EC522D0CC943BC586913CF3768C003FF2DAF48@dbde02.ent.ti.com>
	<0680EC522D0CC943BC586913CF3768C003FF2DAF49@dbde02.ent.ti.com>
	<87bp7gz7by.fsf@deeprootsystems.com>
	<0680EC522D0CC943BC586913CF3768C003FF2DAF53@dbde02.ent.ti.com>
	<87vd5oxrr0.fsf@deeprootsystems.com>
	<0680EC522D0CC943BC586913CF3768C003FF2DAF55@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:44295 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755321Ab0I2UD4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Sep 2010 16:03:56 -0400
Received: by pwj5 with SMTP id 5so76586pwj.19
        for <linux-omap@vger.kernel.org>; Wed, 29 Sep 2010 13:03:56 -0700 (PDT)
In-Reply-To: <0680EC522D0CC943BC586913CF3768C003FF2DAF55@dbde02.ent.ti.com>
	(Rajendra Nayak's message of "Thu, 30 Sep 2010 01:24:05 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: "Raja, Govindraj" <govindraj.raja@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Varadarajan, Charulatha" <charu@ti.com>

"Nayak, Rajendra" <rnayak@ti.com> writes:

[...]

>> > Btw, the WARN's come only for UART3 and the error at hwmod init shows that
>> > maybe _wait_target_ready fails.
>> >
>> > [    0.000000] NR_IRQS:402
>> > [    0.000000] Clocking rate (Crystal/DPLL/MPU): 13.0/660/330 MHz
>> > [    0.000000] omap_hwmod: uart3: cannot be enabled (3)
>> >
>> 
>> UART3 on 24xx is in CM_IDLEST2_CORE, and the 2430 hwmod data has it in
>> CM_IDLEST1_CORE.
>> 
>> Can you test the change below?  I don't have a 2430, and it appears that
>> this is already correct in the 2420 hwmod data.
>> 
>> Kevin
>> 
>> 
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
>> index 92f4ec0..5b61f7c 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
>> @@ -449,9 +449,9 @@ static struct omap_hwmod omap2430_uart3_hwmod = {
>>  	.prcm		= {
>>  		.omap2 = {
>>  			.module_offs = CORE_MOD,
>> -			.prcm_reg_id = 1,
>> +			.prcm_reg_id = 2,
>>  			.module_bit = OMAP24XX_EN_UART3_SHIFT,
>> -			.idlest_reg_id = 1,
>> +			.idlest_reg_id = 2,
>>  			.idlest_idle_bit = OMAP24XX_EN_UART3_SHIFT,
>>  		},
>>  	},
>
> This does seem to fix the issue on 2430. I don't see the error at hwmod init
> or the WARN's later.

Thanks for testing Rajendra,

I'll fold this into the UART hwmod data for OMAP2 since that was
originally done by me, not Govindraj.

Kevin
