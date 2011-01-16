From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: State of LDP3430 platform
Date: Sun, 16 Jan 2011 00:04:06 +0000
Message-ID: <20110116000406.GA21077@n2100.arm.linux.org.uk>
References: <20101206125526.GC31777@n2100.arm.linux.org.uk> <20101206181913.GH8345@atomide.com> <alpine.DEB.2.00.1012061125400.13430@utopia.booyaka.com> <20101207083720.GB18336@n2100.arm.linux.org.uk> <alpine.DEB.2.00.1012071745120.13430@utopia.booyaka.com> <alpine.DEB.2.00.1012072012000.13430@utopia.booyaka.com> <20110115000301.GT4957@atomide.com> <alpine.DEB.2.00.1101151237240.32245@utopia.booyaka.com> <20110115233744.GA18159@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54271 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752889Ab1APAES (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 15 Jan 2011 19:04:18 -0500
Content-Disposition: inline
In-Reply-To: <20110115233744.GA18159@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Richard Woodruff <r-woodruff2@ti.com>

On Sat, Jan 15, 2011 at 11:37:44PM +0000, Russell King - ARM Linux wrote:
> On Sat, Jan 15, 2011 at 12:38:46PM -0700, Paul Walmsley wrote:
> > On Fri, 14 Jan 2011, Tony Lindgren wrote:
> > 
> > > * Paul Walmsley <paul@pwsan.com> [101207 19:30]:
> > > > On Tue, 7 Dec 2010, Paul Walmsley wrote:
> > > > 
> > > > Regarding the watchdog problem, unfortunately, I can't reproduce on the 
> > > > BeagleBoard with v2.6.37-rc5 with either omap2plus_defconfig or 
> > > > omap2plus_defconfig without CONFIG_WATCHDOG.  If you send along your 
> > > > .config, one of us can try to reproduce the problem with it.  Do the 
> > > > 2.6.38 hwmod and wdt patchsets fix the problem for .38, at least?
> > > 
> > > I've been seeing this on my omap4 panda. While debugging it, I left
> > > u-boot console only running for a few minutes to see if that stays up.
> > > It did.. And after doing that somehow now my panda boots all the way
> > > and stays up. Weird.
> > 
> > Hmmm, do you think the watchdog is what's killing it?  I don't think 
> > leaving u-boot running would affect that?
> 
> Right, well, the LDP3430 (and probably all OMAP) is broken by my
> init_sched_clock() changes because I gave up with testing on OMAP
> platforms.
> 
> Why does OMAP initialize its clock sources soo late, outside of
> the timer initialization?  This means you have no counter in place
> (except for the jiffies counter) during early boot.
> 
> Is there a reason why OMAP uniquely does this?

Right... with that initialization fixed, the LDP3430 boots, and doesn't
reboot during userspace bring-up.  However it doesn't seem to reach a
login prompt (presumably because the change of serial device naming.)

I'm still seeing a flood of MMC errors, eg:

mmcblk0: error -84 transferring data, sector 1847929, nr 184,
 cmd response 0x900, card status 0x900

This means it's regularly seeing data CRC errors.  The original kernel
supplied with the LDP3430 reports no data CRC errors.

