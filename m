From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [RFC 1/8] TILER-DMM: DMM-PAT driver for TI TILER
Date: Wed, 28 Jul 2010 01:23:28 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044ED6385D@dbde02.ent.ti.com>
References: <1279927348-21750-1-git-send-email-davidsin@ti.com>
 <1279927348-21750-2-git-send-email-davidsin@ti.com>
 <19F8576C6E063C45BE387C64729E7394044ED6384D@dbde02.ent.ti.com>
 <513FF747EED39B4AADBB4D6C9D9F9F7903D644D974@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45555 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751801Ab0G0Txw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Jul 2010 15:53:52 -0400
In-Reply-To: <513FF747EED39B4AADBB4D6C9D9F9F7903D644D974@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sin, David" <davidsin@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Molnar, Lajos" <molnar@ti.com>


> -----Original Message-----
> From: Sin, David
> Sent: Wednesday, July 28, 2010 12:35 AM
> To: Hiremath, Vaibhav; linux-arm-kernel@lists.infradead.org; linux-
> omap@vger.kernel.org; Tony Lindgren; Russell King
> Cc: Kanigeri, Hari; Ohad Ben-Cohen; Shilimkar, Santosh; Molnar, Lajos
> Subject: RE: [RFC 1/8] TILER-DMM: DMM-PAT driver for TI TILER
>
> > -----Original Message-----
> > From: Hiremath, Vaibhav
> > Sent: Tuesday, July 27, 2010 1:38 PM
> > To: Sin, David; linux-arm-kernel@lists.arm.linux.org.uk;
> > linux-omap@vger.kernel.org; Tony Lindgren; Russell King
> > Cc: Kanigeri, Hari; Ohad Ben-Cohen; Shilimkar, Santosh; Molnar, Lajos
> > Subject: RE: [RFC 1/8] TILER-DMM: DMM-PAT driver for TI TILER
> >
> > > -----Original Message-----
> > > From: Sin, David
> > > Sent: Saturday, July 24, 2010 4:52 AM
> > > To: linux-arm-kernel@lists.arm.linux.org.uk;
> > linux-omap@vger.kernel.org;
> > > Tony Lindgren; Russell King
> > > Cc: Kanigeri, Hari; Ohad Ben-Cohen; Hiremath, Vaibhav;
> > Shilimkar, Santosh;
> > > Sin, David; Molnar, Lajos
> > > Subject: [RFC 1/8] TILER-DMM: DMM-PAT driver for TI TILER
> > >
> > > This patch adds support for DMM-PAT initialization and programming.
> > >
> > [Hiremath, Vaibhav] Sorry for delayed response, always better
> > late than never.
>
> [dhs] Thanks for your comments, Vaibhav.  I'll pull them in for RFC v2.
> >
> >
> > > Signed-off-by: David Sin <davidsin@ti.com>
> > > Signed-off-by: Lajos Molnar <molnar@ti.com>
> > > ---
> > >  arch/arm/mach-omap2/include/mach/dmm.h |  128 ++++++++++++++++++++
> > >  drivers/media/video/tiler/dmm.c        |  200
> > > ++++++++++++++++++++++++++++++++
> > >  2 files changed, 328 insertions(+), 0 deletions(-)
> > >  create mode 100644 arch/arm/mach-omap2/include/mach/dmm.h
> > >  create mode 100644 drivers/media/video/tiler/dmm.c
> > >
> > [Hiremath, Vaibhav] If I understand correctly, DMM stands for
> > dynamic memory manager. Is it something which can only be
> > used with Video devices? Any specific reason why this is part
> > of drivers/media/video/ directory,
> [dhs] Any device can use TILER memory, but there is a big advantage,
> performance-wise, for 2-Dimensional macro block based buffers.  This HW is
> intended for image/video hardware accelerators (e.g. OMAP4 IVA-HD).  Plus
> there's the added advantage of doing zero-copy flips and rotations for the
> OMAP display and image sub-systems.
> >
[Hiremath, Vaibhav] When you mention Tiler memory, you meant Tiler Virtual memory which is independent of physical memory. Driver requesting/using Tiler is responsible for allocating physical memory. Is that understanding correct?

