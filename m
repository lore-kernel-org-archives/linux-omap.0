From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH 07/16] OMAP3: PM: Adding smartreflex class 3 driver.
Date: Fri, 5 Mar 2010 20:33:58 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0321CBD2B2@dbde02.ent.ti.com>
References: <1267003757-22456-1-git-send-email-thara@ti.com>
	<1267003757-22456-2-git-send-email-thara@ti.com>
	<1267003757-22456-3-git-send-email-thara@ti.com>
	<1267003757-22456-4-git-send-email-thara@ti.com>
	<1267003757-22456-5-git-send-email-thara@ti.com>
	<1267003757-22456-6-git-send-email-thara@ti.com>
	<1267003757-22456-7-git-send-email-thara@ti.com>
	<1267003757-22456-8-git-send-email-thara@ti.com>
 <87y6iav7lh.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60324 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751771Ab0CEPEG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Mar 2010 10:04:06 -0500
In-Reply-To: <87y6iav7lh.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Menon, Nishanth" <nm@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>



>>-----Original Message-----
>>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>Sent: Wednesday, March 03, 2010 1:07 AM
>>To: Gopinath, Thara
>>Cc: linux-omap@vger.kernel.org; paul@pwsan.com; Menon, Nishanth; Cousson, Benoit; Sripathy,
>>Vishwanath; Sawant, Anand
>>Subject: Re: [PATCH 07/16] OMAP3: PM: Adding smartreflex class 3 driver.
>>
>>Thara Gopinath <thara@ti.com> writes:
>>
>>> This patch adds smartreflex class 3 driver. This driver hooks
>>> up with the generic smartreflex driver smartreflex.c to abstract
>>> out class specific implementations out of the generic driver.
>>>
>>> Signed-off-by: Thara Gopinath <thara@ti.com>
>>
>>I like this abstraction, but I don't like that it still uses OPP IDs.
>>
>>So, before doing this, we need to get rid of OPP IDs from the
>>smartreflex layer and keep OPP ID usage isolated to SRF.
>>
>>It appears the only reason we need OPP IDs in SR is because the Nvalue
>>tables are indexed by OPP ID in sr_enable().

Actually this is not true. If you see my patch14 sr err_minlimit and vp errorgain are opp dependent. In fact for 3630 for VDD1 there are 4 supported OPP's and 4 different values for err_minlimit and errorgain - one for each opp. So we might still need the opp id.
>>
>>One way to fix this is for this SR layer to keep it's own mapping of
>>voltage to nvalue.  So instead of taking OPP ID, sr_enable() should
>>take a voltage (or frequency) and use that to look up the nvalue.
>>
>>a couple other minor comments below...

Thank you for these comments and I will fix them in V2

