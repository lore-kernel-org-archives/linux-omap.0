From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 12/19] omap3+: sr: disable interrupt by default
Date: Wed, 02 Mar 2011 16:59:31 -0800
Message-ID: <87ei6pt3ws.fsf@ti.com>
References: <1298116918-30744-1-git-send-email-nm@ti.com>
	<1298116918-30744-13-git-send-email-nm@ti.com> <8739n5vz3g.fsf@ti.com>
	<4D6EE04D.600@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:40780 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751612Ab1CCA7s (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 19:59:48 -0500
Received: by iwc10 with SMTP id 10so482401iwc.10
        for <linux-omap@vger.kernel.org>; Wed, 02 Mar 2011 16:59:48 -0800 (PST)
In-Reply-To: <4D6EE04D.600@ti.com> (Nishanth Menon's message of "Thu, 03 Mar
	2011 05:56:53 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

Nishanth Menon <nm@ti.com> writes:

> Kevin Hilman wrote, on 03/03/2011 05:45 AM:
>> Nishanth Menon<nm@ti.com>  writes:
>>
>>> We will enable and disable interrupt on a need basis in the class
>>> driver. we need to keep the irq disabled by default else the
>>> forceupdate or vcbypass events could trigger events that we dont
>>> need/expect to handle.
>>
>> It's not clear from the patch where the IRQ is re-enabled.  For example,
>> without knowing better, I would expect a corresponding change to the
>> Class 3 driver to enable/disable the IRQ as needed.
>
> Why would that be?
> a) class 3 driver does not request for any notifiers
> b) class 3 does'nt need interrupts.
> c) each class driver can choose to enable when it needs it - class3 does'nt.
>
> is it fine if I add a "this is a preperation for class drivers such as
> class 2 and class 1.5 which would need to use interrupts" in commit
> message?

Yes, also stating/summarizing that existing class driver (e.g. class 3)
does not use interrupts would be helpful.

Kevin
