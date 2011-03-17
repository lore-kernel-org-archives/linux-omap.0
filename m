From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH V3 11/19] OMAP3+: SR: fix cosmetic indentation
Date: Thu, 17 Mar 2011 13:02:45 -0700
Message-ID: <87mxkt1pne.fsf@ti.com>
References: <1299338962-5602-1-git-send-email-nm@ti.com>
	<1299338962-5602-12-git-send-email-nm@ti.com> <874o718xyy.fsf@ti.com>
	<alpine.DEB.1.10.1103171939171.2634@esdhcp041196.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:53992 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752970Ab1CQUCs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Mar 2011 16:02:48 -0400
Received: by mail-yi0-f46.google.com with SMTP id 27so1276566yia.19
        for <linux-omap@vger.kernel.org>; Thu, 17 Mar 2011 13:02:47 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.10.1103171939171.2634@esdhcp041196.research.nokia.com>
	(Aaro Koskinen's message of "Thu, 17 Mar 2011 19:43:09 +0200 (EET)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: Nishanth Menon <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Tony <tony@atomide.com>, Paul <paul@pwsan.com>

Aaro Koskinen <aaro.koskinen@nokia.com> writes:

> Hi,
>
> On Thu, 17 Mar 2011, Kevin Hilman wrote:
>>
>> Thanks, queuing for 2.6.40.
>>
> [...]
>>
>>> -		iounmap(sr_info->base);
>>> -		mem = platform_get_resource(sr_info->pdev, IORESOURCE_MEM, 0);
>>> -		release_mem_region(mem->start, resource_size(mem));
>>> -		list_del(&sr_info->node);
>>> -		dev_err(&sr_info->pdev->dev, "%s: ERROR in registering"
>>> -			"interrupt handler. Smartreflex will"
>>> -			"not function as desired\n", __func__);
>>> -		kfree(name);
>>> -		kfree(sr_info);
>>> -		return ret;
>>> +	iounmap(sr_info->base);
>>> +	mem = platform_get_resource(sr_info->pdev, IORESOURCE_MEM, 0);
>>> +	release_mem_region(mem->start, resource_size(mem));
>>> +	list_del(&sr_info->node);
>>> +	dev_err(&sr_info->pdev->dev, "%s: ERROR in registering"
>>> +		"interrupt handler. Smartreflex will"
>>> +		"not function as desired\n", __func__);
>>> +	kfree(name);
>>> +	kfree(sr_info);
>>> +	return ret;
>
> Just FYI, this code is partly broken and probably need to be fixed in .39.

OK

> Some of those resources are also freed by omap_sr_probe() when
> sr_late_init() fails and that cannot be correct.

Got a patch around to fix that?  Sounds like something we should get
into the .39-rc cycle.

Kevin




