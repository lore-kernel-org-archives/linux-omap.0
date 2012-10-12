From: Tony Lindgren <tony@atomide.com>
Subject: Re: Errors at boot time from OMAP4430SDP (and a whinge about
 serial stuff)
Date: Fri, 12 Oct 2012 09:56:17 -0700
Message-ID: <20121012165616.GF30339@atomide.com>
References: <20121012155434.GO28061@n2100.arm.linux.org.uk>
 <20121012162452.GD30339@atomide.com>
 <5078469E.1030707@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:59851 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755674Ab2JLQ4W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Oct 2012 12:56:22 -0400
Content-Disposition: inline
In-Reply-To: <5078469E.1030707@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, Afzal Mohammed <afzal@ti.com>, =?utf-8?B?UMOpdGVy?= Ujfalusi <peter.ujfalusi@ti.com>

* Benoit Cousson <b-cousson@ti.com> [121012 09:36]:
> Hi Tony,
> 
> On 10/12/2012 06:24 PM, Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [121012 08:56]:
> >> For those who don't bother looking at my kautobuild boot tests on the OMAP
> >> boards I have, here's the errors which get spat out at boot time.  Note
> >> that some of these I've reported in the past, and one of them is missing
> >> a newline character at the end of its string.
> > 
> > Thanks, let's get those fixed ASAP.
> >  
> >> twd: can't register interrupt 45 (-22)
> >> twd_local_timer_register failed -22

Posted a fix for this as "ARM: OMAP4: Fix twd_local_timer_register
regression".
 
> > Hmm I think this regression was caused by my sparse IRQ changes,
> > looks like I have a typo using OMAP_INTC_START in stead of the
> > GIC base. Will do a patch for this.
> > 
> >> omap_hwmod: mcpdm: cannot be enabled for reset (3)
> > 
> > Paul, Benoit, care to take a look at this?
> 
> Yeah, that one is a warning. The mcpdm is not accessible at boot time if
> the external clock (from twl6040) is not enabled.
> 
> Paul introduced a HWMOD_EXT_OPT_MAIN_CLK flag to avoid the warning [1],
> but it looks like that code is not merged.
> I'll check where that patch is stuck.

Thanks, seems like that would be OK to do during the early -rc
cycle to fix the warning.

Regards,

Tony
 
> [1]
> http://lists.infradead.org/pipermail/linux-arm-kernel/2012-June/103019.html
