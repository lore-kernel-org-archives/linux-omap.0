From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 04/15] OMAP: Add support for VRFB rotation engine
Date: Wed, 5 Aug 2009 17:31:41 +0300
Message-ID: <20090805143141.GI7374@atomide.com>
References: <1249481741-14008-1-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-2-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-3-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-4-git-send-email-tomi.valkeinen@nokia.com> <1249481741-14008-5-git-send-email-tomi.valkeinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:59680 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934404AbZHEObr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Aug 2009 10:31:47 -0400
Content-Disposition: inline
In-Reply-To: <1249481741-14008-5-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@nokia.com> [090805 17:19]:
> VRFB rotation engine is a block in OMAP2/3 that offers 12 independent
> contexts that can be used for framebuffer rotation.
> 
> Each context has a backend area of real memory, where it stores the
> pixels in undisclosed format. This memory is offered to users via 4
> virtual memory areas, which see the same memory area in different
> rotation angles (0, 90, 180 and 270 degrees).
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> ---
>  arch/arm/plat-omap/Kconfig             |    3 +
>  arch/arm/plat-omap/Makefile            |    1 +
>  arch/arm/plat-omap/include/mach/vrfb.h |   46 +++++
>  arch/arm/plat-omap/vrfb.c              |  281 ++++++++++++++++++++++++++++++++
>  4 files changed, 331 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/plat-omap/include/mach/vrfb.h
>  create mode 100644 arch/arm/plat-omap/vrfb.c
> 
> diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
> index ca06037..2d6ae55 100644
> --- a/arch/arm/plat-omap/Kconfig
> +++ b/arch/arm/plat-omap/Kconfig
> @@ -186,6 +186,9 @@ config OMAP_SERIAL_WAKE
>  config OMAP2_VRAM
>  	bool
>  
> +config OMAP2_VRFB
> +	bool
> +
>  endmenu
>  
>  endif
> diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
> index 0472bbe..462edf3 100644
> --- a/arch/arm/plat-omap/Makefile
> +++ b/arch/arm/plat-omap/Makefile
> @@ -26,3 +26,4 @@ obj-y += $(i2c-omap-m) $(i2c-omap-y)
>  obj-$(CONFIG_OMAP_MBOX_FWK) += mailbox.o
>  
>  obj-$(CONFIG_OMAP2_VRAM) += vram.o
> +obj-$(CONFIG_OMAP2_VRFB) += vrfb.o

Can you please place this file under drivers/video?


