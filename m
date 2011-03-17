From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: Re: [PATCH V3 11/19] OMAP3+: SR: fix cosmetic indentation
Date: Thu, 17 Mar 2011 19:43:09 +0200 (EET)
Message-ID: <alpine.DEB.1.10.1103171939171.2634@esdhcp041196.research.nokia.com>
References: <1299338962-5602-1-git-send-email-nm@ti.com> <1299338962-5602-12-git-send-email-nm@ti.com> <874o718xyy.fsf@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.48]:59789 "EHLO mgw-sa02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751576Ab1CQRph (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Mar 2011 13:45:37 -0400
In-Reply-To: <874o718xyy.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Nishanth Menon <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Tony <tony@atomide.com>, Paul <paul@pwsan.com>

Hi,

On Thu, 17 Mar 2011, Kevin Hilman wrote:
>
> Thanks, queuing for 2.6.40.
>
[...]
>
>> -		iounmap(sr_info->base);
>> -		mem = platform_get_resource(sr_info->pdev, IORESOURCE_MEM, 0);
>> -		release_mem_region(mem->start, resource_size(mem));
>> -		list_del(&sr_info->node);
>> -		dev_err(&sr_info->pdev->dev, "%s: ERROR in registering"
>> -			"interrupt handler. Smartreflex will"
>> -			"not function as desired\n", __func__);
>> -		kfree(name);
>> -		kfree(sr_info);
>> -		return ret;
>> +	iounmap(sr_info->base);
>> +	mem = platform_get_resource(sr_info->pdev, IORESOURCE_MEM, 0);
>> +	release_mem_region(mem->start, resource_size(mem));
>> +	list_del(&sr_info->node);
>> +	dev_err(&sr_info->pdev->dev, "%s: ERROR in registering"
>> +		"interrupt handler. Smartreflex will"
>> +		"not function as desired\n", __func__);
>> +	kfree(name);
>> +	kfree(sr_info);
>> +	return ret;

Just FYI, this code is partly broken and probably need to be fixed in .39.

Some of those resources are also freed by omap_sr_probe() when
sr_late_init() fails and that cannot be correct.

A.
