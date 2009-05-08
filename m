From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/5] More header clean-up
Date: Fri, 8 May 2009 08:21:03 -0700
Message-ID: <20090508152103.GJ5593@atomide.com>
References: <20090507203552.7461.35051.stgit@localhost> <EAF47CD23C76F840A9E7FCE10091EFAB02B4688430@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:62149 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751481AbZEHPVG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 May 2009 11:21:06 -0400
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02B4688430@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [090507 22:20]:
> If this series is planned for this window then OMAP4 series also needs few changes. Is it ?

Yeah. For omap4 those changes should be trivial though.

Maybe do a test rebase on top of these patches to see which ones
you need to rename?

But when posting patches to mailings lists, please keep them against
the mainline. I should be able to deal with the conflicts pretty easily
when adding them to for-next.

Regards,

Tony

 
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org 
> > [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Tony Lindgren
> > Sent: Friday, May 08, 2009 2:12 AM
> > To: linux-omap@vger.kernel.org
> > Subject: [PATCH 0/5] More header clean-up
> > 
> > Hi all,
> > 
> > This series cleans up the conflicting defines a bit more.
> > Now the biggest problem is till in clock24xx.h, but at least the
> > conflict is local. Now changing the processors should not cause
> > everything to be rebuilt..
> > 
> > The first patch also fixes the CONFIG_SPINLOCK_DEBUG problem where
> > sched_clock was called before we have things initialized.
> > 
> > This series causes some updates to the other pending patch series,
> > like the PM series. But it would be nice to get in before we add
> > more code.
> > 
> > Kevin, the 2/5 is improved version of what I sent you earlier,
> > the earlier version had issues between 2420 vs 2430. Let me
> > know if the other patches cause big headaches for your PM
> > series.
> > 
> > Regards,
> > 
> > Tony
> > 
> > ---
> > 
> > Tony Lindgren (5):
> >       ARM: OMAP2/3: Remove OMAP_CM_REGADDR
> >       ARM: OMAP2/3: Remove OMAP2_PRCM_BASE
> >       ARM: OMAP2/3: Move define of OMAP2_VA_IC_BASE to be 
> > local to entry-macro.S
> >       ARM: OMAP2/3: Remove OMAP_PRM_REGADDR and OMAP2_PRM_BASE
> >       ARM: OMAP2/3: Remove OMAP2_32KSYNCT_BASE
> > 
> > 
> >  arch/arm/mach-omap2/clock24xx.c               |   21 ++--
> >  arch/arm/mach-omap2/clock24xx.h               |   11 ++
> >  arch/arm/mach-omap2/clock34xx.h               |    2 
> >  arch/arm/mach-omap2/cm.h                      |    5 -
> >  arch/arm/mach-omap2/prm.h                     |  136 
> > +++++++++++++------------
> >  arch/arm/mach-omap2/sdrc2xxx.c                |    5 +
> >  arch/arm/mach-omap2/sram242x.S                |    4 -
> >  arch/arm/mach-omap2/sram243x.S                |    4 -
> >  arch/arm/plat-omap/common.c                   |   69 +++++++++++--
> >  arch/arm/plat-omap/include/mach/entry-macro.S |    9 +-
> >  arch/arm/plat-omap/include/mach/omap24xx.h    |   18 ---
> >  arch/arm/plat-omap/include/mach/omap34xx.h    |    9 --
> >  12 files changed, 170 insertions(+), 123 deletions(-)
> > 
> > -- 
> > Signature
> > --
> > To unsubscribe from this list: send the line "unsubscribe 
> > linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> > 
