From: ambresh <a0393775@ti.com>
Subject: Re: [PATCH v4 1/2] OMAP3: SDRC: Dynamic Calculation of SDRC stall
 latency during DVFS
Date: Sun, 21 Mar 2010 18:54:42 +0530
Message-ID: <4BA61E1A.8080603@ti.com>
References: <1268888148-10983-1-git-send-email-pramod.gurav@ti.com> <1268888148-10983-2-git-send-email-pramod.gurav@ti.com> <4BA1D31F.3070809@ti.com> <FCCFB4CDC6E5564B9182F639FC35608703045F2FED@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34031 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752559Ab0CUNZA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 21 Mar 2010 09:25:00 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o2LDOvhY008016
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Sun, 21 Mar 2010 08:24:59 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o2LDOu7p025588
	for <linux-omap@vger.kernel.org>; Sun, 21 Mar 2010 18:54:56 +0530 (IST)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608703045F2FED@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Cc: "K, Ambresh" <ambresh@ti.com>, "Gurav , Pramod" <pramod.gurav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Reddy, Teerth" <teerth@ti.com>

Sripathy, Vishwanath wrote:
> 

>>> +	/* calculate the sram delay */
>>> +	delay_sram = (((mpurate / gt_rate) * diff) / (loop * 2));
>>> +
>>> +	error_gain = mpurate / gt_rate;
>>> +	delay_sram = delay_sram + error_gain;
>> Cosmetic changes:
>>
>>          error_gain = mpurate / gt_rate;
>>          delay_sram = (error_gain * diff) / (loop);
>>          delay_sram += error_gain;
>>
> Why *2 is missing in your code? 2 is needed since the loop takes 2 arm cycles.

its a typo, it should be (loop * 2).

BR,
Ambresh

> 
> Regards
> Vishwa
>> Thanks,
>> Ambresh
>>
>>> +
>>> +	return delay_sram;
>>> +}
>>> +#endif
>>> +
>>>  int __init omap_sram_init(void)
>>>  {
>>>  	omap_detect_sram();
>>>  	omap_map_sram();
>>>
>>> +#ifdef CONFIG_ARCH_OMAP3
>>> +	_omap3_sram_delay = omap_sram_push(__sram_wait_delay,
>>> +						__sram_wait_delay_sz);
>>> +#endif
>>> +
>>>  	if (!(cpu_class_is_omap2()))
>>>  		omap1_sram_init();
>>>  	else if (cpu_is_omap242x())
> 

