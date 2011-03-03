From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 12/19] omap3+: sr: disable interrupt by default
Date: Thu, 03 Mar 2011 06:53:22 +0530
Message-ID: <4D6EED8A.7000809@ti.com>
References: <1298116918-30744-1-git-send-email-nm@ti.com>	<1298116918-30744-13-git-send-email-nm@ti.com> <8739n5vz3g.fsf@ti.com>	<4D6EE04D.600@ti.com> <87ei6pt3ws.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:34848 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756100Ab1CCBXa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 20:23:30 -0500
Received: by mail-vw0-f49.google.com with SMTP id 7so575140vws.8
        for <linux-omap@vger.kernel.org>; Wed, 02 Mar 2011 17:23:29 -0800 (PST)
In-Reply-To: <87ei6pt3ws.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

Kevin Hilman wrote, on 03/03/2011 06:29 AM:
> Nishanth Menon<nm@ti.com>  writes:
>
>> Kevin Hilman wrote, on 03/03/2011 05:45 AM:
>>> Nishanth Menon<nm@ti.com>   writes:
>>>
>>>> We will enable and disable interrupt on a need basis in the class
>>>> driver. we need to keep the irq disabled by default else the
>>>> forceupdate or vcbypass events could trigger events that we dont
>>>> need/expect to handle.
>>>
>>> It's not clear from the patch where the IRQ is re-enabled.  For example,
>>> without knowing better, I would expect a corresponding change to the
>>> Class 3 driver to enable/disable the IRQ as needed.
>>
>> Why would that be?
>> a) class 3 driver does not request for any notifiers
>> b) class 3 does'nt need interrupts.
>> c) each class driver can choose to enable when it needs it - class3 does'nt.
>>
>> is it fine if I add a "this is a preperation for class drivers such as
>> class 2 and class 1.5 which would need to use interrupts" in commit
>> message?
>
> Yes, also stating/summarizing that existing class driver (e.g. class 3)
> does not use interrupts would be helpful.
Ack. will do in v3.

-- 
Regards,
Nishanth Menon