> diff --git a/arch/arm/plat-omap/include/mach/vrfb.h b/arch/arm/plat-omap/include/mach/vrfb.h
> new file mode 100644
> index 0000000..8790612
> --- /dev/null
> +++ b/arch/arm/plat-omap/include/mach/vrfb.h
> @@ -0,0 +1,46 @@
> +/*
> + * VRFB Rotation Engine
> + *
> + * Copyright (C) 2009 Nokia Corporation
> + * Author: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write to the Free Software Foundation, Inc.,
> + * 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
> + */
> +
> +#ifndef __OMAP_VRFB_H__
> +#define __OMAP_VRFB_H__
> +
> +#define OMAP_VRFB_LINE_LEN 2048
> +
> +struct vrfb {
> +	u8 context;
> +	void __iomem *vaddr[4];
> +	unsigned long paddr[4];
> +	u16 xoffset;
> +	u16 yoffset;
> +	u8 bytespp;
> +};
> +
> +extern int omap_vrfb_request_ctx(struct vrfb *vrfb);
> +extern void omap_vrfb_release_ctx(struct vrfb *vrfb);
> +extern void omap_vrfb_suspend_ctx(struct vrfb *vrfb);
> +extern void omap_vrfb_resume_ctx(struct vrfb *vrfb);
> +extern void omap_vrfb_adjust_size(u16 *width, u16 *height,
> +		u8 bytespp);
> +extern void omap_vrfb_setup(struct vrfb *vrfb, unsigned long paddr,
> +		u16 width, u16 height,
> +		unsigned bytespp, bool yuv_mode);
> +extern void omap_vrfb_restore_context(void);
> +
> +#endif /* __VRFB_H */
> diff --git a/arch/arm/plat-omap/vrfb.c b/arch/arm/plat-omap/vrfb.c
> new file mode 100644
> index 0000000..240058f
> --- /dev/null
> +++ b/arch/arm/plat-omap/vrfb.c
> @@ -0,0 +1,281 @@
> +/*
> + * VRFB Rotation Engine
> + *
> + * Copyright (C) 2009 Nokia Corporation
> + * Author: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write to the Free Software Foundation, Inc.,
> + * 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/ioport.h>
> +#include <linux/io.h>
> +#include <linux/bitops.h>
> +#include <linux/mutex.h>
> +
> +#include <mach/io.h>
> +#include <mach/vrfb.h>
> +/*#define DEBUG*/
> +
> +#ifdef DEBUG
> +#define DBG(format, ...) pr_debug("VRFB: " format, ## __VA_ARGS__)
> +#else
> +#define DBG(format, ...)
> +#endif
> +
> +#define SMS_ROT_VIRT_BASE(context, rot) \
> +	(((context >= 4) ? 0xD0000000 : 0x70000000) \
> +	 + (0x4000000 * (context)) \
> +	 + (0x1000000 * (rot)))
> +
> +#define OMAP_VRFB_SIZE			(2048 * 2048 * 4)
> +
> +#define VRFB_PAGE_WIDTH_EXP	5 /* Assuming SDRAM pagesize= 1024 */
> +#define VRFB_PAGE_HEIGHT_EXP	5 /* 1024 = 2^5 * 2^5 */
> +#define VRFB_PAGE_WIDTH		(1 << VRFB_PAGE_WIDTH_EXP)
> +#define VRFB_PAGE_HEIGHT	(1 << VRFB_PAGE_HEIGHT_EXP)
> +#define SMS_IMAGEHEIGHT_OFFSET	16
> +#define SMS_IMAGEWIDTH_OFFSET	0
> +#define SMS_PH_OFFSET		8
> +#define SMS_PW_OFFSET		4
> +#define SMS_PS_OFFSET		0
> +
> +#define OMAP_SMS_BASE		0x6C000000
> +#define SMS_ROT_CONTROL(context)	(OMAP_SMS_BASE + 0x180 + 0x10 * context)
> +#define SMS_ROT_SIZE(context)		(OMAP_SMS_BASE + 0x184 + 0x10 * context)
> +#define SMS_ROT_PHYSICAL_BA(context)	(OMAP_SMS_BASE + 0x188 + 0x10 * context)
> +
> +#define VRFB_NUM_CTXS 12
> +/* bitmap of reserved contexts */
> +static unsigned long ctx_map;
> +/* bitmap of contexts for which we have to keep the HW context valid */
> +static unsigned long ctx_map_active;
> +
> +static DEFINE_MUTEX(ctx_lock);
> +
> +/*
> + * Access to this happens from client drivers or the PM core after wake-up.
> + * For the first case we require locking at the driver level, for the second
> + * we don't need locking, since no drivers will run until after the wake-up
> + * has finished.
> + */
> +static struct {
> +	u32 physical_ba;
> +	u32 control;
> +	u32 size;
> +} vrfb_hw_context[VRFB_NUM_CTXS];
> +
> +static inline void restore_hw_context(int ctx)
> +{
> +	omap_writel(vrfb_hw_context[ctx].control, SMS_ROT_CONTROL(ctx));
> +	omap_writel(vrfb_hw_context[ctx].size, SMS_ROT_SIZE(ctx));
> +	omap_writel(vrfb_hw_context[ctx].physical_ba, SMS_ROT_PHYSICAL_BA(ctx));
> +}

Please use ioremap + and readl/writel instead of omap_read/write for all new code.

Otherwise we'll have harder time to reclaim more address space for kernel
as discussed earlier on linux-omap list.


