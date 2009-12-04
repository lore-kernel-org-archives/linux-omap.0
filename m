From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2]: Introducing 'gpmc-nand.c' for GPMC specific NAND
 init
Date: Fri, 4 Dec 2009 14:01:39 -0800
Message-ID: <20091204220138.GJ24013@atomide.com>
References: <64662.192.168.10.89.1259933932.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51520 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757360AbZLDWBe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Dec 2009 17:01:34 -0500
Content-Disposition: inline
In-Reply-To: <64662.192.168.10.89.1259933932.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, vimal.newwork@gmail.com

Hi,

Looks good, just one comment below.

* Govindraj.R <govindraj.raja@ti.com> [091204 05:37]:
> From: Vimal Singh <vimalsingh@ti.com>
> Date: Wed, 25 Nov 2009 18:23:15 +0530
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
>  arch/arm/mach-omap2/gpmc-nand.c        |  141 ++++++++++++++++++++++++++++++++
>  arch/arm/plat-omap/include/plat/nand.h |    6 ++
>  drivers/mtd/nand/omap2.c               |   26 +-----
>  4 files changed, 153 insertions(+), 23 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/gpmc-nand.c

<snip>
 
> --- /dev/null
> +++ b/arch/arm/mach-omap2/gpmc-nand.c

<snip>

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
> +
> +	/* Enable RD PIN Monitoring Reg */
> +	if (gpmc_nand_data->dev_ready) {
> +		val  = gpmc_cs_read_reg(gpmc_nand_data->cs,
> +						 GPMC_CS_CONFIG1);
> +		val |= WR_RD_PIN_MONITORING;
> +		gpmc_cs_write_reg(gpmc_nand_data->cs,
> +						GPMC_CS_CONFIG1, val);
> +	}

Above looks OK..

> +	val  = gpmc_cs_read_reg(gpmc_nand_data->cs, GPMC_CS_CONFIG7);
> +	val &= ~(0xf << 8);
> +	val |=  (0xc & 0xf) << 8;
> +	gpmc_cs_write_reg(gpmc_nand_data->cs, GPMC_CS_CONFIG7, val);

..but this looks messy. Maybe use some GPMC defines for the
0xf << 8 mask?

Then the 0xc & 0xf part looks a bit redundant, what's the 0xf
there for?

I know it's all from the old code, but might as well clean it up
while at it :)

Regards,

Tony
