From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv8 06/16] power: omap-prm: added chain interrupt handler
Date: Wed, 21 Sep 2011 02:51:55 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1109210230550.10719@utopia.booyaka.com>
References: <1316189150-21448-1-git-send-email-t-kristo@ti.com> <1316189150-21448-7-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:56689 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752084Ab1IUIvz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Sep 2011 04:51:55 -0400
In-Reply-To: <1316189150-21448-7-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm@lists.arm.linux.org.uk, Kevin Hilman <khilman@ti.com>, "Avinash.H.M" <avinashhm@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, "Govindraj.R" <govindraj.raja@ti.com>

Hi

some comments (also see the comments for the 1/16 patch, some of which 
apply to this patch)

On Fri, 16 Sep 2011, Tero Kristo wrote:

> diff --git a/drivers/power/omap_prm.c b/drivers/power/omap_prm.c
> index dfc0920..880748a 100644
> --- a/drivers/power/omap_prm.c
> +++ b/drivers/power/omap_prm.c

...

> +static int __init omap_prm_probe(struct platform_device *pdev)
> +{
> +	struct omap_hwmod *oh;

This is a sign that something is wrong here.  Device driver code shouldn't 
have any hwmod dependencies.  The driver should just use whatever data it 
gets from the struct platform_device / platform_data.  

Code in arch/arm/mach-omap2 can use hwmod data to populate platform_data, 
if needed.  But it doesn't even look like that would be needed in this 
case.  The PRM revision register resides inside the PRM IP block, so it's 
valid for the PRM driver to read it directly.

Anyway, this PRM revision code is presumably mooted anyway if different 
drivers are probed for OMAP2430 vs. OMAP4-style PRMs.

> +	int rev;
> +
> +	oh = omap_hwmod_lookup("prm");
> +
> +	if (!oh) {
> +		pr_err("prm hwmod not found\n");
> +		return -ENODEV;
> +	}
> +
> +	prm_dev.base = omap_hwmod_get_mpu_rt_va(oh);
> +
> +	rev = prm_read_reg(oh->class->sysc->rev_offs);
> +
> +	switch (rev) {
> +	case OMAP3_PRM_REVISION:
> +		prm_dev.irq_setup = &omap3_prcm_irq_setup;
> +		prm_dev.revision = PRM_OMAP3;
> +		break;
> +	case OMAP4_PRM_REVISION:
> +		prm_dev.irq_setup = &omap4_prcm_irq_setup;
> +		prm_dev.revision = PRM_OMAP4;
> +		break;
> +	default:
> +		pr_err("unknown PRM revision: %08x\n", rev);
> +		return -ENODEV;
> +	}
> +
> +	prm_dev.irq = oh->mpu_irqs[0].irq;
> +
> +	omap_prcm_irq_init();
> +
> +	return 0;
> +}

- Paul
