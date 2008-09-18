From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] Re: omap-sdp3430_Rotation patch
Date: Thu, 18 Sep 2008 09:50:48 +0100
Message-ID: <20080918085048.GC25141@flint.arm.linux.org.uk>
References: <20080916074100.GA6034@flint.arm.linux.org.uk> <1221666210-24970-1-git-send-email-nskamat@ti.com> <c656a4d20809172229q4f6bd776v6a67f7b2f03482b2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:40134 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752800AbYIRIwK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Sep 2008 04:52:10 -0400
Content-Disposition: inline
In-Reply-To: <c656a4d20809172229q4f6bd776v6a67f7b2f03482b2@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arun c <arun.edarath@gmail.com>
Cc: nskamat@ti.com, linux-omap@vger.kernel.org, Rajesh K <krajesh@ti.com>, Iqbal Shareef <iqbal@ti.com>

On Thu, Sep 18, 2008 at 01:29:24AM -0400, arun c wrote:
> Because set_fb_fix will be using those to fill up struct fb_fix_screeninfo
> 
> see below
> 
>         rg = &plane->fbdev->mem_desc.region[plane->idx];
>         fbi->screen_base        = (char __iomem *)rg->vaddr;

You should get rid of that cast.  Remember: casts are bad news when
overused.  Only use casts when you really have no other alternative and
you're sure that you should be doing what you're trying to do.  (Eg, I've
recently seen someone casting a platform device structure to its platform
data - and the cast there clearly shouted out "wrong" - they didn't
actually want to be doing that.)

> > diff --git a/drivers/video/omap/dispc.h b/drivers/video/omap/dispc.h
> > index ef720a7..506e4c6 100644
> > --- a/drivers/video/omap/dispc.h
> > +++ b/drivers/video/omap/dispc.h
> > @@ -2,7 +2,7 @@
> >  #define _DISPC_H
> >
> >  #include <linux/interrupt.h>
> > -
> > +#include <mach/hardware.h>

Could do with keeping the blank line after the #include statements.

> >  #define DISPC_PLANE_GFX                        0
> >  #define DISPC_PLANE_VID1               1
> >  #define DISPC_PLANE_VID2               2
> > @@ -32,6 +32,37 @@
> >  #define DISPC_TFT_DATA_LINES_18                2
> >  #define DISPC_TFT_DATA_LINES_24                3
> >
> > +/* Rotation using VRFB */
> > +extern int rotation;
> > +#define SMS_ROT_BASE_ADDR(context, degree)      (0x70000000            \
> > +                               | 0x4000000 * (context) \
> > +                               | 0x1000000 * (degree/90))
> > +#define BITS_PER_PIXEL         16  /* RGB value */
> > +#define VRFB_SIZE               (2048 * 640 * (BITS_PER_PIXEL/8))
> 
> VRFB_SIZE deifned but not used
> 
> > +#define PAGE_WIDTH_EXP          5 /* Assuming SDRAM pagesize= 1024 */
> > +#define PAGE_HEIGHT_EXP         5 /* 1024 = 2^5 * 2^5 */
> > +#define SMS_IMAGEHEIGHT_OFFSET  16
> > +#define SMS_IMAGEWIDTH_OFFSET   0
> > +#define SMS_PH_OFFSET           8
> > +#define SMS_PW_OFFSET           4
> > +#define SMS_PS_OFFSET           0
> > +#define ROT_LINE_LENGTH         2048
> > +
> > +#define DSS_REG_BASE           0x48050000
> > +#define DISPC_REG_OFFSET       0x00000400
> > +#define DISPC_BASE             0x48050400
> > +#define OMAP_SMS_BASE           (0x6C000000)
> > +#define DISPC_GFX_BA0          0x0080
> > +#define DISPC_GFX_ROW_INC      0x00AC
> > +#define DISPC_GFX_PIXEL_INC    0x00B0
> > +#define DISPC_CONTROL          0x0040
> > +
> > +#define SMS_ROT0_PHYSICAL_BA(context)   OMAP2_IO_ADDRESS(OMAP_SMS_BASE + 0x188 \
> > +                                       + 0x10 * context)
> > +#define SMS_ROT_CONTROL(context)        OMAP2_IO_ADDRESS(OMAP_SMS_BASE + 0x180 \
> > +                                       + 0x10 * context)
> > +#define SMS_ROT0_SIZE(context)          OMAP2_IO_ADDRESS(OMAP_SMS_BASE + 0x184 \
> > +                                       + 0x10 * context)
> >  extern void omap_dispc_set_lcd_size(int width, int height);
> >
> >  extern void omap_dispc_enable_lcd_out(int enable);
> > diff --git a/drivers/video/omap/omapfb_main.c b/drivers/video/omap/omapfb_main.c
> > index d176a2c..1d2ceb8 100644
> > --- a/drivers/video/omap/omapfb_main.c
> > +++ b/drivers/video/omap/omapfb_main.c
> > @@ -35,7 +35,8 @@
> >  #include "dispc.h"
> >
> >  #define MODULE_NAME    "omapfb"
> > -
> > +int rotation = -1;

Bad name for a public variable.

> > -       def_vxres = def_vxres ? : fbdev->panel->x_res;
> > +       def_vxres = ROT_LINE_LENGTH;
> Or
> if (rotation)
>           def_vxres = ROT_LINE_LENGTH;
> else
>          def_vxres = def_vxres ? : fbdev->panel->x_res;

Please avoid using foo ? : bar - although legal, please write it more
clearly as "foo ? foo : bar", or in this case:

	if (rotation)
		def_vxres = ROT_LINE_LENGTH;
	else if (!def_vxres)
		def_vxres = fbdev->panel->x_res;

Ditto for def_vyres.
