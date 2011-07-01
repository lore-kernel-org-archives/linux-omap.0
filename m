From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v2 04/13] OMAP: hwmod: Wait the idle status to be disabled
Date: Fri, 1 Jul 2011 15:10:04 +0200
Message-ID: <4E0DC72C.3080906@ti.com>
References: <1309189641-25010-1-git-send-email-b-cousson@ti.com> <1309189641-25010-5-git-send-email-b-cousson@ti.com> <alpine.DEB.2.00.1107010632200.27025@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60854 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754529Ab1GANKJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Jul 2011 09:10:09 -0400
In-Reply-To: <alpine.DEB.2.00.1107010632200.27025@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Nayak, Rajendra" <rnayak@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 7/1/2011 2:34 PM, Paul Walmsley wrote:
> Hi
>
> two comments on this one:
>
> On Mon, 27 Jun 2011, Benoit Cousson wrote:
>
>> It is mandatory to wait for a module to be in disabled state before
>> potentially disabling source clock or re-asserting a reset.
>>
>> omap_hwmod_idle and omap_hwmod_shutdown does not wait for
>> the module to be fully idle.
>>
>> Add a cm_xxx accessor to wait the clkctrl idle status to be disabled.
>> Fix hwmod_[idle|shutdown] to use this API.
>>
>> Based on Rajendra's initial patch.
>>
>> Please note that most interconnects hwmod will return one timeout because
>> it is impossible for them to be in idle since the processor is accessing
>> the registers though the interconnect.
>
> Should we have some flag in the data for this so the code does not waste
> time waiting for those modules to go idle?

That was my initial thought, but I still didn't fully understand the 
reason for all the IPs. For some interconnect paths it makes sense, but 
for some other, I'm still wondering.
This is something we will have to do once we will have a better 
understanding of that status.

Benoit

>> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
>> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>> Cc: Paul Walmsley<paul@pwsan.com>
>> ---
>>   arch/arm/mach-omap2/cminst44xx.c |   25 +++++++++++++++++++++++
>>   arch/arm/mach-omap2/cminst44xx.h |    1 +
>>   arch/arm/mach-omap2/omap_hwmod.c |   40 ++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 66 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/cminst44xx.c b/arch/arm/mach-omap2/cminst44xx.c
>> index 1df740e..fa44ff5 100644
>> --- a/arch/arm/mach-omap2/cminst44xx.c
>> +++ b/arch/arm/mach-omap2/cminst44xx.c
>> @@ -244,3 +244,28 @@ int omap4_cm_wait_module_ready(u8 part, u16 inst, s16 cdoffs, u16 clkctrl_offs)
>>   	return (i<  MAX_MODULE_READY_TIME) ? 0 : -EBUSY;
>>   }
>>
>> +/**
>> + * omap4_cm_wait_module_idle - wait for a module to be in 'disabled'
>> + * state
>> + * @part: PRCM partition ID that the CM_CLKCTRL register exists in
>> + * @inst: CM instance register offset (*_INST macro)
>> + * @cdoffs: Clockdomain register offset (*_CDOFFS macro)
>> + * @clkctrl_offs: Module clock control register offset (*_CLKCTRL macro)
>> + *
>> + * Wait for the module IDLEST to be disabled. Some PRCM transition,
>> + * like reset assertion or parent clock de-activation must wait the
>> + * module to be fully disabled.
>> + */
>> +int omap4_cm_wait_module_idle(u8 part, u16 inst, s16 cdoffs, u16 clkctrl_offs)
>> +{
>> +	int i = 0;
>> +
>> +	if (!clkctrl_offs)
>> +		return 0;
>> +
>> +	omap_test_timeout(
>> +		_clkctrl_idlest(part, inst, cdoffs, clkctrl_offs) == 0x3,
>> +		MAX_MODULE_READY_TIME, i);
>> +
>> +	return (i<  MAX_MODULE_READY_TIME) ? 0 : -EBUSY;
>> +}
>> diff --git a/arch/arm/mach-omap2/cminst44xx.h b/arch/arm/mach-omap2/cminst44xx.h
>> index 9d39c70..4c5da7d 100644
>> --- a/arch/arm/mach-omap2/cminst44xx.h
>> +++ b/arch/arm/mach-omap2/cminst44xx.h
>> @@ -18,6 +18,7 @@ extern void omap4_cminst_clkdm_force_sleep(u8 part, s16 inst, u16 cdoffs);
>>   extern void omap4_cminst_clkdm_force_wakeup(u8 part, s16 inst, u16 cdoffs);
>>
>>   extern int omap4_cm_wait_module_ready(u8 part, u16 inst, s16 cdoffs, u16 clkctrl_offs);
>> +extern int omap4_cm_wait_module_idle(u8 part, u16 inst, s16 cdoffs, u16 clkctrl_offs);
>>
>>   /*
>>    * In an ideal world, we would not export these low-level functions,
>> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
>> index ea1c976..adbd4b8 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod.c
>> @@ -1029,6 +1029,36 @@ static int _wait_target_ready(struct omap_hwmod *oh)
>>   }
>>
>>   /**
>> + * _wait_target_disable - wait for a module to be disabled
>> + * @oh: struct omap_hwmod *
>> + *
>> + * Wait for a module @oh to leave slave idle.  Returns 0 if the module
>> + * does not have an IDLEST bit or if the module successfully leaves
>> + * slave idle; otherwise, pass along the return value of the
>> + * appropriate *_cm_wait_module_ready() function.
>> + */
>> +static int _wait_target_disable(struct omap_hwmod *oh)
>> +{
>> +	if (!oh)
>> +		return -EINVAL;
>> +
>> +	if (oh->_int_flags&  _HWMOD_NO_MPU_PORT)
>> +		return 0;
>> +
>> +	if (oh->flags&  HWMOD_NO_IDLEST)
>> +		return 0;
>> +
>> +	/* TODO: For now just handle OMAP4+ */
>> +	if (cpu_is_omap24xx() || cpu_is_omap34xx())
>> +		return 0;
>
> This is a pretty minor issue, but I'd suggest moving this up to the
> top of this function so the compiler can optimize it out completely on
> non-OMAP4 builds.
>
>> +
>> +	return omap4_cm_wait_module_idle(oh->clkdm->prcm_partition,
>> +					 oh->clkdm->cm_inst,
>> +					 oh->clkdm->clkdm_offs,
>> +					 oh->prcm.omap4.clkctrl_offs);
>> +}
>> +
>> +/**
>>    * _lookup_hardreset - fill register bit info for this hwmod/reset line
>>    * @oh: struct omap_hwmod *
>>    * @name: name of the reset line in the context of this hwmod
>> @@ -1335,6 +1365,8 @@ static int _enable(struct omap_hwmod *oh)
>>    */
>>   static int _idle(struct omap_hwmod *oh)
>>   {
>> +	int ret;
>> +
>>   	if (oh->_state != _HWMOD_STATE_ENABLED) {
>>   		WARN(1, "omap_hwmod: %s: idle state can only be entered from "
>>   		     "enabled state\n", oh->name);
>> @@ -1347,6 +1379,10 @@ static int _idle(struct omap_hwmod *oh)
>>   		_idle_sysc(oh);
>>   	_del_initiator_dep(oh, mpu_oh);
>>   	_disable_clocks(oh);
>> +	ret = _wait_target_disable(oh);
>> +	if (ret)
>> +		pr_debug("omap_hwmod: %s: _wait_target_disable failed\n",
>> +			   oh->name);
>>
>>   	/* Mux pins for device idle if populated */
>>   	if (oh->mux&&  oh->mux->pads_dynamic)
>> @@ -1439,6 +1475,10 @@ static int _shutdown(struct omap_hwmod *oh)
>>   		_del_initiator_dep(oh, mpu_oh);
>>   		/* XXX what about the other system initiators here? dma, dsp */
>>   		_disable_clocks(oh);
>> +		ret = _wait_target_disable(oh);
>> +		if (ret)
>> +			pr_debug("omap_hwmod: %s: _wait_target_disable failed\n",
>> +				   oh->name);
>>   	}
>>   	/* XXX Should this code also force-disable the optional clocks? */
>>
>> --
>> 1.7.0.4
>>
>
>
> - Paul

