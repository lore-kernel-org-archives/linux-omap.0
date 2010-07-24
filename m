From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC 1/8] TILER-DMM: DMM-PAT driver for TI TILER
Date: Sat, 24 Jul 2010 11:15:48 +0100
Message-ID: <20100724101548.GA16238@n2100.arm.linux.org.uk>
References: <1279927348-21750-1-git-send-email-davidsin@ti.com> <1279927348-21750-2-git-send-email-davidsin@ti.com> <20100724080915.GC15064@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:59012 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753800Ab0GXKQC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 24 Jul 2010 06:16:02 -0400
Content-Disposition: inline
In-Reply-To: <20100724080915.GC15064@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Sin <davidsin@ti.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Hari Kanigeri <h-kanigeri2@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, Vaibhav Hiremath <hvaibhav@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Lajos Molnar <molnar@ti.com>

This is what I'd expect to see.  This uses a hardware-upwards registration
scheme, so by registering a 'dmm' device, when the driver for 'dmm' gets
registered, it automatically registers with the next level up.

However, you should think carefully about this kind of layered approach.
Would it be more appropriate to turn the 'tmm' and higher layers into a
set of library calls for this driver to use, so that they can be reused
with less modifications when other hardware comes along?

#include <linux/errno.h>
#include <linux/io.h>
#include <linux/module.h>
#include <linux/platform_device.h>
#include <linux/slab.h>

/* RMK: or whatever path to this... */
#include "tmm.h"
/*
 * RMK: which contains at least something like:
 *
 * struct tmm;
 * int tmm_register(struct tmm **tmm, int (*refill)(struct pat *, enum pat_mode, void *), void *priv);
 * void tmm_unregister(struct tmm *tmm);
 */

#define MASK(msb, lsb) (((1 << ((msb) + 1 - (lsb))) - 1) << (lsb))
#define SET_FLD(reg, msb, lsb, val) \
(((reg) & ~MASK((msb), (lsb))) | (((val) << (lsb)) & MASK((msb), (lsb))))

struct dmm {
	void __iomem *base;
	struct tmm *tmm;
};

static int dmm_wait(void __iomem *reg, unsigned mask, unsigned val, unsigned long timeout)
{
	while ((readl(reg) & mask) != val) {
		if (timeout-- == 0)
			return -ETIMEDOUT;
		udelay(1);
	}
	return 0;
}

static int dmm_refill(struct pat *pat, enum pat_mode mode, void *priv)
{
	struct dmm *dmm = priv;
	int ret;
	u32 v;

	if (mode != PAT_MODE_MANUAL || pat->data & 0x0000000f)
		/* RMK: and maybe check the range of other args */
		return -EINVAL;

	/* Check that the DMM_PAT_STATUS register has not reported an error */
	v = readl(dmm->base + DMM_PAT_STATUS__0);
	if (v & 0xfc00)
		return -EIO;

	/* Set "next" register to 0 */
	/* RMK: not null - hardware doesn't take virtual addresses */
	v = readl(dmm->base + DMM_PAT_DESCR__0);
	v = SET_FLD(v, 31, 4, 0);
	writel(v, dmm->base + DMM_PAT_DESCR__0);

	/* Set area to be refilled */
	v = readl(dmm->base + DMM_PAT_AREA__0) & 0xc000c000;
	v = (pat->area.y1 << 24) | (pat->area.x1 << 16) |
	    (pat->area.y0 << 8) | pat->area.x0;
	writel(v, dmm->base + DMM_PAT_AREA__0);

	/* Clear the DMM_PAT_IRQSTATUS register */
	writel(~0, dmm->base + DMM_PAT_IRQSTATUS);

	ret = dmm_wait(dmm->base + DMM_PAT_IRQSTATUS_RAW), ~0, 0, timeout);
	if (ret)
		return ret;

	/* Fill data register */
	v = readl(dmm->base + DMM_PAT_DATA__0) & 0x0000000f;
	v |= pat->data;
	writel(v, dmm->base + DMM_PAT_DATA__0);

	/*
	 * Read back PAT_DATA__0 to see if write was successful
	 * RMK: shouldn't this just check bits 31-4 ?  Is this just
	 * trying to ensure that the value is written before the next one?
	 * if so, writes to devices are ordered with each other, so this
	 * should not be necessary.
	 */
	ret = dmm_wait(dmm->base + DMM_PAT_DATA__0, ~0, pat->data, timeout);
	if (ret)
		return ret;

	v = readl(dmm->base + DMM_PAT_CTRL__0) & 0x0ffefc8e;
	v |= (pat->ctrl.ini << 28) | (pat->ctrl.sync << 16) |
	     (pat->ctrl.lut_id << 8) | (pat->ctrl.dir << 4) | pat->ctrl.start;
	writel(v, dmm->base + DMM_PAT_CTRL__0);

	/* Check if PAT_IRQSTATUS_RAW is set after the PAT has been refilled */
	ret = dmm_wait(dmm->base + DMM_PAT_IRQSTATUS_RAW, 3, 3, timeout);
	if (ret)
		return ret;

	/* Clear the DMM_PAT_IRQSTATUS register */
	writel(~0, dmm->base + DMM_PAT_IRQSTATUS);

	ret = dmm_wait(dmm->base + DMM_PAT_IRQSTATUS_RAW, ~0, 0, timeout);
	if (ret)
		return ret;	

	/* Set "next" register to 0 to clear any PAT STATUS errors */
	v = readl(dmm->base + DMM_PAT_DESCR__0);
	v = SET_FLD(v, 31, 4, 0);
	writel(v, dmm->base + DMM_PAT_DESCR__0);

	/*
	 * Now check that the DMM_PAT_STATUS register has not reported an error
	 */
	v = readl(dmm->base + DMM_PAT_STATUS__0);
	if (v & 0xfc00)
		return -EIO;

	return 0;
}

