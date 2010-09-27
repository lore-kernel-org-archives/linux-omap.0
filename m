From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH v2 03/11] OMAP4: Add the new voltage to vsel calculation
 formula
Date: Mon, 27 Sep 2010 14:32:25 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB035E172EFB@dbde02.ent.ti.com>
References: <1285419086-13047-1-git-send-email-thara@ti.com>
 <1285419086-13047-4-git-send-email-thara@ti.com>
 <A83AA0411A704EFC876CC665358490FD@india.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37009 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755652Ab0I0JCe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Sep 2010 05:02:34 -0400
In-Reply-To: <A83AA0411A704EFC876CC665358490FD@india.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Manuel, Lesly Arackal" <leslyam@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>



>>-----Original Message-----
>>From: Manuel, Lesly Arackal
>>Sent: Monday, September 27, 2010 9:44 AM
>>To: Gopinath, Thara; linux-omap@vger.kernel.org
>>Cc: khilman@deeprootsystems.com; paul@pwsan.com; Cousson, Benoit; Sripathy, Vishwanath; Sawant, Anand
>>Subject: RE: [PATCH v2 03/11] OMAP4: Add the new voltage to vsel calculation formula
>>
>>Hi Thara,
>>
>>
>>> -----Original Message-----
>>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>>> owner@vger.kernel.org] On Behalf Of Thara Gopinath
>>> Sent: Saturday, September 25, 2010 6:21 PM
>>> To: linux-omap@vger.kernel.org
>>> Cc: khilman@deeprootsystems.com; paul@pwsan.com; b-cousson@ti.com;
>>> vishwanath.bs@ti.com; sawant@ti.com; Thara Gopinath
>>> Subject: [PATCH v2 03/11] OMAP4: Add the new voltage to vsel calculation
>>> formula
>>>
>>> TWL6030 the power IC used along with OMAP4 in OMAP4 SDPs,
>>> blaze boards and panda boards has a different formula
>>> from that of TWL4030 for voltage to vsel and
>>> vsel to voltage calculation. This patch implements the new
>>> formula depending on the PMIC type.
>>>
>>> Signed-off-by: Thara Gopinath <thara@ti.com>
>>> ---
>>>  arch/arm/plat-omap/opp_twl_tps.c |   71
>>> ++++++++++++++++++++++++++++++++++++++
>>>  1 files changed, 71 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/arm/plat-omap/opp_twl_tps.c b/arch/arm/plat-
>>> omap/opp_twl_tps.c
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
>>> +			twl_i2c_read_u8(TWL6030_MODULE_ID0, &smps_offset,
>>0xE0);
>>> +			is_offset_valid = true;
>>> +		}
>>
>>Is it necessary to do the i2c read each time to check the smps_offset?
>>OR it can be done one time initially.
Hello Lesly,

It is not done every time. It is only done the first time omap_twl_vsel_to_uv
or omap_twl_uv_to_vsel is called. If is_offset_valid, we do not read the register
via i2c interface.

Regards
Thara

