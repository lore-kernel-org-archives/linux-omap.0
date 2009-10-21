From: <Tero.Kristo@nokia.com>
Subject: RE: [PATCH 16/17] OMAP3: PM: Write voltage and clock setup times
 dynamically in idle loop
Date: Wed, 21 Oct 2009 17:37:07 +0200
Message-ID: <1F18D6510CF0474A8C9500565A7E41A210F6A5859E@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1255690150-16853-1-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-2-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-3-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-4-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-5-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-6-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-7-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-8-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-9-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-10-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-11-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-12-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-13-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-14-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-15-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-16-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-17-git-send-email-tero.kristo@nokia.com>
	<87aazmj6t3.fsf@deeprootsystems.com>
	<1F18D6510CF0474A8C9500565A7E41A210F6A58235@NOK-EUMSG-02.mgdnok.nokia.com>
 <87r5swomtx.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:58967 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753965AbZJUPhV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Oct 2009 11:37:21 -0400
In-Reply-To: <87r5swomtx.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org

 

>-----Original Message-----
>From: ext Kevin Hilman [mailto:khilman@deeprootsystems.com] 
>Sent: 21 October, 2009 17:15
>To: Kristo Tero (Nokia-D/Tampere)
>Cc: linux-omap@vger.kernel.org
>Subject: Re: [PATCH 16/17] OMAP3: PM: Write voltage and clock 
>setup times dynamically in idle loop
>
><Tero.Kristo@nokia.com> writes:
>
>>  
>>
>>>-----Original Message-----
>>>From: ext Kevin Hilman [mailto:khilman@deeprootsystems.com] 
>>>Sent: 20 October, 2009 20:48
>>>To: Kristo Tero (Nokia-D/Tampere)
>>>Cc: linux-omap@vger.kernel.org
>>>Subject: Re: [PATCH 16/17] OMAP3: PM: Write voltage and clock 
>>>setup times dynamically in idle loop
>>>
>>>Tero Kristo <tero.kristo@nokia.com> writes:
>>>
>>>> From: Tero Kristo <tero.kristo@nokia.com>
>>>>
>>>> It is suggested by TI (SWPA152 February 2009) to write clksetup,
>>>> voltsetup_time1, voltsetup_time2, voltsetup2 dynamically in 
>>>idle loop.
>>>
>>>Can you summarize the reasons why?
>>
>> Basically this optimizes the clksetup / voltsetup times 
>according to the sleep mode. Currently the settings are too 
>high in both retention and off-mode, because the hardware 
>appears to use for example VOLTSETUP2 even if we are not in 
>off-mode, adding extra delay to wakeup. Also, CLKSETUP is too 
>high for retention mode because oscillator is not actually 
>shut-off here.
>>
>> However, now that I think about it, it might be better to 
>change this in a way that it is user configurable whether we 
>want to change the settings or not, maybe add new items in to 
>the prm_setup struct for alternate settings for ret / off and 
>only use these if available. Some boards might actually switch 
>oscillator off in retention mode which would require higher setup time.
>>
>>>
>>>> Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
>>>> ---
>>>>  arch/arm/mach-omap2/pm34xx.c |   36 
>>>+++++++++++++++++++++++++-----------
>>>>  1 files changed, 25 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/arch/arm/mach-omap2/pm34xx.c 
>>>b/arch/arm/mach-omap2/pm34xx.c
>>>> index f492142..ae83121 100644
>>>> --- a/arch/arm/mach-omap2/pm34xx.c
>>>> +++ b/arch/arm/mach-omap2/pm34xx.c
>>>> @@ -575,6 +575,30 @@ void omap_sram_idle(void)
>>>>  	if (regset_save_on_suspend)
>>>>  		pm_dbg_regset_save(1);
>>>>  
>>>> +	/* Write voltage setup times which are changed dynamically */
>>>
>>>AFAICT, we only set these values at init time and they are never
>>>changed.  Are there some forthcoming patches that change these
>>>dynamically?
>>
>> Following bit of the code actually changes them dynamically, you can
>> see that e.g. CLKSETUP time is either prm_setup.clksetup or 0x1
>> depending on the sleep mode. 
>
>Doh, I see now.
>
>> But as previously said, I think these should probably be added as
>> new items to the prm_setup struct.
>
>Yes, I would rather see the prm_setup struct extended so these can be
>passed in by board code.

