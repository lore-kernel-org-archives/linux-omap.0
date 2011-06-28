From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 0/7] OMAP4: Add modulemode support to hwmod framework
 (part 2)
Date: Tue, 28 Jun 2011 10:14:17 +0200
Message-ID: <4E098D59.7040108@ti.com>
References: <1309192391-12410-1-git-send-email-b-cousson@ti.com> <1309244182.1825.28.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57418 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755036Ab1F1IOW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Jun 2011 04:14:22 -0400
In-Reply-To: <1309244182.1825.28.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 6/28/2011 8:56 AM, Valkeinen, Tomi wrote:
> On Mon, 2011-06-27 at 18:33 +0200, Benoit Cousson wrote:
>> Hi Paul,
>>
>> Here is the second part of the modulemode series.
>> The goal here is to do the cleanup on the clock nodes and PRCM macros
>> that are not needed anymore by the hwmod data.
>> Some macros are still needed because of clock data. It should be removed
>> once the clock data will be cleaned.
>>
>> Moreover, in order to get rid of static clkdev, omap_device is trying to
>> create dynamically an "fck" alias if a main_clk is defined in hwmod data.
>>
>> As usual, because of drivers non-adapted to pm_runtime, some temp hacks
>> are needed for both MMC and timer1.
>> If the drivers are fixes before these series, these temp patches could be
>> dropped.
>>
>> The series is based on for_3.0.1/5_hwmod_clkdm_fixes and tested
>> on OMAP4430 ES2.1 + SDP. It should not affect OMAP2&  3, but some testing
>> are definitively needed.
>>
>> The patches are available here:
>> git://gitorious.org/omap-pm/linux.git for_3.0.1/6_hwmod_modulemode
>
> I tested the branch on Blaze, but DSS doesn't work as the clock aliases
> have changed, leading to crash. And as only OMAP4 clocks/hwmods were
> changed, this makes me believe OMAP2/3 DSS would still work.

Mmm, so what alias are you using today? The one from the opt_clock role?
In theory, that main_clock should be named "fck" and the secondary or 
optional clocks will have the name from the role.

> I think the OMAP2/3/4 changes need to be done in sync, and at the same
> time keeping the peripherals working.

Sure, but first we need to figure out what will be the proper clock alias.

Regards,
Benoit
