From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v7 2/6] ARM: OMAP2+: cleaned-up DT support of various
 ECC schemes
Date: Mon, 7 Oct 2013 12:35:48 +0100
Message-ID: <20131007113547.GB15365@e106331-lin.cambridge.arm.com>
References: <1380916188-24206-1-git-send-email-pekon@ti.com>
 <1380916188-24206-3-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:43652 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752153Ab3JGLfv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Oct 2013 07:35:51 -0400
Content-Disposition: inline
In-Reply-To: <1380916188-24206-3-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pekon Gupta <pekon@ti.com>
Cc: "robherring2@gmail.com" <robherring2@gmail.com>, "olof@lixom.net" <olof@lixom.net>, "computersforpeace@gmail.com" <computersforpeace@gmail.com>, "dedekind1@gmail.com" <dedekind1@gmail.com>, Pawel Moll <Pawel.Moll@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "arnd@arndb.de" <arnd@arndb.de>, "tony@atomide.com" <tony@atomide.com>, "bcousson@baylibre.com" <bcousson@baylibre.com>, "avinashphilipk@gmail.com" <avinashphilipk@gmail.com>, "balbi@ti.com" <balbi@ti.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Fri, Oct 04, 2013 at 08:49:44PM +0100, Pekon Gupta wrote:
> OMAP NAND driver support multiple ECC scheme, which can used in following
> different flavours, depending on in-build Hardware engines supported by SoC.
> 
> +---------------------------------------+---------------+---------------+
> | ECC scheme                            |ECC calculation|Error detection|
> +---------------------------------------+---------------+---------------+
> |OMAP_ECC_HAM1_CODE_HW                  |H/W (GPMC)     |S/W            |
> +---------------------------------------+---------------+---------------+
> |OMAP_ECC_BCH8_CODE_HW_DETECTION_SW     |H/W (GPMC)     |S/W            |
> |(requires CONFIG_MTD_NAND_ECC_BCH)     |               |               |
> +---------------------------------------+---------------+---------------+
> |OMAP_ECC_BCH8_CODE_HW                  |H/W (GPMC)     |H/W (ELM)      |
> |(requires CONFIG_MTD_NAND_OMAP_BCH &&  |               |               |
> | ti,elm-id in DT)                      |               |               |
> +---------------------------------------+---------------+---------------+
> To optimize footprint of omap2-nand driver, selection of some ECC schemes
> also require enabling following Kconfigs, in addition to setting appropriate
> DT bindings
> - Kconfig:CONFIG_MTD_NAND_ECC_BCH        error detection done in software
> - Kconfig:CONFIG_MTD_NAND_OMAP_BCH       error detection done by h/w engine
> 
> DT binding updates in this patch are:
> - ti,elm-id: replaces elm_id
> - ti,nand-ecc-opts: supported values ham1, bch4, and bch8
> 	selection of h/w or s/w implementation depends on ti,elm-id
> 
> Signed-off-by: Pekon Gupta <pekon@ti.com>
> ---
>  .../devicetree/bindings/mtd/gpmc-nand.txt          |  8 +++-
>  arch/arm/mach-omap2/gpmc.c                         | 47 ++++++++++++++++------
>  include/linux/platform_data/mtd-nand-omap2.h       | 14 +++++--
>  3 files changed, 52 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
> index 25ee232..7785666 100644
> --- a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
> +++ b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
> @@ -36,8 +36,12 @@ Optional properties:
>  		"prefetch-dma"		Prefetch enabled sDMA mode
>  		"prefetch-irq"		Prefetch enabled irq mode
>  
> - - elm_id:	Specifies elm device node. This is required to support BCH
> - 		error correction using ELM module.
> + - elm_id:	<deprecated> use "ti,elm-id" instead
> + - ti,elm-id:	Specifies pHandle of the ELM devicetree node.

s/pHandle/phandle/

> +		ELM is an on-chip hardware engine on TI SoC which is used for
> +		locating ECC errors for BCHx algorithms. SoC devices which have
> +		ELM hardware engines should specify this device node in .dtsi
> +		Using ELM for ECC error correction frees some CPU cycles.
>  
>  For inline partiton table parsing (optional):
>  
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index 1c45b72..5a607fa 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -1341,12 +1341,6 @@ static void __maybe_unused gpmc_read_timings_dt(struct device_node *np,
>  
>  #ifdef CONFIG_MTD_NAND
>  
> -static const char * const nand_ecc_opts[] = {
> -	[OMAP_ECC_HAM1_CODE_HW]			= "ham1",
> -	[OMAP_ECC_BCH4_CODE_HW]			= "bch4",
> -	[OMAP_ECC_BCH8_CODE_HW]			= "bch8",
> -};
> -
>  static const char * const nand_xfer_types[] = {
>  	[NAND_OMAP_PREFETCH_POLLED]		= "prefetch-polled",
>  	[NAND_OMAP_POLLED]			= "polled",
> @@ -1361,6 +1355,8 @@ static int gpmc_probe_nand_child(struct platform_device *pdev,
>  	const char *s;
>  	struct gpmc_timings gpmc_t;
>  	struct omap_nand_platform_data *gpmc_nand_data;
> +	const __be32 *phandle;

I don't think you need this. With of_parse_phandle you should never need
to see the raw phandle value.

> +	int lenp;
>  
>  	if (of_property_read_u32(child, "reg", &val) < 0) {
>  		dev_err(&pdev->dev, "%s has no 'reg' property\n",
> @@ -1376,12 +1372,39 @@ static int gpmc_probe_nand_child(struct platform_device *pdev,
>  	gpmc_nand_data->cs = val;
>  	gpmc_nand_data->of_node = child;
>  
> -	if (!of_property_read_string(child, "ti,nand-ecc-opt", &s))
> -		for (val = 0; val < ARRAY_SIZE(nand_ecc_opts); val++)
> -			if (!strcasecmp(s, nand_ecc_opts[val])) {
> -				gpmc_nand_data->ecc_opt = val;
> -				break;
> -			}
> +	/* Detect availability of ELM module */
> +	phandle = of_get_property(child, "ti,elm-id", &lenp);
> +	if ((phandle == NULL) || (lenp != sizeof(void *))) {
> +		pr_warn("%s: ti,elm-id property not found\n", __func__);
> +		gpmc_nand_data->elm_of_node = NULL;
> +	} else {
> +		gpmc_nand_data->elm_of_node =
> +				of_find_node_by_phandle(be32_to_cpup(phandle));
> +	}

Use of_parse_handle rather than open-coding it:

	gpmc_nand_data->elm_of_node = 
		of_parse_phandle(child, "ti,elm-id", 0);

Was "elm_id" ever handled previously? I don't see any code handling it
being remove or modified.

Thanks,
Mark.
