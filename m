From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: RE: [PATCH][RFC] OMAP3630: Create architecture macros and config
 entries.
Date: Tue, 22 Sep 2009 00:40:04 +0200
Message-ID: <74583B8642AB8841B30447520659FCA9DD8C64D8@dnce01.ent.ti.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E9402534261B3@dbde02.ent.ti.com>
 <74583B8642AB8841B30447520659FCA9DD85B939@dnce01.ent.ti.com>
 <A24693684029E5489D1D202277BE89444C6864B8@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36333 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754099AbZIUWkE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Sep 2009 18:40:04 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n8LMe7qO032283
	for <linux-omap@vger.kernel.org>; Mon, 21 Sep 2009 17:40:07 -0500
Received: from dlep20.itg.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id n8LMe7wh029321
	for <linux-omap@vger.kernel.org>; Mon, 21 Sep 2009 17:40:07 -0500 (CDT)
Received: from dnce72.ent.ti.com (localhost [127.0.0.1])
	by dlep20.itg.ti.com (8.12.11/8.12.11) with ESMTP id n8LMe6tE024670
	for <linux-omap@vger.kernel.org>; Mon, 21 Sep 2009 17:40:06 -0500 (CDT)
In-Reply-To: <A24693684029E5489D1D202277BE89444C6864B8@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>, "Pais, Allen" <allen.pais@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Raju, Veeramanikandan" <veera@ti.com>, "Bongale, Hariprasad" <hariprasad.bongale@ti.com>

Hi Sergio,

> -----Original Message-----
> From: Aguirre Rodriguez, Sergio Alberto
> Sent: Monday, September 21, 2009 8:32 PM
> To: Cousson, Benoit; Pais, Allen; linux-omap@vger.kernel.org
> Cc: Raju, Veeramanikandan; Bongale, Hariprasad
> Subject: RE: [PATCH][RFC] OMAP3630: Create architecture macros and config
> entries.
> 
> 
> 
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Cousson, Benoit
> > Sent: Sunday, September 20, 2009 10:08 AM
> > To: Pais, Allen; linux-omap@vger.kernel.org
> > Cc: Raju, Veeramanikandan; Bongale, Hariprasad
> > Subject: RE: [PATCH][RFC] OMAP3630: Create architecture macros and
> config
> > entries.
> >
> > Hi Allen,
> >
> > > -----Original Message-----
> > > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > > owner@vger.kernel.org] On Behalf Of Pais, Allen
> > > Sent: Sunday, September 20, 2009 9:47 AM
> > > To: linux-omap@vger.kernel.org; Raju, Veeramanikandan; Bongale,
> > Hariprasad
> > > Subject: [PATCH][RFC] OMAP3630: Create architecture macros and config
> > > entries.
> > >
> > >
> > > This patch creates the architectural macros for OMAP3630.
> > >
> > > Signed-off-by: Allen Pais <allen.pais@ti.com>
> > >
> > > arch/arm/mach-omap2/Kconfig                 |   13 ++
> > > arch/arm/plat-omap/include/mach/cpu.h       |   30 +++++-
> > >
> > > diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> > > index 75b1c7e..618b7d5 100755
> > > --- a/arch/arm/mach-omap2/Kconfig
> > > +++ b/arch/arm/mach-omap2/Kconfig
> > > @@ -19,11 +19,20 @@ config ARCH_OMAP34XX
> > >  	bool "OMAP34xx Based System"
> > >  	depends on ARCH_OMAP3
> > >
> > > +config ARCH_OMAP36XX
> > > +	bool "OMAP36xx Based System"
> > > +	depends on ARCH_OMAP3
> > > +
> > >  config ARCH_OMAP3430
> > >  	bool "OMAP3430 support"
> > >  	depends on ARCH_OMAP3 && ARCH_OMAP34XX
> > >  	select ARCH_OMAP_OTG
> > >
> > > +config ARCH_OMAP3630
> > > +	bool "OMAP3630 support"
> > > +	depends on ARCH_OMAP3 && ARCH_OMAP34XX && ARCH_OMAP36XX
> > > +	select ARCH_OMAP_OTG
> > > +
> > >  comment "OMAP Board Type"
> > >  	depends on ARCH_OMAP2 || ARCH_OMAP3 || ARCH_OMAP4
> > >
> > > @@ -73,6 +82,10 @@ config MACH_OMAP_3430SDP
> > >  	bool "OMAP 3430 SDP board"
> > >  	depends on ARCH_OMAP3 && ARCH_OMAP34XX
> > >
> > > +config MACH_OMAP_3630SDP
> > > +	bool "OMAP 3630 SDP board"
> > > +	depends on ARCH_OMAP3 && ARCH_OMAP34XX & ARCH_OMAP36XX
> > > +
> > >  config MACH_NOKIA_N8X0
> > >  	bool "Nokia N800/N810"
> > >  	depends on ARCH_OMAP2420
> > > diff --git a/arch/arm/plat-omap/include/mach/cpu.h b/arch/arm/plat-
> > > omap/include/mach/cpu.h
> > > index 7a5f9e8..73c656c 100755
> > > --- a/arch/arm/plat-omap/include/mach/cpu.h
> > > +++ b/arch/arm/plat-omap/include/mach/cpu.h
> > > @@ -157,10 +157,12 @@ IS_OMAP_CLASS(15xx, 0x15)
> > >  IS_OMAP_CLASS(16xx, 0x16)
> > >  IS_OMAP_CLASS(24xx, 0x24)
> > >  IS_OMAP_CLASS(34xx, 0x34)
> > > +IS_OMAP_CLASS(36xx, 0x36)
> >
> > OMAP3630 is "just" an OMAP3430 in disguise.
> > I don't think it deserves a new class. It should probably be handled
> like
> > it was done for 1610 and 1710.
> >
> > Theoretically, it should be considered as a 3430 ES4.0, because it is an
> > OMAP3430 ES3 + couple of bug fixes + couple of improvements.
> >
> > I think, that the proposal from Sanjeev to support 35xx
> > (http://marc.info/?l=linux-omap&m=125050987112798&w=2 ) might be
> leveraged
> > to handle 36xx as well.
> >
> 
> I respectfully tend to disagree with this, since there are some components
> inside the chip that aren't specifically fixes, so IMHO they need to start
> from scratch about silicon revisions because of that.

Could you be more specific? To what point are you answering? 
Who are "they"? 

> If there are many common points between 34xx/35xx/36xx, then rename the
> reused functions/defines to omap3, instead of omap34xx/omap35xx/omap36xx.

Sure, it is the minimum, but then we still have to handle the differences. Do we use a chip specific function or the feature approach?
 
Benoit
