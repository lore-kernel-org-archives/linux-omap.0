From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V2 4/4] ARM: OMAP2+: AM43x: Use gptimer as clocksource
Date: Fri, 28 Feb 2014 15:34:02 -0800
Message-ID: <20140228233402.GY13624@atomide.com>
References: <1391768486-2134-1-git-send-email-lokeshvutla@ti.com>
 <1391768486-2134-5-git-send-email-lokeshvutla@ti.com>
 <20140213231919.GO28216@atomide.com>
 <52FDD7D5.30508@ti.com>
 <530B4391.2050205@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:35981 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752139AbaB1XeP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Feb 2014 18:34:15 -0500
Content-Disposition: inline
In-Reply-To: <530B4391.2050205@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nm@ti.com, linux@arm.linux.org.uk, nsekhar@ti.com

* Lokesh Vutla <lokeshvutla@ti.com> [140224 05:08]:
> Hi Tony,
> On Friday 14 February 2014 02:16 PM, Rajendra Nayak wrote:
> > On Friday 14 February 2014 04:49 AM, Tony Lindgren wrote:
> >> * Lokesh Vutla <lokeshvutla@ti.com> [140207 02:24]:
> >>> From: Rajendra Nayak <rnayak@ti.com>
> >>>
> >>> The SyncTimer in AM43x is clocked using the following two sources:
> >>> 1) An inaccuarte 32k clock (CLK_32KHZ) derived from PER DPLL, causing system
> >>>    time to go slowly (~10% deviation).
> >>> 2) external 32KHz RTC clock, which may not always be available on board like
> >>>    in the case of ePOS EVM
> >>>
> >>> Use gptimer as clocksource instead, as is done in the case of AM335x
> >>> (which does not have a SyncTimer). With this, system time keeping works
> >>> accurately.
> >>
> >> Hmm doesn't this also mean that PM for any deeper idle states won't
> >> work properly?
> > 
> > Thats true. This would mean we cannot put the peripheral/core domain down
> > in idle. Suspend however can still work if suspend/resume callbacks are added
> > to the clockevent and clocksource code to shut the non-wakeup domain timer.
> This is a platform level limitation that only MPU domain can be put down in idle, just like AM335x.

OK applying all four into omap-for-v3.15/soc thanks.

Tony
