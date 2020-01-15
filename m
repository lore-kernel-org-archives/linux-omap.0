From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv4 08/14] remoteproc/omap: remove the platform_data header
Date: Wed, 15 Jan 2020 14:58:46 +0200
Message-ID: <4a5d7320-1950-4ea8-19ee-3d09caeb3f80@ti.com>
References: <20200102131845.12992-1-t-kristo@ti.com>
 <20200102131845.12992-9-t-kristo@ti.com>
 <4391856a-d956-751e-6d38-02f8306bb691@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lelv0142.ext.ti.com ([198.47.23.249]:50432 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgAOM6u (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Wed, 15 Jan 2020 07:58:50 -0500
In-Reply-To: <4391856a-d956-751e-6d38-02f8306bb691@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>, bjorn.andersson@linaro.org, ohad@wizery.com, linux-remoteproc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org, linux-omap@vger.kernel.org

On 08/01/2020 21:44, Suman Anna wrote:
> On 1/2/20 7:18 AM, Tero Kristo wrote:
>> The platform data header for OMAP remoteproc is no longer used for
>> anything post ti-sysc conversion, so just remove it completely.
> 
> Thanks for removing the header now altogether,
> %s/ti-sysc/ti-sysc and DT/ to be more accurate.
> 
> With that,
> Acked-by: Suman Anna <s-anna@ti.com>

Ok, will change that.

-Tero

> 
> regards
> Suman
> 
>>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> ---
>> v4:
>>    - new patch, to remove the platform data file completely compared to
>>      patches #8 / #9 in previous version of the series
>>
>>   include/linux/platform_data/remoteproc-omap.h | 51 -------------------
>>   1 file changed, 51 deletions(-)
>>   delete mode 100644 include/linux/platform_data/remoteproc-omap.h
>>
>> diff --git a/include/linux/platform_data/remoteproc-omap.h b/include/linux/platform_data/remoteproc-omap.h
>> deleted file mode 100644
>> index 7e3a16097672..000000000000
>> --- a/include/linux/platform_data/remoteproc-omap.h
>> +++ /dev/null
>> @@ -1,51 +0,0 @@
>> -/* SPDX-License-Identifier: GPL-2.0-only */
>> -/*
>> - * Remote Processor - omap-specific bits
>> - *
>> - * Copyright (C) 2011 Texas Instruments, Inc.
>> - * Copyright (C) 2011 Google, Inc.
>> - */
>> -
>> -#ifndef _PLAT_REMOTEPROC_H
>> -#define _PLAT_REMOTEPROC_H
>> -
>> -struct rproc_ops;
>> -struct platform_device;
>> -
>> -/*
>> - * struct omap_rproc_pdata - omap remoteproc's platform data
>> - * @name: the remoteproc's name
>> - * @oh_name: omap hwmod device
>> - * @oh_name_opt: optional, secondary omap hwmod device
>> - * @firmware: name of firmware file to load
>> - * @mbox_name: name of omap mailbox device to use with this rproc
>> - * @ops: start/stop rproc handlers
>> - * @device_enable: omap-specific handler for enabling a device
>> - * @device_shutdown: omap-specific handler for shutting down a device
>> - * @set_bootaddr: omap-specific handler for setting the rproc boot address
>> - */
>> -struct omap_rproc_pdata {
>> -	const char *name;
>> -	const char *oh_name;
>> -	const char *oh_name_opt;
>> -	const char *firmware;
>> -	const char *mbox_name;
>> -	const struct rproc_ops *ops;
>> -	int (*device_enable)(struct platform_device *pdev);
>> -	int (*device_shutdown)(struct platform_device *pdev);
>> -	void (*set_bootaddr)(u32);
>> -};
>> -
>> -#if defined(CONFIG_OMAP_REMOTEPROC) || defined(CONFIG_OMAP_REMOTEPROC_MODULE)
>> -
>> -void __init omap_rproc_reserve_cma(void);
>> -
>> -#else
>> -
>> -static inline void __init omap_rproc_reserve_cma(void)
>> -{
>> -}
>> -
>> -#endif
>> -
>> -#endif /* _PLAT_REMOTEPROC_H */
>>
> 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
