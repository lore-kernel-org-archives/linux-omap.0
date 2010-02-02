From: <Tero.Kristo@Nokia.com>
Subject: RE: [PATCHv4 2/8] OMAP: Powerdomains: Add support for INACTIVE
 state on pwrdm level
Date: Tue, 2 Feb 2010 10:26:43 +0100
Message-ID: <1F18D6510CF0474A8C9500565A7E41A22372771C4E@NOK-EUMSG-02.mgdnok.nokia.com>
References: <> <1264182951-9205-1-git-send-email-tero.kristo@nokia.com>
 <1264182951-9205-2-git-send-email-tero.kristo@nokia.com>
 <1264182951-9205-3-git-send-email-tero.kristo@nokia.com>
 <alpine.DEB.2.00.1002020027130.19652@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:45950 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754502Ab0BBJ1a convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Feb 2010 04:27:30 -0500
In-Reply-To: <alpine.DEB.2.00.1002020027130.19652@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: linux-omap@vger.kernel.org

 

>-----Original Message-----
>From: ext Paul Walmsley [mailto:paul@pwsan.com] 
>Sent: 02 February, 2010 10:04
>To: Kristo Tero (Nokia-D/Tampere)
>Cc: linux-omap@vger.kernel.org
>Subject: Re: [PATCHv4 2/8] OMAP: Powerdomains: Add support for 
>INACTIVE state on pwrdm level
>
>Hello Tero,
>
>On Fri, 22 Jan 2010, Tero Kristo wrote:
>
>> Currently only ON, RET and OFF are supported, and ON is 
>arguably broken as it
>> allows the powerdomain to enter INACTIVE state unless idle 
>is prevented.
>> Now, pwrdm code prevents idle if ON is selected and hardware 
>supervised
>> mode for the underlying clockdomain is enabled, and also 
>adds support for
>> INACTIVE. This simplifies the control needed inside sleep code.
>> 
>> This patch also requires caching of next power state inside 
>powerdomain code,
>> as INACTIVE is not directly supported by hardware. Next 
>powerstate is thus
>> now stored for each powerdomain in next_state.
>
>Still thinking about this patch.  Am not sure it makes sense, 
>or at least, 
>it is incomplete.  Consider:

Reasoning for this patch at least for OMAP3 is as follows:
- sleep code needs to know the states for mpu and core better than it does now, there is currently at least one "bug" in the sleep path which effectively prevents core INACTIVE completely (uart clocks are only turned off if core is going to RET or OFF)
- support for ON/INACTIVE allows better testing facilities for different power states (e.g. suspend)
- adding support for ON/INACTIVE to powerdomain code simplifies the interface between cpuidle34xx / pm34xx
- adding support for other powerdomains than mpu/core is a nice to have feature and we can most likely live without it

Alternative is to duplicate this code to several locations (pm34xx.c, cpuidle34xx.c.), or just put this code into separate file, and use it from the locations where it is needed.

>
>1. In the current code, pwrdm->next_state can never be initialized to 
>INACTIVE during pwrdm_register(), but this should be possible.  To do 
>this, the code needs to iterate through the powerdomain's 
>clockdomains and 
>determine whether they are in hardware-supervised idle or 
>software-supervised idle.

Well, there is a chicken-egg problem here. It is not possible to check the clockdomains at this state as clockdomains do not exist yet. It would be possible to split this out from powerdomain code, maybe into powerdomain34xx.c as you suggested and do the init later.

>
>2. What should happen to pwrdm->next_state if someone calls 
>omap2_clkdm_allow_idle(), omap2_clkdm_deny_idle(), 
>omap2_clkdm_sleep(), or 
>omap2_clkdm_wakeup()?  Right now, nothing will happen, which 
>is a problem 
>since calling one of these functions could mean that the powerdomain's 
>possible next state may change from ON to INACTIVE or vice-versa.  A 
>similar problem appears to exist with hwsup_changed: other 
>code may have 
>changed the clockdomain autoidle state, which may cause 
>hwsup_changed to 
>not reflect reality any longer.

True... We should probably do something for these. However, at least currently this implementation does not cause any problems as clkdm_allow_idle, deny_idle, sleep and wakeup are not used anywhere.


>
>...
>
>I am still not sure that the idea of setting the powerdomain's 
>next power 
>state to INACTIVE makes sense.  The TRM claims that a 
>powerdomain can be 
>"inactive," but this seems to be just poor documentation.  To 
>say that a 
>powerdomain can be inactive is really just to say that the 
>powerdomain is 
>'ON' -- powered -- but all of its subsidiary clockdomain 
>activity states 
>are INACTIVE.  Between ON and INACTIVE, the power state of the 
>powerdomain 
>is the same from the hardware's point of view -- but the differences 
>between the OFF, RET, and ON power states are distinct.  And 
>from the PRCM 
>point of view, the only place that an INACTIVE power domain 
>state shows up 
>is in the powerdomain current power state register.

