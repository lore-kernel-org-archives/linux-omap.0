From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] Introducing 'gpmc-nand.c' for GPMC specific NAND
 init
Date: Thu, 4 Feb 2010 15:47:53 -0800
Message-ID: <20100204234753.GZ22747@atomide.com>
References: <ce9ab5791001122250m5daa723y6f084c83ce25fb5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52881 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932660Ab0BDXrX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Feb 2010 18:47:23 -0500
Content-Disposition: inline
In-Reply-To: <ce9ab5791001122250m5daa723y6f084c83ce25fb5@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vimal Singh <vimal.newwork@gmail.com>
Cc: linux-omap@vger.kernel.org, Linux MTD <linux-mtd@lists.infradead.org>

Hi,

Almost there.. Few more comments below.

* Vimal Singh <vimal.newwork@gmail.com> [100112 22:48]:
> From 89eaa5d55e04f65e76ad49ed8b010cba578d91ca Mon Sep 17 00:00:00 2001
> From: Vimal Singh <vimalsingh@ti.com>
> Date: Mon, 11 Jan 2010 16:01:29 +0530
> Subject: [PATCH] Introducing 'gpmc-nand.c' for GPMC specific NAND init
> 
> Introducing 'gpmc-nand.c' for GPMC specific NAND init.
> For example: GPMC timing parameters and all.
> This patch also migrates gpmc related calls from 'nand/omap2.c'
> to 'gpmc-nand.c'.
> 
> Signed-off-by: Vimal Singh <vimalsingh@ti.com>
> ---
>  arch/arm/mach-omap2/Makefile           |    3 +
>  arch/arm/mach-omap2/gpmc-nand.c        |  139 ++++++++++++++++++++++++++++++++
>  arch/arm/plat-omap/include/plat/nand.h |    8 ++
>  drivers/mtd/nand/omap2.c               |   35 +-------
>  4 files changed, 154 insertions(+), 31 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/gpmc-nand.c

<snip>
 
> +static int omap2_nand_gpmc_config(void __iomem *nand_base)
> +{
> +	struct gpmc_timings t;
> +	int err;
> +
> +	memset(&t, 0, sizeof(t));
> +	t.sync_clk = gpmc_round_ns_to_ticks(gpmc_nand_data->gpmc_t->sync_clk);
> +	t.cs_on = gpmc_round_ns_to_ticks(gpmc_nand_data->gpmc_t->cs_on);
> +	t.adv_on = gpmc_round_ns_to_ticks(gpmc_nand_data->gpmc_t->adv_on);
> +
> +	/* Read */
> +	t.adv_rd_off = gpmc_round_ns_to_ticks(
> +				gpmc_nand_data->gpmc_t->adv_rd_off);
> +	t.oe_on  = t.adv_on;
> +	t.access = gpmc_round_ns_to_ticks(gpmc_nand_data->gpmc_t->access);
> +	t.oe_off = gpmc_round_ns_to_ticks(gpmc_nand_data->gpmc_t->oe_off);
> +	t.cs_rd_off = gpmc_round_ns_to_ticks(gpmc_nand_data->gpmc_t->cs_rd_off);
> +	t.rd_cycle  = gpmc_round_ns_to_ticks(gpmc_nand_data->gpmc_t->rd_cycle);
> +
> +	/* Write */
> +	t.adv_wr_off = gpmc_round_ns_to_ticks(
> +				gpmc_nand_data->gpmc_t->adv_wr_off);
> +	t.we_on  = t.oe_on;
> +	if (cpu_is_omap34xx()) {
> +	    t.wr_data_mux_bus =	gpmc_round_ns_to_ticks(
> +				gpmc_nand_data->gpmc_t->wr_data_mux_bus);
> +	    t.wr_access = gpmc_round_ns_to_ticks(
> +				gpmc_nand_data->gpmc_t->wr_access);
> +	}
> +	t.we_off = gpmc_round_ns_to_ticks(gpmc_nand_data->gpmc_t->we_off);
> +	t.cs_wr_off = gpmc_round_ns_to_ticks(gpmc_nand_data->gpmc_t->cs_wr_off);
> +	t.wr_cycle  = gpmc_round_ns_to_ticks(gpmc_nand_data->gpmc_t->wr_cycle);
> +
> +	/* Configure GPMC */
> +	gpmc_cs_write_reg(gpmc_nand_data->cs, GPMC_CS_CONFIG1,
> +			GPMC_CONFIG1_DEVICESIZE(gpmc_nand_data->devsize) |
> +			GPMC_CONFIG1_DEVICETYPE_NAND);
> +
> +	err = gpmc_cs_set_timings(gpmc_nand_data->cs, &t);
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}

The nand_base is unused in omap2_nand_gpmc_config. And it's not needed there,
see below.

Also, maybe rename it to omap2_nand_gpmc_retime() instead? It should get
get called dynamically based on the cpufreq notifications from the driver
whenever the L3 frequency is being scaled. Otherwise NAND will stop working :)

> +
> +static int gpmc_nand_setup(void __iomem *nand_base)
> +{
> +	struct device *dev = &gpmc_nand_device.dev;
> +
> +	/* Set timings in GPMC */
> +	if (omap2_nand_gpmc_config(nand_base) < 0) {
> +		dev_err(dev, "Unable to set gpmc timings\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}

Here too nand_base is not needed. You can now get rid of this function.

> +
> +int __init gpmc_nand_init(struct omap_nand_platform_data *_nand_data)
> +{
> +	unsigned int val;
> +	int err	= 0;
> +	struct device *dev = &gpmc_nand_device.dev;
> +
> +	gpmc_nand_data = _nand_data;
> +	gpmc_nand_data->nand_setup = gpmc_nand_setup;
> +	gpmc_nand_device.dev.platform_data = gpmc_nand_data;
> +
> +	err = gpmc_nand_setup(gpmc_nand_data->gpmc_cs_baseaddr);
> +	if (err < 0) {
> +		dev_err(dev, "NAND platform setup failed: %d\n", err);
> +		return err;
> +	}

And this ordering must be changed around. You need to first call
gpmc_cs_request to allocate the GPMC area based on the chip select
and size from the gpmc_nand_data.

Only then you can call the timing function.

> +	err = gpmc_cs_request(gpmc_nand_data->cs, NAND_IO_SIZE,
> +				&gpmc_nand_data->phys_base);
> +	if (err < 0) {
> +		dev_err(dev, "Cannot request GPMC CS\n");
> +		return err;
> +	}

So please do the gpmc_cs_request first.

Should be easy to fix for the whole series. Then let's plan on
merging it, it will be a nice improvment for all omaps using
NAND.

Cheers,

Tony
