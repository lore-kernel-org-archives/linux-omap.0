From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 1/3] OMAP4: SMP: Add OMAP4430 SMP board files
Date: Fri, 8 May 2009 22:14:47 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B476BA63@dbde02.ent.ti.com>
References: <1241681366-21094-1-git-send-email-santosh.shilimkar@ti.com>
 <20090507204653.GD5593@atomide.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02B4688409@dbde02.ent.ti.com>
 <20090508151755.GI5593@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37666 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754090AbZEHQpI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 May 2009 12:45:08 -0400
In-Reply-To: <20090508151755.GI5593@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Tony Lindgren
> Sent: Friday, May 08, 2009 8:48 PM
> To: Shilimkar, Santosh
> Cc: linux-arm-kernel@lists.arm.linux.org.uk; 
> linux-omap@vger.kernel.org
> Subject: Re: [PATCH 1/3] OMAP4: SMP: Add OMAP4430 SMP board files
> 
> * Shilimkar, Santosh <santosh.shilimkar@ti.com> [090507 22:10]:
> > > -----Original Message-----
> > > From: Tony Lindgren [mailto:tony@atomide.com] 
> > > Sent: Friday, May 08, 2009 2:17 AM
> > > To: Shilimkar, Santosh
> > > Cc: linux-arm-kernel@lists.arm.linux.org.uk; 
> > > linux-omap@vger.kernel.org
> > > Subject: Re: [PATCH 1/3] OMAP4: SMP: Add OMAP4430 SMP board files
> > > 
> > > * Santosh Shilimkar <santosh.shilimkar@ti.com> [090507 00:29]:
> > > > This patch adds SMP platform files support for OMAP4430SDP. 
> > > TI's OMAP4430
> > > > SOC is based on ARM Cortex-A9 SMP architecture. It's a 
> dual core SOC
> > > > with GIC used for interrupt handling and SCU for cache 
> coherency.
> > > > 
> > > > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > > > ---
> > > >  arch/arm/mach-omap2/omap-headsmp.S    |   49 +++++++
> > > >  arch/arm/mach-omap2/omap-smp.c        |  238 
> > > +++++++++++++++++++++++++++++++++
> > > >  arch/arm/plat-omap/include/mach/scu.h |   28 ++++
> > > >  arch/arm/plat-omap/include/mach/smp.h |   56 ++++++++
> > > >  4 files changed, 371 insertions(+), 0 deletions(-)
> > > >  create mode 100644 arch/arm/mach-omap2/omap-headsmp.S
> > > >  create mode 100644 arch/arm/mach-omap2/omap-smp.c
> > > >  create mode 100644 arch/arm/plat-omap/include/mach/scu.h
> > > >  create mode 100644 arch/arm/plat-omap/include/mach/smp.h
> > > 
> > > <snip snip>
> > >  
> > > > --- /dev/null
> > > > +++ b/arch/arm/mach-omap2/omap-smp.c
> > > > @@ -0,0 +1,238 @@
> > > > +/*
> > > > + * OMAP4 SMP source file. It contains platform 
> specific fucntions
> > > > + * needed for the linux smp kernel.
> > > > + *
> > > > + * Copyright (C) 2009 Texas Instruments, Inc.
> > > > + *
> > > > + * Author:
> > > > + *      Santosh Shilimkar <santosh.shilimkar@ti.com>
> > > > + *
> > > > + * Platform file needed for the OMAP4 SMP. This file is 
> > > based on arm
> > > > + * realview smp platform.
> > > > + * * Copyright (c) 2002 ARM Limited.
> > > > + *
> > > > + * This program is free software; you can redistribute it 
> > > and/or modify
> > > > + * it under the terms of the GNU General Public License 
> > > version 2 as
> > > > + * published by the Free Software Foundation.
> > > > + */
> > > > +#include <linux/init.h>
> > > > +#include <linux/errno.h>
> > > > +#include <linux/delay.h>
> > > > +#include <linux/device.h>
> > > > +#include <linux/jiffies.h>
> > > > +#include <linux/smp.h>
> > > > +#include <linux/io.h>
> > > > +
> > > > +#include <asm/cacheflush.h>
> > > > +#include <mach/scu.h>
> > > > +#include <mach/hardware.h>
> > > > +#include <asm/mach-types.h>
> > > > +
> > > > +/* Registers used for communicating startup information */
> > > > +#define OMAP4_AUXCOREBOOT_REG0		
> > > (OMAP44XX_VA_WKUPGEN_BASE + 0x800)
> > > > +#define OMAP4_AUXCOREBOOT_REG1		
> > > (OMAP44XX_VA_WKUPGEN_BASE + 0x804)
> > > > +
> > > > +/* FIXME: Move to a common header file */
> > > > +extern void omap_secondary_startup(void);
> > > 
> > > How about move this to cpu.h?
> >  
> > Possible. The thing is this functions should be available 
> only for OMAP4 SMP. We may need #ifdef ARCH_OMAP4. Is that ok ? 
> 
> Please rathar have a ifdef section in cpu.h for CONFIG_SMP.

Perfect !!

Regards
Santosh
