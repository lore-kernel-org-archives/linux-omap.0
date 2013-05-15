From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: [PATCH] ARM: OMAP2+: Allow NAND transfer mode to be specified
 in DT
Date: Wed, 15 May 2013 05:28:37 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73E9C47EC@DBDE04.ent.ti.com>
References: <5171A43C.7040602@newflow.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54936 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751186Ab3EOF2v convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 May 2013 01:28:51 -0400
In-Reply-To: <5171A43C.7040602@newflow.co.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Jackson <mpfj-list@newflow.co.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "tony@atomide.com" <tony@atomide.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>

Acked-by: Pekon Gupta <pekon@ti.com>

> OMAP devices support various NAND transfer modes.
> 
> Currently all device-tree definitions will use the default "prefetch
> polled" mode, so this patch enables the transfer mode to be specified
> in the device-tree.
> ---
>  .../devicetree/bindings/mtd/gpmc-nand.txt          |    8 ++++++++
>  arch/arm/mach-omap2/gpmc.c                         |   14 ++++++++++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
> b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
> index e7f8d7e..cd4a19b 100644
> --- a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
> +++ b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
> @@ -29,6 +29,13 @@ Optional properties:
>  		"bch4"		4-bit BCH ecc code
>  		"bch8"		8-bit BCH ecc code
> 
> + - ti,nand-xfer-type:		A string setting the data transfer type.
> One of:
> +
> +		"prefetch-polled"	Prefetch polled mode (default)
> +		"polled"		Polled mode, without prefetch
> +		"prefetch-dma"		Prefetch enabled sDMA
> mode
> +		"prefetch-irq"		Prefetch enabled irq mode
> +
>   - elm_id:	Specifies elm device node. This is required to support
> BCH
>   		error correction using ELM module.
> 
> @@ -55,6 +62,7 @@ Example for an AM33xx board:
>  			reg = <0 0 0>; /* CS0, offset 0 */
>  			nand-bus-width = <16>;
>  			ti,nand-ecc-opt = "bch8";
> +			ti,nand-xfer-type = "polled";
> 
>  			gpmc,sync-clk = <0>;
>  			gpmc,cs-on = <0>;
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-
> omap2/gpmc.c
> index 410e1ba..2f47f76 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -1212,6 +1212,13 @@ static const char * const nand_ecc_opts[] = {
>  	[OMAP_ECC_BCH8_CODE_HW]			= "bch8",
>  };
> 
> +static const char * const nand_xfer_types[] = {
> +	[NAND_OMAP_PREFETCH_POLLED]		= "prefetch-
> polled",
> +	[NAND_OMAP_POLLED]			= "polled",
> +	[NAND_OMAP_PREFETCH_DMA]		= "prefetch-
> dma",
> +	[NAND_OMAP_PREFETCH_IRQ]		= "prefetch-irq",
> +};
> +
>  static int gpmc_probe_nand_child(struct platform_device *pdev,
>  				 struct device_node *child)
>  {
> @@ -1241,6 +1248,13 @@ static int gpmc_probe_nand_child(struct
> platform_device *pdev,
>  				break;
>  			}
> 
> +	if (!of_property_read_string(child, "ti,nand-xfer-type", &s))
> +		for (val = 0; val < ARRAY_SIZE(nand_xfer_types); val++)
> +			if (!strcasecmp(s, nand_xfer_types[val])) {
> +				gpmc_nand_data->xfer_type = val;
> +				break;
> +			}
> +
>  	val = of_get_nand_bus_width(child);
>  	if (val == 16)
>  		gpmc_nand_data->devsize = NAND_BUSWIDTH_16;
> --
> 1.7.9.5
> --
