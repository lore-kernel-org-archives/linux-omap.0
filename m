From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH 0/9] OMAP: GPIO: cleanup, consolidation, etc. (v2)
Date: Mon, 25 Apr 2011 13:59:43 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037AD27761@dbde02.ent.ti.com>
References: <1303418127-4310-1-git-send-email-khilman@ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB037AD2771A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49418 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757064Ab1DYIaM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Apr 2011 04:30:12 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p3P8U95Z029263
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 25 Apr 2011 03:30:11 -0500
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB037AD2771A@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Varadarajan, Charulatha" <charu@ti.com>

Kevin,
[...]
> >
> > Here's an updated version of my work-in-progress GPIO cleanups.
> >
> > I now understand that others have some similar work in progress, so
> > these are posted (to linux-omap only, for now) so that we can begin
> > collaboration on the GPIO cleanups.
> >
> > This series applies on top of v2.6.39-rc4 plus the generic irq_chip
> > series from Thomas Gleixner since in addition to the cleanups, I
> > started moving the GPIO IRQ handling over to use generic irq_chip
> > (last patch in series.)
> >
> > This work in progress is available in my wip/gpio-cleanup branch.
> There are two observations in this series:
> (1) omap1_defconfig  build generates following compilation errors:
I realized that I missed the patch series from Thomas Gleixner.
BTW, there are multiple series related to irq_chip cleanup.
Do we need to apply all the series?
--
Tarun

>   CHK     include/generated/compile.h
>   CC      arch/arm/plat-omap/gpio.o
> arch/arm/plat-omap/gpio.c: In function 'omap_mpuio_alloc_gc':
> arch/arm/plat-omap/gpio.c:1207: error: implicit declaration of function
> 'irq_alloc_generic_chip'
> arch/arm/plat-omap/gpio.c:1208: warning: assignment makes pointer from
> integer without a cast
> arch/arm/plat-omap/gpio.c:1209: error: dereferencing pointer to incomplete
> type
> arch/arm/plat-omap/gpio.c:1212: error: dereferencing pointer to incomplete
> type
> arch/arm/plat-omap/gpio.c:1212: error: 'irq_gc_mask_set_bit' undeclared
> (first use in this function)
> arch/arm/plat-omap/gpio.c:1212: error: (Each undeclared identifier is
> reported only once
> arch/arm/plat-omap/gpio.c:1212: error: for each function it appears in.)
> arch/arm/plat-omap/gpio.c:1213: error: dereferencing pointer to incomplete
> type
> arch/arm/plat-omap/gpio.c:1213: error: 'irq_gc_mask_clr_bit' undeclared
> (first use in this function)
> arch/arm/plat-omap/gpio.c:1214: error: dereferencing pointer to incomplete
> type
> arch/arm/plat-omap/gpio.c:1217: error: dereferencing pointer to incomplete
> type
> arch/arm/plat-omap/gpio.c:1219: error: dereferencing pointer to incomplete
> type
> arch/arm/plat-omap/gpio.c:1219: warning: left-hand operand of comma
> expression has no effect
> arch/arm/plat-omap/gpio.c:1220: error: implicit declaration of function
> 'irq_setup_generic_chip'
> arch/arm/plat-omap/gpio.c:1220: error: implicit declaration of function
> 'IRQ_MSK'
> make[1]: *** [arch/arm/plat-omap/gpio.o] Error 1
> make: *** [arch/arm/plat-omap] Error 2
> 
> (2) Warning in the 8th patch. Also, note the typo (consolidate).
> Applying: OMAP: GPIO: conslidate enable/disable of GPIO IRQs,
> /home/a0876346/working/tony3/linux-omap-2.6/.git/rebase-apply/patch:272:
> trailing whitespace.
> 
> warning: 1 line adds whitespace errors.
> Applying: OMAP: GPIO: convert MPUIO IRQ over to generic
> 
> --
> Tarun
> >
> > Kevin Hilman (9):
> >   OMAP: GPIO: _clear_gpio_irqbank: fix flushing of posted write
> >   OMAP: GPIO: remove MPUIO handling from _clear_gpio_irqbank()
> >   OMAP: GPIO: move bank width into struct gpio_bank
> >   OMAP: GPIO: _get_gpio_irqbank_mask: replace hard-coded mask with
> >     bank->width
> >   OMAP: GPIO: move register offset defines into gpio.h
> >   OMAP: GPIO: consolidate direction, input, output, remove #ifdefs
> >   OMAP: GPIO: consolidate IRQ status handling, remove #ifdefs
> >   OMAP: GPIO: conslidate enable/disable of GPIO IRQs, remove ifdefs
> >   OMAP: GPIO: convert MPUIO IRQ over to generic irq_chip
> >
> >  arch/arm/mach-omap1/gpio15xx.c         |   13 +
> >  arch/arm/mach-omap1/gpio16xx.c         |   22 ++
> >  arch/arm/mach-omap1/gpio7xx.c          |   21 +
> >  arch/arm/mach-omap2/gpio.c             |   20 +
> >  arch/arm/plat-omap/gpio.c              |  641 ++++++-------------------
> --
> > -----
> >  arch/arm/plat-omap/include/plat/gpio.h |  120 ++++++
> >  6 files changed, 318 insertions(+), 519 deletions(-)
> >
> > --
> > 1.7.4
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
