From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 2/3] AM35xx: Introduce am35xx.h file
Date: Thu, 7 Jan 2010 23:08:54 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044A397EDB@dbde02.ent.ti.com>
References: <hvaibhav@ti.com>
	<1262613116-20185-3-git-send-email-hvaibhav@ti.com>
 <873a2iaj42.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44245 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751520Ab0AGRjq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jan 2010 12:39:46 -0500
In-Reply-To: <873a2iaj42.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Govindarajan, Sriramakrishnan" <srk@ti.com>


> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Thursday, January 07, 2010 5:20 AM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org; tony@atomide.com; Govindarajan,
> Sriramakrishnan
> Subject: Re: [PATCH 2/3] AM35xx: Introduce am35xx.h file
> 
> hvaibhav@ti.com writes:
> 
> > From: Vaibhav Hiremath <hvaibhav@ti.com>
> >
> > Add base address definations for new AM35xx IPSS modules, like
> > VPFE, USBOTG, CPGMAC.
> >
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > Signed-off-by: Sriramakrishnan <srk@ti.com>
> > ---
> >  arch/arm/plat-omap/include/plat/am35xx.h   |   25
> +++++++++++++++++++++++++
> >  arch/arm/plat-omap/include/plat/hardware.h |    1 +
> >  2 files changed, 26 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/arm/plat-omap/include/plat/am35xx.h
> >
> > diff --git a/arch/arm/plat-omap/include/plat/am35xx.h
> b/arch/arm/plat-omap/include/plat/am35xx.h
> > new file mode 100644
> > index 0000000..d41bd61
> > --- /dev/null
> > +++ b/arch/arm/plat-omap/include/plat/am35xx.h
> > @@ -0,0 +1,25 @@
> > +/*:
> > + * Address mappings and base address for AM35XX specific
> interconnects
> > + * and peripherals.
> > + *
> > + * Copyright (C) 2009 Texas Instruments
> > + *
> > + * Author: Sriramakrishnan <srk@ti.com>
> > + *	   Vaibhav Hiremath <hvaibhav@ti.com>
> > + *
> > + * This program is free software; you can redistribute it and/or
> modify
> > + * it under the terms of the GNU General Public License version 2
> as
> > + * published by the Free Software Foundation.
> > + */
> > +#ifndef __ASM_ARCH_AM35XX_H
> > +#define __ASM_ARCH_AM35XX_H
> > +
> > +/*
> > + * Base addresses
> > + */
> > +#define AM35XX_IPSS_EMAC_BASE		0x5C000000
> > +#define AM35XX_IPSS_USBOTGSS_BASE	0x5C040000
> > +#define AM35XX_IPSS_HECC_BASE		0x5C050000
> > +#define AM35XX_IPSS_VPFE_BASE		0x5C060000
> 
> I think this secont needs ome more comments.  In the 34xx TRM memory
> map, this region is shown as IVA2, so folks familiar with 34xx might
> be confused.
> 
[Hiremath, Vaibhav] I will update the comment with sufficient info.

> That being said, is there any reason to have these in a global
> header
> file?  Nobody should use these except SoC/board init code, so these
> should probably stay in arch/arm/mach-omap2 in AM35x specific code.
> 
[Hiremath, Vaibhav] Agreed, but there are some occurrences where these macros may required to use in plat-omap/ directory. Just for an example - 

Macro OMAP443X_SCM_BASE, defined in arch/arm/plat-omap/include/plat/omap44xx.h file is getting used in arch/arm/plat-omap/common.c file.

Thanks,
Vaibhav

> I know this is different than what is done for 34xx, but we don't
> need
> the 34xx defines to be global anymore either.
> 
> Kevin
> 
> > +#endif /*  __ASM_ARCH_AM35XX_H */
> > diff --git a/arch/arm/plat-omap/include/plat/hardware.h
> b/arch/arm/plat-omap/include/plat/hardware.h
> > index d5b26ad..930c3f9 100644
> > --- a/arch/arm/plat-omap/include/plat/hardware.h
> > +++ b/arch/arm/plat-omap/include/plat/hardware.h
> > @@ -285,6 +285,7 @@
> >  #include <plat/omap16xx.h>
> >  #include <plat/omap24xx.h>
> >  #include <plat/omap34xx.h>
> > +#include <plat/am35xx.h>
> >  #include <plat/omap44xx.h>
> >
> >  #endif	/* __ASM_ARCH_OMAP_HARDWARE_H */
> > --
> > 1.6.2.4
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-
> omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
