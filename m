From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH v3 08/11] OMAP3: PM: Adding debug support to Voltage and
 Smartreflex drivers
Date: Thu, 30 Sep 2010 11:28:58 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB035E173B98@dbde02.ent.ti.com>
References: <1285166719-19352-1-git-send-email-thara@ti.com>
	<1285166719-19352-9-git-send-email-thara@ti.com>
 <87k4m4qgr4.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56229 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751759Ab0I3F7F convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Sep 2010 01:59:05 -0400
In-Reply-To: <87k4m4qgr4.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>



>>-----Original Message-----
>>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>Sent: Thursday, September 30, 2010 4:50 AM
>>To: Gopinath, Thara
>>Cc: linux-omap@vger.kernel.org; paul@pwsan.com; Cousson, Benoit; Sripathy,
>>Vishwanath; Sawant, Anand
>>Subject: Re: [PATCH v3 08/11] OMAP3: PM: Adding debug support to Voltage and
>>Smartreflex drivers
>>
>>Thara Gopinath <thara@ti.com> writes:
>>
>>[...]
>>
>>> diff --git a/arch/arm/plat-omap/include/plat/voltage.h b/arch/arm/plat-
>>omap/include/plat/voltage.h
>>> index 99836a1..8978d33 100644
>>> --- a/arch/arm/plat-omap/include/plat/voltage.h
>>> +++ b/arch/arm/plat-omap/include/plat/voltage.h
>>> @@ -14,6 +14,11 @@
>>>  #ifndef __ARCH_ARM_MACH_OMAP2_VOLTAGE_H
>>>  #define __ARCH_ARM_MACH_OMAP2_VOLTAGE_H
>>>
>>> +extern u32 enable_sr_vp_debug;
>>> +#ifdef CONFIG_PM_DEBUG
>>> +extern struct dentry *pm_dbg_main_dir;
>>> +#endif
>>> +
>>>  #define VOLTSCALE_VPFORCEUPDATE		1
>>>  #define VOLTSCALE_VCBYPASS		2
>>
>>This belongs in PATCH 1/11 and belongs in pm.h, not voltage.h as it's a
>>feature of the PM debug layer, not the voltage layer.

Yes indeed!! Will fix this in v4

Regards
Thara
