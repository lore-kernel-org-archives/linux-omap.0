From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH/RFT 3/3] ARM: OMAP3: PM: cleanup cam_pwrdm leftovers
Date: Fri, 27 Apr 2012 13:18:23 -0700
Message-ID: <8762cl53ow.fsf@ti.com>
References: <1335277420-29124-1-git-send-email-khilman@ti.com>
	<1335277420-29124-4-git-send-email-khilman@ti.com>
	<1335511214.2149.136.camel@sokoban>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:49976 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757651Ab2D0USX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Apr 2012 16:18:23 -0400
Received: by pbcup15 with SMTP id up15so1255042pbc.28
        for <linux-omap@vger.kernel.org>; Fri, 27 Apr 2012 13:18:22 -0700 (PDT)
In-Reply-To: <1335511214.2149.136.camel@sokoban> (Tero Kristo's message of
	"Fri, 27 Apr 2012 10:20:14 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: t-kristo@ti.com
Cc: linux-omap@vger.kernel.org, Jean Pihet <jean.pihet@newoldbits.com>, Paul Walmsley <paul@pwsan.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Tero Kristo <t-kristo@ti.com> writes:

> Looks good to me, acked.

Thanks.

Kevin

>
> On Tue, 2012-04-24 at 07:23 -0700, Kevin Hilman wrote:
>> commit e7410cf7 (02fdb03e69699f26e1370d0e51593dbc8a4e5265) moved
>> mangement of cam_pwrdm to CPUidle but left some remnants behind,
>> namely the call to clkcm_allo_idle() for the clockdomains in the MPU
>> pwrdm.  Remove these since they are not necessary and cause unwanted
>> latency in the idle path.
>> 
>> Cc: Tero Kristo <Tero Kristo <t-kristo@ti.com>
>> Signed-off-by: Kevin Hilman <khilman@ti.com>
>> ---
>>  arch/arm/mach-omap2/pm34xx.c |    4 ----
>>  1 file changed, 4 deletions(-)
>> 
>> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
>> index 74a7f8c..66ff828 100644
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -70,7 +70,6 @@ void (*omap3_do_wfi_sram)(void);
>>  
>>  static struct powerdomain *mpu_pwrdm, *neon_pwrdm;
>>  static struct powerdomain *core_pwrdm, *per_pwrdm;
>> -static struct powerdomain *cam_pwrdm;
>>  
>>  static void omap3_enable_io_chain(void)
>>  {
>> @@ -395,8 +394,6 @@ void omap_sram_idle(void)
>>  
>>  	if (mpu_next_state < PWRDM_POWER_ON)
>>  		pwrdm_post_transition(mpu_pwrdm);
>> -
>> -	clkdm_allow_idle(mpu_pwrdm->pwrdm_clkdms[0]);
>>  }
>>  
>>  static void omap3_pm_idle(void)
>> @@ -759,7 +756,6 @@ static int __init omap3_pm_init(void)
>>  	neon_pwrdm = pwrdm_lookup("neon_pwrdm");
>>  	per_pwrdm = pwrdm_lookup("per_pwrdm");
>>  	core_pwrdm = pwrdm_lookup("core_pwrdm");
>> -	cam_pwrdm = pwrdm_lookup("cam_pwrdm");
>>  
>>  	neon_clkdm = clkdm_lookup("neon_clkdm");
>>  	mpu_clkdm = clkdm_lookup("mpu_clkdm");
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
