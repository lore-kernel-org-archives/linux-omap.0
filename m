From: Roger Quadros <ext-roger.quadros@nokia.com>
Subject: Re: [RFC][PATCH] OMAP3: PM: Fix workaround implementation for	OMAP3
 errata (1.142)
Date: Fri, 07 Aug 2009 11:03:30 +0300
Message-ID: <4A7BDFD2.6090403@nokia.com>
References: <1248873393-29503-1-git-send-email-ext-roger.quadros@nokia.com>	 <87tz0k614d.fsf@deeprootsystems.com> <1249625784.6485.249.camel@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:54441 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754811AbZHGIEF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Aug 2009 04:04:05 -0400
In-Reply-To: <1249625784.6485.249.camel@ubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Rajendra Nayak <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

ext Kalle Jokiniemi wrote:
> On Fri, 2009-08-07 at 01:14 +0300, Kevin Hilman wrote:
>> Roger Quadros <ext-roger.quadros@nokia.com> writes:
>>
>>> As per errata 1.142, on EMU/HS devices, SDRC_POWER should be programmed
>>> for automatic self-refresh before transition to OFF mode.
>>> In the current implementation this is done in omap3_scratchpad_contents()
>>> which is wrong, since this is the value that will be restored while
>>> resuming from OFF mode and not while transitioning to it.
>>>
>>> This patch implements the workaround in the correct way as per errata.
>>>
>>> Signed-off-by: Roger Quadros <ext-roger.quadros@nokia.com>
>> This looks right to me.
>>
>> Rajendra, Kalle, any comments? since you were the originators of
>> the original patch.
>>
>> Kevin
>>
>>> ---
>>>  arch/arm/mach-omap2/control.c |   16 ++--------------
>>>  arch/arm/mach-omap2/pm34xx.c  |   20 ++++++++++++++------
>>>  2 files changed, 16 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
>>> index a7159a9..0a563c8 100644
>>> --- a/arch/arm/mach-omap2/control.c
>>> +++ b/arch/arm/mach-omap2/control.c
>>> @@ -272,20 +272,8 @@ void omap3_save_scratchpad_contents(void)
>>>  			(sdrc_read_reg(SDRC_ERR_TYPE) & 0xFFFF);
>>>  	sdrc_block_contents.dll_a_ctrl = sdrc_read_reg(SDRC_DLLA_CTRL);
>>>  	sdrc_block_contents.dll_b_ctrl = 0x0;
>>> -	/*
>>> -	 * Due to a OMAP3 errata (1.142), on EMU/HS devices SRDC should
>>> -	 * be programed to issue automatic self refresh on timeout
>>> -	 * of AUTO_CNT = 1 prior to any transition to OFF mode.
>>> -	 */
>>> -	if ((omap_type() != OMAP2_DEVICE_TYPE_GP)
>>> -			&& (omap_rev() >= OMAP3430_REV_ES3_0))
>>> -		sdrc_block_contents.power = (sdrc_read_reg(SDRC_POWER) &
>>> -				~(SDRC_POWER_AUTOCOUNT_MASK|
>>> -				SDRC_POWER_CLKCTRL_MASK)) |
>>> -				(1 << SDRC_POWER_AUTOCOUNT_SHIFT) |
>>> -				SDRC_SELF_REFRESH_ON_AUTOCOUNT;
>>> -	else
>>> -		sdrc_block_contents.power = sdrc_read_reg(SDRC_POWER);
>>> +
>>> +	sdrc_block_contents.power = sdrc_read_reg(SDRC_POWER);
> 
> Why do you want to remove the workaround from scratchpad?
> 
> When we wake up from off mode, the boot ROM code writes these settings
> as the first sdrc_power settings after wakeup. If that setting does not
> include the workaround, we'll have a period of time where sdram is not
> being refreshed. This hits especially HS devices that do long secure
> context restore in ROM code as well.
> 
> 
I suppose SDRAM is always refreshed (i.e. auto refresh) when ON. However when we 
enter OFF mode it should be _self_ refreshed. That is done by the below code 
before we switch to OFF mode.

When we wake up from OFF mode (the scratchpad contents are used), we should 
restore the original register setting that was there before we went to OFF mode 
and not the self refresh mode setting. Hence the removal of above code.

-roger
>>>  
>>>  	sdrc_block_contents.cs_0 = 0x0;
>>>  	sdrc_block_contents.mcfg_0 = sdrc_read_reg(SDRC_MCFG_0);
>>> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
>>> index 14f10bc..eb3c9e5 100644
>>> --- a/arch/arm/mach-omap2/pm34xx.c
>>> +++ b/arch/arm/mach-omap2/pm34xx.c
>>> @@ -405,15 +405,23 @@ void omap_sram_idle(void)
>>>  	}
>>>  
>>>  	/*
>>> -	* On EMU/HS devices ROM code restores a SRDC value
>>> -	* from scratchpad which has automatic self refresh on timeout
>>> -	* of AUTO_CNT = 1 enabled. This takes care of errata 1.142.
>>> -	* Hence store/restore the SDRC_POWER register here.
>>> -	*/
>>> +	 * Due to a OMAP3 errata (1.142), on EMU/HS devices SRDC should
>>> +	 * be programed to issue automatic self refresh on timeout
>>> +	 * of AUTO_CNT = 1 prior to any transition to OFF mode.
>>> +	 */
>>> +
>>>  	if (omap_rev() >= OMAP3430_REV_ES3_0 &&
>>>  	    omap_type() != OMAP2_DEVICE_TYPE_GP &&
>>> -	    core_next_state == PWRDM_POWER_OFF)
>>> +	    core_next_state == PWRDM_POWER_OFF) {
>>> +
>>>  		sdrc_pwr = sdrc_read_reg(SDRC_POWER);
>>> +		sdrc_write_reg((sdrc_pwr &
>>> +				~(SDRC_POWER_AUTOCOUNT_MASK|
>>> +				SDRC_POWER_CLKCTRL_MASK)) |
>>> +				(1 << SDRC_POWER_AUTOCOUNT_SHIFT) |
>>> +				SDRC_SELF_REFRESH_ON_AUTOCOUNT,
>>> +					SDRC_POWER);
>>> +	}
> 
> This part seems ok to me.
> 
> - Kalle
> 
> 
>>>  
>>>  	if (regset_save_on_suspend)
>>>  		pm_dbg_regset_save(1);
>>> -- 
>>> 1.6.0.4
> 

