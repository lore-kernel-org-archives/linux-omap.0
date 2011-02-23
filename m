From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH] omap: Move omap_hwmod_late_init() to mdesc->timer->init()
 code
Date: Wed, 23 Feb 2011 15:20:01 +0100
Message-ID: <4D651791.8000900@ti.com>
References: <1298385449-27356-1-git-send-email-santosh.shilimkar@ti.com> <alpine.DEB.2.00.1102230015480.22636@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54771 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751114Ab1BWOUG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Feb 2011 09:20:06 -0500
In-Reply-To: <alpine.DEB.2.00.1102230015480.22636@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>

Salut Paul,

On 2/23/2011 8:18 AM, Paul Walmsley wrote:
> Hi Santosh,
>
> On Tue, 22 Feb 2011, Santosh Shilimkar wrote:
>
>> To adhere to recent early_init changes, commit '44dc0' made
>> omap_hwmod_late_init() to core_initcall to avoid ioremap() failures.
>>
>> Later 'e7c7d7' removed _mpu_rt_va population omap_hwmod_late_init()
>>
>> So now if we move the  omap_hwmod_late_init() to mdesc->timer->init(),
>> timer1 should work with hwmod instead of any special hwmod settings.
>>
>> This was proposed by Paul Walmsley<paul@pwsan.com>
>
> thanks -- something like this series was what I had in mind to go to
> mainline:
>
>     http://marc.info/?l=linux-omap&m=129844518908008&w=2
>
> This series is also available at the branch "hwmod_clockevent_2.6.39" of
> git://git.pwsan.com/linux-2.6.
>
> Ultimately, of course, it's up to Tony to decide what approach he wants to
> use...

This is indeed a little bit cleaner to init only the timer hwmod in the 
timer code, but I'm still wondering it it worth the extra complexity.

As soon as we have one hwmod to initialize, why cannot we initialize the 
whole list like before?
If tomorrow we want to handle PRCM and control module using hwmod, like 
I'd like to do, we will have to init these hwmods early as well.
Even earlier that init_early for the control module at least.

And then we will have a bunch of different init paths from different 
parts of the boot sequence that might become tricky to handle.

Regards,
Benoit
