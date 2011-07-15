From: Vishwanath Sripathy <vishwanath.bs@ti.com>
Subject: RE: [GIT PULL] minimal omap4460 support for v3.1 merge window
Date: Fri, 15 Jul 2011 15:34:08 +0530
Message-ID: <f4cffad16aa1de61a44edfae84e2249a@mail.gmail.com>
References: <20110710065627.GE5783@atomide.com> <20110710195215.GJ5783@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:52224 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S965014Ab1GOKEO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Jul 2011 06:04:14 -0400
Received: by mail-vx0-f173.google.com with SMTP id 29so245564vxi.18
        for <linux-omap@vger.kernel.org>; Fri, 15 Jul 2011 03:04:13 -0700 (PDT)
In-Reply-To: <20110710195215.GJ5783@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nico@fluxnic.net>

Tony,
I boot tested this pull request on 4460 Panda and it boots up fine.

Regards
Vishwa


> -----Original Message-----
> From: linux-arm-kernel-bounces@lists.infradead.org [mailto:linux-
> arm-kernel-bounces@lists.infradead.org] On Behalf Of Tony Lindgren
> Sent: Monday, July 11, 2011 1:22 AM
> To: Arnd Bergmann
> Cc: Thomas Gleixner; linux-omap@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; Nicolas Pitre
> Subject: Re: [GIT PULL] minimal omap4460 support for v3.1 merge
> window
>
> Correting the email address for Arnd.
>
> * Tony Lindgren <tony@atomide.com> [110709 23:51]:
> > Hi Arnd,
> >
> > Please pull minimal omap4460 support from:
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-
> 2.6.git 4460
> >
> > Regards,
> >
> > Tony
> >
> >
> > The following changes since commit
> 48cb1258e8b0f8c81cfb699b42326c5b2147b3f8:
> >   Tony Lindgren (1):
> >         Merge branch 'for_3.1/pm-misc' of
> git://git.kernel.org/.../khilman/linux-omap-pm into devel-cleanup
> >
> > are available in the git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-
> 2.6.git 4460
> >
> > Aneesh V (2):
> >       OMAP: ID: introduce chip detection for OMAP4460
> >       OMAP4: ID: add omap_has_feature for max freq supported
> >
> > Rajendra Nayak (2):
> >       OMAP4: PRCM: OMAP4460 specific PRM and CM register bitshifts
> >       OMAP4: clocks: Update the clock tree with 4460 clock nodes
> >
> >  arch/arm/mach-omap2/clock44xx_data.c          |   39
> ++++++++++++++++++
> >  arch/arm/mach-omap2/cm-regbits-44xx.h         |   36
> +++++++++++++++++
> >  arch/arm/mach-omap2/id.c                      |   53
> ++++++++++++++++++++----
> >  arch/arm/mach-omap2/prm-regbits-44xx.h        |    8 ++++
> >  arch/arm/plat-omap/include/plat/clkdev_omap.h |    1 +
> >  arch/arm/plat-omap/include/plat/clock.h       |    2 +
> >  arch/arm/plat-omap/include/plat/cpu.h         |   35
> +++++++++++++++-
> >  7 files changed, 162 insertions(+), 12 deletions(-)
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-
> omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
