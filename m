From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6 1/4] ARM: OMAP2+: cleaned-up DT support of various
 ECC schemes
Date: Wed, 25 Sep 2013 11:29:11 -0700
Message-ID: <20130925182911.GB23337@ld-irv-0074.broadcom.com>
References: <1378986619-26765-1-git-send-email-pekon@ti.com>
 <1378986619-26765-2-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1378986619-26765-2-git-send-email-pekon-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pekon Gupta <pekon-l0cyMroinI0@public.gmane.org>
Cc: dedekind1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, benoit.cousson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, avinashphilipk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Sep 12, 2013 at 05:20:16PM +0530, Pekon Gupta wrote:
> OMAP NAND driver support multiple ECC scheme, which can used in following
> different flavours, depending on in-build Hardware engines supported by SoC.
> 
> +---------------------------------------+---------------+---------------+
> | ECC scheme                            |ECC calculation|Error detection|
> +---------------------------------------+---------------+---------------+
> |OMAP_ECC_HAMMING_CODE_HW               |H/W (GPMC)     |S/W            |
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
> - Kconfig:CONFIG_MTD_NAND_ECC_BCH        enables S/W based BCH ECC algorithm
> - Kconfig:CONFIG_MTD_NAND_OMAP_BCH       enables H/W based BCH ECC algorithm
> 
> This patch
> - updates DT binding for selection of ecc-scheme
> - updates DT binding for detection of ELM h/w engine
> - removes following obselete ECC schemes
> 	OMAP_ECC_HAMMING_CODE_DEFAULT (S/W based 1-bit Hamming ECC)
> 	OMAP_ECC_HAMMING_CODE_HW_ROMCODE (H/W based 1-bit Hamming ECC scheme)
> - updates DT binding documentation for mtd/gpmc-nand
> 
> Signed-off-by: Pekon Gupta <pekon-l0cyMroinI0@public.gmane.org>
> ---
>  .../devicetree/bindings/mtd/gpmc-nand.txt          | 14 +++----
>  arch/arm/mach-omap2/board-flash.c                  |  2 +-
>  arch/arm/mach-omap2/gpmc.c                         | 47 +++++++++++++++-------
>  include/linux/platform_data/mtd-nand-omap2.h       | 23 +++++++----
>  4 files changed, 56 insertions(+), 30 deletions(-)
> 
...
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index 9f4795a..6409884 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
...
> @@ -1378,12 +1371,36 @@ static int gpmc_probe_nand_child(struct platform_device *pdev,
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
> +	parp = of_get_property(child, "ti,elm-id", &lenp);
> +	if ((parp == NULL) && (lenp != (sizeof(void *) * 2))) {

I think && should be ||

> +		pr_warn("%s: ti,elm-id property not found\n", __func__);
> +		gpmc_nand_data->elm_of_node = NULL;
> +	} else {
> +		gpmc_nand_data->elm_of_node =
> +				of_find_node_by_phandle(be32_to_cpup(parp));
> +	}
> +	/* select NAND ecc-scheme */
> +	if (of_property_read_string(child, "ti,nand-ecc-scheme", &s)) {
> +		pr_err("%s: valid ti,nand-ecc-scheme not found\n", __func__);
> +		return -ENODEV;
> +	}
> +	if (!strcmp(s, "ham1"))
> +		gpmc_nand_data->ecc_opt = OMAP_ECC_HAMMING_CODE_HW;
> +	else if (!strcmp(s, "bch4"))
> +		if (gpmc_nand_data->elm_of_node)
> +			gpmc_nand_data->ecc_opt = OMAP_ECC_BCH4_CODE_HW;
> +		else
> +			gpmc_nand_data->ecc_opt =
> +				OMAP_ECC_BCH4_CODE_HW_DETECTION_SW;
> +	else if (!strcmp(s, "bch8"))
> +		if (gpmc_nand_data->elm_of_node)
> +			gpmc_nand_data->ecc_opt = OMAP_ECC_BCH8_CODE_HW;
> +		else
> +			gpmc_nand_data->ecc_opt =
> +				OMAP_ECC_BCH8_CODE_HW_DETECTION_SW;
> +	else
> +		pr_err("%s: ti,ecc-scheme: invalid property value\n", __func__);
>  
>  	if (!of_property_read_string(child, "ti,nand-xfer-type", &s))
>  		for (val = 0; val < ARRAY_SIZE(nand_xfer_types); val++)

Otherwise, I think this patch is OK.

Brian
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
