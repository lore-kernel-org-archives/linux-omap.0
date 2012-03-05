From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP totally fucked?
Date: Mon, 5 Mar 2012 11:07:59 -0800
Message-ID: <20120305190759.GJ12083@atomide.com>
References: <20120303154650.GA16132@n2100.arm.linux.org.uk>
 <20120303180428.GA10293@atomide.com>
 <201203031829.06992.arnd@arndb.de>
 <20120303210521.GE10293@atomide.com>
 <20120304155909.GA14466@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:59722 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757429Ab2CETIF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Mar 2012 14:08:05 -0500
Content-Disposition: inline
In-Reply-To: <20120304155909.GA14466@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, Olof Johansson <olof@lixom.net>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120304 07:27]:
> On Sat, Mar 03, 2012 at 01:05:21PM -0800, Tony Lindgren wrote:
> > * Arnd Bergmann <arnd@arndb.de> [120303 09:57]:
> > > On Saturday 03 March 2012, Tony Lindgren wrote:
> > > > Well 85631d2 builds fine, looks like now some more includes of
> > > > plat/hardware.h are now needed.Have not yet tracked down which
> > > > commit triggers the build errors. Eventually those should become
> > > > local headers too..
> > > 
> > > I've tried building arm-soc/for-next and rmk/for-next, they are both
> > > fine, just merging the two gives me the same build errors that Russell
> > > saw.
> > > 
> > > Adding plat/hardware.h in all files that break solves the problems,
> > > aside from the iommu dependency for rpmsg for which Ohad has provided
> > > a fix already that I should pull.
> > 
> > Here's a patch for you to the cleanup branch to fix the hardware.h
> > build errors.
> 
> Right, with this applied, things are better:
> 
> 1. omap3430ldp allnoconfig is the first build without warnings, congrats.
> 2. omap4430sdp allnoconfig has a bunch of new section mismatch warnings,
>    a couple of compiler warnings, and builds:
> 
> WARNING: arch/arm/mach-omap2/built-in.o(.text+0x183c): Section mismatch in reference from the function omap2_init_processor_devices() to the function .init.text:_init_omap_device()
> The function omap2_init_processor_devices() references
> the function __init _init_omap_device().
> This is often because omap2_init_processor_devices lacks a __init 
> annotation or the annotation of _init_omap_device is wrong.
> 
> arch/arm/mach-omap2/io.c:51: warning: 'omap24xx_io_desc' defined but not used
> arch/arm/mach-omap2/omap-wakeupgen.c:181: warning: 'wakeupgen_irqmask_all' defined but not used
> 
> 3. omap4430sdp randconfig built with these omap specific warnings (exluding
>    ones already mentioned):
> 
> arch/arm/mach-omap2/board-n8x0.c:39: warning: 'slot1_cover_open' defined but not used
> arch/arm/mach-omap2/board-n8x0.c:40: warning: 'slot2_cover_open' defined but not used
> arch/arm/mach-omap2/board-n8x0.c:41: warning: 'mmc_device' defined but not used

I'll do some patches to fix these warnings.
 
> and, of course, this is with these configs building OMAP2..OMAP4 because of
> the config.

That should get fixed soon too with revert.

Regards,

Tony
