From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v4 2/7] OMAP3: PM: Erratum i581 support: dll kick strategy
Date: Mon, 20 Dec 2010 08:21:19 -0600
Message-ID: <4D0F665F.8050804@ti.com>
References: <1292712817-24999-1-git-send-email-nm@ti.com> <1292712817-24999-3-git-send-email-nm@ti.com> <AANLkTi=4DJAnXcTZ37rcmr9Kz2CmXx6uhPqNThnoR2gu@mail.gmail.com> <20101220113322.GS31404@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:53877 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753843Ab0LTOVW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Dec 2010 09:21:22 -0500
Received: by mail-gy0-f174.google.com with SMTP id 11so1206500gyb.19
        for <linux-omap@vger.kernel.org>; Mon, 20 Dec 2010 06:21:22 -0800 (PST)
In-Reply-To: <20101220113322.GS31404@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: ext Jean Pihet <jean.pihet@newoldbits.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Kevin <khilman@deeprootsystems.com>, Tony <tony@atomide.com>

Peter 'p2' De Schrijver had written, on 12/20/2010 05:33 AM, the following:
[..]
>>> +       /* these 2 words need to be at the end !!! */
>>> +kick_counter:
>>> +       .word   0
>>> +wait_dll_lock_counter:
>>> +       .word   0
>> Why do they need to be at the end? Also, at the end of what do they need to be?
>>
> 
> At the end of omap34xx_cpu_suspend. As we don't know where in SRAM the
> counters will be, the code accessing those counters addresses them
> relative from (_omap_sram_idle + omap34xx_cpu_suspend_sz). Not sure if
> this part of the code made it to linux-omap though.
I have not posted the change needed to expose these counters to 
userspace waiting for the churn in sleep34xx.S to settle down.

-- 
Regards,
Nishanth Menon
