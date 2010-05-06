From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: RE: [PATCH]omap: mux.c warning removal
Date: Thu, 6 May 2010 12:06:13 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C003B3165321@dbde02.ent.ti.com>
References: <0680EC522D0CC943BC586913CF3768C003B31651B1@dbde02.ent.ti.com>
 <87mxwe3uzf.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49779 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151Ab0EFGgQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 May 2010 02:36:16 -0400
In-Reply-To: <87mxwe3uzf.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: "tony@atomide.com" <tony@atomide.com>


Hi Kevin 
   Thanks for review comments!  The updated patch is below.


From: Keshava Munegowda <a0393220@ti.com>

This patch removes the below warning 
arch/arm/mach-omap2/mux.c:52: warning: 'mux_phys' defined but not used
The definition of variable mux_phys should be enclosed in the macro CONFIG_ARCH_OMAP3 

Signed-off-by: Keshava Munegowda <a0393220@ti.com>

Index: linux-2.6/arch/arm/mach-omap2/mux.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-omap2/mux.c	2010-05-05 23:59:19.000000000 +0530
+++ linux-2.6/arch/arm/mach-omap2/mux.c	2010-05-06 00:00:07.000000000 +0530
@@ -49,7 +49,7 @@
 	struct list_head	node;
 };
 
-static unsigned long mux_phys;
+
 static void __iomem *mux_base;
 
 u16 omap_mux_read(u16 reg)
@@ -373,6 +373,7 @@
 #ifdef CONFIG_ARCH_OMAP3
 static LIST_HEAD(muxmodes);
 static DEFINE_MUTEX(muxmode_mutex);
+static unsigned long mux_phys;
 
 #ifdef CONFIG_OMAP_MUX
 
 

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Thursday, May 06, 2010 2:52 AM
> To: Munegowda, Keshava
> Cc: linux-omap@vger.kernel.org; tony@atomide.com
> Subject: Re: [PATCH]omap: mux.c warning removal
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
> > Index: linux-2.6/arch/arm/mach-omap2/mux.c
> > ===================================================================
> > --- linux-2.6.orig/arch/arm/mach-omap2/mux.c	2010-05-05 05:28:47.000000000 +0530
> > +++ linux-2.6/arch/arm/mach-omap2/mux.c	2010-05-05 05:29:02.000000000 +0530
> > @@ -49,7 +49,9 @@
> >  	struct list_head	node;
> >  };
> >
> > +#ifdef CONFIG_ARCH_OMAP3
> >  static unsigned long mux_phys;
> > +#endif
> 
> Rather than add another #ifdef, just move this inside the existing
> #ifdef farther down in the file.
> 
> Kevin
