From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 1/5] omap:hwmod-hwspinlock-enable
Date: Tue, 27 Jul 2010 18:05:48 +0200
Message-ID: <4C4F03DC.5070806@ti.com>
References: <1279558221-14954-1-git-send-email-h-kanigeri2@ti.com> <1279558221-14954-2-git-send-email-h-kanigeri2@ti.com> <B85A65D85D7EB246BE421B3FB0FBB59301E7DA2245@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58272 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751017Ab0G0QFy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Jul 2010 12:05:54 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301E7DA2245@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, Linux Omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Que, Simon" <sque@ti.com>

Hi Sanjeev,

On 7/27/2010 5:57 PM, Premi, Sanjeev wrote:
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org
>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kanigeri, Hari
>> Sent: Monday, July 19, 2010 10:20 PM
>> To: Linux Omap; Tony Lindgren
>> Cc: Shilimkar, Santosh; Cousson, Benoit; Que, Simon; Kanigeri, Hari
>> Subject: [PATCH 1/5] omap:hwmod-hwspinlock-enable
>>
>> From: Simon Que<sque@ti.com>
>>
>> uncomment the hwmod part for hwspinlock
>>
>> Signed-off-by: Simon Que<sque@ti.com>
>> Signed-off-by: Hari Kanigeri<h-kanigeri2@ti.com>
>> ---
>>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    2 +-
>>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> [sp] Does this patch depend upon any other patch waiting in the queue?
>       I don't see omap_hwmod_44xx_data.c on the master branch.

Yes, you need to use Kevin's pm-wip/hwmods-omap4 branch in order to get 
the OMAP4 data.

Regards,
Benoit

>
> ~sanjeev
>
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> index 03bb3db..41dc77d 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> @@ -4966,7 +4966,7 @@ static __initdata struct omap_hwmod
>> *omap44xx_hwmods[] = {
>>   /*	&omap44xx_smartreflex_iva_hwmod, */
>>   /*	&omap44xx_smartreflex_mpu_hwmod, */
>>   	/* spinlock class */
>> -/*	&omap44xx_spinlock_hwmod, */
>> +	&omap44xx_spinlock_hwmod,
>>   	/* timer class */
>>   	&omap44xx_timer1_hwmod,
>>   	&omap44xx_timer2_hwmod,
>> --
>> 1.7.0
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe
>> linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

