From: <Tero.Kristo@nokia.com>
Subject: RE: [PATCHv2 5/6] OMAP: Powerdomains: Add support for checking if
 pwrdm/clkdm can idle
Date: Wed, 13 Jan 2010 09:14:54 +0100
Message-ID: <1F18D6510CF0474A8C9500565A7E41A223723AB953@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1259916781-2741-1-git-send-email-tero.kristo@nokia.com>
	<1259916781-2741-2-git-send-email-tero.kristo@nokia.com>
	<1259916781-2741-3-git-send-email-tero.kristo@nokia.com>
	<1259916781-2741-4-git-send-email-tero.kristo@nokia.com>
	<1259916781-2741-5-git-send-email-tero.kristo@nokia.com>
	<1259916781-2741-6-git-send-email-tero.kristo@nokia.com>
 <876377b18b.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:57550 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754785Ab0AMIRY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jan 2010 03:17:24 -0500
In-Reply-To: <876377b18b.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org

 

>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org 
>[mailto:linux-omap-owner@vger.kernel.org] On Behalf Of ext Kevin Hilman
>Sent: 12 January, 2010 20:57
>To: Kristo Tero (Nokia-D/Tampere)
>Cc: linux-omap@vger.kernel.org
>Subject: Re: [PATCHv2 5/6] OMAP: Powerdomains: Add support for 
>checking if pwrdm/clkdm can idle
>
>Tero Kristo <tero.kristo@nokia.com> writes:
>
>> From: Tero Kristo <tero.kristo@nokia.com>
>>
>> pwrdm_can_idle(pwrdm) will check if the specified 
>powerdomain can enter
>> idle. This is done by checking all clockdomains under the powerdomain
>> if they can idle also.
>>
>> omap2_clkdm_can_idle(clkdm) will check if the specified 
>clockdomain can
>> enter idle. This checks the functional clock status in the 
>clockdomain.
>>
>> These calls can be used e.g. inside cpuidle to decide which 
>power states
>> core and mpu should enter during idle, as there are certain 
>dependencies
>> between wakeup capabilities and reset logic.
>>
>> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
>
>This looks good by me, but needs a review from Paul to go upstream with
>the rest of his clockdomain/powerdomain updates for 2.6.34.
>
>One question... I'm wondering if it might be good to also check the
>CM_IDLEST_<pwrdm> register in the can_idle function.  Even if all
>clocks are disabled, if the idle modes of the module are not 
>set correctly,
>it may not enter the target state.

Hmm I guess you are right here. I think at least one case would be secure devices which do not have FCLK control on the non-secure kernel, but their IDLEST would indeed block state transition. I'll investigate this a bit and update the patch.


