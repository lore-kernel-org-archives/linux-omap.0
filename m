From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 1/2] DSPBRIDGE: remove dependency of mpu freq
Date: Thu, 21 Jan 2010 01:48:00 -0600
Message-ID: <4B5806B0.5070305@ti.com>
References: <1264025953-4620-1-git-send-email-nm@ti.com> <1264025953-4620-2-git-send-email-nm@ti.com> <4B580615.1080700@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42515 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754805Ab0AUHsF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Jan 2010 02:48:05 -0500
In-Reply-To: <4B580615.1080700@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Dasgupta, Romit" <romit@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Ameya Palande <ameya.palande@nokia.com>, "Chitriki Rudramuni, Deepak" <deepak.chitriki@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>

Dasgupta, Romit had written, on 01/21/2010 01:45 AM, the following:
>> @@ -67,6 +92,9 @@ module_init(dspbridge_init);
>>  
>>  static void __exit dspbridge_exit(void)
>>  {
>> +	struct dspbridge_platform_data *pdata = &dspbridge_pdata;
>> +	kfree(pdata->mpu_speeds);
>> +	kfree(pdata->dsp_freq_table);
>>  	platform_device_unregister(dspbridge_pdev);
>>  }
>>  module_exit(dspbridge_exit);
> 
> Ok if pdata->mpu_speeds, pdata->dsp_freq_table are NULL to start with, then you
> need to make them NULL after kfree as well. Otherwise next time you insert the
> module it may fail if pdata_mpu_speeds is initialized but pdata->dsp_freq_table
> is not.
Good catch. thanks.

-- 
Regards,
Nishanth Menon
