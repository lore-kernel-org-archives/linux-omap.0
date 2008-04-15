From: "Syed Mohammed, Khasim" <khasim@ti.com>
Subject: RE: [PATCH 1/4] Updating Kconfig and Makefile for OMAP3 EVM support
Date: Tue, 15 Apr 2008 12:43:10 +0530
Message-ID: <7EAD1AEEA7621C45899FE99123E124A0018C8749@dbde01.ent.ti.com>
References: <7EAD1AEEA7621C45899FE99123E124A0018C8603@dbde01.ent.ti.com> <20080414180447.GA4463@kedavra.cpe.vivax.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:49453 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752998AbYDOHNZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Apr 2008 03:13:25 -0400
Content-class: urn:content-classes:message
In-Reply-To: <20080414180447.GA4463@kedavra.cpe.vivax.com.br>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: linux-omap@vger.kernel.org



> -----Original Message-----
> From: Felipe Balbi [mailto:me@felipebalbi.com]
> Sent: Monday, April 14, 2008 11:35 PM
> To: Syed Mohammed, Khasim
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH 1/4] Updating Kconfig and Makefile for OMAP3 EVM
> support
> 
> On Mon, Apr 14, 2008 at 05:36:50PM +0530, Syed Mohammed, Khasim wrote:
> >
> > Updated Kconfig and Makefile for OMAP3 EVM support
> >
> > Signed-off-by: Syed Mohammed Khasim <khasim@ti.com>
> > ---
> >  arch/arm/mach-omap2/Kconfig  |   10 +++++++---
> >  arch/arm/mach-omap2/Makefile |    1 +
> >  2 files changed, 8 insertions(+), 3 deletions(-)
> >
> > Index: my_branch/arch/arm/mach-omap2/Kconfig
> > ===================================================================
> > --- my_branch.orig/arch/arm/mach-omap2/Kconfig	2008-04-14
> 16:07:11.000000000 +0530
> > +++ my_branch/arch/arm/mach-omap2/Kconfig	2008-04-14
> 16:07:41.000000000 +0530
> > @@ -98,10 +98,14 @@
> >  	bool "OMAP 2430 SDP board"
> >  	depends on ARCH_OMAP2 && ARCH_OMAP2430
> >
> > +config MACH_OMAP_2430OSK
> > +	bool "OMAP 2430 OSK board"
> > +	depends on ARCH_OMAP2 && ARCH_OMAP24XX
> > +
> >  config MACH_OMAP_3430SDP
> >  	bool "OMAP 3430 SDP board"
> >  	depends on ARCH_OMAP3 && ARCH_OMAP34XX
> >
> > -config MACH_OMAP_2430OSK
> > -	bool "OMAP 2430 OSK board"
> > -	depends on ARCH_OMAP2 && ARCH_OMAP24XX
> > +config MACH_OMAP3EVM
> > +	bool "OMAP 3530 EVM board"
> > +	depends on ARCH_OMAP3 && ARCH_OMAP34XX
> 
> Do you really need to move 2430OSK here?
> It looks like unnecessary change.
> 
> please revert.
> 
This change is good as it lists all omap2 followed by omap3 boards. Otherwise it mixes OMAP2 boards with OMAP3 boards.

Regards,
Khasim
