From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arch: arm: omap: terminate ifndef
Date: Wed, 19 Aug 2009 16:17:52 +0300
Message-ID: <20090819131752.GC7629@atomide.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DCD67D97@dbde02.ent.ti.com> <1250677938-27955-1-git-send-email-felipe.balbi@nokia.com> <B85A65D85D7EB246BE421B3FB0FBB59301DD1AD8FB@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:64831 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752814AbZHSOR4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Aug 2009 10:17:56 -0400
Content-Disposition: inline
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DD1AD8FB@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Premi, Sanjeev <premi@ti.com> [090819 14:34]:
>  
> 
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org 
> > [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Felipe Balbi
> > Sent: Wednesday, August 19, 2009 4:02 PM
> > To: linux-omap@vger.kernel.org
> > Cc: Felipe Balbi
> > Subject: [PATCH] arch: arm: omap: terminate ifndef
> > 
> > There was a missing endif on cpu.h
> > 
> > Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> > ---
> >  arch/arm/plat-omap/include/mach/cpu.h |    2 ++
> >  1 files changed, 2 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/plat-omap/include/mach/cpu.h 
> > b/arch/arm/plat-omap/include/mach/cpu.h
> > index 61dbe90..7a5f9e8 100644
> > --- a/arch/arm/plat-omap/include/mach/cpu.h
> > +++ b/arch/arm/plat-omap/include/mach/cpu.h
> > @@ -422,3 +422,5 @@ IS_OMAP_TYPE(3430, 0x3430)
> >  
> >  int omap_chip_is(struct omap_chip_id oci);
> >  void omap2_check_revision(void);
> > +
> > +#endif /* __ASM_ARCH_OMAP_CPU_H */
> 
> ACKed.
> Have mentioned the same yesterday.

Sorry, I pushed that experimental patch accidentally while rebasing the upstream
branches. I've pushed Felipe's fix now.

Tony
