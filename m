From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH V4 0/2] OMAP3: Dynamic Calculation of SDRC stall latency
 during DVFS
Date: Thu, 1 Jul 2010 12:42:17 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1007011235090.13691@utopia.booyaka.com>
References: <> <1270142216-18118-1-git-send-email-pramod.gurav@ti.com> <5A47E75E594F054BAF48C5E4FC4B92AB0322986980@dbde02.ent.ti.com> <5A47E75E594F054BAF48C5E4FC4B92AB03232DAE08@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43035 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932297Ab0GASmS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Jul 2010 14:42:18 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB03232DAE08@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gurav , Pramod" <pramod.gurav@ti.com>, teerth@ti.com
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, b-cousson@ti.com, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>

Pramod, Teerth,

On Mon, 7 Jun 2010, Gurav , Pramod wrote:

> Can you please push these patches if you don't you are OK with them?

As we discussed in Bangalore, these patches need some changes:

1. The delay needs to be precisely characterized in terms of what the 
hardware actually needs.  It should not be necessary to add any extra 
timing slop, due to unknown sources, in the code.  Unknown sources of 
delay can cause problems if, for example, a customer changes some board 
characteristics (such as sys_clk frequency, or DPLL multipliers/dividers) 
that the delay depends on.

Also, my understanding is that RX-51 shipped without unknown timing 
factors in this code.  Please work with the hardware people to precisely 
characterize the delay, assuming that it does not match what is documented 
in the TRM.

2. Please split out the individual components of the delay calculation to 
the code that handles those clocks.  For example, HSDIVIDER change delay 
should be calculated by code that handles the HSDIVIDER.  DPLL relock 
delay should be calculated by code in the dpll*.c files.  etc.

regards

- Paul

> -
> Thanks and Best Regards
> Pramod Gurav
> 
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Gurav , Pramod
> > Sent: Friday, April 23, 2010 7:53 PM
> > To: linux-omap@vger.kernel.org; Paul Walmsley; Kevin Hilman
> > Cc: Sripathy, Vishwanath; K, Ambresh
> > Subject: RE: [PATCH V4 0/2] OMAP3: Dynamic Calculation of SDRC stall
> > latency during DVFS
> > 
> > Hi Paul,
> > 
> > Please let me know if you have any comments on the patches below.
> > The comments from Kevin, Ambresh and Sergio have been addressed in the
> > last version of the patches and few in these patches.
> > 
> > > -----Original Message-----
> > > From: Gurav , Pramod
> > > Sent: Thursday, April 01, 2010 10:47 PM
> > > To: linux-omap@vger.kernel.org
> > > Cc: Gurav , Pramod
> > > Subject: [PATCH V4 0/2] OMAP3: Dynamic Calculation of SDRC stall latency
> > > during DVFS
> > >
> > > From: Pramod Gurav <pramod.gurav@ti.com>
> > >
> > > The patch has the changes to calculate the dpll3 clock stabilization
> > > delay dynamically. The SRAM delay is calibrated during bootup using the
> > > gptimers and used while calculating the stabilization delay. By using
> > > the dynamic method the dependency on the type of cache being used is
> > > removed.
> > >
> > > Formula to calculate the DVFS latency for 3430 and 3630 are different.
> > > The second patch implements the formula for later.
> > >
> > > This Version of patches adds optimisation to the formula implementation.
> > >
> > > Teerth Reddy (1):
> > >   OMAP3: SDRC: Dynamic Calculation of SDRC stall latency during DVFS
> > > Pramod Gurav (1):
> > >   OMAP3630 SDRC: Change in DVFS Latency Formula for OMAP3630
> > >
> > >  arch/arm/mach-omap2/clkt34xx_dpll3m2.c |   71
> > > +++++++++++++++++++++++++++-----
> > >  arch/arm/mach-omap2/clock34xx.h        |    2 +
> > >  arch/arm/mach-omap2/clock3xxx.c        |    2 +-
> > >  arch/arm/mach-omap2/clock3xxx.h        |    1 +
> > >  arch/arm/mach-omap2/clock3xxx_data.c   |   13 ++++++
> > >  arch/arm/mach-omap2/sram34xx.S         |    8 ++++
> > >  arch/arm/plat-omap/include/plat/sram.h |    4 ++
> > >  arch/arm/plat-omap/sram.c              |   51 +++++++++++++++++++++++
> > >  8 files changed, 140 insertions(+), 12 deletions(-)
> > 
> > 
> > 
> > -
> > Thanks and Best Regards
> > Pramod Gurav
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
