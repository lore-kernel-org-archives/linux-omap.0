From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 7/7][RFC] OMAP4: Enable basic build support.
Date: Wed, 22 Apr 2009 10:25:45 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B3D8F40C@dbde02.ent.ti.com>
References: <1240319293-19662-1-git-send-email-santosh.shilimkar@ti.com>
 <1240319293-19662-2-git-send-email-santosh.shilimkar@ti.com>
 <1240319293-19662-3-git-send-email-santosh.shilimkar@ti.com>
 <1240319293-19662-4-git-send-email-santosh.shilimkar@ti.com>
 <1240319293-19662-5-git-send-email-santosh.shilimkar@ti.com>
 <1240319293-19662-6-git-send-email-santosh.shilimkar@ti.com>
 <1240319293-19662-7-git-send-email-santosh.shilimkar@ti.com>
 <20090421183940.GN25864@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42036 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750780AbZDVEzz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Apr 2009 00:55:55 -0400
In-Reply-To: <20090421183940.GN25864@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com] 
> Sent: Wednesday, April 22, 2009 12:10 AM
> To: Shilimkar, Santosh
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH 7/7][RFC] OMAP4: Enable basic build support.
> 
> * Santosh Shilimkar <santosh.shilimkar@ti.com> [090421 06:08]:
> > This patch updates the Makefile and defconfig for OMAP4. 
> Minimal set of
> > drivers are enabled fot the kernel bootup.
> > 
> > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > ---
 
> > diff --git a/arch/arm/mach-omap2/Makefile 
> b/arch/arm/mach-omap2/Makefile
> > index c49d9bf..68d50a8 100644
> > --- a/arch/arm/mach-omap2/Makefile
> > +++ b/arch/arm/mach-omap2/Makefile
> > @@ -3,9 +3,13 @@
> >  #
> >  
> >  # Common support
> > +ifeq ($(CONFIG_ARCH_OMAP4),y)
> > +obj-y := id.o io.o control.o mux.o devices.o serial.o 
> gpmc.o timer-gp.o
> > +else
> >  obj-y := irq.o id.o io.o sdrc.o control.o prcm.o clock.o mux.o \
> >  		devices.o serial.o gpmc.o timer-gp.o powerdomain.o \
> >  		clockdomain.o
> > +endif
> 
> This ifeq else we don't want to do as it breaks things for multi-omap.

How do we handle this. For OMAP4, those files are not common and needed at this point of time. More so if we agree that OMAP4 won't support multi-omap, then this should be ok.
Some thing like this can be done but then Makefile will be completely rewamped. 

# Common support
obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-gp.o

obj-$(CONFIG_ARCH_OMAP2) += display.o sdrc.o prcm.o clock.o powerdomain.o clockdomain.o
obj-$(CONFIG_ARCH_OMAP3) += display.o sdrc.o prcm.o clock.o powerdomain.o clockdomain.o

Is this OK ?