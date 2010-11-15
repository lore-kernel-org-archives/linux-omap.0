From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH v3 1/6] OMAP4: Add the new voltage to vsel calculation
 formula
Date: Mon, 15 Nov 2010 20:16:51 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB035EFF4F6D@dbde02.ent.ti.com>
References: <1288196196-15469-1-git-send-email-thara@ti.com>
 <1288196196-15469-2-git-send-email-thara@ti.com>
 <20101104172417.GC9264@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56231 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757566Ab0KOOrB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Nov 2010 09:47:01 -0500
In-Reply-To: <20101104172417.GC9264@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>



>>-----Original Message-----
>>From: Tony Lindgren [mailto:tony@atomide.com]
>>Sent: Thursday, November 04, 2010 10:54 PM
>>To: Gopinath, Thara
>>Cc: linux-omap@vger.kernel.org; paul@pwsan.com; khilman@deeprootsystems.com;
>>Cousson, Benoit; Sripathy, Vishwanath; Sawant, Anand
>>Subject: Re: [PATCH v3 1/6] OMAP4: Add the new voltage to vsel calculation
>>formula
>>
>>* Thara Gopinath <thara@ti.com> [101027 09:07]:
>>> TWL6030 the power IC used along with OMAP4 in OMAP4 SDPs,
>>> blaze boards and panda boards has a different formula
>>> from that of TWL4030 for voltage to vsel and
>>> vsel to voltage calculation. This patch implements the new
>>> formula depending on the PMIC type.
>>>
>>> Signed-off-by: Thara Gopinath <thara@ti.com>
>>> ---
>>>  arch/arm/plat-omap/opp_twl_tps.c |   71
>>++++++++++++++++++++++++++++++++++++++
>>>  1 files changed, 71 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/arm/plat-omap/opp_twl_tps.c b/arch/arm/plat-
>>omap/opp_twl_tps.c
>>> index 4448fc5..358b67b 100644
>>> --- a/arch/arm/plat-omap/opp_twl_tps.c
>>> +++ b/arch/arm/plat-omap/opp_twl_tps.c
>>> @@ -15,9 +15,16 @@
>>>
>>>  #include <linux/module.h>
>>>
>>> +#include <linux/i2c/twl.h>
>>> +
>>>  #include <plat/opp_twl_tps.h>
>>>  #include <plat/voltage.h>
>>>
>>> +static bool is_offset_valid;
>>> +static u8 smps_offset;
>>> +
>>> +#define REG_SMPS_OFFSET         0xE0
>>> +
>>>  /**
>>>   * omap_twl_vsel_to_vdc - convert TWL/TPS VSEL value to microvolts DC
>>>   * @vsel: TWL/TPS VSEL value to convert
>>> @@ -27,6 +34,38 @@
>>>   */
>>>  unsigned long omap_twl_vsel_to_uv(const u8 vsel)
>>>  {
>>> +	if (twl_class_is_6030()) {
>>> +		/*
>>> +		 * In TWL6030 depending on the value of SMPS_OFFSET
>>> +		 * efuse register the voltage range supported in
>>> +		 * standard mode can be either between 0.6V - 1.3V or
>>> +		 * 0.7V - 1.4V. In TWL6030 ES1.0 SMPS_OFFSET efuse
>>> +		 * is programmed to all 0's where as starting from
>>> +		 * TWL6030 ES1.1 the efuse is programmed to 1
>>> +		 */
>>> +		if (!is_offset_valid) {
>>> +			twl_i2c_read_u8(TWL6030_MODULE_ID0, &smps_offset, 0xE0);
>>> +			is_offset_valid = true;
>>> +		}
>>> +
>>> +		if (smps_offset & 0x8) {
>>> +			return ((((vsel - 1) * 125) + 7000)) * 100;
>>> +		} else {
>>> +			/*
>>> +			 * In case of the supported voltage range being
>>> +			 * between 0.6V - 1.3V, there is not specific
>>> +			 * formula for voltage to vsel conversion above
>>> +			 * 1.3V. There are special hardcoded values for
>>> +			 * voltages above 1.3V. Currently we are hardcodig
>>> +			 * only for 1.35 V which is used for 1GH OPP for
>>> +			 * OMAP4430.
>>> +			 */
>>> +			if (vsel == 0x3A)
>>> +				return 1350000;
>>> +			return ((((vsel - 1) * 125) + 6000)) * 100;
>>> +		}
>>> +	}
>>> +
>>>  	return (((vsel * 125) + 6000)) * 100;
>>>  }
>>
>>Here too you will want to restructure things a bit so you can avoid
>>adding the "if twl_class_is_whatever else if" tests. Usually the best
>>way is to set separate functions for different chips during the init.
Hello Tony,

Thanks for the review.
There is another comment for this patch to drop this file all-together
and move this code to drivers/mfd/twl-core.c. Will take care of your
comment in the new location

Regards
Thara
