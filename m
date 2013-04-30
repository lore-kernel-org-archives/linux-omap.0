From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: Latest build results - errors/warnings - lots of them
Date: Tue, 30 Apr 2013 14:18:42 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1304301418100.17372@syhkavp.arg>
References: <20130430081739.GP14496@n2100.arm.linux.org.uk> <201304301304.20650.arnd@arndb.de> <20130430114229.GA2439@linaro.org> <alpine.LFD.2.03.1304301110030.17372@syhkavp.arg> <20130430172816.GA31101@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qe0-f53.google.com ([209.85.128.53]:54297 "EHLO
	mail-qe0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760751Ab3D3SSq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Apr 2013 14:18:46 -0400
Received: by mail-qe0-f53.google.com with SMTP id i11so472273qej.40
        for <linux-omap@vger.kernel.org>; Tue, 30 Apr 2013 11:18:45 -0700 (PDT)
In-Reply-To: <20130430172816.GA31101@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Martin <dave.martin@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, 30 Apr 2013, Dave Martin wrote:

> On Tue, Apr 30, 2013 at 11:12:12AM -0400, Nicolas Pitre wrote:
> > On Tue, 30 Apr 2013, Dave Martin wrote:
> > 
> > > On Tue, Apr 30, 2013 at 01:04:20PM +0200, Arnd Bergmann wrote:
> > > > On Tuesday 30 April 2013, Russell King - ARM Linux wrote:
> > > > > Latest nightly build of 3.9+my for-next+arm-soc's for-next results in a
> > > > > great load of new warnings and errors.  arch/arm/common/mcpm_head.S,
> > > > > arch/arm/common/mcpm_platsmp.c, arch/arm/common/vlock.S are the biggest
> > > > > source of errors.
> > > 
> > > [...]
> > >  
> > > > >arch/arm/common/mcpm_head.S:39: Error: selected processor does not support ARM mode `ubfx r9,r0,#0,#8'
> > > > >arch/arm/common/mcpm_head.S:40: Error: selected processor does not support ARM mode `ubfx r10,r0,#8,#8'
> > > > >arch/arm/common/mcpm_head.S:100: Error: selected processor does not support ARM mode `dmb'
> > > > >arch/arm/common/mcpm_head.S:115: Error: selected processor does not support ARM mode `dmb'
> > > > >arch/arm/common/mcpm_head.S:127: Error: selected processor does not support ARM mode `dmb'
> > > > >arch/arm/common/mcpm_head.S:131: Error: selected processor does not support ARM mode `dmb'
> > > > >arch/arm/common/mcpm_head.S:138: Error: selected processor does not support ARM mode `dsb'
> > > > >arch/arm/common/mcpm_head.S:152: Error: selected processor does not support ARM mode `dmb'
> > > > >arch/arm/common/mcpm_head.S:161: Error: selected processor does not support ARM mode `dmb'
> > > > >arch/arm/common/mcpm_head.S:175: Error: selected processor does not support ARM mode `dmb'
> > > > >arch/arm/common/vlock.S:62: Error: selected processor does not support ARM mode `dmb'
> > > > >arch/arm/common/vlock.S:72: Error: selected processor does not support ARM mode `dmb'
> > > > >arch/arm/common/vlock.S:72: Error: selected processor does not support ARM mode `dsb'
> > > > >arch/arm/common/vlock.S:89: Error: selected processor does not support ARM mode `dmb'
> > > > >arch/arm/common/vlock.S:95: Error: selected processor does not support ARM mode `dmb'
> > > > >arch/arm/common/vlock.S:95: Error: selected processor does not support ARM mode `dsb'
> > > > >arch/arm/common/vlock.S:102: Error: selected processor does not support ARM mode `dmb'
> > > > >arch/arm/common/vlock.S:105: Error: selected processor does not support ARM mode `dsb'
> > > > 
> > > > Right, the problem here is that the code was never tested with an ARMv6+ARMv7 config.
> > > > We can either fix it up by adding
> > > > 
> > > > 	.arch	armv7-a
> > > > 
> > > > in the assembly files, or by doing the same in the Makefile:
> > > > 
> > > > AFLAGS_vlock.S += -march=armv7-a
> > > > AFLAGS_mcpm_head.S += -march=armv7-a
> > > 
> > > 
> > > Hmmm, this code was tested with ARCH_MULTIPLATFORM, but it looks like
> > > no v6 boards were configured in when testing that...
> > > 
> > > 
> > > Assuming people are OK with the Makefile route, here's a patch for that,
> > > build-tested with a v6+v7 ARCH_MULTIPLATFORM config.
> > 
> > Isn't the .arch armv7-a route a bit cleaner?  That would have been my 
> > choice, although I don't feel strongly about it.
> 
> I don't feel strongly either.  We already have the CFLAGS_DISABLE stuff,
> so it didn't feel that unnatural to add this in the Makefile; but .arch
> would work equally well.
> 
> If somebody wants to change it, it's not a problem for me, but I didn't
> want to create extra disruption by proposing a different patch...

Fair enough.

Acked-by: Nicolas Pitre <nico@linaro.org>



> 
> Cheers
> ---Dave
> 
