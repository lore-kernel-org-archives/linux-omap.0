From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 4/5] omap2plus: voltage: Trivial linking fix 'undefined
 reference'
Date: Tue, 04 Jan 2011 12:52:54 -0600
Message-ID: <4D236C86.10703@ti.com>
References: <1294165576-15628-1-git-send-email-santosh.shilimkar@ti.com> <1294165576-15628-2-git-send-email-santosh.shilimkar@ti.com> <1294165576-15628-3-git-send-email-santosh.shilimkar@ti.com> <1294165576-15628-4-git-send-email-santosh.shilimkar@ti.com> <1294165576-15628-5-git-send-email-santosh.shilimkar@ti.com> <4D236AFB.2050301@ti.com> <2a7055e7c506648a2a48a0454756687b@mail.gmail.com> <d7800f7a785b294a089ea8772607d232@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:53334 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751127Ab1ADSw6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Jan 2011 13:52:58 -0500
Received: by mail-gw0-f43.google.com with SMTP id 17so7593498gwb.2
        for <linux-omap@vger.kernel.org>; Tue, 04 Jan 2011 10:52:58 -0800 (PST)
In-Reply-To: <d7800f7a785b294a089ea8772607d232@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Thara Gopinath <thara@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

Santosh Shilimkar had written, on 01/04/2011 12:50 PM, the following:
[..]
>>>> +static inline struct voltagedomain
>>> *omap_voltage_domain_lookup(char *name)
>>>> +{
>>>> +	return NULL;
>>> the omap_voltage_domain_lookup uses ERR_PTR() for all return
>> values
>>> which are handled by the callers with IS_ERR()
>>>
>>> I think you should return ERR_PTR(-EINVAL)
>>>
>> The expected return value is pointer type and hence used
>> NULL.
> 
> 'ERR_PTR(-EINVAL)' is also ok.
looking at the implementation (when CONFIG_PM is enabled),
http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=blob;f=arch/arm/mach-omap2/voltage.c;h=ed6079c94c57bae30f599bbad5e25a38fc676fa8;hb=refs/heads/omap-for-linus#l1487
ERR_PTR(-EINVAL) looks more appropriate to me.

-- 
Regards,
Nishanth Menon
