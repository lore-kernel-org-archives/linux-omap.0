From: Tony Lindgren <tony@atomide.com>
Subject: Re: hwmod data duplication (was: Re: [RFC/NOT FOR MERGING 2/3]
 serial: omap: remove hwmod dependency)
Date: Tue, 19 Feb 2013 14:09:33 -0800
Message-ID: <20130219220932.GL5724@atomide.com>
References: <20130214193911.GD11806@atomide.com>
 <alpine.DEB.2.00.1302141946110.11016@utopia.booyaka.com>
 <alpine.DEB.2.00.1302142124370.11016@utopia.booyaka.com>
 <20130214224710.GF11362@atomide.com>
 <alpine.DEB.2.00.1302191527200.32069@utopia.booyaka.com>
 <20130219154511.GU17852@n2100.arm.linux.org.uk>
 <20130219163053.GE5724@atomide.com>
 <20130219182257.GV17852@n2100.arm.linux.org.uk>
 <20130219193122.GJ5724@atomide.com>
 <20130219194327.GB8978@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:53874 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933538Ab3BSWJk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Feb 2013 17:09:40 -0500
Content-Disposition: inline
In-Reply-To: <20130219194327.GB8978@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Paul Walmsley <paul@pwsan.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

* Felipe Balbi <balbi@ti.com> [130219 11:47]:
> Hi,
> 
> On Tue, Feb 19, 2013 at 11:31:22AM -0800, Tony Lindgren wrote:
> > > However... if you think you're going to get away with another total
> > > rewrite of OMAP device support away from hwmod to a new scheme with a
> > > new load of huge churn, think again.  Remember, churn is evil.  I've
> > > complained to you about the amount of churn that OMAP manufactures
> > > in the past.  Linus has complained about it too.  You can't continue
> > > like this.
> > 
> > I don't think there's any churn needed here if done properly. It's
> > mostly a question of dropping duplicate data from hwmod that we
> > already have available in device tree. That means we can shrink the
> > hwmod data needed.
> 
> how about starting by removing register addresses and interrupt numbers
> which are passed by devicetree today ? If you want to move to DT-only
> now even without all drivers DT-adapted, you can have something like
> what Marvel folks did for kirkwood:
> 
> static void __init kirkwood_dt_init(void)
> {
> 
> [ ... ]
> 
> 	if (of_machine_is_compatible("globalscale,dreamplug"))
> 		dreamplug_init();
> 
> 	if (of_machine_is_compatible("dlink,dns-kirkwood"))
> 		dnskw_init();
> 
> 	if (of_machine_is_compatible("iom,iconnect"))
> 		iconnect_init();
> 
> [ ... ]
> 
> 	of_platform_populate(NULL, kirkwood_dt_match_table, NULL, NULL);
> }
> 
> those machine-based inits are there just to initialize drivers which
> aren't converted to DT.

Yes we could do that at least partially, but..
 
> this would let you remove all board-files except board-generic.c and
> remove data which is already passed in via DT. It has the benefit of
> showing Linus (or whoever cares) that we are working to remove the
> "churn" while also removing some of the pressure of DT conversion, since
> there are still details which need to be sorted out (UART function
> pointers, clock nodes via DT - see Roger's discussion with Rajendra, DMA
> nodes, etc etc).

..that means massive amount of churn in the board-*.c files to convert
them to various init functions to be called from board-generic.c and
removing the ones that are working with DT.

I think we're better off making first sure things are usable with
DT, then just dropping the board-*.c files as we go.

And omap4 is the place to start as we only have blaze and panda
board files. Once DSS, USB and WLAN work with the .dts files, we
can just drop those board files and make omap4 DT only.

We may be able to drop omap4 board-*.c files faster than going full
DT with few selected legacy init functions in board-generic.c for
things like LCD panel configuration etc.
 
> Only on board-files we're talking about over 13K lines:
> 
>  arch/arm/mach-omap2/board-2430sdp.c          |  289 ------
>  arch/arm/mach-omap2/board-3430sdp.c          |  602 ------------
>  arch/arm/mach-omap2/board-3630sdp.c          |  216 -----
>  arch/arm/mach-omap2/board-4430sdp.c          |  730 ---------------
>  arch/arm/mach-omap2/board-am3517crane.c      |   97 --
>  arch/arm/mach-omap2/board-am3517evm.c        |  398 --------
>  arch/arm/mach-omap2/board-apollon.c          |  342 -------
>  arch/arm/mach-omap2/board-cm-t35.c           |  769 ----------------
>  arch/arm/mach-omap2/board-cm-t3517.c         |  302 ------
>  arch/arm/mach-omap2/board-devkit8000.c       |  648 -------------
>  arch/arm/mach-omap2/board-flash.c            |  242 -----
>  arch/arm/mach-omap2/board-flash.h            |   62 --
>  arch/arm/mach-omap2/board-h4.c               |  347 -------
>  arch/arm/mach-omap2/board-igep0020.c         |  673 --------------
>  arch/arm/mach-omap2/board-ldp.c              |  440 ---------
>  arch/arm/mach-omap2/board-n8x0.c             |  762 ---------------
>  arch/arm/mach-omap2/board-omap3beagle.c      |  549 -----------
>  arch/arm/mach-omap2/board-omap3evm.c         |  762 ---------------
>  arch/arm/mach-omap2/board-omap3logic.c       |  249 -----
>  arch/arm/mach-omap2/board-omap3pandora.c     |  623 -------------
>  arch/arm/mach-omap2/board-omap3stalker.c     |  432 ---------
>  arch/arm/mach-omap2/board-omap3touchbook.c   |  391 --------
>  arch/arm/mach-omap2/board-omap4panda.c       |  467 ----------
>  arch/arm/mach-omap2/board-overo.c            |  556 -----------
>  arch/arm/mach-omap2/board-rm680.c            |  165 ----
>  arch/arm/mach-omap2/board-rx51-peripherals.c | 1276 --------------------------
>  arch/arm/mach-omap2/board-rx51-video.c       |   89 --
>  arch/arm/mach-omap2/board-rx51.c             |  128 ---
>  arch/arm/mach-omap2/board-rx51.h             |   11 -
>  arch/arm/mach-omap2/board-ti8168evm.c        |   62 --
>  arch/arm/mach-omap2/board-zoom-debugboard.c  |  139 ---
>  arch/arm/mach-omap2/board-zoom-display.c     |  147 ---
>  arch/arm/mach-omap2/board-zoom-peripherals.c |  304 ------
>  arch/arm/mach-omap2/board-zoom.c             |  155 ----
>  arch/arm/mach-omap2/board-zoom.h             |   10 -
>  35 files changed, 13434 deletions(-)
> 
> If we remove all addresses and interrupts, numbers look even better.

Yeah. Let's start with omap4 first when DSS + USB + WLAN work.

Regards,

Tony

