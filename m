From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH V3 6/8] ARM: OMAP4: Route PMU IRQs to CTI IRQs
Date: Mon, 24 Sep 2012 14:46:10 -0500
Message-ID: <5060B882.3060007@ti.com>
References: <1347290626-21164-1-git-send-email-jon-hunter@ti.com> <1347290626-21164-7-git-send-email-jon-hunter@ti.com> <alpine.DEB.2.00.1209201655060.12583@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37178 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750770Ab2IXTqT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Sep 2012 15:46:19 -0400
In-Reply-To: <alpine.DEB.2.00.1209201655060.12583@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Ming Lei <ming.lei@canonical.com>, Woodruff Richard <r-woodruff2@ti.com>, Will Deacon <will.deacon@arm.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>


On 09/20/2012 11:59 AM, Paul Walmsley wrote:
> Hi
> 
> On Mon, 10 Sep 2012, Jon Hunter wrote:
> 
>> From: Ming Lei <ming.lei@canonical.com>
>>
>> For OMAP4430 there are no dedicate PMU interrupts, however, PMU events can be
>> routed to via the CTI IRQs. This allows tools such as PERF and OPROFILE to work
>> on OMAP4430.
>>
>> The idea is from Woodruff Richard in the disscussion about "Oprofile on
>> Pandaboard / Omap4" on pandaboard@googlegroups.com.
>>
>> Ming's original patch was called "arm: omap4: support pmu" [1] and has been
>> renamed and modified by Jon Hunter. There main differences from the original
>> patch are ...
>>
>> 1. Instead of only configuring the CTI interrupt once during boot, the
>>    interrupts are configured everytime the the PMU is used. The reason for this
>>    is because during power transitions the CTI logic state will be lost and so
>>    we will need to configure the interrupts everytime they are used. This is
>>    accomplished by using the PM runtime callbacks which will be called whenever
>>    the PMU is used.
>> 2. Assign the PMU events to different cross triggering channels. This prevents
>>    a single PMU event generating interrupts to both CPUs and hence can cause
>>    spurious interrupts to occur. Reported by Ming [2].
>>
>> [1] http://marc.info/?l=linux-arm-kernel&m=132227620816504&w=2
>> [2] http://permalink.gmane.org/gmane.linux.linaro.devel/10532
> 
> Spent some time with this one here.  At this point I don't think I can 
> queue it.  It's got hardcoded IRQ numbers and address information for the 
> CTI, and mixes the CTI and PMU programming.  A few months ago we might 
> have gotten away with this, but now it seems best to do this one cleanly.
> Probably the CTI control should be moved off into mach-omap2/omap4-cti.c 
> or somewhere into drivers/ if possible.  So let's revisit this for 3.8.

Ok, no problem, I can't say I was thrilled with the implementation so
probably best to re-think some more. How about adding the cross-trigger
interface as a hwmod for omap4 to store the base address and interrupt
number?

Cheers
Jon


