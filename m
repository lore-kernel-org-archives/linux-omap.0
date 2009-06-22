From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: RE: [PATCH] ARM: MACH-OMAP2: Cleanup Kconfig entries
Date: Mon, 22 Jun 2009 07:56:48 -0500
Message-ID: <A24693684029E5489D1D202277BE8944411FCBB2@dlee02.ent.ti.com>
References: <A24693684029E5489D1D202277BE8944411FC323@dlee02.ent.ti.com>
 <20090622125233.GG7352@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42385 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753476AbZFVMzF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Jun 2009 08:55:05 -0400
In-Reply-To: <20090622125233.GG7352@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Monday, June 22, 2009 7:53 AM
> To: Aguirre Rodriguez, Sergio Alberto
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH] ARM: MACH-OMAP2: Cleanup Kconfig entries
> 
> * Aguirre Rodriguez, Sergio Alberto <saaguirre@ti.com> [090619 17:53]:
> > From 9258708325e0a04de7d7503b65cabc25860a9e7d Mon Sep 17 00:00:00 2001
> > From: Sergio Aguirre <saaguirre@ti.com>
> > Date: Fri, 19 Jun 2009 09:50:52 -0500
> > Subject: [PATCH] ARM: MACH-OMAP2: Cleanup Kconfig entries
> >
> > This patch removes some duplicate entries, and intents to cleanup
> > the order.
> 
> This does not seem to apply to the mainline kernel or linux-omap,
> can you please check?

Tony,

I'm sorry for not clarifying...

I applied this patch on top of Kevin's PM tree, I'll check on l-o tree.

Regards,
Sergio

> 
> Tony
> 
> > Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
> > ---
> >  arch/arm/mach-omap2/Kconfig |   38 ++++++++++++++----------------------
> --
> >  1 files changed, 14 insertions(+), 24 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> > index bfb36e2..caf5144 100644
> > --- a/arch/arm/mach-omap2/Kconfig
> > +++ b/arch/arm/mach-omap2/Kconfig
> > @@ -109,22 +109,30 @@ config MACH_OMAP_2430SDP
> >  	bool "OMAP 2430 SDP board"
> >  	depends on ARCH_OMAP2 && ARCH_OMAP2430
> >
> > -config MACH_OMAP_LDP
> > -	bool "OMAP3 LDP board"
> > +config MACH_OMAP_3430SDP
> > +	bool "OMAP 3430 SDP board"
> >  	depends on ARCH_OMAP3 && ARCH_OMAP34XX
> >
> > +config MACH_OMAP_4430SDP
> > +	bool "OMAP 4430 SDP board"
> > +	depends on ARCH_OMAP4
> > +
> >  config MACH_OMAP2EVM
> >  	bool "OMAP 2530 EVM board"
> >  	depends on ARCH_OMAP2 && ARCH_OMAP24XX
> >
> > -config MACH_OMAP_3430SDP
> > -	bool "OMAP 3430 SDP board"
> > -	depends on ARCH_OMAP3 && ARCH_OMAP34XX
> > -
> >  config MACH_OMAP3EVM
> >  	bool "OMAP 3530 EVM board"
> >  	depends on ARCH_OMAP3 && ARCH_OMAP34XX
> >
> > +config MACH_OMAP_LDP
> > +	bool "OMAP3 LDP board"
> > +	depends on ARCH_OMAP3 && ARCH_OMAP34XX
> > +
> > +config MACH_OMAP_ZOOM2
> > +	bool "OMAP3 Zoom2 board"
> > +	depends on ARCH_OMAP3 && ARCH_OMAP34XX
> > +
> >  config MACH_OMAP3_BEAGLE
> >  	bool "OMAP3 BEAGLE board"
> >  	depends on ARCH_OMAP3 && ARCH_OMAP34XX
> > @@ -133,26 +141,8 @@ config MACH_OVERO
> >  	bool "Gumstix Overo board"
> >  	depends on ARCH_OMAP3 && ARCH_OMAP34XX
> >
> > -config MACH_OMAP3EVM
> > -	bool "OMAP 3530 EVM board"
> > -	depends on ARCH_OMAP3 && ARCH_OMAP34XX
> > -
> >  config MACH_OMAP3_PANDORA
> >  	bool "OMAP3 Pandora"
> >  	depends on ARCH_OMAP3 && ARCH_OMAP34XX
> >
> > -config MACH_OMAP_3430SDP
> > -	bool "OMAP 3430 SDP board"
> > -	depends on ARCH_OMAP3 && ARCH_OMAP34XX
> >
> > -config MACH_OMAP_ZOOM2
> > -	bool "OMAP3 Zoom2 board"
> > -	depends on ARCH_OMAP3 && ARCH_OMAP34XX
> > -
> > -config MACH_OMAP_ZOOM2
> > -	bool "OMAP3 Zoom2 board"
> > -	depends on ARCH_OMAP3 && ARCH_OMAP34XX
> > -
> > -config MACH_OMAP_4430SDP
> > -	bool "OMAP 4430 SDP board"
> > -	depends on ARCH_OMAP4
> > --
> > 1.6.3.2
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html