I'll change the patch accordingly.


>>>
>>>Kevin
>>>
>>>> +	if (core_next_state == PWRDM_POWER_OFF) {
>>>> +		prm_write_mod_reg(0, OMAP3430_GR_MOD,
>>>> +				OMAP3_PRM_VOLTSETUP1_OFFSET);
>>>> +		prm_write_mod_reg(prm_setup.voltsetup2, OMAP3430_GR_MOD,
>>>> +				OMAP3_PRM_VOLTSETUP2_OFFSET);
>>>> +		prm_write_mod_reg(prm_setup.clksetup, OMAP3430_GR_MOD,
>>>> +				OMAP3_PRM_CLKSETUP_OFFSET);
>>>> +	} else {
>>>> +		prm_write_mod_reg((prm_setup.voltsetup_time2 <<
>>>> +				OMAP3430_SETUP_TIME2_SHIFT) |
>>>> +				(prm_setup.voltsetup_time1 <<
>>>> +				OMAP3430_SETUP_TIME1_SHIFT),
>>>> +				OMAP3430_GR_MOD, 
>>>OMAP3_PRM_VOLTSETUP1_OFFSET);
>>>> +		prm_write_mod_reg(0, OMAP3430_GR_MOD,
>>>> +				OMAP3_PRM_VOLTSETUP2_OFFSET);
>>>> +		/*
>>>> +		 * Use static 1 as only HF_CLKOUT is turned off.
>>>> +		 * Value taken from application note SWPA152
>>>> +		 */
>>>> +		prm_write_mod_reg(0x1, OMAP3430_GR_MOD,
>>>> +				OMAP3_PRM_CLKSETUP_OFFSET);
>>>> +	}
>>>> +
>>>>  	/*
>>>>  	 * omap3_arm_context is the location where ARM registers
>>>>  	 * get saved. The restore path then reads from this
>>>> @@ -1379,19 +1403,9 @@ static void __init configure_vc(void)
>>>>  			  OMAP3430_GR_MOD,
>>>>  			  OMAP3_PRM_VC_I2C_CFG_OFFSET);
>>>>  
>>>> -	/* Write setup times */
>>>> -	prm_write_mod_reg(prm_setup.clksetup, OMAP3430_GR_MOD,
>>>> -			OMAP3_PRM_CLKSETUP_OFFSET);
>>>> -	prm_write_mod_reg((prm_setup.voltsetup_time2 <<
>>>> -			OMAP3430_SETUP_TIME2_SHIFT) |
>>>> -			(prm_setup.voltsetup_time1 <<
>>>> -			OMAP3430_SETUP_TIME1_SHIFT),
>>>> -			OMAP3430_GR_MOD, OMAP3_PRM_VOLTSETUP1_OFFSET);
>>>> -
>>>> +	/* Write static setup times */
>>>>  	prm_write_mod_reg(prm_setup.voltoffset, OMAP3430_GR_MOD,
>>>>  			OMAP3_PRM_VOLTOFFSET_OFFSET);
>>>> -	prm_write_mod_reg(prm_setup.voltsetup2, OMAP3430_GR_MOD,
>>>> -			OMAP3_PRM_VOLTSETUP2_OFFSET);
>>>>  
>>>>  	pm_dbg_regset_init(1);
>>>>  	pm_dbg_regset_init(2);
>>>> -- 
>>>> 1.5.4.3
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe 
>>>linux-omap" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>