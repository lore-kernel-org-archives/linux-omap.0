From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Open issues after 2.6.38 merge window
Date: Mon, 17 Jan 2011 12:11:44 +0000
Message-ID: <20110117121144.GA18600@flint.arm.linux.org.uk>
References: <20110114194758.GM4957@atomide.com> <alpine.DEB.1.10.1101171328440.8142@esdhcp041196.research.nokia.com> <701a8169276ef3a1eccbac0d31117a6b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:38052 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728Ab1AQMMD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jan 2011 07:12:03 -0500
Content-Disposition: inline
In-Reply-To: <701a8169276ef3a1eccbac0d31117a6b@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On Mon, Jan 17, 2011 at 05:29:01PM +0530, Santosh Shilimkar wrote:
> > On Fri, 14 Jan 2011, Tony Lindgren wrote:
> > > Before I update out master branch, let's try to summarize the
> > > open issues after the merge window. Here's a list of issues
> > > in omap-fixes-for-linus that I'm aware of:
> > >
> > > - NFS root oopses while mounting root
> > >
> > > - omap4430 es1.0 hangs if L2X0 cache is enabled
> > >
> > > - omap4 panda powers down after boot (watchdog?)
> > >
> > > - omap3 ldp board powers down after boot?

This doesn't happen for me.

> > >
> > > Any other issues?
> >
> > Amstrad E3 fails during the boot. Bisection points to:
> >
> >  	commit 211baa7016894c02fc18693e21ca479cd08ac0c0
> >  	Author: Russell King <rmk+kernel@arm.linux.org.uk>
> >  	Date:   Tue Jan 11 16:23:04 2011 +0000
> >
> >  	    ARM: sched_clock: allow init_sched_clock() to be called
> > early
> >
> > The board does not have sched_clock(), although HAVE_SCHED_CLOCK is
> > defined for all OMAP.
> >
> I guess above is sorted out by the attached patch from Paul.

There's an issue missing from Tony's list:

- running an omap2plus_defconfig kernel on SMP is unsafe to the point
  of being data corrupting for filesystems, especially for ext2/ext3
  mounted read-write.

This is because when CPU_32v6K is disabled - which is required to build
a kernel to boot on ARMv6, it turns off the SMP safe bitops - the SMP
safe bitops only use instructions available to ARMv6K and above.  They
are reduced to local-irq-disabling, plain byte loads and stores.

So, running omap2plus_defconfig on SMP is risking filesystem corruption.

Patches for this are being worked on, but they won't be ready for -rc1.
I strongly suggest someone restores some kind of build or runtime error
(eg, by removing CPU_32v6K's dependence on !OMAP2 - thereby _intentionally_
breaking omap2plus_defconfig) before someone ends up with a corrupted
filesystem.  Or just make sure that everyone is aware that
omap2plus_defconfig can eat filesystems at the moment.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
