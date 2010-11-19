From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 09/13] OMAP3: PM: Apply errata i540 before save secure
 ram
Date: Fri, 19 Nov 2010 11:18:46 -0600
Message-ID: <4CE6B176.10204@ti.com>
References: <1290131698-6194-1-git-send-email-nm@ti.com>	<1290131698-6194-10-git-send-email-nm@ti.com> <87sjyxb5gh.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:43031 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755360Ab0KSRSv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Nov 2010 12:18:51 -0500
Received: by mail-vw0-f53.google.com with SMTP id 8so258880vws.12
        for <linux-omap@vger.kernel.org>; Fri, 19 Nov 2010 09:18:50 -0800 (PST)
In-Reply-To: <87sjyxb5gh.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Jean Pihet <jean.pihet@newoldbits.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Tony <tony@atomide.com>

Kevin Hilman had written, on 11/19/2010 11:15 AM, the following:
> Nishanth Menon <nm@ti.com> writes:
> 
>> From: Eduardo Valentin <eduardo.valentin@nokia.com>
>>
>> We need to disable the autoidle bit from MPU INTC,
>> otherwise INTC would get stall, and we would never
>> come out of WFI. This must be done before save secure ram
>> as well because save secure ram also does WFI.
>>
>> This patch is just a addition to the current W/A we have for i540,
>> in order to cover the WFI inside the save secure ram.
> 
> This 'in addition' doesn't really make sense to me.  This doesn't add
> anything to the current workaround, it just changes the order of
> operations.

yes - the "in addition" part is as follows:

ideally speaking you just need the omap3_intc_prepare_idle just before 
wfi. we "in addition" need to protect the save_secure_ram call as well 
because ROM code's WFI hits the same window of the bug that we do in the 
kernel. I believe the "in addition" was meant to state that we have to 
protect the logic of romcode as well..

> 
> Kevin
> 
>> Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
>> ---
>>  arch/arm/mach-omap2/pm34xx.c |   10 ++++++++--
>>  1 files changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
>> index f520b38..c7e2db0 100644
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -422,6 +422,14 @@ void omap_sram_idle(void)
>>  				omap3_per_save_context();
>>  	}
>>  
>> +	/*
>> +	 * We need to disable the autoidle bit from MPU INTC,
>> +	 * otherwise INTC would get stall, and we would never
>> +	 * come out of WFI. This is done here because
>> +	 * save secure ram also does WFI.
>> +	 */
>> +	omap3_intc_prepare_idle();
>> +
>>  	/* CORE */
>>  	if (core_next_state < PWRDM_POWER_ON) {
>>  		omap_uart_prepare_idle(0);
>> @@ -433,8 +441,6 @@ void omap_sram_idle(void)
>>  		}
>>  	}
>>  
>> -	omap3_intc_prepare_idle();
>> -
>>  	/*
>>  	* On EMU/HS devices ROM code restores a SRDC value
>>  	* from scratchpad which has automatic self refresh on timeout


-- 
Regards,
Nishanth Menon
