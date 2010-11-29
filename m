From: Rajendra Nayak <rnayak@ti.com>
Subject: RE: [PATCH 1/6] OMAP: powerdomain: Move powerdomain.c from mach-omap2
 to plat-omap
Date: Mon, 29 Nov 2010 14:52:26 +0530
Message-ID: <5859cdc36d06fe7fcd8a225a031e42d2@mail.gmail.com>
References: <1289921886-5139-1-git-send-email-rnayak@ti.com>
 <1289921886-5139-2-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1011281658460.2515@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:57682 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750939Ab0K2JWa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Nov 2010 04:22:30 -0500
Received: by mail-qw0-f49.google.com with SMTP id 8so1291972qwb.8
        for <linux-omap@vger.kernel.org>; Mon, 29 Nov 2010 01:22:29 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1011281658460.2515@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, b-cousson@ti.com, khilman@deeprootsystems.com

Hi Paul,

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Monday, November 29, 2010 5:36 AM
> To: Rajendra Nayak
> Cc: linux-omap@vger.kernel.org; b-cousson@ti.com;
khilman@deeprootsystems.com
> Subject: Re: [PATCH 1/6] OMAP: powerdomain: Move powerdomain.c from
mach-omap2 to plat-omap
>
> Hello Rajendra,
>
> some comments:
>
> On Tue, 16 Nov 2010, Rajendra Nayak wrote:
>
> > This is in preparation of splitting the powerdomain framework into
> > platform-independent part (for all omaps) and platform-specific
> > parts.
> > The platform-independent code would reside in plat-omap/powerdomain.c
> > and the platform-specific code will resides in
> > mach-omap2/powerdomain-xxxx.c files.
>
> Since we're not implementing powerdomain support for OMAP1 right now, is
> there any reason why we can't just leave the powerdomain-common stuff in
> the mach-omap2/ directory for now?

There was no other reason why I moved these in plat-omap
except to keep the split similar to the way clock framework
is done. I should be able to keep this in mach-omap2 itself.

Regards,
Rajendra

>
> > Some of the hacks to include header files are done to make sure the
> > patch compiles and works fine. These hacks will be removed in the
> > subsequent patches.
> >
> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > Cc: Benoit Cousson <b-cousson@ti.com>
> > Cc: Kevin Hilman <khilman@deeprootsystems.com>
> > ---
> >  arch/arm/mach-omap2/Makefile                     |    2 +-
> >  arch/arm/plat-omap/Makefile                      |    6 +++---
> >  arch/arm/{mach-omap2 => plat-omap}/powerdomain.c |   14
+++++++-------
> >  3 files changed, 11 insertions(+), 11 deletions(-)
> >  rename arch/arm/{mach-omap2 => plat-omap}/powerdomain.c (99%)
> >
> > diff --git a/arch/arm/mach-omap2/Makefile
b/arch/arm/mach-omap2/Makefile
> > index 60e51bc..4bfadc5 100644
> > --- a/arch/arm/mach-omap2/Makefile
> > +++ b/arch/arm/mach-omap2/Makefile
> > @@ -9,7 +9,7 @@ obj-y := id.o io.o control.o mux.o devices.o serial.o
gpmc.o timer-gp.o pm.o \
> >  omap-2-3-common				= irq.o sdrc.o
prm2xxx_3xxx.o
> >  hwmod-common				= omap_hwmod.o \
> >  					  omap_hwmod_common_data.o
> > -prcm-common				= prcm.o powerdomain.o
> > +prcm-common				= prcm.o
> >  clock-common				= clock.o
clock_common_data.o \
> >  					  clockdomain.o clkt_dpll.o \
> >  					  clkt_clksel.o
> > diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
> > index a4a1285..424a9ae 100644
> > --- a/arch/arm/plat-omap/Makefile
> > +++ b/arch/arm/plat-omap/Makefile
> > @@ -13,9 +13,9 @@ obj-  :=
> >  obj-$(CONFIG_ARCH_OMAP16XX) += ocpi.o
> >
> >  # omap_device support (OMAP2+ only at the moment)
> > -obj-$(CONFIG_ARCH_OMAP2) += omap_device.o
> > -obj-$(CONFIG_ARCH_OMAP3) += omap_device.o
> > -obj-$(CONFIG_ARCH_OMAP4) += omap_device.o
> > +obj-$(CONFIG_ARCH_OMAP2) += omap_device.o powerdomain.o
> > +obj-$(CONFIG_ARCH_OMAP3) += omap_device.o powerdomain.o
> > +obj-$(CONFIG_ARCH_OMAP4) += omap_device.o powerdomain.o
>
> The powerdomain code isn't directly related to the omap_device code, so
> please create a new section in the mach-omap2/Makefile for this stuff.
> Perhaps something like:
>
> # OMAP PRCM powerdomain support
> obj-$(CONFIG_ARCH_OMAP2) += powerdomain.o
> obj-$(CONFIG_ARCH_OMAP3) += powerdomain.o
> obj-$(CONFIG_ARCH_OMAP4) += powerdomain.o
>
> >
> >  obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
> >  obj-$(CONFIG_OMAP_IOMMU) += iommu.o iovmm.o
> > diff --git a/arch/arm/mach-omap2/powerdomain.c
b/arch/arm/plat-omap/powerdomain.c
> > similarity index 99%
> > rename from arch/arm/mach-omap2/powerdomain.c
> > rename to arch/arm/plat-omap/powerdomain.c
>
> (see the first comment)
>
> > index 6527ec3..9204799 100644
> > --- a/arch/arm/mach-omap2/powerdomain.c
> > +++ b/arch/arm/plat-omap/powerdomain.c
>
> > @@ -26,19 +26,19 @@
> >
> >  #include <asm/atomic.h>
> >
> > -#include "cm.h"
> > -#include "cm-regbits-34xx.h"
> > -#include "cm-regbits-44xx.h"
> > -#include "prm.h"
> > -#include "prm-regbits-34xx.h"
> > -#include "prm-regbits-44xx.h"
> > +#include "../mach-omap2/cm.h"
> > +#include "../mach-omap2/cm-regbits-34xx.h"
> > +#include "../mach-omap2/cm-regbits-44xx.h"
> > +#include "../mach-omap2/prm.h"
> > +#include "../mach-omap2/prm-regbits-34xx.h"
> > +#include "../mach-omap2/prm-regbits-44xx.h"
> >
> >  #include <plat/cpu.h>
> >  #include <plat/powerdomain.h>
> >  #include <plat/clockdomain.h>
> >  #include <plat/prcm.h>
> >
> > -#include "pm.h"
> > +#include "../mach-omap2/pm.h"
> >
> >  enum {
> >  	PWRDM_STATE_NOW = 0,
> > --
> > 1.7.0.4
> >
>
>
> - Paul
