From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH v3 04/27] mtd: nand: omap2: Use gpmc_omap_get_nand_ops()
 to get NAND registers
Date: Wed, 2 Dec 2015 21:00:44 -0800
Message-ID: <20151203050044.GD120110@google.com>
References: <1442588029-13769-1-git-send-email-rogerq@ti.com>
 <1442588029-13769-5-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1442588029-13769-5-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: tony@atomide.com, dwmw2@infradead.org, ezequiel@vanguardiasur.com.ar, javier@dowhile0.org, fcooper@ti.com, nsekhar@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Sep 18, 2015 at 05:53:26PM +0300, Roger Quadros wrote:
> Deprecate nand register passing via platform data and use
> gpmc_omap_get_nand_ops() instead.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  arch/arm/mach-omap2/gpmc-nand.c              | 2 --
>  drivers/mtd/nand/omap2.c                     | 9 ++++++++-
>  include/linux/platform_data/mtd-nand-omap2.h | 4 +++-
>  3 files changed, 11 insertions(+), 4 deletions(-)

This one also seems a bit oddly-split, if you're trying to allow
bringing these into different trees. The nand/omap2.c changes seem like
they can be done completely on their own (after the previous patches),
and the arch/arm/mach-omap2/gpmc-nand.c and
include/linux/platform_data/mtd-nand-omap2.h changes can come in their
own patch afterward.

That does still make things a little complicated for applying to
different trees, though, as we have some arch/arm -> drivers/mtd ->
arch/arm dependencies.

If it helps, I can try to provide Tony with a stable v4.4-rc1-based
piece of the MTD tree, and just take everything through there (with
acks). (FWIW, everything in l2-mtd.git can be considered stable,
git-wise. I've been keeping a clean history. But it'd be best to
coordinate what points to cross-merge.)

Then if we do that, we'd have to keep a close eye to make sure I don't
take any more conflicting changes to drivers/mtd/nand/omap2.c, or else
do another cross-merge...

Any better suggestions?

Brian

> 
> diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
> index 72918c4..04e6998 100644
> --- a/arch/arm/mach-omap2/gpmc-nand.c
> +++ b/arch/arm/mach-omap2/gpmc-nand.c
> @@ -121,8 +121,6 @@ int gpmc_nand_init(struct omap_nand_platform_data *gpmc_nand_data,
>  	if (err < 0)
>  		goto out_free_cs;
>  
> -	gpmc_update_nand_reg(&gpmc_nand_data->reg, gpmc_nand_data->cs);
> -
>  	if (!gpmc_hwecc_bch_capable(gpmc_nand_data->ecc_opt)) {
>  		pr_err("omap2-nand: Unsupported NAND ECC scheme selected\n");
>  		err = -EINVAL;
> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> index 60fa899..f214fe2 100644
> --- a/drivers/mtd/nand/omap2.c
> +++ b/drivers/mtd/nand/omap2.c
> @@ -28,6 +28,7 @@
>  #include <linux/mtd/nand_bch.h>
>  #include <linux/platform_data/elm.h>
>  
> +#include <linux/omap-gpmc.h>
>  #include <linux/platform_data/mtd-nand-omap2.h>
>  
>  #define	DRIVER_NAME	"omap2-nand"
> @@ -169,7 +170,9 @@ struct omap_nand_info {
>  	} iomode;
>  	u_char				*buf;
>  	int					buf_len;
> +	/* Interface to GPMC */
>  	struct gpmc_nand_regs		reg;
> +	struct gpmc_nand_ops		*ops;
>  	/* generated at runtime depending on ECC algorithm and layout selected */
>  	struct nand_ecclayout		oobinfo;
>  	/* fields specific for BCHx_HW ECC scheme */
> @@ -1677,9 +1680,13 @@ static int omap_nand_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, info);
>  
> +	info->ops = gpmc_omap_get_nand_ops(&info->reg, info->gpmc_cs);
> +	if (!info->ops) {
> +		dev_err(&pdev->dev, "Failed to get GPMC->NAND interface\n");
> +		return -ENODEV;
> +	}
>  	info->pdev		= pdev;
>  	info->gpmc_cs		= pdata->cs;
> -	info->reg		= pdata->reg;
>  	info->of_node		= pdata->of_node;
>  	info->ecc_opt		= pdata->ecc_opt;
>  	mtd			= &info->mtd;
> diff --git a/include/linux/platform_data/mtd-nand-omap2.h b/include/linux/platform_data/mtd-nand-omap2.h
> index 090bbab..a067f58 100644
> --- a/include/linux/platform_data/mtd-nand-omap2.h
> +++ b/include/linux/platform_data/mtd-nand-omap2.h
> @@ -75,10 +75,12 @@ struct omap_nand_platform_data {
>  	enum nand_io		xfer_type;
>  	int			devsize;
>  	enum omap_ecc           ecc_opt;
> -	struct gpmc_nand_regs	reg;
>  
>  	/* for passing the partitions */
>  	struct device_node	*of_node;
>  	struct device_node	*elm_of_node;
> +
> +	/* deprecated */
> +	struct gpmc_nand_regs	reg;
>  };
>  #endif
> -- 
> 2.1.4
> 
