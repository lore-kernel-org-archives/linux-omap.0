From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] ARM: OMAP2+: Prepare to move GPMC to drivers by
 platform data header
Date: Fri, 21 Nov 2014 08:15:30 -0800
Message-ID: <20141121161529.GQ7046@atomide.com>
References: <1416522501-14999-1-git-send-email-tony@atomide.com>
 <1416522501-14999-2-git-send-email-tony@atomide.com>
 <546F05C3.6090508@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:37563 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932625AbaKUQPo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Nov 2014 11:15:44 -0500
Content-Disposition: inline
In-Reply-To: <546F05C3.6090508@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>

* Roger Quadros <rogerq@ti.com> [141121 01:30]:
> On 11/21/2014 12:28 AM, Tony Lindgren wrote:
> > +#include <linux/omap-gpmc.h>
> > +#include <linux/platform_data/omap-gpmc.h>
> 
> I think we should get rid for mach-omap2/gpmc.h and include the above two
> headers wherever needed.

Well I'm trying to keep the churn on patching all board-*.c files
down to minimum until they just get dropped.

So let's keep gpmc.h around still for a little while for all the
board-*.c files.
 
> > diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> > index 175564c..88721df 100644
> > --- a/arch/arm/mach-omap2/pm34xx.c
> > +++ b/arch/arm/mach-omap2/pm34xx.c
> > @@ -29,6 +29,7 @@
> >  #include <linux/delay.h>
> >  #include <linux/slab.h>
> >  #include <linux/omap-dma.h>
> > +#include <linux/omap-gpmc.h>
> >  #include <linux/platform_data/gpio-omap.h>
> >  
> >  #include <trace/events/power.h>
> > @@ -43,7 +44,6 @@
> >  #include "common.h"
> >  #include "cm3xxx.h"
> >  #include "cm-regbits-34xx.h"
> > -#include "gpmc.h"
> >  #include "prm-regbits-34xx.h"
> >  #include "prm3xxx.h"
> >  #include "pm.h"

And for the files that will stay around, let's not include gpmc.h.

> > --- /dev/null
> > +++ b/include/linux/platform_data/omap-gpmc.h
> > @@ -0,0 +1,177 @@
> > +/*
> > + * General-Purpose Memory Controller for OMAP2
> > + *
> > + * Copyright (C) 2005-2006 Nokia Corporation
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#ifndef __OMAP2_GPMC_H
> > +#define __OMAP2_GPMC_H
> > +
> > +#include <linux/platform_data/mtd-nand-omap2.h>
> 
> Why do need to include this header here?

Probably left over from the old code, that looks unnecessary.

Regards,

Tony
