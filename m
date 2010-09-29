From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH v3 03/11] OMAP3: PM: Adding smartreflex driver support.
Date: Wed, 29 Sep 2010 20:11:26 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB035E1739F5@dbde02.ent.ti.com>
References: <1285166719-19352-1-git-send-email-thara@ti.com>
	<1285166719-19352-4-git-send-email-thara@ti.com>
 <87iq1pa1jk.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41273 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751835Ab0I2Olf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Sep 2010 10:41:35 -0400
In-Reply-To: <87iq1pa1jk.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>



>>-----Original Message-----
>>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>Sent: Wednesday, September 29, 2010 5:01 AM
>>To: Gopinath, Thara
>>Cc: linux-omap@vger.kernel.org; paul@pwsan.com; Cousson, Benoit; Sripathy,
>>Vishwanath; Sawant, Anand
>>Subject: Re: [PATCH v3 03/11] OMAP3: PM: Adding smartreflex driver support.
>>
>>Thara Gopinath <thara@ti.com> writes:
>>
>>> SmartReflex modules do adaptive voltage control for real-time
>>> voltage adjustments. With Smartreflex the power supply voltage
>>> can be adapted to the silicon performance(manufacturing process,
>>> temperature induced performance, age induced performance etc).
>>>
>>> There are differnet classes of smartreflex implementation.
>>> 	Class-0: Manufacturing Test Calibration
>>> 	Class-1: Boot-Time Software Calibration
>>> 	Class-2: Continuous Software Calibration
>>> 	Class-3: Continuous Hardware Calibration
>>> 	Class-4: Fully Integrated Power Management
>>>
>>> OMAP3 has two smartreflex modules one associated with VDD1 and the
>>> other associated with VDD2.
>>> This patch adds support for  smartreflex driver. The driver is designed
>>> for Class-1 , Class-2 and Class-3 support and is  a platform driver.
>>> Smartreflex driver can be enabled through a Kconfig option
>>> "SmartReflex support" under "System type"->"TI OMAP implementations" menu.
>>>
>>> Smartreflex autocompensation feature can be enabled runtime through
>>> a debug fs option.
>>> To enable smartreflex autocompensation feature
>>> 	echo 1 > /debugfs/pm_debug/smartreflex/sr_<X>/autocomp
>>> To disable smartreflex autocompensation feature
>>> 	echo 0 > /debugfs/pm_debug/smartreflex/sr_<X>/autocomp
>>>
>>> where X can be mpu, core , iva etc.
>>>
>>
>>[...]
>>
>>> +static void sr_set_regfields(struct omap_sr *sr)
>>> +{
>>> +	/*
>>> +	 * For time being these values are defined in smartreflex.h
>>> +	 * and populated during init. May be they can be moved to board
>>> +	 * file or pmic specific data structure. In that case these structure
>>> +	 * fields will have to be populated using the pdata or pmic structure.
>>> +	 */
>>> +	if (cpu_is_omap34xx()) {
>>> +		sr->err_weight = OMAP3430_SR_ERRWEIGHT;
>>> +		sr->err_maxlimit = OMAP3430_SR_ERRMAXLIMIT;
>>> +		sr->accum_data = OMAP3430_SR_ACCUMDATA;
>>> +		if (!(strcmp(sr->voltdm->name, "mpu"))) {
>>> +			sr->senn_avgweight = OMAP3430_SR1_SENNAVGWEIGHT;
>>> +			sr->senp_avgweight = OMAP3430_SR1_SENPAVGWEIGHT;
>>> +		} else {
>>> +			sr->senn_avgweight = OMAP3430_SR2_SENNAVGWEIGHT;
>>> +			sr->senp_avgweight = OMAP3430_SR2_SENPAVGWEIGHT;
>>> +		}
>>> +	}
>>> +	/* TODO: 3630 and Omap4 specific bit field values */
>>
>>This comment is still present even after the OMAP4 series is applied.
>>
>>[...]
>>
>>> +/*
>>> + * 3430 specific values. Maybe these should be passed from board file or
>>> + * pmic structures.
>>> + */
>>> +#define OMAP3430_SR_ACCUMDATA		0x1f4
>>> +
>>> +#define OMAP3430_SR1_SENPAVGWEIGHT	0x03
>>> +#define OMAP3430_SR1_SENNAVGWEIGHT	0x03
>>> +
>>> +#define OMAP3430_SR2_SENPAVGWEIGHT	0x01
>>> +#define OMAP3430_SR2_SENNAVGWEIGHT	0x01
>>> +
>>> +#define OMAP3430_SR_ERRWEIGHT		0x04
>>> +#define OMAP3430_SR_ERRMAXLIMIT		0x02
>>> +
>>> +/* TODO:3630/OMAP4 values if it has to come from this file */
>>
>>ditto
>>
>>It's best to just not put these kind of things into the code in the
>>first place, they tend to be forgotten and stale quickly.

Will fix this and post V4. 
>>
>>Kevin
