From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: RE: [PATCH V2]omap: mux.c warning removal
Date: Tue, 11 May 2010 16:00:23 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C003B3209CCD@dbde02.ent.ti.com>
References: <0680EC522D0CC943BC586913CF3768C003B31655C3@dbde02.ent.ti.com>
 <874oiflos4.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41557 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750818Ab0EKKaf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 May 2010 06:30:35 -0400
In-Reply-To: <874oiflos4.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Monday, May 10, 2010 9:42 PM
> To: Munegowda, Keshava
> Cc: linux-omap@vger.kernel.org; tony@atomide.com
> Subject: Re: [PATCH V2]omap: mux.c warning removal
> 
> "Munegowda, Keshava" <keshava_mgowda@ti.com> writes:
> 
> > From: Keshava Munegowda <a0393220@ti.com>
> >
> > This patch removes the below warning
> > arch/arm/mach-omap2/mux.c:52: warning: 'mux_phys' defined but not used
> > The definition of variable mux_phys should be enclosed in the macro CONFIG_ARCH_OMAP3
> >
> > Signed-off-by: Keshava Munegowda <a0393220@ti.com>
> 
> Thanks, this version looks better.
> 
> Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
> 
> 
> One silly question though... is your a0....@ti.com address the one you
> want as your From: and Signed-off-by?  Since the mail actually comes
> from a more human readable address, I'm guessing that would be
> preferred?  If so, create a ~/.gitconfig file and add this:
> 
> [user]
> 	name = Keshava Munegowda
> 	email = keshava_mgowda@ti.com
> 
> This way, all your local git commands will use this name/email in your
> git commits, sign-offs etc.
> 
> 
 Thanks Kevin, I will keep this configuration.
 Keshava Munegowda



> 
> 
> 
> 
> 
> 
> > Index: linux-2.6/arch/arm/mach-omap2/mux.c
> > ===================================================================
> > --- linux-2.6.orig/arch/arm/mach-omap2/mux.c	2010-05-05 23:59:19.000000000 +0530
> > +++ linux-2.6/arch/arm/mach-omap2/mux.c	2010-05-06 00:00:07.000000000 +0530
> > @@ -49,7 +49,7 @@
> >  	struct list_head	node;
> >  };
> >
> > -static unsigned long mux_phys;
> > +
> >  static void __iomem *mux_base;
> >
> >  u16 omap_mux_read(u16 reg)
> > @@ -373,6 +373,7 @@
> >  #ifdef CONFIG_ARCH_OMAP3
> >  static LIST_HEAD(muxmodes);
> >  static DEFINE_MUTEX(muxmode_mutex);
> > +static unsigned long mux_phys;
> >
> >  #ifdef CONFIG_OMAP_MUX
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
