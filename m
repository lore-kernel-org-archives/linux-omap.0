From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCHv3 2/6] ARM: OMAP3 PM: Move IO Daisychain function to omap3
 prm file
Date: Thu, 01 Mar 2012 14:13:27 +0530
Message-ID: <4F4F36AF.5010000@ti.com>
References: <1330525621-29836-1-git-send-email-t-kristo@ti.com>	 <1330525621-29836-3-git-send-email-t-kristo@ti.com>	 <4F4F1BFD.4020903@ti.com> <1330590484.2116.76.camel@sokoban>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:51535 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932285Ab2CAInf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Mar 2012 03:43:35 -0500
Received: by ggnh1 with SMTP id h1so106584ggn.33
        for <linux-omap@vger.kernel.org>; Thu, 01 Mar 2012 00:43:34 -0800 (PST)
In-Reply-To: <1330590484.2116.76.camel@sokoban>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: t-kristo@ti.com
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org, Vishwanath BS <vishwanath.bs@ti.com>, "Dhavlikar, Nilesh" <dnilesh@ti.com>

On Thursday 01 March 2012 01:58 PM, Tero Kristo wrote:
> On Thu, 2012-03-01 at 12:19 +0530, Rajendra Nayak wrote:
>> On Wednesday 29 February 2012 07:56 PM, Tero Kristo wrote:
>>> From: Vishwanath BS<vishwanath.bs@ti.com>
>>>
>>> Since IO Daisychain modifies only PRM registers, it makes sense to move
>>> it to PRM File.
>>>
>>> Signed-off-by: Vishwanath BS<vishwanath.bs@ti.com>
>>> Tested-by: Govindraj.R<govindraj.raja@ti.com>
>>> Signed-off-by: Tero Kristo<t-kristo@ti.com>
>>> ---
>>>    arch/arm/mach-omap2/pm34xx.c       |   30 +-----------------------------
>>>    arch/arm/mach-omap2/prm2xxx_3xxx.c |   32 ++++++++++++++++++++++++++++++++
>>>    arch/arm/mach-omap2/prm2xxx_3xxx.h |   14 ++++++++++++++
>>>    3 files changed, 47 insertions(+), 29 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
>>> index b0821a8..e97ec3f 100644
>>> --- a/arch/arm/mach-omap2/pm34xx.c
>>> +++ b/arch/arm/mach-omap2/pm34xx.c
>>> @@ -85,34 +85,6 @@ static inline void omap3_per_restore_context(void)
>>>    	omap_gpio_restore_context();
>>>    }
>>>
>>> -static void omap3_enable_io_chain(void)
>>> -{
>>> -	int timeout = 0;
>>> -
>>> -	omap2_prm_set_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK, WKUP_MOD,
>>> -				   PM_WKEN);
>>> -	/* Do a readback to assure write has been done */
>>> -	omap2_prm_read_mod_reg(WKUP_MOD, PM_WKEN);
>>> -
>>> -	while (!(omap2_prm_read_mod_reg(WKUP_MOD, PM_WKST)&
>>> -		 OMAP3430_ST_IO_CHAIN_MASK)) {
>>> -		timeout++;
>>> -		if (timeout>   1000) {
>>> -			pr_err("Wake up daisy chain activation failed.\n");
>>> -			return;
>>> -		}
>>> -	}
>>> -	omap2_prm_clear_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK, WKUP_MOD,
>>> -			PM_WKEN);
>>> -
>>> -}
>>> -
>>> -static void omap3_disable_io_chain(void)
>>> -{
>>> -	omap2_prm_clear_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK, WKUP_MOD,
>>> -				     PM_WKEN);
>>> -}
>>> -
>>>    static void omap3_core_save_context(void)
>>>    {
>>>    	omap3_ctrl_save_padconf();
>>> @@ -324,7 +296,7 @@ void omap_sram_idle(void)
>>>    	     core_next_state<   PWRDM_POWER_ON)) {
>>>    		omap2_prm_set_mod_reg_bits(OMAP3430_EN_IO_MASK, WKUP_MOD, PM_WKEN);
>>>    		if (omap3_has_io_chain_ctrl())
>>> -			omap3_enable_io_chain();
>>> +			omap3_trigger_io_chain();
>>>    	}
>>>
>>>    	pwrdm_pre_transition();
>>> diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.c b/arch/arm/mach-omap2/prm2xxx_3xxx.c
>>> index 9ce7654..fc98781 100644
>>> --- a/arch/arm/mach-omap2/prm2xxx_3xxx.c
>>> +++ b/arch/arm/mach-omap2/prm2xxx_3xxx.c
>>> @@ -301,6 +301,38 @@ void omap3xxx_prm_restore_irqen(u32 *saved_mask)
>>>    				OMAP3_PRM_IRQENABLE_MPU_OFFSET);
>>>    }
>>>
>>> +/**
>>> + * Maximum time(us) it takes to output the signal WUCLKOUT of the last pad of
>>> + * the I/O ring after asserting WUCLKIN high
>>> + */
>>> +#define MAX_IOPAD_LATCH_TIME 1000
>>
>> Since we are changing the implementation to use omap_test_timeout()
>> in this patch, it makes sense to make this 100 so we have a max 100us
>> delay, similar to what we did on OMAP4.
>
> I didn't change this timeout as I wasn't quite sure what is a safe value
> for it. Do you know if 100us is safe for omap3 also in all possible
> scenarios?

The IO daisy implementation is essentially the same on OMAP3 and OMAP4.
I looped in Nilesh again who can shout if it isn't.

Besides the previous implementation was just a loop of 1000  (not using
omap_test_timeout() which internally does udelay(1)) and that should be
always less than 100us even with MPU at the lowest OPP on OMAP3.

>
>>
>>> +
>>> +/* OMAP3 Daisychain enable sequence */
>>> +void omap3_trigger_io_chain(void)
>>> +{
>>> +	int i = 0;
>>> +
>>> +	omap2_prm_set_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK, WKUP_MOD,
>>> +				   PM_WKEN);
>>> +	/* Do a readback to assure write has been done */
>>> +	omap2_prm_read_mod_reg(WKUP_MOD, PM_WKEN);
>>> +
>>> +	omap_test_timeout(((omap2_prm_read_mod_reg(WKUP_MOD, PM_WKST)&
>>> +			    OMAP3430_ST_IO_CHAIN_MASK) == 1),
>>> +			  MAX_IOPAD_LATCH_TIME, i);
>>> +
>>> +	omap2_prm_clear_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK, WKUP_MOD,
>>> +				     PM_WKEN);
>>
>> The comment from Djamil should hold good here too. We should wait for
>> IO chain status to show 0 here.
>
> Hmm okay, I'll address this also for next version.
>
> -Tero
>
>
>>
>>> +}
>>> +
>>
>> regards,
>> Rajendra
>
>

