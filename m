From: "George G. Davis" <gdavis@mvista.com>
Subject: Re: [PATCH] ARM: OMAP2: Fix missing system control module exports
Date: Thu, 5 Mar 2009 21:31:08 -0500
Message-ID: <20090306023108.GI5202@mvista.com>
References: <20090302144723.GD18140@mvista.com> <20090306004309.GG6784@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:48199 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752490AbZCFCbQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Mar 2009 21:31:16 -0500
Content-Disposition: inline
In-Reply-To: <20090306004309.GG6784@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>

Hi,

On Thu, Mar 05, 2009 at 04:43:09PM -0800, Tony Lindgren wrote:
> Hi,
> 
> * George G. Davis <gdavis@mvista.com> [090302 08:19]:
> > When building ASoC drivers as modules for SND_OMAP_SOC_MCBSP based
> > targets, the build fails because omap_ctrl_{read,write}l lack exports.
> > So add the missing exports for omap_ctrl_{read,write}[bwl] to allow
> > building these ASoC (and other) drivers as modules.
> 
> I think Paul has some comments on how the clock framework should
> handle this case without needing to export the omap_ctrl_read/write.

Yeah, I figured direct calls to these from drivers was just
plain wrong to begin with (preemption issues come to mind
for one), but went with the quick fix.  I'm all ears on
the proper fix...

--
Regards,
George

> 
> Regards,
> 
> Tony
>  
> > Signed-off-by: George G. Davis <gdavis@mvista.com>
> > Acked-by: Jarkko Nikula <jarkko.nikula@nokia.com>
> > ---
> >  arch/arm/mach-omap2/control.c |    6 ++++++
> >  1 files changed, 6 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
> > index 5f3aad9..6b14639 100644
> > --- a/arch/arm/mach-omap2/control.c
> > +++ b/arch/arm/mach-omap2/control.c
> > @@ -36,29 +36,35 @@ u8 omap_ctrl_readb(u16 offset)
> >  {
> >  	return __raw_readb(OMAP_CTRL_REGADDR(offset));
> >  }
> > +EXPORT_SYMBOL(omap_ctrl_readb);
> >  
> >  u16 omap_ctrl_readw(u16 offset)
> >  {
> >  	return __raw_readw(OMAP_CTRL_REGADDR(offset));
> >  }
> > +EXPORT_SYMBOL(omap_ctrl_readw);
> >  
> >  u32 omap_ctrl_readl(u16 offset)
> >  {
> >  	return __raw_readl(OMAP_CTRL_REGADDR(offset));
> >  }
> > +EXPORT_SYMBOL(omap_ctrl_readl);
> >  
> >  void omap_ctrl_writeb(u8 val, u16 offset)
> >  {
> >  	__raw_writeb(val, OMAP_CTRL_REGADDR(offset));
> >  }
> > +EXPORT_SYMBOL(omap_ctrl_writeb);
> >  
> >  void omap_ctrl_writew(u16 val, u16 offset)
> >  {
> >  	__raw_writew(val, OMAP_CTRL_REGADDR(offset));
> >  }
> > +EXPORT_SYMBOL(omap_ctrl_writew);
> >  
> >  void omap_ctrl_writel(u32 val, u16 offset)
> >  {
> >  	__raw_writel(val, OMAP_CTRL_REGADDR(offset));
> >  }
> > +EXPORT_SYMBOL(omap_ctrl_writel);
> >  
> > -- 
> > 1.6.1.2.MVISTA
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
