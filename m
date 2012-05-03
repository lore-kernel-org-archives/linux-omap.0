From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH-V6 0/3] ARM: OMAP: Make OMAP clocksource source selection
 runtime
Date: Thu, 3 May 2012 13:19:41 -0500
Message-ID: <4FA2CC3D.8000804@ti.com>
References: <1335967014-11937-1-git-send-email-hvaibhav@ti.com> <4FA19162.5040102@ti.com> <79CD15C6BA57404B839C016229A409A83EA11F12@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45208 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754345Ab2ECSTt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 May 2012 14:19:49 -0400
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA11F12@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "tony@atomide.com" <tony@atomide.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Vaibhav,

On 05/03/2012 12:07 AM, Hiremath, Vaibhav wrote:
> On Thu, May 03, 2012 at 01:26:18, Hunter, Jon wrote:
>> Hi Vaibhav,
>>
>> On 05/02/2012 08:56 AM, Vaibhav Hiremath wrote:
>>> Current OMAP code supports couple of clocksource options based
>>> on compilation flag (CONFIG_OMAP_32K_TIMER). The 32KHz sync-timer
>>> and a gptimer which can run on 32KHz or system clock (e.g 38.4 MHz)
>>>
>>> This patch series cleans up the existing 32k-sync timer implementation,
>>> movind SoC init code to respective files (mach-omap1/timer32k.c and
>>> mach-omap2/timer.c) and uses kernel parameter to override the default
>>> clocksource of "counter_32k", also in order to support some OMAP based
>>> derivative SoCs like AM33XX which doesn't have 32K sync-timer hardware IP,
>>> adds hwmod lookup for omap2+ devices, and if lookup fails then
>>> fall back to gp-timer.
>>>
>>> if(use_gptimer_clksrc == true)
>>> 	gptimer clocksource init;
>>> else if (counter_32 init == false)
>>> 	/* Fallback to gptimer */
>>> 	gptimer clocksource init(;
>>>
>>> With this, we should be able to support multi-omap boot
>>> including devices with/without 32k-sync timer.
>>>
>>> This patch-series has been boot tested on AM37xEVM platform, it
>>> would be helpful if somebody help me to validate it on OMAP1/2
>>> platforms.
>>>
>>> The patches are also available at (based on linux-omap/master) -
>>> https://github.com/hvaibhav/am335x-linux   32ksync-timer-cleanup
>>
>> I was testing on OMAP4 and I found that the gptimer was always being set by default. I noticed that currently the HWMOD for counter_32k on OMAP4 is commented and hence was not being found. Please can you include the following with your series?
>>
> 
> The 32kcounter hwmod entry is already enabled in linux-omap/master branch.
> 
> Your baseline looks pretty old to me, are you not using linux-omap/master?

Ha! My "old" baseline is the latest mainline kernel ;-)

I guess this is a bit out-dated in terms of omap now. Sorry I missed
that fact your patches were on top of the omap kernel in the changelog.

Cheers
Jon
