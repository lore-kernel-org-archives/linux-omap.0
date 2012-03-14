From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 01/12] mfd: twl-core: don't depend on pdata->irq_base/end
Date: Wed, 14 Mar 2012 14:17:54 -0700
Message-ID: <87y5r2evb1.fsf@ti.com>
References: <1330707024-23730-1-git-send-email-b-cousson@ti.com>
	<1330707024-23730-2-git-send-email-b-cousson@ti.com>
	<87pqcegapk.fsf@ti.com> <4F6108C1.2060004@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog134.obsmtp.com ([74.125.149.83]:41590 "EHLO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1030915Ab2CNVRn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Mar 2012 17:17:43 -0400
Received: by mail-pz0-f45.google.com with SMTP id p14so9487632dad.18
        for <linux-omap@vger.kernel.org>; Wed, 14 Mar 2012 14:17:42 -0700 (PDT)
In-Reply-To: <4F6108C1.2060004@ti.com> (Benoit Cousson's message of "Wed, 14
	Mar 2012 22:08:17 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: sameo@linux.intel.com, tony@atomide.com, grant.likely@secretlab.ca, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>

"Cousson, Benoit" <b-cousson@ti.com> writes:

> On 3/14/2012 9:59 PM, Kevin Hilman wrote:
>> Benoit Cousson<b-cousson@ti.com>  writes:
>>
>>> From: Felipe Balbi<balbi@ti.com>
>>>
>>> With sparse IRQs the driver shouldn't depend at all on
>>> any IRQ values coming from board-file.
>>>
>>> Remove every occurences of pdata->irq_base/end.
>>
>> Well, not quite *every*. :)
>
> Hehe, good catch, thanks.
>
>> If the driver isn't going to use those fields anymore, they should also
>> be removed from the pdata struct too[1].  Also, the remaining board/init
>> code that is initializing those fields should be removed as well[2], since
>> it obviously has no effect.
>>
>> The first patch below should probably be folded into this one, and then
>> the 2nd patch removes all the users.
>
> We should probably remove all the users before removing the attribute?
> It looks like your patches are ordered in the opposite way.

Agreed.

> I'll add that in the series and repost the pull request.

Great, thanks.

Kevin