>
>Kevin
>
>> ---
>>  arch/arm/mach-omap2/clockdomain.c             |   24 
>++++++++++++++++++++++++
>>  arch/arm/mach-omap2/clockdomains.h            |   14 ++++++++++++++
>>  arch/arm/mach-omap2/powerdomain.c             |   25 
>+++++++++++++++++++++++++
>>  arch/arm/plat-omap/include/plat/clockdomain.h |   12 ++++++++++++
>>  arch/arm/plat-omap/include/plat/powerdomain.h |    1 +
>>  5 files changed, 76 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/clockdomain.c 
>b/arch/arm/mach-omap2/clockdomain.c
>> index fcd8232..9ddeb96 100644
>> --- a/arch/arm/mach-omap2/clockdomain.c
>> +++ b/arch/arm/mach-omap2/clockdomain.c
>> @@ -474,6 +474,30 @@ int omap2_clkdm_wakeup(struct 
>clockdomain *clkdm)
>>  	return 0;
>>  }
>>  
>> +
>> +/**
>> + * omap2_clkdm_can_idle - check if clockdomain has any 
>active clocks or not
>> + * @clkdm: struct clockdomain *
>> + *
>> + * Checks if the clockdomain has any active clock or not, 
>i.e. whether it
>> + * can enter idle. Returns -EINVAL if clkdm is NULL; 0 if 
>unable to idle;
>> + * 1 if can idle.
>> + */
>> +int omap2_clkdm_can_idle(struct clockdomain *clkdm)
>> +{
>> +	int i;
>> +	const int fclk_regs[] = { CM_FCLKEN, OMAP3430ES2_CM_FCLKEN3 };
>> +
>> +	if (!clkdm)
>> +		return -EINVAL;
>> +
>> +	for (i = 0; i < clkdm->fclk_reg_amt; i++)
>> +		if (cm_read_mod_reg(clkdm->pwrdm.ptr->prcm_offs,
>> +				    fclk_regs[i]) & 
>~clkdm->fclk_masks[i])
>> +			return 0;
>> +	return 1;
>> +}
>> +
>>  /**
>>   * omap2_clkdm_allow_idle - enable hwsup idle transitions for clkdm
>>   * @clkdm: struct clockdomain *
>> diff --git a/arch/arm/mach-omap2/clockdomains.h 
>b/arch/arm/mach-omap2/clockdomains.h
>> index c4ee076..2cde82a 100644
>> --- a/arch/arm/mach-omap2/clockdomains.h
>> +++ b/arch/arm/mach-omap2/clockdomains.h
>> @@ -167,6 +167,7 @@ static struct clockdomain iva2_clkdm = {
>>  	.flags		= CLKDM_CAN_HWSUP_SWSUP,
>>  	.clktrctrl_mask = OMAP3430_CLKTRCTRL_IVA2_MASK,
>>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
>> +	.fclk_reg_amt	= 1,
>>  };
>>  
>>  static struct clockdomain gfx_3430es1_clkdm = {
>> @@ -183,6 +184,7 @@ static struct clockdomain sgx_clkdm = {
>>  	.flags		= CLKDM_CAN_HWSUP_SWSUP,
>>  	.clktrctrl_mask = OMAP3430ES2_CLKTRCTRL_SGX_MASK,
>>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
>> +	.fclk_reg_amt	= 1,
>>  };
>>  
>>  /*
>> @@ -206,6 +208,11 @@ static struct clockdomain core_l3_34xx_clkdm = {
>>  	.flags		= CLKDM_CAN_HWSUP,
>>  	.clktrctrl_mask = OMAP3430_CLKTRCTRL_L3_MASK,
>>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
>> +	.fclk_reg_amt	= 2,
>> +	.fclk_masks	= {
>> +		[0] = OMAP3430_EN_UART2 | OMAP3430_EN_UART1,
>> +		[1] = 0,
>> +	},
>>  };
>>  
>>  static struct clockdomain core_l4_34xx_clkdm = {
>> @@ -222,6 +229,7 @@ static struct clockdomain dss_34xx_clkdm = {
>>  	.flags		= CLKDM_CAN_HWSUP_SWSUP,
>>  	.clktrctrl_mask = OMAP3430_CLKTRCTRL_DSS_MASK,
>>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
>> +	.fclk_reg_amt	= 1,
>>  };
>>  
>>  static struct clockdomain cam_clkdm = {
>> @@ -230,6 +238,7 @@ static struct clockdomain cam_clkdm = {
>>  	.flags		= CLKDM_CAN_HWSUP_SWSUP,
>>  	.clktrctrl_mask = OMAP3430_CLKTRCTRL_CAM_MASK,
>>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
>> +	.fclk_reg_amt	= 1,
>>  };
>>  
>>  static struct clockdomain usbhost_clkdm = {
>> @@ -238,6 +247,7 @@ static struct clockdomain usbhost_clkdm = {
>>  	.flags		= CLKDM_CAN_HWSUP_SWSUP,
>>  	.clktrctrl_mask = OMAP3430ES2_CLKTRCTRL_USBHOST_MASK,
>>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
>> +	.fclk_reg_amt	= 1,
>>  };
>>  
>>  static struct clockdomain per_clkdm = {
>> @@ -246,6 +256,10 @@ static struct clockdomain per_clkdm = {
>>  	.flags		= CLKDM_CAN_HWSUP_SWSUP,
>>  	.clktrctrl_mask = OMAP3430_CLKTRCTRL_PER_MASK,
>>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
>> +	.fclk_reg_amt	= 1,
>> +	.fclk_masks	= {
>> +		[0] = OMAP3430_EN_UART3,
>> +	},
>>  };
>>  
>>  /*
>> diff --git a/arch/arm/mach-omap2/powerdomain.c 
>b/arch/arm/mach-omap2/powerdomain.c
>> index 1237717..2bef099 100644
>> --- a/arch/arm/mach-omap2/powerdomain.c
>> +++ b/arch/arm/mach-omap2/powerdomain.c
>> @@ -1217,6 +1217,31 @@ int pwrdm_wait_transition(struct 
>powerdomain *pwrdm)
>>  	return 0;
>>  }
>>  
>> +/**
>> + * pwrdm_can_idle - check if the powerdomain can enter idle
>> + * @pwrdm: struct powerdomain * the powerdomain to check status of
>> + *
>> + * Checks all associated clockdomains if they can idle or not.
>> + * Returns 1 if the powerdomain can idle, 0 if not.
>> + */
>> +int pwrdm_can_idle(struct powerdomain *pwrdm)
>> +{
>> +	unsigned long flags;
>> +	int i;
>> +	int ret = 1;
>> +
>> +	read_lock_irqsave(&pwrdm_rwlock, flags);
>> +
>> +	for (i = 0; i < PWRDM_MAX_CLKDMS; i++)
>> +		if (pwrdm->pwrdm_clkdms[i] &&
>> +		    !omap2_clkdm_can_idle(pwrdm->pwrdm_clkdms[i]))
>> +			ret = 0;
>> +
>> +	read_unlock_irqrestore(&pwrdm_rwlock, flags);
>> +
>> +	return ret;
>> +}
>> +
>>  int pwrdm_state_switch(struct powerdomain *pwrdm)
>>  {
>>  	return _pwrdm_state_switch(pwrdm, PWRDM_STATE_NOW);
>> diff --git a/arch/arm/plat-omap/include/plat/clockdomain.h 
>b/arch/arm/plat-omap/include/plat/clockdomain.h
>> index eb73482..4dfb820 100644
>> --- a/arch/arm/plat-omap/include/plat/clockdomain.h
>> +++ b/arch/arm/plat-omap/include/plat/clockdomain.h
>> @@ -30,6 +30,12 @@
>>  #define CLKDM_CAN_SWSUP		(CLKDM_CAN_FORCE_SLEEP 
>| CLKDM_CAN_FORCE_WAKEUP)
>>  #define CLKDM_CAN_HWSUP_SWSUP	(CLKDM_CAN_SWSUP | 
>CLKDM_CAN_HWSUP)
>>  
>> +/*
>> + * Maximum number of FCLK register masks that can be 
>associated with a
>> + * clockdomain. CORE powerdomain on OMAP3 is the worst case
>> + */
>> +#define CLKDM_MAX_FCLK				2
>> +
>>  /* OMAP24XX CM_CLKSTCTRL_*.AUTOSTATE_* register bit values */
>>  #define OMAP24XX_CLKSTCTRL_DISABLE_AUTO		0x0
>>  #define OMAP24XX_CLKSTCTRL_ENABLE_AUTO		0x1
>> @@ -83,6 +89,10 @@ struct clockdomain {
>>  	/* OMAP chip types that this clockdomain is valid on */
>>  	const struct omap_chip_id omap_chip;
>>  
>> +	/* For idle checks */
>> +	u8 fclk_reg_amt;
>> +	u32 fclk_masks[CLKDM_MAX_FCLK];
>> +
>>  	/* Usecount tracking */
>>  	atomic_t usecount;
>>  
>> @@ -108,4 +118,6 @@ int omap2_clkdm_sleep(struct clockdomain *clkdm);
>>  int omap2_clkdm_clk_enable(struct clockdomain *clkdm, 
>struct clk *clk);
>>  int omap2_clkdm_clk_disable(struct clockdomain *clkdm, 
>struct clk *clk);
>>  
>> +int omap2_clkdm_can_idle(struct clockdomain *clkdm);
>> +
>>  #endif
>> diff --git a/arch/arm/plat-omap/include/plat/powerdomain.h 
>b/arch/arm/plat-omap/include/plat/powerdomain.h
>> index 55350d0..e6a227f 100644
>> --- a/arch/arm/plat-omap/include/plat/powerdomain.h
>> +++ b/arch/arm/plat-omap/include/plat/powerdomain.h
>> @@ -177,6 +177,7 @@ int pwrdm_disable_hdwr_sar(struct 
>powerdomain *pwrdm);
>>  bool pwrdm_has_hdwr_sar(struct powerdomain *pwrdm);
>>  
>>  int pwrdm_wait_transition(struct powerdomain *pwrdm);
>> +int pwrdm_can_idle(struct powerdomain *pwrdm);
>>  
>>  int pwrdm_state_switch(struct powerdomain *pwrdm);
>>  int pwrdm_clkdm_state_switch(struct clockdomain *clkdm);
>> -- 
>> 1.5.4.3
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe 
>linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>--
>To unsubscribe from this list: send the line "unsubscribe 
>linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>