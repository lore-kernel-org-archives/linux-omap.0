From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH] OMAP3: PM: Adding T2 enabling of smartreflex
Date: Wed, 5 Jan 2011 16:21:18 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0373D2F0E6@dbde02.ent.ti.com>
References: <1293782878-9756-1-git-send-email-thara@ti.com>
 <87ipy45lr3.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49545 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751630Ab1AEKv1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Jan 2011 05:51:27 -0500
In-Reply-To: <87ipy45lr3.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>, "Menon, Nishanth" <nm@ti.com>



>>-----Original Message-----
>>From: Hilman, Kevin
>>Sent: Wednesday, January 05, 2011 4:18 AM
>>To: Gopinath, Thara
>>Cc: linux-omap@vger.kernel.org; paul@pwsan.com; Cousson, Benoit; Sripathy,
>>Vishwanath; Sawant, Anand; Menon, Nishanth
>>Subject: Re: [PATCH] OMAP3: PM: Adding T2 enabling of smartreflex
>>
>>Thara Gopinath <thara@ti.com> writes:
>>
>>> The smartreflex bit on twl4030 needs to be enabled by default
>>irrespective
>>> of whether smartreflex module is enabled on the OMAP side or not.
>>> This is because without this bit enabled the voltage scaling through
>>> vp forceupdate does not function properly on OMAP3.
>>
>>Based on Nishanth's comments, the abofe statements need a little more
>>justification.
>>
>>What is probably needed is some default setting (possibly this one) but
>>with the possibility of board code to disable this if needed.

Yes. If we need to support the other means of voltage scaling, we definitely need to override this bit from board files. I am not so convinced that we need to support them though. IMHO, this patch can still go in with change in the comment and if needed, there can be another patch with an API in omap_twl.c allowing overriding/ enabling-disabling of sr - i2c bit on
the T2 side.

Regards
Thara

>>
>>Kevin
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