Regards
Thara
>>
>>> ---
>>>  arch/arm/mach-omap2/Makefile             |    1 +
>>>  arch/arm/mach-omap2/smartreflex-class3.c |   49 ++++++++++++++++++++++++++++++
>>>  arch/arm/plat-omap/Kconfig               |   11 ++++++-
>>>  3 files changed, 60 insertions(+), 1 deletions(-)
>>>  create mode 100644 arch/arm/mach-omap2/smartreflex-class3.c
>>>
>>> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
>>> index f6f901f..cd8ab86 100644
>>> --- a/arch/arm/mach-omap2/Makefile
>>> +++ b/arch/arm/mach-omap2/Makefile
>>> @@ -52,6 +52,7 @@ obj-$(CONFIG_ARCH_OMAP2)		+= sleep24xx.o
>>>  obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o cpuidle34xx.o
>>>  obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
>>>  obj-$(CONFIG_OMAP_SMARTREFLEX)	+= smartreflex.o
>>> +obj-$(CONFIG_OMAP_SMARTREFLEX_CLASS3)	+= smartreflex-class3.o
>>>
>>>  AFLAGS_sleep24xx.o			:=-Wa,-march=armv6
>>>  AFLAGS_sleep34xx.o			:=-Wa,-march=armv7-a
>>> diff --git a/arch/arm/mach-omap2/smartreflex-class3.c b/arch/arm/mach-omap2/smartreflex-class3.c
>>> new file mode 100644
>>> index 0000000..d2e98a5
>>> --- /dev/null
>>> +++ b/arch/arm/mach-omap2/smartreflex-class3.c
>>> @@ -0,0 +1,49 @@
>>> +/*
>>> + * Smart reflex Class 3 specific implementations
>>> + *
>>> + * Copyright (C) 2009 Texas Instruments, Inc.
>>
>>2010
>>
>>> + * Thara Gopinath <thara@ti.com>
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License version 2 as
>>> + * published by the Free Software Foundation.
>>> + */
>>> +
>>> +#include "smartreflex.h"
>>> +
>>> +static int sr_class3_enable(int id)
>>> +{
>>> +	int target_opp_no = 0;
>>
>>insert blank line
>>
>>> +	if (id == SR1)
>>> +		target_opp_no = get_vdd1_opp();
>>> +	else if (id == SR2)
>>> +		target_opp_no = get_vdd2_opp();
>>> +	if (!target_opp_no) {
>>> +		pr_warning("Targetopp not known.Cannot enable SR%d\n", id);
>>> +		return false;
>>> +	}
>>
>>and here
>>
>>> +	return sr_enable(id, target_opp_no);
>>> +}
>>>
>>> +static int sr_class3_disable(int id)
>>> +{
>>> +	int target_opp_no = 0;
>>
>>blank line
>>
>>> +	if (id == SR1)
>>> +		target_opp_no = get_vdd1_opp();
>>> +	else if (id == SR2)
>>> +		target_opp_no = get_vdd2_opp();
>>> +	sr_disable(id);
>>
>>blank line
>>
>>> +	return true;
>>> +}
>>> +/* SR class3 structure */
>>> +struct omap_smartreflex_class_data class3_data = {
>>> +	.enable = sr_class3_enable,
>>> +	.disable = sr_class3_disable,
>>> +};
>>> +
>>> +static int __init sr_class3_init(void)
>>> +{
>>> +	omap_sr_register_class(&class3_data);
>>> +	return 0;
>>> +}
>>> +late_initcall(sr_class3_init);
>>> diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
>>> index cef67f3..9d286e6 100644
>>> --- a/arch/arm/plat-omap/Kconfig
>>> +++ b/arch/arm/plat-omap/Kconfig
>>> @@ -54,7 +54,7 @@ config OMAP_DEBUG_LEDS
>>>
>>>  config OMAP_SMARTREFLEX
>>>  	bool "SmartReflex support"
>>> -	depends on ARCH_OMAP3 && TWL4030_CORE && PM
>>> +	depends on ARCH_OMAP3 && PM
>>>  	help
>>>  	  Say Y if you want to enable SmartReflex.
>>>
>>> @@ -69,6 +69,15 @@ config OMAP_SMARTREFLEX
>>>  	  compensation for VDD1 and VDD2, user must write 1 to
>>>  	  /sys/power/sr_vddX_autocomp, where X is 1 or 2.
>>>
>>> +config OMAP_SMARTREFLEX_CLASS3
>>> +	bool "Class 3 mode of Smartreflex Implementation"
>>> +	depends on OMAP_SMARTREFLEX && TWL4030_CORE
>>> +	help
>>> +	  Say Y to enable Class 3 implementation of Smartreflex
>>> +
>>> +	  Class 3 implementation of Smartreflex employs continuous hardware
>>> +	  voltage caliberation.
>>> +
>>>  config OMAP_SMARTREFLEX_TESTING
>>>  	bool "Smartreflex testing support"
>>>  	depends on OMAP_SMARTREFLEX
>>> --
>>> 1.7.0.rc1.33.g07cf0f
