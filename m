From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v5 6/12] OMAP: dmtimer: infrastructure to support hwmod
Date: Tue, 7 Dec 2010 10:20:48 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03736F500D@dbde02.ent.ti.com>
References: <1291679059-13419-1-git-send-email-tarun.kanti@ti.com>
 <1291679059-13419-7-git-send-email-tarun.kanti@ti.com>
 <20101206170929.GC4924@manju-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36920 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754455Ab0LGEu4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Dec 2010 23:50:56 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id oB74oroI023282
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 6 Dec 2010 22:50:55 -0600
In-Reply-To: <20101206170929.GC4924@manju-desktop>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gopinath, Thara" <thara@ti.com>

> -----Original Message-----
> From: G, Manjunath Kondaiah
> Sent: Monday, December 06, 2010 10:39 PM
> To: DebBarma, Tarun Kanti
> Cc: linux-omap@vger.kernel.org; Gopinath, Thara
> Subject: Re: [PATCH v5 6/12] OMAP: dmtimer: infrastructure to support
> hwmod
> 
> On Tue, Dec 07, 2010 at 05:14:13AM +0530, Tarun Kanti DebBarma wrote:
> > (1) Add new fields and data structures to support dmtimer conversion
> > to platform driver.
> > (2) Constants to identify IP revision so that Highlander IP in OMAP 4
> 
> s/OMAP 4/OMAP4
Ok.
> 
> > can be distinguished.
> > (3) field to identify OMAP4 abe timers.
> > (4) Interface function to support early boot.
> >
> > Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> > Signed-off-by: Thara Gopinath <thara@ti.com>
> > Reviewed-by: Cousson, Benoit <b-cousson@ti.com>
> > Reviewed-by: Varadarajan, Charulatha <charu@ti.com>
> > ---
> >  arch/arm/mach-omap2/dmtimer.h             |   30
> +++++++++++++++++++++++++++++
> >  arch/arm/plat-omap/dmtimer.c              |    7 ++++++
> >  arch/arm/plat-omap/include/plat/dmtimer.h |   30
> +++++++++++++++++++++++++++++
> >  3 files changed, 67 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/arm/mach-omap2/dmtimer.h
> >
> > diff --git a/arch/arm/mach-omap2/dmtimer.h b/arch/arm/mach-
> omap2/dmtimer.h
> > new file mode 100644
> > index 0000000..75cca6c
> > --- /dev/null
> > +++ b/arch/arm/mach-omap2/dmtimer.h
> > @@ -0,0 +1,30 @@
> > +/**
> > + * OMAP Dual-Mode Timers - early initialization interface
> > + *
> > + * Function interface called first to start dmtimer early
> initialization.
> > + *
> > + * Copyright (C) 2010 Texas Instruments Incorporated -
> http://www.ti.com/
> > + * Tarun Kanti DebBarma <tarun.kanti@ti.com>
> > + * Thara Gopinath <thara@ti.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> > + * kind, whether express or implied; without even the implied warranty
> > + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + */
> > +#ifndef __ASM_ARCH_DMTIMER_H
> > +#define __ASM_ARCH_DMTIMER_H
> > +
> > +/*
> > + * dmtimer is required during early part of boot sequence even before
> > + * device model and pm_runtime if fully up and running. This function
> > + * provides hook to omap2_init_common_hw() which is triggered from
> > + * start_kernel()->init_irq() of kernel initialization sequence.
> > + */
> > +void __init omap2_dm_timer_early_init(void);
> > +
> > +#endif
> > diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
> > index 1d706cf..7fdf107 100644
> > --- a/arch/arm/plat-omap/dmtimer.c
> > +++ b/arch/arm/plat-omap/dmtimer.c
> > @@ -3,6 +3,12 @@
> >   *
> >   * OMAP Dual-Mode Timers
> >   *
> > + * Copyright (C) 2010 Texas Instruments Incorporated -
> http://www.ti.com/
> > + * Tarun Kanti DebBarma <tarun.kanti@ti.com>
> > + * Thara Gopinath <thara@ti.com>
> > + *
> > + * dmtimer adaptation to platform_driver.
> > + *
> >   * Copyright (C) 2005 Nokia Corporation
> >   * OMAP2 support by Juha Yrjola
> >   * API improvements and OMAP2 clock framework support by Timo Teras
> > @@ -160,6 +166,7 @@ struct omap_dm_timer {
> >  	unsigned reserved:1;
> >  	unsigned enabled:1;
> >  	unsigned posted:1;
> > +	struct platform_device *pdev;
> >  };
> >
> >  static int dm_timer_count;
> > diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-
> omap/include/plat/dmtimer.h
> > index dfa3aff..b90b906 100644
> > --- a/arch/arm/plat-omap/include/plat/dmtimer.h
> > +++ b/arch/arm/plat-omap/include/plat/dmtimer.h
> > @@ -3,6 +3,12 @@
> >   *
> >   * OMAP Dual-Mode Timers
> >   *
> > + * Copyright (C) 2010 Texas Instruments Incorporated -
> http://www.ti.com/
> > + * Tarun Kanti DebBarma <tarun.kanti@ti.com>
> > + * Thara Gopinath <thara@ti.com>
> > + *
> > + * Platform device conversion and hwmod support.
> > + *
> >   * Copyright (C) 2005 Nokia Corporation
> >   * Author: Lauri Leukkunen <lauri.leukkunen@nokia.com>
> >   * PWM and clock framwork support by Timo Teras.
> > @@ -29,6 +35,8 @@
> >  #ifndef __ASM_ARCH_DMTIMER_H
> >  #define __ASM_ARCH_DMTIMER_H
> >
> > +#include <linux/platform_device.h>
> > +
> >  /* clock sources */
> >  #define OMAP_TIMER_SRC_SYS_CLK			0x00
> >  #define OMAP_TIMER_SRC_32_KHZ			0x01
> > @@ -44,11 +52,33 @@
> >  #define OMAP_TIMER_TRIGGER_OVERFLOW		0x01
> >  #define OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE	0x02
> >
> > +/*
> > + * IP revision identifier so that Highlander IP
> > + * in OMAP 4 can be distinguished.
> > + */
> > +#define OMAP_TIMER_IP_VERSION_1			0x1
> > +#define OMAP_TIMER_IP_VERSION_2			0x2
> 
> As mentioned in earlier patches, introduce these defines where you are
> using.
Ok.
> 
> > +
> > +/*
> > + * OMAP 4 IP revision has different register offsets
> 
> s/OMAP 4/OMAP4/gc
Ok.

--
Tarun
