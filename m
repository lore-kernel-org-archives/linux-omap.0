From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC 1/8] TILER-DMM: DMM-PAT driver for TI TILER
Date: Sat, 24 Jul 2010 09:09:15 +0100
Message-ID: <20100724080915.GC15064@n2100.arm.linux.org.uk>
References: <1279927348-21750-1-git-send-email-davidsin@ti.com> <1279927348-21750-2-git-send-email-davidsin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:51747 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751901Ab0GXIJ1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 24 Jul 2010 04:09:27 -0400
Content-Disposition: inline
In-Reply-To: <1279927348-21750-2-git-send-email-davidsin@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Sin <davidsin@ti.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Hari Kanigeri <h-kanigeri2@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, Vaibhav Hiremath <hvaibhav@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Lajos Molnar <molnar@ti.com>

On Fri, Jul 23, 2010 at 06:22:21PM -0500, David Sin wrote:
> +static struct platform_driver dmm_driver_ldm = {
> +	.driver = {
> +		.owner = THIS_MODULE,
> +		.name = "dmm",
> +	},
> +	.probe = NULL,
> +	.shutdown = NULL,
> +	.remove = NULL,
> +};

What's the point of this driver structure?

> +s32 dmm_pat_refill(struct dmm *dmm, struct pat *pd, enum pat_mode mode)
> +{
> +	void __iomem *r;
> +	u32 v;
> +
> +	/* Only manual refill supported */
> +	if (mode != MANUAL)
> +		return -EFAULT;
> +
> +	/* Check that the DMM_PAT_STATUS register has not reported an error */
> +	r = dmm->base + DMM_PAT_STATUS__0;
> +	v = __raw_readl(r);
> +	if (WARN(v & 0xFC00, KERN_ERR "dmm_pat_refill() error.\n"))
> +		return -EIO;
> +
> +	/* Set "next" register to NULL */
> +	r = dmm->base + DMM_PAT_DESCR__0;
> +	v = __raw_readl(r);
> +	v = SET_FLD(v, 31, 4, (u32) NULL);
> +	__raw_writel(v, r);
> +
> +	/* Set area to be refilled */
> +	r = dmm->base + DMM_PAT_AREA__0;
> +	v = __raw_readl(r);
> +	v = SET_FLD(v, 30, 24, pd->area.y1);
> +	v = SET_FLD(v, 23, 16, pd->area.x1);
> +	v = SET_FLD(v, 14, 8, pd->area.y0);
> +	v = SET_FLD(v, 7, 0, pd->area.x0);
> +	__raw_writel(v, r);
> +	wmb();

Maybe use writel() (which will contain the barrier _before_ the write op.)

> +
> +	/* First, clear the DMM_PAT_IRQSTATUS register */
> +	r = dmm->base + DMM_PAT_IRQSTATUS;
> +	__raw_writel(0xFFFFFFFF, r);
> +	wmb();

And consider using:
	writel(0xffffffff, dmm->base + DMM_PAT_IRQSTATUS);

In any case, writes to devices are ordered, so there's no real need to
add barriers between each write - in which case writel_relaxed() or
__raw_writel() can be used (which'll be added soon.)

> +
> +	r = dmm->base + DMM_PAT_IRQSTATUS_RAW;
> +	while (__raw_readl(r) != 0)
> +		;

It's normal to use cpu_relax() in busy-wait loops.  What if the IRQ status
never becomes zero?

> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("davidsin@ti.com");
> +MODULE_AUTHOR("molnar@ti.com");

MODULE_AUTHOR("Name <email>"); or just MODULE_AUTHOR("Name");
