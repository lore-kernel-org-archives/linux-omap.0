From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: [PATCH v12 6/9] dmtimer: switch-over to platform device driver
Date: Sat, 12 Mar 2011 09:50:35 +0530
Message-ID: <20110312042035.GB7492@m-desktop>
References: <1299627948-20040-1-git-send-email-tarun.kanti@ti.com>
 <1299627948-20040-7-git-send-email-tarun.kanti@ti.com>
 <20110309220241.GR26463@atomide.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB037A4DD852@dbde02.ent.ti.com>
 <20110310175611.GV26463@atomide.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB037A4DD9D2@dbde02.ent.ti.com>
 <20110311124533.GA7492@m-desktop>
 <20110311191548.GG10079@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:36134 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751053Ab1CLEWX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Mar 2011 23:22:23 -0500
Received: by gwb11 with SMTP id 11so1443544gwb.34
        for <linux-omap@vger.kernel.org>; Fri, 11 Mar 2011 20:22:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110311191548.GG10079@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "G, Manjunath Kondaiah" <manjugk@ti.com>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Mar 11, 2011 at 11:15:48AM -0800, Tony Lindgren wrote:
> * G, Manjunath Kondaiah <manjugk@ti.com> [110311 04:45]:
> > On Fri, Mar 11, 2011 at 11:05:25AM +0530, DebBarma, Tarun Kanti wrote:
> > > [...]
> > > > > >
> > > > > > * Tarun Kanti DebBarma <tarun.kanti@ti.com> [110308 15:41]:
> > > > > > > switch-over to platform device driver through following changes:
> > > > > > > (a) initiate dmtimer early initialization from omap2_gp_timer_init()
> > > > > > > in timer-gp.c. This is equivalent of timer_init()->timer->init().
> > > > > > > (b) modify plat-omap/dmtimer routines to use new register map and
> > > > > > > platform data.
> > > > > >
> > > > > > This patch breaks booting for 2420 and makes boot hang early
> > > > > > on 2430. Note that to test with omap-for-linus branch you need
> > > > > > to disable the following in omap2plus_defconfig:
> > > > > >
> > > > > > CONFIG_ARCH_OMAP3
> > > > > > CONFIG_ARCH_OMAP4
> > > > > > CONFIG_CPU_32v6K
> > > > > I disabled above options on omap-for-linus *WITHOUT* my patch series.
> > > > > I am still seeing crash. Here is the log.
> > > > > I tried on two different setups. Not sure if I am missing something.
> > > > 
> > > > Hmm sounds like H4 needs some attention. Can you try the following
> > > > completely untested patch?
> > > 
> > > This works fine!
> > 
> > I tried to use below patch for booting  OMAP2420 H4 on top of:
> > git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
> > Branch: omap-for-linus
> > commit 94a06b74e724caabcf0464c81527cfbcae0c8aff
> > Merge: 0dde52a 9062511
> > Author: Tony Lindgren <tony@atomide.com>
> > Merge branch 'for_2.6.39/pm-misc' of
> > ssh://master.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm
> > into omap-for-linus
> > 
> > Looks like it stops after uncompressing kernel. Same setup works fine
> > with tag v2.6.37.
> 
> See the mails earlier in this thread on what you currently need to
> disable in .config in omap-for-linus branch to boot omap2 machines.
> This will get sorted out in mainline when Russell's ARMv6K related
> patches get merged during the merge window.

Thanks. Disabling OMAP3 and OMAP4 along with this patch is working fine.
Tested on OMAP2420-H4 and OMAP2430-SDP.

-Manjunath 
