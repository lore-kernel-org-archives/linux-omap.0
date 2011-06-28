From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 0/7] OMAP4: Add modulemode support to hwmod framework
 (part 2)
Date: Tue, 28 Jun 2011 11:14:41 +0200
Message-ID: <4E099B81.8080002@ti.com>
References: <1309192391-12410-1-git-send-email-b-cousson@ti.com>	 <1309244182.1825.28.camel@deskari>  <4E098D59.7040108@ti.com> <1309249797.1825.52.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57666 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756316Ab1F1JOr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Jun 2011 05:14:47 -0400
In-Reply-To: <1309249797.1825.52.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 6/28/2011 10:29 AM, Valkeinen, Tomi wrote:
> On Tue, 2011-06-28 at 10:14 +0200, Cousson, Benoit wrote:
>> On 6/28/2011 8:56 AM, Valkeinen, Tomi wrote:
>>> On Mon, 2011-06-27 at 18:33 +0200, Benoit Cousson wrote:
>>>> Hi Paul,
>>>>
>>>> Here is the second part of the modulemode series.
>>>> The goal here is to do the cleanup on the clock nodes and PRCM macros
>>>> that are not needed anymore by the hwmod data.
>>>> Some macros are still needed because of clock data. It should be removed
>>>> once the clock data will be cleaned.
>>>>
>>>> Moreover, in order to get rid of static clkdev, omap_device is trying to
>>>> create dynamically an "fck" alias if a main_clk is defined in hwmod data.
>>>>
>>>> As usual, because of drivers non-adapted to pm_runtime, some temp hacks
>>>> are needed for both MMC and timer1.
>>>> If the drivers are fixes before these series, these temp patches could be
>>>> dropped.
>>>>
>>>> The series is based on for_3.0.1/5_hwmod_clkdm_fixes and tested
>>>> on OMAP4430 ES2.1 + SDP. It should not affect OMAP2&   3, but some testing
>>>> are definitively needed.
>>>>
>>>> The patches are available here:
>>>> git://gitorious.org/omap-pm/linux.git for_3.0.1/6_hwmod_modulemode
>>>
>>> I tested the branch on Blaze, but DSS doesn't work as the clock aliases
>>> have changed, leading to crash. And as only OMAP4 clocks/hwmods were
>>> changed, this makes me believe OMAP2/3 DSS would still work.
>>
>> Mmm, so what alias are you using today? The one from the opt_clock role?
>> In theory, that main_clock should be named "fck" and the secondary or
>> optional clocks will have the name from the role.
>
> You can see the clocks from drivers/video/dss/dss.c:dss_get_clocks(). It
> currently gets these via the clkdev aliases:
>
> - ick
> - fck
> - sys_clk
> - tv_clk
> - video_clk
>
>>> I think the OMAP2/3/4 changes need to be done in sync, and at the same
>>> time keeping the peripherals working.
>>
>> Sure, but first we need to figure out what will be the proper clock alias.
>
> My current pm_runtime patch set removes the omapdss clock aliases from
> arch/arm/mach-omap2/clock44xx_data.c, as the driver uses the opt-clock
> names. Isn't that correct way?

Yes, it is, but we need to take care of the name. The names are local to 
the device, so previously I had to prefix with dss_ every clocks 
affected to the dss_core. Since now, most of them are connected only to 
the relevant hwmod, we can use alias like "fck" if the role of the clock 
is the functional one.

> The opt-clocks that my patch set gets are:
>
> - dss_clk

So that one was the DSS PRCM modulemode and will not exist anymore.

> - sys_clk

That one is OK.

> - hdmi_clk

I guess that one should be name "fck", since only the HDMI hwmod will 
use it.

> - rfbi_iclk

Should be named "ick", but I'm not even sure that one is needed.

> - tv_clk
> - tv_dac_clk

Why do you have two clocks for the tv? I can only see the dss_tv_fclk in 
the spec.

> Additionally these are used to configure the clk rates:
> - dpll4_m4_ck
> - dpll_per_m5x2_ck
>
> The "dss_clk" opt-clock is a bit of an odd-ball. The same clock is used
> as a main-clk and an opt-clock. The driver uses the clock to change the
> clock rates. If the driver can get the main-clock with some built-in
> alias, like "fck", then this opt-clock is not needed. But I wasn't aware
> of such a method.

Maybe because I've just introduced it :-)
OMAP: omap_device: Create clkdev entry for hwmod main_clk

It was not done like that before. Only the opt_clk were used, because 
the main_clk was not relevant. With that series, the main_clk represents 
real clock, and thus can be exposed with "fck" alias.

Benoit

