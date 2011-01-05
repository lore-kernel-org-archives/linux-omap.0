From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH] OMAP3: PM: Adding T2 enabling of smartreflex
Date: Wed, 5 Jan 2011 16:16:32 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0373D2F0E0@dbde02.ent.ti.com>
References: <1293782878-9756-1-git-send-email-thara@ti.com>
 <4D21F09D.3040007@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48438 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751507Ab1AEKqn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Jan 2011 05:46:43 -0500
In-Reply-To: <4D21F09D.3040007@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>



>>-----Original Message-----
>>From: Menon, Nishanth
>>Sent: Monday, January 03, 2011 9:22 PM
>>To: Gopinath, Thara
>>Cc: linux-omap@vger.kernel.org; khilman@deeprootsystems.com;
>>paul@pwsan.com; Cousson, Benoit; Sripathy, Vishwanath; Sawant, Anand
>>Subject: Re: [PATCH] OMAP3: PM: Adding T2 enabling of smartreflex
>>
>>Thara Gopinath had written, on 12/31/2010 02:07 AM, the following:
>>> The smartreflex bit on twl4030 needs to be enabled by default
>>irrespective
>>> of whether smartreflex module is enabled on the OMAP side or not.
>>> This is because without this bit enabled the voltage scaling through
>>> vp forceupdate does not function properly on OMAP3.
>>s/does not function properly/ does not function ;)
>>SR I2C is used for forceupdate/vc bypass modes - so neither will
>>function without switching t2 mode.
>>
>>T2 voltages could be set in quiet a few methods:
>>a) Synchronized Scaling Hardware Strategy (ENABLE_VMODE = 1) (for OMAP2
>>and I had worked on one OMAP3430 product which used this as well) using
>>VDD1_VFLOOR and VDD1_VROOF
>>b) Direct Strategy Software Scaling Mode (ENABLE_VMODE = 0) (Smart
>>reflex disabled) - VDD1_VSEL
>>c) using smart reflex - as done below - allows OMAP with smart reflex
>>hardware wired to the twl to use that functionality.
>>
>>Blindly setting it to smartreflex mode is not correct IMHO. It might
>>work on SDP and few TI and non-TI platforms, but not all.

Yes you are right. The SR I2C needs to be enabled for vp force update
and vc bypass method of voltage scaling as well as for smartreflex
feature. Are you telling that there are platforms out there using OMAP3
and T2 and still using VMODE or VSEL. As far as I am aware our h/w folks themselves do not recommend these methods. 

Regards
Thara

>>
>>>
>>> Signed-off-by: Thara Gopinath <thara@ti.com>
>>> ---
>>> This patch is against LO master and has been
>>> tested on OMAP3430 SDP and OMAP2430 SDP.
>>>
>>>  arch/arm/mach-omap2/omap_twl.c |   16 ++++++++++++++++
>>>  1 files changed, 16 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-
>>omap2/omap_twl.c
>>> index 15f8c6c..a59f36b 100644
>>> --- a/arch/arm/mach-omap2/omap_twl.c
>>> +++ b/arch/arm/mach-omap2/omap_twl.c
>>> @@ -58,7 +58,9 @@
>>>  static bool is_offset_valid;
>>>  static u8 smps_offset;
>>>
>>> +#define TWL4030_DCDC_GLOBAL_CFG	0x06
>>>  #define REG_SMPS_OFFSET         0xE0
>>> +#define SMARTREFLEX_ENABLE	BIT(3)
>>>
>>>  unsigned long twl4030_vsel_to_uv(const u8 vsel)
>>>  {
>>> @@ -256,6 +258,7 @@ int __init omap4_twl_init(void)
>>>  int __init omap3_twl_init(void)
>>>  {
>>>  	struct voltagedomain *voltdm;
>>> +	u8 temp;
>>>
>>>  	if (!cpu_is_omap34xx())
>>>  		return -ENODEV;
>>> @@ -267,6 +270,19 @@ int __init omap3_twl_init(void)
>>>  		omap3_core_volt_info.vp_vddmax = OMAP3630_VP2_VLIMITTO_VDDMAX;
>>>  	}
>>>
>>> +	/*
>>> +	 * The smartreflex bit on twl4030 needs to be enabled by
>>> +	 * default irrespective of whether smartreflex module is
>>> +	 * enabled on the OMAP side or not. This is because without
>>> +	 * this bit enabled the voltage scaling through
>>> +	 * vp forceupdate does not function properly on OMAP3.
>>> +	 */
>>> +	twl_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER, &temp,
>>> +			TWL4030_DCDC_GLOBAL_CFG);
>>> +	temp |= SMARTREFLEX_ENABLE;
>>> +	twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, temp,
>>> +			TWL4030_DCDC_GLOBAL_CFG);
>>> +
>>>  	voltdm = omap_voltage_domain_lookup("mpu");
>>>  	omap_voltage_register_pmic(voltdm, &omap3_mpu_volt_info);
>>>
>>
>>
>>--
>>Regards,
>>Nishanth Menon
