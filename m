From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 02/11] ARM: OMAP3: Fix idle mode signaling for sys_clkreq
 and sys_off_mode
Date: Wed, 23 Apr 2014 10:51:10 +0300
Message-ID: <535770EE.8060603@ti.com>
References: <1397173639-29587-1-git-send-email-tony@atomide.com> <1397173639-29587-3-git-send-email-tony@atomide.com> <5348FFFA.5040207@ti.com> <20140412150205.GB32292@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56142 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754103AbaDWHvi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Apr 2014 03:51:38 -0400
In-Reply-To: <20140412150205.GB32292@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Kevin Hilman <khilman@linaro.org>, Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>

On 04/12/2014 06:02 PM, Tony Lindgren wrote:
> * Tero Kristo <t-kristo@ti.com> [140412 02:01]:
>> On 04/11/2014 02:47 AM, Tony Lindgren wrote:>
>>> @@ -282,6 +283,7 @@ void omap_sram_idle(void)
>>>
>>>    	/* CORE */
>>>    	if (core_next_state < PWRDM_POWER_ON) {
>>> +		omap3_vc_set_pmic_signaling(core_next_state);
>>>    		if (core_next_state == PWRDM_POWER_OFF) {
>>>    			omap3_core_save_context();
>>>    			omap3_cm_save_context();
>>
>> I think this implementation is sub-optimal, as it only scales
>> voltages if core is entering idle state. MPU only idle is possible,
>> however you do not scale voltages in this case.
>
> Hmm that's same as PWRDM_POWER_RET? That's working too.
> Or do you have something else in mind that I'm not aware
> of?

No, I mean the case where core_next_state == PWRDM_POWER_ON, but 
mpu_next_state <= PWRDM_POWER_RET. You could scale MPU voltage in this 
case but you don't with this implementation.

>
>>> @@ -220,6 +220,78 @@ static inline u32 omap_usec_to_32k(u32 usec)
>>>    	return DIV_ROUND_UP_ULL(32768ULL * (u64)usec, 1000000ULL);
>>>    }
>>>
>>> +void omap3_vc_set_pmic_signaling(int core_next_state)
>>> +{
>>> +	u32 voltctrl;
>>> +
>>> +	voltctrl = omap2_prm_read_mod_reg(OMAP3430_GR_MOD,
>>> +					  OMAP3_PRM_VOLTCTRL_OFFSET);
>>
>> Just a note here, I am currently working on trying to get rid of all
>> the direct prm_read/write calls outside PRCM drivers, this and rest
>> should use voltdm->read/write.
>
> OK, sounds like you already have a patch for that in your
> 3.14-rc4-cm-prm-driver-wip branch?

Yes, there is a patch for that.

>
> Let's do the fixes first, then it's going to be a lot easier for
> us to test the rest of the PRMC changes.
>
>>> +	/*
>>> +	 * By default let's use I2C4 signaling for retention idle
>>> +	 * and sys_off_mode pin signaling for off idle. This way we
>>> +	 * have sys_clk_req pin go down for retention and both
>>> +	 * sys_clk_req and sys_off_mode pins will go down for off
>>> +	 * idle. And we can also scale voltages to zero for off-idle.
>>> +	 * Note that no actual voltage scaling will happen unless the
>>> +	 * board specific twl4030 PMIC scripts are loaded.
>>> +	 */
>>> +	val = omap2_prm_read_mod_reg(OMAP3430_GR_MOD,
>>> +				     OMAP3_PRM_VOLTCTRL_OFFSET);
>>
>> Why not use the I2C4 signalling for off-mode? This way the voltages
>> can be scaled to 0.6V even without any board specific scripts.
>
> Using I2C4 works too, we're just missing a place to set
> and clear OMAP3430_PRM_VOLTCTRL_SEL_OFF bit currently. Sounds
> like eventually we should allow changing it dynamically somewhere.

You can't check the presence of the scripts here?

> But for now, SEL_OFF should be enabled as it allows debugging PM
> by looking at the sys_clkreq and sys_off_mode pins no matter if
> there are board specific scripts or not. The sys_off_mode won't
> toggle if things are configured to use I2C4, which is confusing.

You can always measure the voltage rails directly also, but yea, it is 
more convenient to just look at the led.

-Tero

