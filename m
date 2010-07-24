From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC 7/8] TILER-DMM: Main TILER driver implementation.
Date: Sat, 24 Jul 2010 08:55:24 +0100
Message-ID: <20100724075524.GA15064@n2100.arm.linux.org.uk>
References: <1279927348-21750-1-git-send-email-davidsin@ti.com> <1279927348-21750-2-git-send-email-davidsin@ti.com> <1279927348-21750-3-git-send-email-davidsin@ti.com> <1279927348-21750-4-git-send-email-davidsin@ti.com> <1279927348-21750-5-git-send-email-davidsin@ti.com> <1279927348-21750-6-git-send-email-davidsin@ti.com> <1279927348-21750-7-git-send-email-davidsin@ti.com> <1279927348-21750-8-git-send-email-davidsin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:55353 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751561Ab0GXHzh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 24 Jul 2010 03:55:37 -0400
Content-Disposition: inline
In-Reply-To: <1279927348-21750-8-git-send-email-davidsin@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Sin <davidsin@ti.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Hari Kanigeri <h-kanigeri2@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, Vaibhav Hiremath <hvaibhav@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Lajos Molnar <molnar@ti.com>

On Fri, Jul 23, 2010 at 06:22:27PM -0500, David Sin wrote:
> +struct platform_driver tiler_driver_ldm = {
> +	.driver = {
> +		.owner = THIS_MODULE,
> +		.name = "tiler",
> +	},
> +	.probe = NULL,
> +	.shutdown = NULL,
> +	.remove = NULL,
> +};

What's the purpose of this apparantly stub driver?

> +static s32 refill_pat(struct tmm *tmm, struct tcm_area *area, u32 *ptr)
> +{
> +	s32 res = 0;
> +	struct pat_area p_area = {0};
> +
> +	p_area.x0 = area->p0.x;
> +	p_area.y0 = area->p0.y;
> +	p_area.x1 = area->p1.x;
> +	p_area.y1 = area->p1.y;
> +
> +	memcpy(dmac_va, ptr, sizeof(*ptr) * tcm_sizeof(*area));
> +
> +	if (tmm_map(tmm, p_area, dmac_pa))
> +		res = -EFAULT;

What's wrong with making tmm_map return an error code and propagating it?
This can be a simple:

	return tmm_map(tmm, p_area, dmac_pa);

In any case, I'm not sure I like all this layered code - it makes it much
harder to follow what's going on when you have to look at multiple files
to find out what X does.

If tmm_map() is only used here, move the contents of tmm_map here.

> +/* verify input params and calculate tiler container params for a block */
> +static s32 __analize_area(enum tiler_fmt fmt, u32 width, u32 height,
> +			  u16 *x_area, u16 *y_area, u16 *align, u16 *offs)

Analyze is spelt like that, not with an i.

> +/* driver initialization */
> +static s32 __init tiler_init(void)
> +{
> +	s32 r = -1;
> +	struct tcm *sita = NULL;
> +	struct tmm *tmm_pat = NULL;
> +
> +	tiler_geom_init(&tiler);
> +
> +	/* check module parameters for correctness */
> +	if (default_align > PAGE_SIZE ||
> +	    default_align & (default_align - 1) ||
> +	    granularity < 1 || granularity > PAGE_SIZE ||
> +	    granularity & (granularity - 1))
> +		return -EINVAL;
> +
> +	/*
> +	 * Array of physical pages for PAT programming, which must be a 16-byte
> +	 * aligned physical address.
> +	 */
> +	dmac_va = dma_alloc_coherent(NULL, tiler.width * tiler.height *
> +					sizeof(*dmac_va), &dmac_pa, GFP_ATOMIC);

Why GFP_ATOMIC?  Surely GFP_KERNEL will work here?

What if there ends up being more than one tiler at some point in the future
and you need two of these?  Shouldn't this be in some driver probe function
so you have a struct device to use with it?
