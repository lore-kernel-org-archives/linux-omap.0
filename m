From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: Open issues after 2.6.38 merge window
Date: Mon, 17 Jan 2011 17:49:00 +0530
Message-ID: <9aa00167a81147bc0104bb7af010d9a5@mail.gmail.com>
References: <20110114194758.GM4957@atomide.com> <alpine.DEB.1.10.1101171328440.8142@esdhcp041196.research.nokia.com>
 <701a8169276ef3a1eccbac0d31117a6b@mail.gmail.com> <20110117121144.GA18600@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:45801 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750945Ab1AQMTE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Jan 2011 07:19:04 -0500
Received: by mail-fx0-f42.google.com with SMTP id 11so6113280fxm.29
        for <linux-omap@vger.kernel.org>; Mon, 17 Jan 2011 04:19:02 -0800 (PST)
In-Reply-To: <20110117121144.GA18600@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

> -----Original Message-----
> From: Russell King [mailto:rmk@arm.linux.org.uk]
> Sent: Monday, January 17, 2011 5:42 PM
> To: Santosh Shilimkar
> Cc: Aaro Koskinen; Tony Lindgren; linux-omap@vger.kernel.org
> Subject: Re: Open issues after 2.6.38 merge window
>
> On Mon, Jan 17, 2011 at 05:29:01PM +0530, Santosh Shilimkar wrote:
> > > On Fri, 14 Jan 2011, Tony Lindgren wrote:
> > > > Before I update out master branch, let's try to summarize the
> > > > open issues after the merge window. Here's a list of issues
> > > > in omap-fixes-for-linus that I'm aware of:
> > > >
> > > > - NFS root oopses while mounting root
> > > >
> > > > - omap4430 es1.0 hangs if L2X0 cache is enabled
> > > >
> > > > - omap4 panda powers down after boot (watchdog?)
> > > >
> > > > - omap3 ldp board powers down after boot?
>
> This doesn't happen for me.
>
> > > >
> > > > Any other issues?
> > >
> > > Amstrad E3 fails during the boot. Bisection points to:
> > >
> > >  	commit 211baa7016894c02fc18693e21ca479cd08ac0c0
> > >  	Author: Russell King <rmk+kernel@arm.linux.org.uk>
> > >  	Date:   Tue Jan 11 16:23:04 2011 +0000
> > >
> > >  	    ARM: sched_clock: allow init_sched_clock() to be called
> > > early
> > >
> > > The board does not have sched_clock(), although HAVE_SCHED_CLOCK
> is
> > > defined for all OMAP.
> > >
> > I guess above is sorted out by the attached patch from Paul.
>
> There's an issue missing from Tony's list:
>
> - running an omap2plus_defconfig kernel on SMP is unsafe to the
> point
>   of being data corrupting for filesystems, especially for ext2/ext3
>   mounted read-write.
>
> This is because when CPU_32v6K is disabled - which is required to
> build
> a kernel to boot on ARMv6, it turns off the SMP safe bitops - the
> SMP
> safe bitops only use instructions available to ARMv6K and above.
> They
> are reduced to local-irq-disabling, plain byte loads and stores.
>
> So, running omap2plus_defconfig on SMP is risking filesystem
> corruption.
>
> Patches for this are being worked on, but they won't be ready for -
> rc1.
> I strongly suggest someone restores some kind of build or runtime
> error
> (eg, by removing CPU_32v6K's dependence on !OMAP2 - thereby
> _intentionally_
> breaking omap2plus_defconfig) before someone ends up with a
> corrupted
> filesystem.  Or just make sure that everyone is aware that
> omap2plus_defconfig can eat filesystems at the moment.
>
Thanks. I missed your other patch of removing !OMAP2 from
CPU_32v6K config.

Regards,
Santosh
