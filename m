From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH V2] OMAP3: PM: Fix for MPU power domain MEM BANK position
Date: Thu, 15 Oct 2009 15:11:34 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030A46CFE7@dbde02.ent.ti.com>
References: <A24693684029E5489D1D202277BE89444BE28394@dlee02.ent.ti.com>
 <1251444297-13577-1-git-send-email-thara@ti.com>
 <alpine.DEB.2.00.0910141536210.23283@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54681 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762036AbZJOJmE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Oct 2009 05:42:04 -0400
In-Reply-To: <alpine.DEB.2.00.0910141536210.23283@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>

Thanks Paul. The bit positions are goofed up only in PWRSTS and PREPWRSTS not in PWSTCTRL register. As per the approach you have suggested below, if we change the mem bank number from 0 to 1 , we will have to change the logic for read/write into PWSTCTRL for mpu pwr domain.

Regards
Thara

>>-----Original Message-----
>>From: Paul Walmsley [mailto:paul@pwsan.com]
>>Sent: Thursday, October 15, 2009 4:51 AM
>>To: Gopinath, Thara
>>Cc: linux-omap@vger.kernel.org; khilman@deeprootsystems.com
>>Subject: Re: [PATCH V2] OMAP3: PM: Fix for MPU power domain MEM BANK position
>>
>>Hi Thara,
>>
>>I regret the delay.  A comment:
>>
>>On Fri, 28 Aug 2009, Thara Gopinath wrote:
>>
>>> MPU power domain bank 0 bits are displayed in position of bank 1
>>> in PWRSTS and PREPWRSTS registers. So read them from correct
>>> position
>>
>>Indeed.  What do you think about a slightly different approach: changing
>>powerdomains34xx.h to be correct?  In other words, instead of
>>
>>	.pwrsts_mem_ret	  = {
>>		[0] = PWRSTS_OFF_RET,
>>	},
>>	.pwrsts_mem_on	  = {
>>		[0] = PWRSTS_OFF_ON,
>>	},
>>
>>we would use:
>>
>>	.pwrsts_mem_ret	  = {
>>		[1] = PWRSTS_OFF_RET,
>>	},
>>	.pwrsts_mem_on	  = {
>>		[1] = PWRSTS_OFF_ON,
>>	},
>>
>>We have to deal with the bank count field in struct powerdomain - we could
>>just convert it into a bitmap representing available banks.  So instead
>>of:
>>
>>        .banks = 1,
>>
>>use maybe:
>>
>>	.banks = PWRDM_BANK_1,  /* | PWRDM_BANK_0, etc */
>>
>>
>>Can you foresee any problems with the above approach?
>>
>>- Paul
>>
>>> Patch refresh issue.
>>>
>>>  arch/arm/mach-omap2/powerdomain.c |   19 +++++++++++++++++++
>>>  1 files changed, 19 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
>>> index 2594cbf..6c5fee9 100644
>>> --- a/arch/arm/mach-omap2/powerdomain.c
>>> +++ b/arch/arm/mach-omap2/powerdomain.c
>>> @@ -971,6 +971,16 @@ int pwrdm_read_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
>>>  		return -EEXIST;
>>>
>>>  	/*
>>> +	 * In 3430, for MPU domain bank 0 status bits
>>> +	 * are displayed in the position of bank1 status bits
>>> +	 * in PWST  . So the hack. Think of a cleaner
>>> +	 * way of doing this
>>> +	 */
>>> +	if (cpu_is_omap34xx())
>>> +		if (!strcmp("mpu_pwrdm", pwrdm->name))
>>> +			bank = 1;
>>> +
>>> +	/*
>>>  	 * The register bit names below may not correspond to the
>>>  	 * actual names of the bits in each powerdomain's register,
>>>  	 * but the type of value returned is the same for each
>>> @@ -1018,6 +1028,15 @@ int pwrdm_read_prev_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
>>>  		return -EEXIST;
>>>
>>>  	/*
>>> +	 * In 3430, for MPU domain bank 0 status bits
>>> +	 * are displayed in the position of bank1 status bits
>>> +	 * in PREPWST  . So the hack. Think of a cleaner
>>> +	 * way of doing this
>>> +	 */
>>> +	if (cpu_is_omap34xx())
>>> +		if (!strcmp("mpu_pwrdm", pwrdm->name))
>>> +			bank = 1;
>>> +	/*
>>>  	 * The register bit names below may not correspond to the
>>>  	 * actual names of the bits in each powerdomain's register,
>>>  	 * but the type of value returned is the same for each
>>> --
>>> 1.5.4.7
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>>
>>- Paul

