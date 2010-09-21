From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 2/5] OMAP3: hwmod: add I2C hwmods for OMAP3430
Date: Tue, 21 Sep 2010 01:16:51 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1009210115320.17727@utopia.booyaka.com>
References: <1284734229-16281-1-git-send-email-rnayak@ti.com> <1284734229-16281-2-git-send-email-rnayak@ti.com> <1284734229-16281-3-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45529 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753242Ab0IUHQw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Sep 2010 03:16:52 -0400
In-Reply-To: <1284734229-16281-3-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>

On Fri, 17 Sep 2010, Rajendra Nayak wrote:

> Add hwmod structures for I2C controllers on OMAP3430.

Also in this patch:

> +static struct omap_hwmod omap3xxx_i2c1_hwmod = {
> +	.name		= "i2c1",
> +	.mpu_irqs	= i2c1_mpu_irqs,
> +	.mpu_irqs_cnt	= ARRAY_SIZE(i2c1_mpu_irqs),
> +	.sdma_reqs	= i2c1_sdma_reqs,
> +	.sdma_reqs_cnt	= ARRAY_SIZE(i2c1_sdma_reqs),
> +	.main_clk	= "i2c1_fck",
> +	.prcm		= {
> +		.omap2 = {
> +			.prcm_reg_id = 1,
> +			.module_bit = OMAP3430_GRPSEL_I2C1_SHIFT,
> +			.idlest_reg_id = 1,
> +			.idlest_idle_bit = OMAP3430_GRPSEL_I2C1_SHIFT,

This should be OMAP3430_ST_I2C1_SHIFT; likewise for the rest of the I2C 
hwmods.

> +		},
> +	},
> +	.slaves		= omap3xxx_i2c1_slaves,
> +	.slaves_cnt	= ARRAY_SIZE(omap3xxx_i2c1_slaves),
> +	.class		= &i2c_class,
> +	.dev_attr	= &i2c1_dev_attr,
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
> +};


- Paul