> +
> +void omap_vrfb_restore_context(void)
> +{
> +	int i;
> +	unsigned long map = ctx_map_active;
> +
> +	for (i = ffs(map); i; i = ffs(map)) {
> +		/* i=1..32 */
> +		i--;
> +		map &= ~(1 << i);
> +		restore_hw_context(i);
> +	}
> +}
> +
> +void omap_vrfb_adjust_size(u16 *width, u16 *height,
> +		u8 bytespp)
> +{
> +	*width = ALIGN(*width * bytespp, VRFB_PAGE_WIDTH) / bytespp;
> +	*height = ALIGN(*height, VRFB_PAGE_HEIGHT);
> +}
> +EXPORT_SYMBOL(omap_vrfb_adjust_size);
> +
> +void omap_vrfb_setup(struct vrfb *vrfb, unsigned long paddr,
> +		u16 width, u16 height,
> +		unsigned bytespp, bool yuv_mode)
> +{
> +	unsigned pixel_size_exp;
> +	u16 vrfb_width;
> +	u16 vrfb_height;
> +	u8 ctx = vrfb->context;
> +	u32 size;
> +	u32 control;
> +
> +	DBG("omapfb_set_vrfb(%d, %lx, %dx%d, %d)\n", ctx, paddr,
> +			width, height, color_mode);
> +
> +	/* For YUV2 and UYVY modes VRFB needs to handle pixels a bit
> +	 * differently. See TRM. */
> +	if (yuv_mode) {
> +		bytespp *= 2;
> +		width /= 2;
> +	}
> +
> +	if (bytespp == 4)
> +		pixel_size_exp = 2;
> +	else if (bytespp == 2)
> +		pixel_size_exp = 1;
> +	else
> +		BUG();
> +
> +	vrfb_width = ALIGN(width * bytespp, VRFB_PAGE_WIDTH) / bytespp;
> +	vrfb_height = ALIGN(height, VRFB_PAGE_HEIGHT);
> +
> +	DBG("vrfb w %u, h %u bytespp %d\n", vrfb_width, vrfb_height, bytespp);
> +
> +	size  = vrfb_width << SMS_IMAGEWIDTH_OFFSET;
> +	size |= vrfb_height << SMS_IMAGEHEIGHT_OFFSET;
> +
> +	control  = pixel_size_exp << SMS_PS_OFFSET;
> +	control |= VRFB_PAGE_WIDTH_EXP  << SMS_PW_OFFSET;
> +	control |= VRFB_PAGE_HEIGHT_EXP << SMS_PH_OFFSET;
> +
> +	vrfb_hw_context[ctx].physical_ba = paddr;
> +	vrfb_hw_context[ctx].size = size;
> +	vrfb_hw_context[ctx].control = control;
> +
> +	omap_writel(paddr, SMS_ROT_PHYSICAL_BA(ctx));
> +	omap_writel(size, SMS_ROT_SIZE(ctx));
> +	omap_writel(control, SMS_ROT_CONTROL(ctx));
> +
> +	DBG("vrfb offset pixels %d, %d\n",
> +			vrfb_width - width, vrfb_height - height);
> +
> +	vrfb->xoffset = vrfb_width - width;
> +	vrfb->yoffset = vrfb_height - height;
> +	vrfb->bytespp = bytespp;
> +}
> +EXPORT_SYMBOL(omap_vrfb_setup);
> +
> +void omap_vrfb_release_ctx(struct vrfb *vrfb)
> +{
> +	int rot;
> +	int ctx = vrfb->context;
> +
> +	if (ctx == 0xff)
> +		return;
> +
> +	DBG("release ctx %d\n", ctx);
> +
> +	mutex_lock(&ctx_lock);
> +
> +	BUG_ON(!(ctx_map & (1 << ctx)));
> +
> +	clear_bit(ctx, &ctx_map_active);
> +	clear_bit(ctx, &ctx_map);
> +
> +	for (rot = 0; rot < 4; ++rot) {
> +		if (vrfb->paddr[rot]) {
> +			release_mem_region(vrfb->paddr[rot], OMAP_VRFB_SIZE);
> +			vrfb->paddr[rot] = 0;
> +		}
> +	}
> +
> +	vrfb->context = 0xff;
> +
> +	mutex_unlock(&ctx_lock);
> +}
> +EXPORT_SYMBOL(omap_vrfb_release_ctx);
> +
> +int omap_vrfb_request_ctx(struct vrfb *vrfb)
> +{
> +	int rot;
> +	u32 paddr;
> +	u8 ctx;
> +	int r;
> +
> +	DBG("request ctx\n");
> +
> +	mutex_lock(&ctx_lock);
> +
> +	for (ctx = 0; ctx < VRFB_NUM_CTXS; ++ctx)
> +		if ((ctx_map & (1 << ctx)) == 0)
> +			break;
> +
> +	if (ctx == VRFB_NUM_CTXS) {
> +		pr_err("vrfb: no free contexts\n");
> +		r = -EBUSY;
> +		goto out;
> +	}
> +
> +	DBG("found free ctx %d\n", ctx);
> +
> +	set_bit(ctx, &ctx_map);
> +	WARN_ON(ctx_map_active & (1 << ctx));
> +	set_bit(ctx, &ctx_map_active);
> +
> +	memset(vrfb, 0, sizeof(*vrfb));
> +
> +	vrfb->context = ctx;
> +
> +	for (rot = 0; rot < 4; ++rot) {
> +		paddr = SMS_ROT_VIRT_BASE(ctx, rot);
> +		if (!request_mem_region(paddr, OMAP_VRFB_SIZE, "vrfb")) {
> +			pr_err("vrfb: failed to reserve VRFB "
> +					"area for ctx %d, rotation %d\n",
> +					ctx, rot * 90);
> +			omap_vrfb_release_ctx(vrfb);
> +			r = -ENOMEM;
> +			goto out;
> +		}
> +
> +		vrfb->paddr[rot] = paddr;
> +
> +		DBG("VRFB %d/%d: %lx\n", ctx, rot*90, vrfb->paddr[rot]);
> +	}
> +
> +	r = 0;
> +out:
> +	mutex_unlock(&ctx_lock);
> +	return r;
> +}
> +EXPORT_SYMBOL(omap_vrfb_request_ctx);
> +
> +void omap_vrfb_suspend_ctx(struct vrfb *vrfb)
> +{
> +	DBG("suspend ctx %d\n", vrfb->context);
> +	mutex_lock(&ctx_lock);
> +
> +	BUG_ON(vrfb->context >= VRFB_NUM_CTXS);
> +	BUG_ON(!((1 << vrfb->context) & ctx_map_active));
> +
> +	clear_bit(vrfb->context, &ctx_map_active);
> +	mutex_unlock(&ctx_lock);
> +}
> +EXPORT_SYMBOL(omap_vrfb_suspend_ctx);
> +
> +void omap_vrfb_resume_ctx(struct vrfb *vrfb)
> +{
> +	DBG("resume ctx %d\n", vrfb->context);
> +	mutex_lock(&ctx_lock);
> +
> +	BUG_ON(vrfb->context >= VRFB_NUM_CTXS);
> +	BUG_ON((1 << vrfb->context) & ctx_map_active);
> +
> +	/*
> +	 * omap_vrfb_restore_context is normally called by the core domain
> +	 * save / restore logic, but since this VRFB context was suspended
> +	 * those calls didn't actually restore the context and now we might
> +	 * have an invalid context. Do an explicit restore here.
> +	 */
> +	restore_hw_context(vrfb->context);
> +	set_bit(vrfb->context, &ctx_map_active);
> +	mutex_unlock(&ctx_lock);
> +}
> +EXPORT_SYMBOL(omap_vrfb_resume_ctx);
> +
> -- 
> 1.6.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
