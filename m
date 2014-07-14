From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: l2c: squelch warning dump on power control
 setting
Date: Mon, 14 Jul 2014 16:16:21 +0530
Message-ID: <53C3B4FD.9040806@ti.com>
References: <20140707110249.GO28884@atomide.com> <53BA8983.3030803@ti.com> <20140707121512.GT3705@n2100.arm.linux.org.uk> <20140707123925.GW28884@atomide.com> <20140707134008.GU3705@n2100.arm.linux.org.uk> <20140707151024.GJ5582@saruman.home> <53BB7980.2060909@ti.com> <20140708082948.GE28884@atomide.com> <20140709092531.GK28884@atomide.com> <53BD34FD.5070005@ti.com> <20140709123950.GV3705@n2100.arm.linux.org.uk> <53BD4E9A.7060903@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39164 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752967AbaGNKqv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Jul 2014 06:46:51 -0400
In-Reply-To: <53BD4E9A.7060903@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, balbi@ti.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>

On Wednesday 09 July 2014 07:45 PM, Santosh Shilimkar wrote:
> On Wednesday 09 July 2014 08:39 AM, Russell King - ARM Linux wrote:
>> On Wed, Jul 09, 2014 at 05:56:37PM +0530, Sekhar Nori wrote:
>>> On Wednesday 09 July 2014 02:55 PM, Tony Lindgren wrote:
>>>> I guess no more comments. Took a look at the patch again, Sekhar, can
>>>> you please update the description with what has been discovered in this
>>>> thread and repost?
>>>
>>> How does the following sound:
>>>
>>> ---
>>> AM437x has L2C-310 version r3p2 and ROM code on that device does not
>>> support writing to L2C-310 power control register. The L2C driver,
>>> however, tries writing to this register for all revisions >= r3p0.
>>>
>>> This leads to a warning dump on boot which leads most users to believe
>>> that L2 cache is non-functional.
>>>
> Power controller register setting doesn't make cache controller
> functional but it is for really clock gating and standby.
> So please reword, the above statement accordingly.

I think you misunderstood the context here. I am not claiming that power
controller setting (or the absence of it) is  making the L2 cache
non-functional. The line addresses the "Why?" part of why I am creating
the patch - because the warning misleads people into thinking something
went wrong with cache initialization when nothing is wrong really.

> 
>>> Since the problem is understood, and cannot be addressed through
>>> software, replace the warning with a pr_info() while maintaining the
>>> WARN_ON() for other truly unexpected scenarios.
>>>
> Instead of being vague here and below, I will just make it very simple as
> below.
> 
> On OMAP SOCs using PL310 controllers, Power_ctrl register is not
> accessible from non-secure software on PL310 versions which supports
> it. The secure code takes care of setting it up correctly and the
> power transitions are proven on these devices.
> 
> So lets add the ignore write check for PL310 Power_ctrl register
> write.

Since the description is already okayed by others, instead of changing
it completely and starting a re-review, I just prepended your input into
an opening paragraph and removed the last para on OMAP4. I will send out
a v2 shortly with this description.

---
On OMAP SOCs using PL310 controllers, power_ctrl register is not
accessible from non-secure software on PL310 versions which supports
it. The secure code takes care of setting it up correctly and the
power transitions are proven on these devices.

For example, AM437x has L2C-310 version r3p3 and ROM code on that device
does not support writing to L2C-310 power control register. The L2C
driver, however, tries writing to this register for all revisions >= r3p0.

This leads to a warning dump on boot which leads most users to believe
that L2 cache is non-functional.

Since the problem is understood, and cannot be addressed through
software, replace the warning with a pr_info() while maintaining the
WARN_ON() for other truly unexpected scenarios.
---

Thanks,
Sekhar