static int dmm_probe(struct platform_device *pdev)
{
	struct resource *res = platform_get_resource(pdev, 0, IORESOURCE_MEM);
	struct dmm *dmm;
	int ret;

	if (!res)
		return -EINVAL;

	if (request_mem_region(res->start, resource_size(res), "dmm")) {
		ret = -EBUSY;
		goto err_region;
	}

	dmm = kzalloc(sizeof(*dmm), GFP_KERNEL);
	if (!dmm) {
		ret = -ENOMEM;
		goto err_kzalloc;
	}

	dmm->base = ioremap(res->start, resource_size(res));
	if (!dmm->base) {
		ret = -ENOMEM;
		goto err_ioremap;
	}

	__raw_writel(0x88888888, dmm->base + DMM_PAT_VIEW__0);
	__raw_writel(0x88888888, dmm->base + DMM_PAT_VIEW__1);
	__raw_writel(0x80808080, dmm->base + DMM_PAT_VIEW_MAP__0);
	__raw_writel(0x80000000, dmm->base + DMM_PAT_VIEW_MAP_BASE);
	__raw_writel(0x88888888, dmm->base + DMM_TILER_OR__0);
	__raw_writel(0x88888888, dmm->base + DMM_TILER_OR__1);

	/* register with the tiler memory manager */
	ret = tmm_register(&dmm->tmm, dmm_refill, dmm);
	if (ret)
		goto err_tmm_register;

	return 0;

err_tmm_register:
	iounmap(dmm->base);
err_iounmap:
	kfree(dmm);
err_kzalloc:
	release_mem_region(res->start, resource_size(res));
err_region:
	return ret;
}

static void dmm_remove(struct platform_device *pdev)
{
	struct resource *res = platform_get_resource(pdev, 0, IORESOURCE_MEM);
	struct dmm *dmm = platform_get_drvdata(pdev);

	tmm_unregister(dmm->tmm);
	iounmap(dmm->base);
	kfree(dmm);
	release_mem_region(res->start, resource_size(res));
}

static struct platform_driver dmm_driver = {
	.driver = {
		.owner = THIS_MODULE,
		.name = "dmm",
	},
	.probe	= dmm_probe,
	.remove	= dmm_remove,
};

static int __init dmm_init(void)
{
	return platform_driver_register(&dmm_driver);
}
module_init(dmm_init);

static void __exit dmm_exit(void)
{
	platform_driver_unregister(&dmm_driver);
}
module_exit(dmm_exit);

MODULE_AUTHOR("Name <email>");
MODULE_DESCRIPTION("TI OMAP4 tiler hardware driver");
MODULE_LICENSE("GPL v2");

