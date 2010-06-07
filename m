From: "Gurav , Pramod" <pramod.gurav@ti.com>
Subject: RE: [PATCH V4 0/2] OMAP3: Dynamic Calculation of SDRC stall latency
 during DVFS
Date: Mon, 7 Jun 2010 16:43:29 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03232DAE08@dbde02.ent.ti.com>
References: <> <1270142216-18118-1-git-send-email-pramod.gurav@ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0322986980@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49814 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751424Ab0FGLNi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Jun 2010 07:13:38 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0322986980@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>

Hello Paul,
Can you please push these patches if you don't you are OK with them?

-
Thanks and Best Regards
Pramod Gurav

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Gurav , Pramod
> Sent: Friday, April 23, 2010 7:53 PM
> To: linux-omap@vger.kernel.org; Paul Walmsley; Kevin Hilman
> Cc: Sripathy, Vishwanath; K, Ambresh
> Subject: RE: [PATCH V4 0/2] OMAP3: Dynamic Calculation of SDRC stall
> latency during DVFS
> 
> Hi Paul,
> 
> Please let me know if you have any comments on the patches below.
> The comments from Kevin, Ambresh and Sergio have been addressed in the
> last version of the patches and few in these patches.
> 
> > -----Original Message-----
> > From: Gurav , Pramod
> > Sent: Thursday, April 01, 2010 10:47 PM
> > To: linux-omap@vger.kernel.org
> > Cc: Gurav , Pramod
> > Subject: [PATCH V4 0/2] OMAP3: Dynamic Calculation of SDRC stall latency
> > during DVFS
> >
> > From: Pramod Gurav <pramod.gurav@ti.com>
> >
> > The patch has the changes to calculate the dpll3 clock stabilization
> > delay dynamically. The SRAM delay is calibrated during bootup using the
> > gptimers and used while calculating the stabilization delay. By using
> > the dynamic method the dependency on the type of cache being used is
> > removed.
> >
> > Formula to calculate the DVFS latency for 3430 and 3630 are different.
> > The second patch implements the formula for later.
> >
> > This Version of patches adds optimisation to the formula implementation.
> >
> > Teerth Reddy (1):
> >   OMAP3: SDRC: Dynamic Calculation of SDRC stall latency during DVFS
> > Pramod Gurav (1):
> >   OMAP3630 SDRC: Change in DVFS Latency Formula for OMAP3630
> >
> >  arch/arm/mach-omap2/clkt34xx_dpll3m2.c |   71
> > +++++++++++++++++++++++++++-----
> >  arch/arm/mach-omap2/clock34xx.h        |    2 +
> >  arch/arm/mach-omap2/clock3xxx.c        |    2 +-
> >  arch/arm/mach-omap2/clock3xxx.h        |    1 +
> >  arch/arm/mach-omap2/clock3xxx_data.c   |   13 ++++++
> >  arch/arm/mach-omap2/sram34xx.S         |    8 ++++
> >  arch/arm/plat-omap/include/plat/sram.h |    4 ++
> >  arch/arm/plat-omap/sram.c              |   51 +++++++++++++++++++++++
> >  8 files changed, 140 insertions(+), 12 deletions(-)
> 
> 
> 
> -
> Thanks and Best Regards
> Pramod Gurav
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