If yes, then feature wise it is same as VRFB in OMAP3, where it provides virtual address space and driver requesting VRFB is responsible for physical memory allocation. There could be additional features, enhancement and stuff but zero-copy rotation for DSS, then its same as VRFB.

Don't you think is would be very difficult to use for drivers with such proposals, I can comment from DSS point of view,

In case of OMAP4 80% of code is being re-used from OMAP3 (located under drivers/video/omap2/), which is currently supported hardware rotation/mirroring and hardly tied to VRFB API's.

Now with this driver we have to do something,

cpu_is_omap34xx()
        VRFB
else if cpu_is_omap44xx()
        Tiler

I am not sure about further OMAP series of devices, where we might have something else with DSS IP reuse (along with software). And I believe Tiler is not part of DSS at all.
Again if some other devices are using Tiler API's it would become more difficult to re-use the code when same IP is being used in multiple SoC's.

Does it make sense to you to have registration based mechanism (function pointer) where you register your hardware capabilities/API's, driver don't have to dependent on underneath hardware block. Ofcource if driver intend to use some specific/custom feature supported by some hardware block then he has to call that API under cpu_is_xxxx

> >
> > > diff --git a/arch/arm/mach-omap2/include/mach/dmm.h b/arch/arm/mach-
> > > omap2/include/mach/dmm.h
> > > new file mode 100644
> > > index 0000000..68b798a
> > > --- /dev/null
> > > +++ b/arch/arm/mach-omap2/include/mach/dmm.h
> > > @@ -0,0 +1,128 @@
> > > +/*
> > > + * dmm.h
> > > + *
> > > + * DMM driver support functions for TI DMM-TILER hardware block.
> > > + *
> > > + * Author: David Sin <davidsin@ti.com>
> > > + *
> > > + * Copyright (C) 2009-2010 Texas Instruments, Inc.
> > > + *
> > > + * This package is free software; you can redistribute it
> > and/or modify
> > > + * it under the terms of the GNU General Public License
> > version 2 as
> > > + * published by the Free Software Foundation.
> > > + *
> > > + * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
> > > + * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
> > > + * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A
> > PARTICULAR PURPOSE.
> > > + */
> > > +
> > > +#ifndef DMM_H
> > > +#define DMM_H
> > > +
> > > +#define DMM_BASE 0x4E000000
> > > +#define DMM_SIZE 0x800
> > [Hiremath, Vaibhav] Unused definition (DMM_SIZE), do we required it?
> [dhs] It's currently being used in dmm.c to indicate how much to ioremap.
[Hiremath, Vaibhav] Opps. Missed it. You can use SZ_2K here.

> >
> > > +
> > > +#define DMM_REVISION          0x000
> > > +#define DMM_HWINFO            0x004
> > > +#define DMM_LISA_HWINFO       0x008
> > > +#define DMM_DMM_SYSCONFIG     0x010
> > > +#define DMM_LISA_LOCK         0x01C
> > > +#define DMM_LISA_MAP__0       0x040
> > > +#define DMM_LISA_MAP__1       0x044
> > > +#define DMM_TILER_HWINFO      0x208
> > > +#define DMM_TILER_OR__0       0x220
> > > +#define DMM_TILER_OR__1       0x224
> > > +#define DMM_PAT_HWINFO        0x408
> > > +#define DMM_PAT_GEOMETRY      0x40C
> > > +#define DMM_PAT_CONFIG        0x410
> > > +#define DMM_PAT_VIEW__0       0x420
> > > +#define DMM_PAT_VIEW__1       0x424
> > > +#define DMM_PAT_VIEW_MAP__0   0x440
> > > +#define DMM_PAT_VIEW_MAP_BASE 0x460
> > > +#define DMM_PAT_IRQ_EOI       0x478
> > > +#define DMM_PAT_IRQSTATUS_RAW 0x480
> > > +#define DMM_PAT_IRQSTATUS     0x490
> > > +#define DMM_PAT_IRQENABLE_SET 0x4A0
> > > +#define DMM_PAT_IRQENABLE_CLR 0x4B0
> > > +#define DMM_PAT_STATUS__0     0x4C0
> > > +#define DMM_PAT_STATUS__1     0x4C4
> > > +#define DMM_PAT_STATUS__2     0x4C8
> > > +#define DMM_PAT_STATUS__3     0x4CC
> > > +#define DMM_PAT_DESCR__0      0x500
> > > +#define DMM_PAT_AREA__0       0x504
> > > +#define DMM_PAT_CTRL__0       0x508
> > > +#define DMM_PAT_DATA__0       0x50C
> > [Hiremath, Vaibhav] Not sure whether somebody has given same
> > comment or not, any specific reason behind double _ here?
> [dhs] Yes -- this comment has been made already.  I'm using the same names
> defined in the TRM.  However, it can be changed.
[Hiremath, Vaibhav] Any specific reason why TRM documents like this?

