From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCHv3 2/17] dmtimer: infrastructure to support hwmod
Date: Thu, 23 Sep 2010 11:34:39 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB032963EBE8@dbde02.ent.ti.com>
References: <1285059089-26341-1-git-send-email-tarun.kanti@ti.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94027863D708@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54703 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753330Ab0IWGEq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Sep 2010 02:04:46 -0400
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E94027863D708@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Basak, Partha" <p-basak2@ti.com>, "Gopinath, Thara" <thara@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>


> -----Original Message-----
> From: G, Manjunath Kondaiah
> Sent: Thursday, September 23, 2010 12:31 AM
> To: DebBarma, Tarun Kanti; linux-omap@vger.kernel.org
> Cc: Basak, Partha; Gopinath, Thara; Cousson, Benoit; Paul Walmsley; Kevin
> Hilman; Tony Lindgren
> Subject: RE: [PATCHv3 2/17] dmtimer: infrastructure to support hwmod
> 
> 
> 
> 
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org
> > [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of
> > DebBarma, Tarun Kanti
> > Sent: Tuesday, September 21, 2010 2:21 PM
> > To: linux-omap@vger.kernel.org
> > Cc: DebBarma, Tarun Kanti; Basak, Partha; Gopinath, Thara;
> > Cousson, Benoit; Paul Walmsley; Kevin Hilman; Tony Lindgren
> > Subject: [PATCHv3 2/17] dmtimer: infrastructure to support hwmod
> >
> > This patch introduces data structures and new fields on
> > existing data structures to support dmtimer conversion to
> > platform driver and support hwmod database for the diferent
> > OMAP platforms.
> >
> > Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> > Signed-off-by: Partha Basak <p-basak2@ti.com>
> > Signed-off-by: Thara Gopinath <thara@ti.com>
> > Cc: Cousson, Benoit <b-cousson@ti.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > Cc: Kevin Hilman <khilman@deeprootsystems.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> > ---
> >  arch/arm/mach-omap2/dmtimer.h             |   25 +++++++++++++++++
> >  arch/arm/plat-omap/dmtimer.c              |    9 ++++++
> >  arch/arm/plat-omap/include/plat/dmtimer.h |   42
> > +++++++++++++++++++++++++++++
> >  3 files changed, 76 insertions(+), 0 deletions(-)  create
> > mode 100644 arch/arm/mach-omap2/dmtimer.h
> >
> > diff --git a/arch/arm/mach-omap2/dmtimer.h
> > b/arch/arm/mach-omap2/dmtimer.h new file mode 100644 index
> > 0000000..3355725
> > --- /dev/null
> > +++ b/arch/arm/mach-omap2/dmtimer.h
> > @@ -0,0 +1,25 @@
> > +/**
> > + * linux/arch/arm/mach-omap2/dmtimer.h
> > + *
> > + * Copyright (C) 2010 Texas Instruments, Inc.
> > + * Thara Gopinath <thara@ti.com>
> > + * Tarun Kanti DebBarma <tarun.kanti@ti.com>
> > + *
> > + * OMAP2 Dual-Mode Timers
> > + * This program is free software; you can redistribute it
> > and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#ifndef __ASM_ARCH_DMTIMER_H
> > +#define __ASM_ARCH_DMTIMER_H
> 
> This header guard name is same as plat-omap dmtimer.h header guard. If
> both
> the headers are used in same file, it will result in build break. Change
> the name. May be __ASM_ARCH_DMTIMER_H__ and __ASM_PLAT_DMTIMER_H__ ?
OK.
