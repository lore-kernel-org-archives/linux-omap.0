From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH] OMAP4: pm.c extensions for OMAP4 support
Date: Mon, 16 Aug 2010 19:38:57 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0324221C3E@dbde02.ent.ti.com>
References: <1281950818-13043-1-git-send-email-thara@ti.com>
 <4C6942C6.5080202@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60800 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754147Ab0HPOJF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Aug 2010 10:09:05 -0400
In-Reply-To: <4C6942C6.5080202@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "paul@pwsan.com" <paul@pwsan.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>



>>-----Original Message-----
>>From: Cousson, Benoit
>>Sent: Monday, August 16, 2010 7:23 PM
>>To: Gopinath, Thara
>>Cc: linux-omap@vger.kernel.org; khilman@deeprootsystems.com; paul@pwsan.com; Sripathy, Vishwanath;
>>Sawant, Anand
>>Subject: Re: [PATCH] OMAP4: pm.c extensions for OMAP4 support
>>
>>Hi Thara,
>>
>>On 8/16/2010 11:26 AM, Thara Gopinath wrote:
>>> OMAP4 has an iva device and a dsp devcice where as OMAP2/3
>>> has only an iva device. In this file the iva device in the
>>> system is registered under the name dsp_dev and the API
>>> to retrieve the iva device is omap2_get_dsp_device.
>>> This patch renames the dsp_dev to iva_dev, renames
>>> omap2_get_dsp_device to omap2_get_iva_device,
>>> registers dsp_dev for OMAP4 and adds a new API
>>> omap4_get_dsp_device to retrieve the dep_dev.
>>> This patch also registers the device "l3_main_1" as the l3
>>> device in case of OMAP4 and retains traditional "l3_main"
>>> in case of OMAP2/3
>>
>>This bug is already fixed in the following patch:
>>http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-
>>pm.git;a=commit;h=71a4efad2196d0c52485aa397093c6791a6995f1

Ok. I did not see this. But rests of the changes are still valid.
I will send a V2 skipping this part.

Regards
Thara
>>
>>Regards,
>>Benoit
>>
>>>
>>> Signed-off-by: Thara Gopinath<thara@ti.com>
>>> ---
>>>   arch/arm/mach-omap2/pm.c                 |   24 ++++++++++++++++++------
>>>   arch/arm/plat-omap/include/plat/common.h |    3 ++-
>>>   2 files changed, 20 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
>>> index 68f9f2e..0331290 100644
>>> --- a/arch/arm/mach-omap2/pm.c
>>> +++ b/arch/arm/mach-omap2/pm.c
>>> @@ -21,8 +21,9 @@
>>>   static struct omap_device_pm_latency *pm_lats;
>>>
>>>   static struct device *mpu_dev;
>>> -static struct device *dsp_dev;
>>> +static struct device *iva_dev;
>>>   static struct device *l3_dev;
>>> +static struct device *dsp_dev;
>>>
>>>   struct device *omap2_get_mpuss_device(void)
>>>   {
>>> @@ -30,10 +31,10 @@ struct device *omap2_get_mpuss_device(void)
>>>   	return mpu_dev;
>>>   }
>>>
>>> -struct device *omap2_get_dsp_device(void)
>>> +struct device *omap2_get_iva_device(void)
>>>   {
>>> -	WARN_ON_ONCE(!dsp_dev);
>>> -	return dsp_dev;
>>> +	WARN_ON_ONCE(!iva_dev);
>>> +	return iva_dev;
>>>   }
>>>
>>>   struct device *omap2_get_l3_device(void)
>>> @@ -42,6 +43,13 @@ struct device *omap2_get_l3_device(void)
>>>   	return l3_dev;
>>>   }
>>>
>>> +struct device *omap4_get_dsp_device(void)
>>> +{
>>> +	WARN_ON_ONCE(!dsp_dev);
>>> +	return dsp_dev;
>>> +}
>>> +EXPORT_SYMBOL(omap4_get_dsp_device);
>>> +
>>>   /* static int _init_omap_device(struct omap_hwmod *oh, void *user) */
>>>   static int _init_omap_device(char *name, struct device **new_dev)
>>>   {
>>> @@ -69,8 +77,12 @@ static int _init_omap_device(char *name, struct device **new_dev)
>>>   static void omap2_init_processor_devices(void)
>>>   {
>>>   	_init_omap_device("mpu",&mpu_dev);
>>> -	_init_omap_device("iva",&dsp_dev);
>>> -	_init_omap_device("l3_main",&l3_dev);
>>> +	_init_omap_device("iva",&iva_dev);
>>> +	_init_omap_device("dsp",&dsp_dev);
>>> +	if (cpu_is_omap44xx())
>>> +		_init_omap_device("l3_main_1",&l3_dev);
>>> +	else
>>> +		_init_omap_device("l3_main",&l3_dev);
>>>   }
>>>
>>>   static int __init omap2_common_pm_init(void)
>>> diff --git a/arch/arm/plat-omap/include/plat/common.h b/arch/arm/plat-omap/include/plat/common.h
>>> index 9776b41..c45dbb9 100644
>>> --- a/arch/arm/plat-omap/include/plat/common.h
>>> +++ b/arch/arm/plat-omap/include/plat/common.h
>>> @@ -91,7 +91,8 @@ void omap3_map_io(void);
>>>   })
>>>
>>>   extern struct device *omap2_get_mpuss_device(void);
>>> -extern struct device *omap2_get_dsp_device(void);
>>> +extern struct device *omap2_get_iva_device(void);
>>>   extern struct device *omap2_get_l3_device(void);
>>> +extern struct device *omap4_get_dsp_device(void);
>>>
>>>   #endif /* __ARCH_ARM_MACH_OMAP_COMMON_H */

