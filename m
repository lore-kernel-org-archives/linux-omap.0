From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 05/24] omap4: Add needed IRQ line into irqs.h
Date: Wed, 17 Feb 2010 11:21:31 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C3CF831B@dbde02.ent.ti.com>
References: <1266335895-32741-1-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-2-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-3-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-4-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-5-git-send-email-santosh.shilimkar@ti.com>
 <alpine.DEB.2.00.1002161506030.10478@utopia.booyaka.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C3CF826A@dbde02.ent.ti.com>
 <alpine.DEB.2.00.1002162218540.10478@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45204 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751245Ab0BQFvv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Feb 2010 00:51:51 -0500
In-Reply-To: <alpine.DEB.2.00.1002162218540.10478@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "ben@fluff.org.uk" <ben@fluff.org.uk>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, "Cousson, Benoit" <b-cousson@ti.com>

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Wednesday, February 17, 2010 11:02 AM
> To: Shilimkar, Santosh
> Cc: tony@atomide.com; linux-omap@vger.kernel.org; ben@fluff.org.uk; sameo@linux.intel.com;
> lrg@slimlogic.co.uk; Cousson, Benoit
> Subject: RE: [PATCH 05/24] omap4: Add needed IRQ line into irqs.h
> 
> On Wed, 17 Feb 2010, Shilimkar, Santosh wrote:
> 
> > > -----Original Message-----
> > > From: Paul Walmsley [mailto:paul@pwsan.com]
> > > Sent: Wednesday, February 17, 2010 3:39 AM
> > > To: Shilimkar, Santosh
> > > Cc: tony@atomide.com; linux-omap@vger.kernel.org; ben@fluff.org.uk; sameo@linux.intel.com;
> > > lrg@slimlogic.co.uk
> > > Subject: Re: [PATCH 05/24] omap4: Add needed IRQ line into irqs.h
> > >
> > > Hello Santosh,
> > >
> > > On Tue, 16 Feb 2010, Santosh Shilimkar wrote:
> > >
> > > > This patch adds DSS, keyboard and ducati irq
> > > > entries in irqs.h
> > > >
> > > > Ones omap4 hwmod is pushed on mainlie, all the
> > > > irqs lines data would be availabe.
> > >
> > > Instead of this patch, why not just replace the current file with the one
> > > from the OMAP4 autogeneration scripts?  I don't see why the IRQ macros
> > > should depend on hwmod availability, and it would be better to have the
> > > correct IRQ data appear in one patch, rather than having to review and
> > > approve several smaller incremental patches over time.
> > We plan to do this but today the autogenrated file names and one in the
> > kernel code is different.
> 
> File names or macro names?
Macros ofcourse
> 
> > Autogenrated headers are kept in alignment
> > with TRM naming as you know.
> > e.g
> > --- autogenaretd
> > #define OMAP44XX_IRQ_MCBSP2   (22 + OMAP44XX_IRQ_GIC_START)
> >
> > --existing kernel
> > #define INT_44XX_MCBSP2_IRQ	(22 + IRQ_GIC_START)
> >
> >
> > So instead of touching every driver file and changing it only for name changes ,
> > what we are doing
> > 1. Created local 44xx_dma.h and 44xx_irq.h mach-omap2 directory
> > 2. All the drivers getting converted in hwmods would use defines from above headers
> > 3. At one point of time all the drivers would use defines from above headers and then
> >    from omap4 point of view there won't be dependency on the irqs.h and dma.h
> >
> > While this is ongoing, we would like the mainline kernel to have most of the
> > drivers supported. And Hence such a patch.
> 
> I grepped through the code base for any instances of INT_44XX:
> 
> [paul@twilight current]$ fgrep -r INT_44XX . | fgrep -v ./arch/arm/plat-omap/include/plat/irqs.h
> ./arch/arm/mach-omap2/devices.c:		.start          = INT_44XX_MAIL_U0_MPU,
> ./arch/arm/mach-omap2/devices.c:			irq = INT_44XX_MMC4_IRQ;
> ./arch/arm/mach-omap2/devices.c:			irq = INT_44XX_MMC5_IRQ;
> ./arch/arm/mach-omap2/timer-mpu.c:	evt->irq = INT_44XX_LOCALTIMER_IRQ;
> ./arch/arm/plat-omap/dmtimer.c:	{ .phys_base = 0x4a318000, .irq = INT_44XX_GPTIMER1 },
> ./arch/arm/plat-omap/dmtimer.c:	{ .phys_base = 0x48032000, .irq = INT_44XX_GPTIMER2 },
> ./arch/arm/plat-omap/dmtimer.c:	{ .phys_base = 0x48034000, .irq = INT_44XX_GPTIMER3 },
> ./arch/arm/plat-omap/dmtimer.c:	{ .phys_base = 0x48036000, .irq = INT_44XX_GPTIMER4 },
> ./arch/arm/plat-omap/dmtimer.c:	{ .phys_base = 0x40138000, .irq = INT_44XX_GPTIMER5 },
> ./arch/arm/plat-omap/dmtimer.c:	{ .phys_base = 0x4013a000, .irq = INT_44XX_GPTIMER6 },
> ./arch/arm/plat-omap/dmtimer.c:	{ .phys_base = 0x4013a000, .irq = INT_44XX_GPTIMER7 },
> ./arch/arm/plat-omap/dmtimer.c:	{ .phys_base = 0x4013e000, .irq = INT_44XX_GPTIMER8 },
> ./arch/arm/plat-omap/dmtimer.c:	{ .phys_base = 0x4803e000, .irq = INT_44XX_GPTIMER9 },
> ./arch/arm/plat-omap/dmtimer.c:	{ .phys_base = 0x48086000, .irq = INT_44XX_GPTIMER10 },
> ./arch/arm/plat-omap/dmtimer.c:	{ .phys_base = 0x48088000, .irq = INT_44XX_GPTIMER11 },
> ./arch/arm/plat-omap/dmtimer.c:	{ .phys_base = 0x4a320000, .irq = INT_44XX_GPTIMER12 },
> ./arch/arm/plat-omap/gpio.c:	{ OMAP44XX_GPIO1_BASE, NULL, INT_44XX_GPIO_BANK1, IH_GPIO_BASE,
> ./arch/arm/plat-omap/gpio.c:	{ OMAP44XX_GPIO2_BASE, NULL, INT_44XX_GPIO_BANK2, IH_GPIO_BASE + 32,
> ./arch/arm/plat-omap/gpio.c:	{ OMAP44XX_GPIO3_BASE, NULL, INT_44XX_GPIO_BANK3, IH_GPIO_BASE + 64,
> ./arch/arm/plat-omap/gpio.c:	{ OMAP44XX_GPIO4_BASE, NULL, INT_44XX_GPIO_BANK4, IH_GPIO_BASE + 96,
> ./arch/arm/plat-omap/gpio.c:	{ OMAP44XX_GPIO5_BASE, NULL, INT_44XX_GPIO_BANK5, IH_GPIO_BASE + 128,
> ./arch/arm/plat-omap/gpio.c:	{ OMAP44XX_GPIO6_BASE, NULL, INT_44XX_GPIO_BANK6, IH_GPIO_BASE + 160,
> ./arch/arm/plat-omap/dma.c:			irq = INT_44XX_SDMA_IRQ0;
> [paul@twilight current]$
> 
> 
> There are only five files to change.  None of them are device
> driver files, so they can all be merged through linux-omap.  The
> changes could easily be done in a single patch.  So I see no
> reason to not use the autogenerated IRQ file.
> 
I think on you tree, you won't have DSS, AUDIO-ALSA, BRIDGE, USB etc. 
All these drivers needs to be updated as well

> > > The same reasoning should apply the DMA data also, I'd think.
> > DMA file will get replaced soon with auto generated since naming
> > is aligned there.
> 
> 
> - Paul