I am still reviewing the patches, so expect some comments.

Thanks,
Vaibhav
> >
> > > +#define DMM_PEG_HWINFO        0x608
> > > +#define DMM_PEG_PRIO          0x620
> > > +#define DMM_PEG_PRIO_PAT      0x640
> > > +
> > > +/**
> > > + * PAT refill programming mode.
> > > + */
> > > +enum pat_mode {
> > > + MANUAL,
> > > + AUTO
> > > +};
> > > +
> > > +/**
> > > + * Area definition for DMM physical address translator.
> > > + */
> > > +struct pat_area {
> > > + s32 x0:8;
> > > + s32 y0:8;
> > > + s32 x1:8;
> > > + s32 y1:8;
> > > +};
> > > +
> > > +/**
> > > + * DMM physical address translator control.
> > > + */
> > > +struct pat_ctrl {
> > > + s32 start:4;
> > > + s32 dir:4;
> > > + s32 lut_id:8;
> > > + s32 sync:12;
> > > + s32 ini:4;
> > > +};
> > > +
> > > +/**
> > > + * PAT descriptor.
> > > + */
> > > +struct pat {
> > > + struct pat *next;
> > > + struct pat_area area;
> > > + struct pat_ctrl ctrl;
> > > + u32 data;
> > > +};
> > > +
> > > +/**
> > > + * DMM device data
> > > + */
> > > +struct dmm {
> > > + void __iomem *base;
> > > +};
> > > +
> > > +/**
> > > + * Create and initialize the physical address translator.
> > > + * @param id    PAT id
> > > + * @return pointer to device data
> > > + */
> > > +struct dmm *dmm_pat_init(u32 id);
> > > +
> > > +/**
> > > + * Program the physical address translator.
> > > + * @param dmm   Device data
> > > + * @param desc  PAT descriptor
> > > + * @param mode  programming mode
> > > + * @return an error status.
> > > + */
> > > +s32 dmm_pat_refill(struct dmm *dmm, struct pat *desc, enum
> > pat_mode mode);
> > > +
> > > +/**
> > > + * Clean up the physical address translator.
> > > + * @param dmm    Device data
> > > + * @return an error status.
> > > + */
> > > +void dmm_pat_release(struct dmm *dmm);
> > > +
> > > +#endif
> > > diff --git a/drivers/media/video/tiler/dmm.c
> > > b/drivers/media/video/tiler/dmm.c
> > > new file mode 100644
> > > index 0000000..e715936
> > > --- /dev/null
> > > +++ b/drivers/media/video/tiler/dmm.c
> > > @@ -0,0 +1,200 @@
> > > +/*
> > > + * dmm.c
> > > + *
> > > + * DMM driver support functions for TI OMAP processors.
> > > + *
> > > + * Authors: David Sin <davidsin@ti.com>
> > > + *          Lajos Molnar <molnar@ti.com>
> > > + *
> > > + * Copyright (C) 2009-2010 Texas Instruments, Inc.
> > > + *
> > > + * This package is free software; you can redistribute it
> > and/or modify
> > > + * it under the terms of the GNU General Public License
> > version 2 as
> > > + * published by the Free Software Foundation.
> > > + *
> > > + * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
> > > + * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
> > > + * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A
> > PARTICULAR PURPOSE.
> > > + */
> > > +
> > > +#include <linux/init.h>
> > > +#include <linux/module.h>
> > > +#include <linux/platform_device.h> /* platform_device() */
> > > +#include <linux/io.h>              /* ioremap() */
> > [Hiremath, Vaibhav] No need to specify comments here actually?
> [dhs] This can be removed -- thanks.
> >
> > > +#include <linux/errno.h>
> > > +#include <linux/slab.h>
> > > +
> > > +#include <mach/dmm.h>
> > > +
> > > +#define MASK(msb, lsb) (((1 << ((msb) + 1 - (lsb))) - 1) << (lsb))
> > > +#define SET_FLD(reg, msb, lsb, val) \
> > > +(((reg) & ~MASK((msb), (lsb))) | (((val) << (lsb)) &
> > MASK((msb), (lsb))))
> > > +
> > > +static struct platform_driver dmm_driver_ldm = {
> > > + .driver = {
> > > +         .owner = THIS_MODULE,
> > > +         .name = "dmm",
> > > + },
> > > + .probe = NULL,
> > > + .shutdown = NULL,
> > > + .remove = NULL,
> > > +};
> > > +
> > > +s32 dmm_pat_refill(struct dmm *dmm, struct pat *pd, enum
> > pat_mode mode)
> > > +{
> > > + void __iomem *r;
> > > + u32 v;
> > > +
> > > + /* Only manual refill supported */
> > > + if (mode != MANUAL)
> > > +         return -EFAULT;
> > > +
> > > + /* Check that the DMM_PAT_STATUS register has not
> > reported an error */
> > > + r = dmm->base + DMM_PAT_STATUS__0;
> > > + v = __raw_readl(r);
> > > + if (WARN(v & 0xFC00, KERN_ERR "dmm_pat_refill() error.\n"))
> > > +         return -EIO;
> > > +
> > > + /* Set "next" register to NULL */
> > > + r = dmm->base + DMM_PAT_DESCR__0;
> > > + v = __raw_readl(r);
> > > + v = SET_FLD(v, 31, 4, (u32) NULL);
> > > + __raw_writel(v, r);
> > > +
> > > + /* Set area to be refilled */
> > > + r = dmm->base + DMM_PAT_AREA__0;
> > > + v = __raw_readl(r);
> > > + v = SET_FLD(v, 30, 24, pd->area.y1);
> > > + v = SET_FLD(v, 23, 16, pd->area.x1);
> > > + v = SET_FLD(v, 14, 8, pd->area.y0);
> > > + v = SET_FLD(v, 7, 0, pd->area.x0);
> > > + __raw_writel(v, r);
> > > + wmb();
> > > +
> > > + /* First, clear the DMM_PAT_IRQSTATUS register */
> > > + r = dmm->base + DMM_PAT_IRQSTATUS;
> > > + __raw_writel(0xFFFFFFFF, r);
> > > + wmb();
> > > +
> > > + r = dmm->base + DMM_PAT_IRQSTATUS_RAW;
> > > + while (__raw_readl(r) != 0)
> > > +         ;
> > > +
> > [Hiremath, Vaibhav] Get rid of infinite loop??
> [dhs] Yes -- this comment has already been posted, thanks.
> >
> > > + /* Fill data register */
> > > + r = dmm->base + DMM_PAT_DATA__0;
> > > + v = __raw_readl(r);
> > > +
> > > + v = SET_FLD(v, 31, 4, pd->data >> 4);
> > > + __raw_writel(v, r);
> > > + wmb();
> > > +
> > > + /* Read back PAT_DATA__0 to see if write was successful */
> > > + while (__raw_readl(r) != pd->data)
> > > +         ;
> > > +
> > > + r = dmm->base + DMM_PAT_CTRL__0;
> > > + v = __raw_readl(r);
> > > + v = SET_FLD(v, 31, 28, pd->ctrl.ini);
> > > + v = SET_FLD(v, 16, 16, pd->ctrl.sync);
> > > + v = SET_FLD(v, 9, 8, pd->ctrl.lut_id);
> > > + v = SET_FLD(v, 6, 4, pd->ctrl.dir);
> > > + v = SET_FLD(v, 0, 0, pd->ctrl.start);
> > > + __raw_writel(v, r);
> > > + wmb();
> > > +
> > > + /* Check if PAT_IRQSTATUS_RAW is set after the PAT has
> > been refilled
> > > */
> > > + r = dmm->base + DMM_PAT_IRQSTATUS_RAW;
> > > + while ((__raw_readl(r) & 0x3) != 0x3)
> > > +         ;
> > > +
> > > + /* Again, clear the DMM_PAT_IRQSTATUS register */
> > > + r = dmm->base + DMM_PAT_IRQSTATUS;
> > > + __raw_writel(0xFFFFFFFF, r);
> > > + wmb();
> > > +
> > > + r = dmm->base + DMM_PAT_IRQSTATUS_RAW;
> > > + while (__raw_readl(r) != 0)
> > > +         ;
> > [Hiremath, Vaibhav] Do you want to wait on whole register
> > value or one specific bit here?
> [dhs] Not whole register, but not one bit either.  I'll revisit this.
> >
> > > +
> > > + /* Again, set "next" register to NULL to clear any PAT
> > STATUS errors
> > > */
> > > + r = dmm->base + DMM_PAT_DESCR__0;
> > > + v = __raw_readl(r);
> > > + v = SET_FLD(v, 31, 4, (u32) NULL);
> > [Hiremath, Vaibhav] Why NULL, can't pass directly 0 here?
> [dhs] This value should be the pointer to the next PAT descriptor.  In this
> case, it's NULL, but '0' should work too.
> >
> > Thanks,
> > Vaibhav
> >
> > > + __raw_writel(v, r);
> > > +
> > > + /*
> > > +  * Now, check that the DMM_PAT_STATUS register
> > > +  * has not reported an error before exiting.
> > > + */
> > > + r = dmm->base + DMM_PAT_STATUS__0;
> > > + v = __raw_readl(r);
> > > + if (WARN(v & 0xFC00, KERN_ERR "dmm_pat_refill() error.\n"))
> > > +         return -EIO;
> > > +
> > > + return 0;
> > > +}
> > > +EXPORT_SYMBOL(dmm_pat_refill);
> > > +
> > > +struct dmm *dmm_pat_init(u32 id)
> > > +{
> > > + u32 base;
> > > + struct dmm *dmm;
> > > + switch (id) {
> > > + case 0:
> > > +         /* only support id 0 for now */
> > > +         base = DMM_BASE;
> > > +         break;
> > > + default:
> > > +         return NULL;
> > > + }
> > > +
> > > + dmm = kzalloc(sizeof(*dmm), GFP_KERNEL);
> > > + if (!dmm)
> > > +         return NULL;
> > > +
> > > + dmm->base = ioremap(base, DMM_SIZE);
> > > + if (!dmm->base) {
> > > +         kfree(dmm);
> > > +         return NULL;
> > > + }
> > > +
> > > + __raw_writel(0x88888888, dmm->base + DMM_PAT_VIEW__0);
> > > + __raw_writel(0x88888888, dmm->base + DMM_PAT_VIEW__1);
> > > + __raw_writel(0x80808080, dmm->base + DMM_PAT_VIEW_MAP__0);
> > > + __raw_writel(0x80000000, dmm->base + DMM_PAT_VIEW_MAP_BASE);
> > > + __raw_writel(0x88888888, dmm->base + DMM_TILER_OR__0);
> > > + __raw_writel(0x88888888, dmm->base + DMM_TILER_OR__1);
> > > +
> > > + return dmm;
> > > +}
> > > +EXPORT_SYMBOL(dmm_pat_init);
> > > +
> > > +/**
> > > + * Clean up the physical address translator.
> > > + * @param dmm    Device data
> > > + * @return an error status.
> > > + */
> > > +void dmm_pat_release(struct dmm *dmm)
> > > +{
> > > + if (dmm) {
> > > +         iounmap(dmm->base);
> > > +         kfree(dmm);
> > > + }
> > > +}
> > > +EXPORT_SYMBOL(dmm_pat_release);
> > > +
> > > +static s32 __init dmm_init(void)
> > > +{
> > > + return platform_driver_register(&dmm_driver_ldm);
> > > +}
> > > +
> > > +static void __exit dmm_exit(void)
> > > +{
> > > + platform_driver_unregister(&dmm_driver_ldm);
> > > +}
> > > +
> > > +MODULE_LICENSE("GPL v2");
> > > +MODULE_AUTHOR("davidsin@ti.com");
> > > +MODULE_AUTHOR("molnar@ti.com");
> > > +module_init(dmm_init);
> > > +module_exit(dmm_exit);
> > > --
> > > 1.6.3.3
> >
> >
