From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: RE: [RFC][PATCH] OMAP3: PM: Fix workaround	implementation	for	OMAP3
 errata (1.142)
Date: Thu, 13 Aug 2009 21:01:44 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03060509BD@dbde02.ent.ti.com>
References: <1249641008.6485.332.camel@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48839 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751462AbZHMPcE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Aug 2009 11:32:04 -0400
In-Reply-To: <1249641008.6485.332.camel@ubuntu>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Jokiniemi <kalle.jokiniemi@digia.com>, Roger Quadros <ext-roger.quadros@nokia.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


>-----Original Message-----
>From: Kalle Jokiniemi [mailto:kalle.jokiniemi@digia.com] 
>Sent: Friday, August 07, 2009 4:00 PM
>To: Roger Quadros
>Cc: Kevin Hilman; Nayak, Rajendra; linux-omap@vger.kernel.org
>Subject: Re: [RFC][PATCH] OMAP3: PM: Fix workaround 
>implementation for OMAP3 errata (1.142)
>
>On Fri, 2009-08-07 at 11:48 +0300, Roger Quadros wrote:
>> ext Kalle Jokiniemi wrote:
>> > On Fri, 2009-08-07 at 11:03 +0300, Roger Quadros wrote:
>> >> ext Kalle Jokiniemi wrote:
>> >>> On Fri, 2009-08-07 at 01:14 +0300, Kevin Hilman wrote:
>> >>>> Roger Quadros <ext-roger.quadros@nokia.com> writes:
>> >>>>
>> >>>>> As per errata 1.142, on EMU/HS devices, SDRC_POWER 
>should be programmed
>> >>>>> for automatic self-refresh before transition to OFF mode.
>> >>>>> In the current implementation this is done in 
>omap3_scratchpad_contents()
>> >>>>> which is wrong, since this is the value that will be 
>restored while
>> >>>>> resuming from OFF mode and not while transitioning to it.
>> >>>>>
>> >>>>> This patch implements the workaround in the correct 
>way as per errata.
>> >>>>>
>> >>>>> Signed-off-by: Roger Quadros <ext-roger.quadros@nokia.com>
>> >>>> This looks right to me.
>> >>>>
>> >>>> Rajendra, Kalle, any comments? since you were the originators of
>> >>>> the original patch.
>> >>>>
>> >>>> Kevin
>> >>>>
>> >>>>> ---
>> >>>>>  arch/arm/mach-omap2/control.c |   16 ++--------------
>> >>>>>  arch/arm/mach-omap2/pm34xx.c  |   20 ++++++++++++++------
>> >>>>>  2 files changed, 16 insertions(+), 20 deletions(-)
>> >>>>>
>> >>>>> diff --git a/arch/arm/mach-omap2/control.c 
>b/arch/arm/mach-omap2/control.c
>> >>>>> index a7159a9..0a563c8 100644
>> >>>>> --- a/arch/arm/mach-omap2/control.c
>> >>>>> +++ b/arch/arm/mach-omap2/control.c
>> >>>>> @@ -272,20 +272,8 @@ void omap3_save_scratchpad_contents(void)
>> >>>>>  			(sdrc_read_reg(SDRC_ERR_TYPE) & 0xFFFF);
>> >>>>>  	sdrc_block_contents.dll_a_ctrl = 
>sdrc_read_reg(SDRC_DLLA_CTRL);
>> >>>>>  	sdrc_block_contents.dll_b_ctrl = 0x0;
>> >>>>> -	/*
>> >>>>> -	 * Due to a OMAP3 errata (1.142), on EMU/HS 
>devices SRDC should
>> >>>>> -	 * be programed to issue automatic self refresh 
>on timeout
>> >>>>> -	 * of AUTO_CNT = 1 prior to any transition to OFF mode.
>> >>>>> -	 */
>> >>>>> -	if ((omap_type() != OMAP2_DEVICE_TYPE_GP)
>> >>>>> -			&& (omap_rev() >= OMAP3430_REV_ES3_0))
>> >>>>> -		sdrc_block_contents.power = 
>(sdrc_read_reg(SDRC_POWER) &
>> >>>>> -				~(SDRC_POWER_AUTOCOUNT_MASK|
>> >>>>> -				SDRC_POWER_CLKCTRL_MASK)) |
>> >>>>> -				(1 << 
>SDRC_POWER_AUTOCOUNT_SHIFT) |
>> >>>>> -				SDRC_SELF_REFRESH_ON_AUTOCOUNT;
>> >>>>> -	else
>> >>>>> -		sdrc_block_contents.power = 
>sdrc_read_reg(SDRC_POWER);
>> >>>>> +
>> >>>>> +	sdrc_block_contents.power = sdrc_read_reg(SDRC_POWER);
>> >>> Why do you want to remove the workaround from scratchpad?
>> >>>
>> >>> When we wake up from off mode, the boot ROM code writes 
>these settings
>> >>> as the first sdrc_power settings after wakeup. If that 
>setting does not
>> >>> include the workaround, we'll have a period of time 
>where sdram is not
>> >>> being refreshed. This hits especially HS devices that do 
>long secure
>> >>> context restore in ROM code as well.
>> >>>
>> >>>
>> >> I suppose SDRAM is always refreshed (i.e. auto refresh) 
>when ON. However when we 
>> >> enter OFF mode it should be _self_ refreshed. That is 
>done by the below code 
>> >> before we switch to OFF mode.
>> > 
>> > The erratum speaks of auto-refresh failing after waking up 
>from CORE off
>> > mode. I think there is the described workaround in place 
>in sleep34xx.S
>> > code to kick up the auto refresh, but this still leaves a short gap
>> > between boot ROM and the sleep code.
>> > 
>> > Unless the self-refresh mode does not get changed by the scratchpad
>> > settings?
>> > 
>> > - Kalle
>> 
>> There are 2 parts in the errata 1.142.
>> 
>> The 1st part is what you are talking about. And it needs to 
>be applied only on 
>> ES3.0 devices.
>> 
>> The 2nd part is valid only for HS devices.
>> "..it is mandatory on HS device to have the SDRC issuing 
>automatic self-refresh
>> entries on inactivity periods.."
>> 
>> My patch is only fixing the implementation of the 2nd part 
>without changing the 
>> work around for the 1st part. no?
>
>The fix for second part is ok. But I have understood that the 
>scratchpad
>change was an additional safeguard against the 1st part. Rajendra, any
>comments? 

