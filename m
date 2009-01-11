From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: RE: [PATCH 0/3] Add support for OMAP35x processors
Date: Sun, 11 Jan 2009 12:34:55 -0600
Message-ID: <A24693684029E5489D1D202277BE8944153C47FA@dlee02.ent.ti.com>
References: <A24693684029E5489D1D202277BE8944163AB5F7@dlee02.ent.ti.com>,<200901102254.42829.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52484 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751023AbZAKSfD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 11 Jan 2009 13:35:03 -0500
In-Reply-To: <200901102254.42829.david-b@pacbell.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>, "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> From: David Brownell [david-b@pacbell.net]
> Sent: Sunday, January 11, 2009 12:54 AM
> To: Aguirre Rodriguez, Sergio Alberto; Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH 0/3] Add support for OMAP35x processors

> On Friday 09 January 2009, Aguirre Rodriguez, Sergio Alberto wrote:
> > >  comment "OMAP Board Type"
> > >       depends on ARCH_OMAP2 || ARCH_OMAP3
> > >
> > > @@ -107,7 +155,7 @@ config MACH_OMAP_2430SDP
> > >
> > >  config MACH_OMAP_LDP
> > >       bool "OMAP3 LDP board"
> > > -     depends on ARCH_OMAP3 && ARCH_OMAP34XX
> > > +     depends on ARCH_OMAP3 && ARCH_OMAP34XX && !ARCH_OMAP35XX
> > >
> > >  config MACH_OMAP2EVM
> > >       bool "OMAP 2530 EVM board"
> > > @@ -115,11 +163,11 @@ config MACH_OMAP2EVM
> > >
> > >  config MACH_OMAP_3430SDP
> > >       bool "OMAP 3430 SDP board"
> > > -     depends on ARCH_OMAP3 && ARCH_OMAP34XX
> > > +     depends on ARCH_OMAP3 && ARCH_OMAP34XX && !ARCH_OMAP35XX
> > >
> > >  config MACH_OMAP3EVM
> > >       bool "OMAP 3530 EVM board"
> > > -     depends on ARCH_OMAP3 && ARCH_OMAP34XX
> > > +     depends on ARCH_OMAP35XX
> > >
> > >  config MACH_OMAP3_BEAGLE
> > >       bool "OMAP3 BEAGLE board"
> >
> > Question to all,
> >
> > Why don't making above options as choice.. endchoice.
> 
> Because that completely breaks "multi-OMAP" builds.
> Having kernels build (and work!) with multiple boards
> has been a goal for some time now.
> 
> Switching that stuff to choice...endchoice would be
> a major regression.  I wouldn't merge such a patch.

Ok, I understand what you're saying.. But I still have some questions:

- Is the above change for being able to select (for example) 3430SDP when !ARCH_OMAP35XX wrong? That won't allow a kernel with both 3430SDP and 3530EVM boards support to build, right?
- Do you think the above kind of check is redundant?:
depends on ARCH_OMAP3 && ARCH_OMAP34XX

Bc i don't think ARCH_OMAP34XX can be when !ARCH_OMAP3...

Thanks for your time,
Sergio
> 
> 
> > Or is there any case that multiple boards are compiled at once?
> 
> Yes, it's routine to build kernels that work with
> multiple boards.  Example, mine work on Beagle,
> Overo, and SDP.
> 
> Why do this?  Several reasons, all of which boil
> down to better quality code.  The most obvious
> ones are being able to build-test more systems
> in the same amount of time ... and then being
> able to run-test them without needing to waste
> any time worrying if the behavioral change was
> due to some odd Kconfig glitch, or is just a bug
> to fix in the code.
> 
> The more subtle issues have to do with the
> various changes that happen to make that
> work well.  Example, board specific #ifdefs
> in code start to vanish ... which is good,
> since they hide lits of problems, and are
> nasty coding style regardless.  Sometimes
> getting rid of such #ifdeffery highlights
> a much better code structure.
> 
> Ditto CPU-specific #ifdeffery, of the type
> which these patches add.  Fix them so they
> don't add #ifdeffery like that, and they
> will be a lot better accepted...
> 
> - Dave
> 
> 