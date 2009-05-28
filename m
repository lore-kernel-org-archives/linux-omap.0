From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/8] ARM: OMAP3: Add support for OMAP3 Zoom2 board, v2
Date: Thu, 28 May 2009 14:39:38 -0700
Message-ID: <20090528213937.GA31087@atomide.com>
References: <20090525174517.19679.18805.stgit@localhost> <20090525175335.19679.3398.stgit@localhost> <20090528160535.GE20736@n2100.arm.linux.org.uk> <20090528211306.GJ32453@atomide.com> <20090528211606.GD29066@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:63482 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809AbZE1Vjv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 May 2009 17:39:51 -0400
Content-Disposition: inline
In-Reply-To: <20090528211606.GD29066@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, Mikkel Christensen <mlc@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Vikram Pandita <vikram.pandita@ti.com>, linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [090528 14:19]:
> On Thu, May 28, 2009 at 02:13:06PM -0700, Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [090528 09:05]:
> > > On Mon, May 25, 2009 at 10:53:35AM -0700, Tony Lindgren wrote:
> > > > diff --git a/arch/arm/mach-omap2/board-zoom-debugboard.c b/arch/arm/mach-omap2/board-zoom-debugboard.c
> > > > new file mode 100644
> > > > index 0000000..91f07c1
> > > > --- /dev/null
> > > > +++ b/arch/arm/mach-omap2/board-zoom-debugboard.c
> > > > @@ -0,0 +1,160 @@
> > > > +/*
> > > > + * Copyright (C) 2009 Texas Instruments Inc.
> > > > + * Mikkel Christensen <mlc@ti.com>
> > > > + *
> > > > + * This program is free software; you can redistribute it and/or modify
> > > > + * it under the terms of the GNU General Public License version 2 as
> > > > + * published by the Free Software Foundation.
> > > > + */
> > > > +
> > > > +#include <linux/kernel.h>
> > > > +#include <linux/init.h>
> > > > +#include <linux/serial_8250.h>
> > > > +#include <linux/smsc911x.h>
> > > > +
> > > > +#include <mach/gpio.h>
> > > 
> > > linux/gpio.h please.
> > > 
> > > > diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/board-zoom2.c
> > > > new file mode 100644
> > > > index 0000000..d4cd7ff
> > > > --- /dev/null
> > > > +++ b/arch/arm/mach-omap2/board-zoom2.c
> > > > @@ -0,0 +1,110 @@
> > > > +/*
> > > > + * Copyright (C) 2009 Texas Instruments Inc.
> > > > + * Mikkel Christensen <mlc@ti.com>
> > > > + *
> > > > + * Modified from mach-omap2/board-ldp.c
> > > > + *
> > > > + * This program is free software; you can redistribute it and/or modify
> > > > + * it under the terms of the GNU General Public License version 2 as
> > > > + * published by the Free Software Foundation.
> > > > + */
> > > > +
> > > > +#include <linux/kernel.h>
> > > > +#include <linux/init.h>
> > > > +#include <linux/platform_device.h>
> > > > +#include <linux/i2c/twl4030.h>
> > > > +
> > > > +#include <asm/mach-types.h>
> > > > +#include <asm/mach/arch.h>
> > > > +
> > > > +#include <mach/gpio.h>
> > > 
> > > Ditto.
> > 
> > Good eye. Here's this one updated.
> 
> Nothing really to do with eyes, more to do with regexps in .muttrc
> highlighting this stuff with a red background...  It currently is
> setup as:
> 
> color body white red "(\\+#include <(asm|mach)/(gp)?io\.h>|return -1|default n)"
> 
> but will probably expand more over time.

Cool. Added that here too.

Tony
