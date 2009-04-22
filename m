From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: OMAP2/3: Reorganize Makefile to add omap4 support
	(Re: [PATCH 7/7][RFC] OMAP4: Enable basic build support.)
Date: Wed, 22 Apr 2009 12:04:57 -0700
Message-ID: <20090422190456.GW25864@atomide.com>
References: <1240319293-19662-1-git-send-email-santosh.shilimkar@ti.com> <1240319293-19662-2-git-send-email-santosh.shilimkar@ti.com> <1240319293-19662-3-git-send-email-santosh.shilimkar@ti.com> <1240319293-19662-4-git-send-email-santosh.shilimkar@ti.com> <1240319293-19662-5-git-send-email-santosh.shilimkar@ti.com> <1240319293-19662-6-git-send-email-santosh.shilimkar@ti.com> <1240319293-19662-7-git-send-email-santosh.shilimkar@ti.com> <20090421183940.GN25864@atomide.com> <EAF47CD23C76F840A9E7FCE10091EFAB02B3D8F40C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="jL2BoiuKMElzg3CS"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51345 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755184AbZDVTFA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Apr 2009 15:05:00 -0400
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02B3D8F40C@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


--jL2BoiuKMElzg3CS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [090421 21:56]:
> > -----Original Message-----
> > From: Tony Lindgren [mailto:tony@atomide.com] 
> > Sent: Wednesday, April 22, 2009 12:10 AM
> > To: Shilimkar, Santosh
> > Cc: linux-omap@vger.kernel.org
> > Subject: Re: [PATCH 7/7][RFC] OMAP4: Enable basic build support.
> > 
> > * Santosh Shilimkar <santosh.shilimkar@ti.com> [090421 06:08]:
> > > This patch updates the Makefile and defconfig for OMAP4. 
> > Minimal set of
> > > drivers are enabled fot the kernel bootup.
> > > 
> > > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > > ---
>  
> > > diff --git a/arch/arm/mach-omap2/Makefile 
> > b/arch/arm/mach-omap2/Makefile
> > > index c49d9bf..68d50a8 100644
> > > --- a/arch/arm/mach-omap2/Makefile
> > > +++ b/arch/arm/mach-omap2/Makefile
> > > @@ -3,9 +3,13 @@
> > >  #
> > >  
> > >  # Common support
> > > +ifeq ($(CONFIG_ARCH_OMAP4),y)
> > > +obj-y := id.o io.o control.o mux.o devices.o serial.o 
> > gpmc.o timer-gp.o
> > > +else
> > >  obj-y := irq.o id.o io.o sdrc.o control.o prcm.o clock.o mux.o \
> > >  		devices.o serial.o gpmc.o timer-gp.o powerdomain.o \
> > >  		clockdomain.o
> > > +endif
> > 
> > This ifeq else we don't want to do as it breaks things for multi-omap.
> 
> How do we handle this. For OMAP4, those files are not common and needed at this point of time. More so if we agree that OMAP4 won't support multi-omap, then this should be ok.

No way we're dropping multi-omap for a few ifdefs.

We need to have code where we can compile in all the selected things.
In this case we should be able to select any combination of CONFIG_ARCH_OMAP2,
CONFIG_ARCH_OMAP3, CONFIG_ARCH_OMAP4. And the code already gets optimized if
only one is selected.

The recent omap2 clock breakage with trivial clock patches is already a
good enough reason to support the multi-omap. So basically all the developers
should do their builds with the multi-omap selected.

Also the distros want multi-omap. Only the product specific kernels
should be built with only one option selected to optimize for speed and size.

> Some thing like this can be done but then Makefile will be completely rewamped. 
> 
> # Common support
> obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-gp.o
> 
> obj-$(CONFIG_ARCH_OMAP2) += display.o sdrc.o prcm.o clock.o powerdomain.o clockdomain.o
> obj-$(CONFIG_ARCH_OMAP3) += display.o sdrc.o prcm.o clock.o powerdomain.o clockdomain.o
> 
> Is this OK ?

How about the attached patch?

Tony

--jL2BoiuKMElzg3CS
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="omap-2-3-makefile-cleanup.patch"

>From 60e0a0d9c74e2aaf4adcd1ab9f045fd8e62a3092 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Wed, 22 Apr 2009 11:59:58 -0700
Subject: [PATCH] ARM: OMAP2/3: Reorganize Makefile to add omap4 support

We don't necessarily want to compile in irq.o and sdrc.o for omap4.
Also, clock and prcm may not be implemented initially.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index c49d9bf..bf3827a 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -3,9 +3,14 @@
 #
 
 # Common support
-obj-y := irq.o id.o io.o sdrc.o control.o prcm.o clock.o mux.o \
-		devices.o serial.o gpmc.o timer-gp.o powerdomain.o \
-		clockdomain.o
+obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-gp.o
+
+omap-2-3-common				= irq.o sdrc.o
+prcm-common				= prcm.o powerdomain.o
+clock-common				= clock.o clockdomain.o
+
+obj-$(CONFIG_ARCH_OMAP2) += $(omap-2-3-common) $(prcm-common) $(clock-common)
+obj-$(CONFIG_ARCH_OMAP3) += $(omap-2-3-common) $(prcm-common) $(clock-common)
 
 obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
 

--jL2BoiuKMElzg3CS--