Sorry, I was off for a while, hence the delay in responding.

So the errata has just one part and not two. Its just that the workaround
is different on GP and HS.

So to summarise
Errata: SDRAM is always put in selfrefresh while in OFF. On the way out of OFF
once SDRC is restored by ROM code, the very first access to SDRAM brings it out
of self refresh and then automatic autorefresh commands should be sent, but
are not sent due to SDRC state machine being in an inappropriate state.

WA:
Issue a manual MR/EMR2 write command to SDRAM.

ON GP devices doing this immediately on a jump to kernel SDRAM restore pointer
code worked fine as there was no access to SDRAM from ROMcode.

However on HS devices the ROM code itself did some SDRAM access causing the
SDRAM to come out of self refresh (while the romcode was still executing)and was 
too late by the time the control came to the kernel SDRAM code where the manual
MR/EMR2 command was sent.
Hence on HS devices there is an aditional need for having to enable automatic
self-refresh entries on timeout of Auto_cnt with auto_cnt set to 1.

So, the code in the current state seems quite fine to be able to take care of this errata
for both GP and HS devices and this patch does not seem to be needed.

>
>I don't know how fast SDRAM corrupts when not refreshed, but on low OPP
>it takes several msecs to reach public code from boot ROM. So keeping
>SDRAM in self-refresh also in this period, seems sensible to me (even
>though the erratum does not mention a requirement for this).
>
>- Kalle
>
>> 
>> -roger
>> 
>> > 
>> >> When we wake up from OFF mode (the scratchpad contents 
>are used), we should 
>> >> restore the original register setting that was there 
>before we went to OFF mode 
>> >> and not the self refresh mode setting. Hence the removal 
>of above code.
>> >>
>> >> -roger
>> >>>>>  
>> >>>>>  	sdrc_block_contents.cs_0 = 0x0;
>> >>>>>  	sdrc_block_contents.mcfg_0 = sdrc_read_reg(SDRC_MCFG_0);
>> >>>>> diff --git a/arch/arm/mach-omap2/pm34xx.c 
>b/arch/arm/mach-omap2/pm34xx.c
>> >>>>> index 14f10bc..eb3c9e5 100644
>> >>>>> --- a/arch/arm/mach-omap2/pm34xx.c
>> >>>>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> >>>>> @@ -405,15 +405,23 @@ void omap_sram_idle(void)
>> >>>>>  	}
>> >>>>>  
>> >>>>>  	/*
>> >>>>> -	* On EMU/HS devices ROM code restores a SRDC value
>> >>>>> -	* from scratchpad which has automatic self 
>refresh on timeout
>> >>>>> -	* of AUTO_CNT = 1 enabled. This takes care of 
>errata 1.142.
>> >>>>> -	* Hence store/restore the SDRC_POWER register here.
>> >>>>> -	*/
>> >>>>> +	 * Due to a OMAP3 errata (1.142), on EMU/HS 
>devices SRDC should
>> >>>>> +	 * be programed to issue automatic self refresh 
>on timeout
>> >>>>> +	 * of AUTO_CNT = 1 prior to any transition to OFF mode.
>> >>>>> +	 */
>> >>>>> +
>> >>>>>  	if (omap_rev() >= OMAP3430_REV_ES3_0 &&
>> >>>>>  	    omap_type() != OMAP2_DEVICE_TYPE_GP &&
>> >>>>> -	    core_next_state == PWRDM_POWER_OFF)
>> >>>>> +	    core_next_state == PWRDM_POWER_OFF) {
>> >>>>> +
>> >>>>>  		sdrc_pwr = sdrc_read_reg(SDRC_POWER);
>> >>>>> +		sdrc_write_reg((sdrc_pwr &
>> >>>>> +				~(SDRC_POWER_AUTOCOUNT_MASK|
>> >>>>> +				SDRC_POWER_CLKCTRL_MASK)) |
>> >>>>> +				(1 << 
>SDRC_POWER_AUTOCOUNT_SHIFT) |
>> >>>>> +				SDRC_SELF_REFRESH_ON_AUTOCOUNT,
>> >>>>> +					SDRC_POWER);
>> >>>>> +	}
>> >>> This part seems ok to me.
>> >>>
>> >>> - Kalle
>> >>>
>> >>>
>> >>>>>  
>> >>>>>  	if (regset_save_on_suspend)
>> >>>>>  		pm_dbg_regset_save(1);
>> >>>>> -- 
>> >>>>> 1.6.0.4
>> > 
>> 
>
>
>