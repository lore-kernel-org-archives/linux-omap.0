From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 12/18] ARM: OMAP3: PM: remove access to PRM_VOLTCTRL register
Date: Wed, 26 Mar 2014 10:00:31 +0200
Message-ID: <5332891F.9070002@ti.com>
References: <1393949958-816-1-git-send-email-t-kristo@ti.com> <1393949958-816-13-git-send-email-t-kristo@ti.com> <20140325223612.GA26395@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60226 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832AbaCZIA7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Mar 2014 04:00:59 -0400
In-Reply-To: <20140325223612.GA26395@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@linaro.org, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>

On 03/26/2014 12:36 AM, Tony Lindgren wrote:
> * Tero Kristo <t-kristo@ti.com> [140304 08:23]:
>> There is a solitary write to this register every wakeup from off-mode,
>> which isn't doing anything, so remove it.
>
> Argh, this chunk of code is for sure the the thing that's blocking all
> the voltage scaling for idle modes that twl4030 is supposed to do!
>
> AFAIK we must have AUTO_SLEEP, AUTO_RET and AUTO_OFF bits set in
> PRM_VOLTCTRL for twl4030 to scale anything. They must be set if we're
> scaling over I2C4 or using the pins as triggers. Unless these bits
> are set, VC won't send any SLEEP, RET or OFF commands.
>
> Looks like we're not even set these bits anywhere like we should?
>
> I think we should enabled these bits in vc.c init, and never clear?

The bits should be set according to the target sleep mode I believe, 
e.g. for retention we should set only AUTO_RET, and for off-mode 
AUTO_OFF. You can't have AUTO_OFF enabled if you are going to retention 
only as far as I recall, this potentially caused some problems.

-Tero

>
> Nishant and Kevin, any comments?
>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> ---
>>   arch/arm/mach-omap2/pm34xx.c |    4 ----
>>   1 file changed, 4 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
>> index 0eecf6f..2fa9478 100644
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -282,10 +282,6 @@ void omap_sram_idle(void)
>>   			omap3_sram_restore_context();
>>   			omap2_sms_restore_context();
>>   		}
>> -		if (core_next_state == PWRDM_POWER_OFF)
>> -			omap2_prm_clear_mod_reg_bits(OMAP3430_AUTO_OFF_MASK,
>> -					       OMAP3430_GR_MOD,
>> -					       OMAP3_PRM_VOLTCTRL_OFFSET);
>>   	}
>>   	omap3_intc_resume_idle();
>>
>> --
>> 1.7.9.5
>>