This is also visible in the previous state register, and well, denying/allowing clockdomain to idle only makes sense for the ON state in general, as this is the only case where we actually care if we have allowed idle or not. It is also good to know if a clockdomain has actually entered idle or not, if we do not have INACTIVE state for powerdomain, we do not know this from anywhere.

>
>Perhaps a separate code layer that incorporates your ideas is 
>worthwhile 
>for use by pm*.c and cpuidle*.c, in order to simplify that 
>code.  But in 
>the current powerdomain and clockdomain code, when we depart 
>from what the 
>hardware is capable of, the code needs to cover all of the 
>software corner 
>cases that can affect state transitions.  Otherwise we probably should 
>stick with the simplicity of following the hardware's registers and 
>capabilities.

Yeah, I think I try to put my powerdomain hacks into separate file. The patch might also break stuff for OMAP2 or OMAP4, which I think we want to avoid. Someone can then fix OMAP4 support if deemed necessary.

>
>Let's discuss further if you are interested.  Perhaps I simply don't 
>understand the patches sufficiently...
>
>A few other thoughts below:
>
>> 
>> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
>> ---
>>  arch/arm/mach-omap2/powerdomain.c             |   37 
>+++++++++++++++++++++----
>>  arch/arm/mach-omap2/powerdomains34xx.h        |   18 ++++++------
>>  arch/arm/plat-omap/include/plat/powerdomain.h |    5 +++
>>  3 files changed, 45 insertions(+), 15 deletions(-)
>> 
>> diff --git a/arch/arm/mach-omap2/powerdomain.c 
>b/arch/arm/mach-omap2/powerdomain.c
>> index 26b3f3e..bdfbbea 100644
>> --- a/arch/arm/mach-omap2/powerdomain.c
>> +++ b/arch/arm/mach-omap2/powerdomain.c
>> @@ -110,8 +110,8 @@ static struct powerdomain 
>*_pwrdm_deps_lookup(struct powerdomain *pwrdm,
>>  static int _pwrdm_state_switch(struct powerdomain *pwrdm, int flag)
>>  {
>>  
>> -	int prev;
>> -	int state;
>> +	u8 prev;
>> +	u8 state;
>>  
>>  	if (pwrdm == NULL)
>>  		return -EINVAL;
>> @@ -218,7 +218,9 @@ int pwrdm_register(struct powerdomain *pwrdm)
>>  
>>  	pr_debug("powerdomain: registered %s\n", pwrdm->name);
>>  	ret = 0;
>> -
>> +	pwrdm->next_state =
>> +		prm_read_mod_bits_shift(pwrdm->prcm_offs, PM_PWSTCTRL,
>> +			OMAP_POWERSTATE_MASK);
>
>(see above)
>
>>  pr_unlock:
>>  	write_unlock_irqrestore(&pwrdm_rwlock, flags);
>>  
>> @@ -699,19 +701,43 @@ int pwrdm_get_mem_bank_count(struct 
>powerdomain *pwrdm)
>>   */
>>  int pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
>>  {
>> +	u8 prg_pwrst;
>> +
>>  	if (!pwrdm)
>>  		return -EINVAL;
>>  
>> +	if (pwrdm->next_state == pwrst)
>> +		return 0;
>> +
>>  	if (!(pwrdm->pwrsts & (1 << pwrst)))
>>  		return -EINVAL;
>>  
>>  	pr_debug("powerdomain: setting next powerstate for %s to %0x\n",
>>  		 pwrdm->name, pwrst);
>>  
>> +	/* INACTIVE is reserved, so we program pwrdm as ON */
>> +	if (pwrst == PWRDM_POWER_INACTIVE)
>> +		prg_pwrst = PWRDM_POWER_ON;
>> +	else
>> +		prg_pwrst = pwrst;
>> +
>>  	prm_rmw_mod_reg_bits(OMAP_POWERSTATE_MASK,
>> -			     (pwrst << OMAP_POWERSTATE_SHIFT),
>> +			     (prg_pwrst << OMAP_POWERSTATE_SHIFT),
>>  			     pwrdm->prcm_offs, PM_PWSTCTRL);
>>  
>> +	/* If next state is ON, prevent idle */
>> +	if (pwrst == PWRDM_POWER_ON) {
>> +		if (omap2_clkdm_get_hwsup(pwrdm->pwrdm_clkdms[0])) {
>> +			omap2_clkdm_deny_idle(pwrdm->pwrdm_clkdms[0]);
>> +			pwrdm->hwsup_changed = 1;
>> +		}
>> +	} else if (pwrdm->hwsup_changed) {
>> +		omap2_clkdm_allow_idle(pwrdm->pwrdm_clkdms[0]);
>> +		pwrdm->hwsup_changed = 0;
>> +	}
>
>For completeness, since this is code that is intended to be 
>chip-agnostic, 
>this code should probably iterate over all of the clockdomains in the 
>powerdomains above, rather than assume that there is only one 
>clockdomain 
>in each powerdomain that is important.

Yeah, this could be done.

>
>> +
>> +	pwrdm->next_state = pwrst;
>> +
>>  	return 0;
>>  }
>>  
>> @@ -728,8 +754,7 @@ int pwrdm_read_next_pwrst(struct 
>powerdomain *pwrdm)
>>  	if (!pwrdm)
>>  		return -EINVAL;
>>  
>> -	return prm_read_mod_bits_shift(pwrdm->prcm_offs, PM_PWSTCTRL,
>> -					OMAP_POWERSTATE_MASK);
>> +	return pwrdm->next_state;
>>  }
>>  
>>  /**
>> diff --git a/arch/arm/mach-omap2/powerdomains34xx.h 
>b/arch/arm/mach-omap2/powerdomains34xx.h
>> index 588f7e0..7a7d8d3 100644
>> --- a/arch/arm/mach-omap2/powerdomains34xx.h
>> +++ b/arch/arm/mach-omap2/powerdomains34xx.h
>> @@ -165,7 +165,7 @@ static struct powerdomain iva2_pwrdm = {
>>  	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
>>  	.dep_bit	  = OMAP3430_PM_WKDEP_MPU_EN_IVA2_SHIFT,
>>  	.wkdep_srcs	  = iva2_wkdeps,
>> -	.pwrsts		  = PWRSTS_OFF_RET_ON,
>> +	.pwrsts		  = PWRSTS_OFF_RET_INA_ON,
>>  	.pwrsts_logic_ret = PWRSTS_OFF_RET,
>>  	.banks		  = 4,
>>  	.pwrsts_mem_ret	  = {
>> @@ -188,7 +188,7 @@ static struct powerdomain mpu_34xx_pwrdm = {
>>  	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
>>  	.dep_bit	  = OMAP3430_EN_MPU_SHIFT,
>>  	.wkdep_srcs	  = mpu_34xx_wkdeps,
>> -	.pwrsts		  = PWRSTS_OFF_RET_ON,
>> +	.pwrsts		  = PWRSTS_OFF_RET_INA_ON,
>>  	.pwrsts_logic_ret = PWRSTS_OFF_RET,
>>  	.flags		  = PWRDM_HAS_MPU_QUIRK,
>>  	.banks		  = 1,
>> @@ -207,7 +207,7 @@ static struct powerdomain 
>core_34xx_pre_es3_1_pwrdm = {
>>  	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES1 |
>>  					   CHIP_IS_OMAP3430ES2 |
>>  					   CHIP_IS_OMAP3430ES3_0),
>> -	.pwrsts		  = PWRSTS_OFF_RET_ON,
>> +	.pwrsts		  = PWRSTS_OFF_RET_INA_ON,
>>  	.dep_bit	  = OMAP3430_EN_CORE_SHIFT,
>>  	.banks		  = 2,
>>  	.pwrsts_mem_ret	  = {
>> @@ -225,7 +225,7 @@ static struct powerdomain 
>core_34xx_es3_1_pwrdm = {
>>  	.name		  = "core_pwrdm",
>>  	.prcm_offs	  = CORE_MOD,
>>  	.omap_chip	  = OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES3_1),
>> -	.pwrsts		  = PWRSTS_OFF_RET_ON,
>> +	.pwrsts		  = PWRSTS_OFF_RET_INA_ON,
>>  	.dep_bit	  = OMAP3430_EN_CORE_SHIFT,
>>  	.flags		  = PWRDM_HAS_HDWR_SAR, /* for USBTLL only */
>>  	.banks		  = 2,
>> @@ -247,7 +247,7 @@ static struct powerdomain dss_pwrdm = {
>>  	.dep_bit	  = OMAP3430_PM_WKDEP_MPU_EN_DSS_SHIFT,
>>  	.wkdep_srcs	  = cam_dss_wkdeps,
>>  	.sleepdep_srcs	  = dss_per_usbhost_sleepdeps,
>> -	.pwrsts		  = PWRSTS_OFF_RET_ON,
>> +	.pwrsts		  = PWRSTS_OFF_RET_INA_ON,
>>  	.pwrsts_logic_ret = PWRDM_POWER_RET,
>>  	.banks		  = 1,
>>  	.pwrsts_mem_ret	  = {
>
>Is the SGX power domain missing here - shouldn't it also be capable of 
>entering INACTIVE?

Yes, however I think I will drop the support to INACTIVE for all the other powerdomains other than MPU/CORE for simplicity.

>
>> @@ -287,7 +287,7 @@ static struct powerdomain cam_pwrdm = {
>>  	.prcm_offs	  = OMAP3430_CAM_MOD,
>>  	.wkdep_srcs	  = cam_dss_wkdeps,
>>  	.sleepdep_srcs	  = cam_gfx_sleepdeps,
>> -	.pwrsts		  = PWRSTS_OFF_RET_ON,
>> +	.pwrsts		  = PWRSTS_OFF_RET_INA_ON,
>>  	.pwrsts_logic_ret = PWRDM_POWER_RET,
>>  	.banks		  = 1,
>>  	.pwrsts_mem_ret	  = {
>> @@ -305,7 +305,7 @@ static struct powerdomain per_pwrdm = {
>>  	.dep_bit	  = OMAP3430_EN_PER_SHIFT,
>>  	.wkdep_srcs	  = per_usbhost_wkdeps,
>>  	.sleepdep_srcs	  = dss_per_usbhost_sleepdeps,
>> -	.pwrsts		  = PWRSTS_OFF_RET_ON,
>> +	.pwrsts		  = PWRSTS_OFF_RET_INA_ON,
>>  	.pwrsts_logic_ret = PWRSTS_OFF_RET,
>>  	.banks		  = 1,
>>  	.pwrsts_mem_ret	  = {
>> @@ -327,7 +327,7 @@ static struct powerdomain neon_pwrdm = {
>>  	.prcm_offs	  = OMAP3430_NEON_MOD,
>>  	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
>>  	.wkdep_srcs	  = neon_wkdeps,
>> -	.pwrsts		  = PWRSTS_OFF_RET_ON,
>> +	.pwrsts		  = PWRSTS_OFF_RET_INA_ON,
>>  	.pwrsts_logic_ret = PWRDM_POWER_RET,
>>  };
>>  
>> @@ -337,7 +337,7 @@ static struct powerdomain usbhost_pwrdm = {
>>  	.omap_chip	  = OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
>>  	.wkdep_srcs	  = per_usbhost_wkdeps,
>>  	.sleepdep_srcs	  = dss_per_usbhost_sleepdeps,
>> -	.pwrsts		  = PWRSTS_OFF_RET_ON,
>> +	.pwrsts		  = PWRSTS_OFF_RET_INA_ON,
>>  	.pwrsts_logic_ret = PWRDM_POWER_RET,
>>  	/*
>>  	 * REVISIT: Enabling usb host save and restore 
>mechanism seems to
>> diff --git a/arch/arm/plat-omap/include/plat/powerdomain.h 
>b/arch/arm/plat-omap/include/plat/powerdomain.h
>> index 0b96005..17377c3 100644
>> --- a/arch/arm/plat-omap/include/plat/powerdomain.h
>> +++ b/arch/arm/plat-omap/include/plat/powerdomain.h
>> @@ -39,6 +39,9 @@
>>  
>>  #define PWRSTS_OFF_RET_ON	(PWRSTS_OFF_RET | (1 << PWRDM_POWER_ON))
>>  
>> +#define PWRSTS_OFF_RET_INA_ON	(PWRSTS_OFF_RET_ON | \
>> +				 (1 << PWRDM_POWER_INACTIVE))
>> +
>>  
>>  /* Powerdomain flags */
>>  #define PWRDM_HAS_HDWR_SAR	(1 << 0) /* hardware 
>save-and-restore support */
>> @@ -123,6 +126,8 @@ struct powerdomain {
>>  	struct list_head node;
>>  
>>  	int state;
>> +	int next_state;
>> +	int hwsup_changed;
>
>Both of these variables can be u8.  Also it would be good to have the 
>kerneldoc documentation for struct powerdomain updated when 
>patches change 
>the structure.

I'll see if I can separate the MPU/CORE from here so that I don't need to hack these structs.

>
>>  	unsigned state_counter[PWRDM_MAX_PWRSTS];
>>  
>>  #ifdef CONFIG_PM_DEBUG
>> -- 
>> 1.5.4.3
>
>regards,
>
>- Paul
>