From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 0/6] ARM: OMAP4: core retention support
Date: Tue, 28 Feb 2012 09:24:15 +0200
Message-ID: <1330413855.2116.29.camel@sokoban>
References: <1330003320-17400-1-git-send-email-t-kristo@ti.com>
	 <87d38zrboc.fsf@ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44344 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754478Ab2B1HYU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Feb 2012 02:24:20 -0500
In-Reply-To: <87d38zrboc.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, 2012-02-27 at 17:25 -0800, Kevin Hilman wrote:
> Tero Kristo <t-kristo@ti.com> writes:
> 
> > This set adds core retention support on top of mainline. The set
> > also adds IO CHAIN wakeup capability for OMAP4, which is a nice feature
> > to have while trying suspend / resume with CSWR as it is quite difficult
> > to wake up the device without this.
> >
> > Patch 6 might cause some stir, but this is needed as omap4 PRCM chain
> > handler currently does not work without SPARSE_IRQ. Enabling the
> > SPARSE_IRQ causes a WARN from gic during boot for omap4, and attempting
> > to fix this creates some spam from interrupt handling code which seems to
> > originate from GPMC/GPIO. Also, omap3 boot breaks completely,
> > thus it is impossible to enable this option as of now.
> >
> > Tested on OMAP4 blaze board, with OMAP4430 EMU chip. Suspend / resume
> > works nicely, and wakeup with UART3 works. The powerdomain state info
> > under pm-debug appears to be somewhat bogus right after boot, but fixes
> > itself during suspend. This should be addressed separately. Also
> > verified that suspend / resume with OMAP3 beagle is okay.
> 
> Please separate out the IO daisy chain stuff as a separate series.

Okay, will do that. Based on your next comment it makes sense. I'll
double check from Vishwa how we handle the IO chain set.

> 
> Vishwa had a multiple patch series that cleaned some of this up and
> also made it common for OMAP3 and 4.
> 
>    http://marc.info/?l=linux-omap&m=132387916807059&w=2
> 
> I had several review comments on that series that were never responded
> to, 
> 
>    http://marc.info/?l=linux-omap&w=2&r=1&s=DaisyChain&q=b
> 

Oh okay, sorry about that. I just checked your comments and most of them
appear valid. One of the major complaints you had was for the IO chain
to be enabled all the time now, this appears to be based on design. IO
chain can now generate wake-ups for idle modules even if the CPU is not
idle. It means that the IO chain must be re-armed every time the IO
config (mux / wakeup setup) changes. The wakeup triggering logic should
be moved to the mux code probably.

> so I'd first like to understand why that series was dropped and only
> selected parts were taken for $SUBJECT series, and what is the plan for
> the IO daisy chain series.

I dropped part of the patches (mainly the ones that touch OMAP3), as I
wasn't quite certain whether they are needed or not, and/or whether they
work on omap3 properly (mainly the above io chain arming logic.) I
wanted to keep this separate from the CSWR set itself as it should be
touching only omap4.

-Tero


