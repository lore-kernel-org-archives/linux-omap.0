From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: RE: [PATCH 0/5 v3] OMAP2PLUS: WDT: Implement WDT in HWMOD way
Date: Fri, 27 Aug 2010 20:08:33 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02CCA86F28@dbde02.ent.ti.com>
References: <1281965809-20585-1-git-send-email-charu@ti.com>
 <87y6btx9vt.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56135 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752234Ab0H0Oim convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Aug 2010 10:38:42 -0400
In-Reply-To: <87y6btx9vt.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "wim@iguana.be" <wim@iguana.be>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Basak, Partha" <p-basak2@ti.com>



> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Friday, August 27, 2010 4:25 AM
> To: Varadarajan, Charulatha
> Cc: linux-omap@vger.kernel.org; wim@iguana.be; paul@pwsan.com; Cousson,
> Benoit; Nayak, Rajendra; Basak, Partha
> Subject: Re: [PATCH 0/5 v3] OMAP2PLUS: WDT: Implement WDT in HWMOD way
> 
> Charulatha V <charu@ti.com> writes:
> 
> > This patch series makes OMAP2PLUS Watchdog Timer Module implemented
> > in HWMOD FW way. It also implements Watchdog timer driver to
> > use the runtime PM layer.
> 
> minor nit: hwmod should not be capitalized, as it's not an acronym.
> This common across the other conversions as well, so it's not unique to
> you.  You just got lucky and got picked on today. :)

Sure, will take care.

> 
> > This patch series is created on "origin/pm-wip/hwmods-omap4".
> >
> > This patch series is tested on OMAP3430 SDP and OMAP4430 SDP.
> > It would be of great help if someone could test the same on
> > OMAP1 and OMAP2 boards.
> 
> At a bare minimum, this should be at least compile tested for OMAP1 &
> OMAP2.  Also, your team should have some OMAP2 hardware.  Please boot
> test there.

Okay.

> 
> Kevin
> 
> > Version History:
> > ---------------
> > Vesrion v3:
> > Fix Minor comments like renaming omap1 watchdog structures
> > with an omap1_ prefix
> >
> > Version v2:
> > Rebase to latest kernel
> > Some of the v2 links:
> > http://www.spinics.net/lists/linux-omap/msg34741.html
> > http://www.spinics.net/lists/linux-omap/msg34673.html
> >
> > Version v1:
> > Initial series
> > Some of the v1 links:
> > http://www.spinics.net/lists/linux-omap/msg30628.html
> > http://www.spinics.net/lists/linux-omap/msg30625.html
> >
> > Benoit Cousson (1):
> >   OMAP4 HWMOD: Add watchdog hwmods.
> >
> > Charulatha V (4):
> >   OMAP3: WDT: Add watchdog timer HWMOD data for OMAP3
> >   OMAP2420: WDT: Add watchdog timer HWMOD data for OMAP2420
> >   OMAP2430: WDT: Add watchdog timer HWMOD data for OMAP2430
> >   OMAP2PLUS: WDT: Conversion to runtime PM
> >
> >  arch/arm/mach-omap2/omap_hwmod_2420_data.c |   59
> ++++++++++++++++++++++++
> >  arch/arm/mach-omap2/omap_hwmod_2430_data.c |   59
> ++++++++++++++++++++++++
> >  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   61
> +++++++++++++++++++++++++
> >  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   68
> ++++++++++++++++++++++++++++
> >  arch/arm/mach-omap2/prcm-common.h          |    4 ++
> >  arch/arm/plat-omap/devices.c               |   64 ++++++++++++++++++---
> -----
> >  drivers/watchdog/omap_wdt.c                |   43 +++--------------
> >  7 files changed, 303 insertions(+), 55 deletions(-)
