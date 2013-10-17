From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v9 7/9] mtd: nand: omap: use
 drivers/mtd/nand/nand_bch.c wrapper for BCH ECC instead of lib/bch.c
Date: Wed, 16 Oct 2013 19:22:37 -0700
Message-ID: <20131017022237.GC23337@ld-irv-0074.broadcom.com>
References: <1381816197-20477-1-git-send-email-pekon@ti.com>
 <1381816197-20477-8-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1381816197-20477-8-git-send-email-pekon-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pekon Gupta <pekon-l0cyMroinI0@public.gmane.org>
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, dedekind1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Pawel.Moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, avinashphilipk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ivan Djelic <ivan.djelic-ITF29qwbsa/QT0dZR+AlfA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

+ Ivan, as he has touched this stuff before

On Tue, Oct 15, 2013 at 11:19:55AM +0530, Pekon Gupta wrote:
> generic frame-work in mtd/nand/nand_bch.c is a wrapper above lib/bch.h which
> encapsulates all control information specific to BCH ecc algorithm in software.
> Thus this patch:
> (1) replace omap specific implementations with equivalent wrapper in nand_bch.c
>     so that more generic code is re-used. like;
>         omap3_correct_data_bch() -> nand_bch_correct_data()
>         omap3_free_bch() -> nand_bch_free()
> (2) replace direct calls to lib/bch.c with wrapper functions defined in nand_bch.c
> 	init_bch() -> nand_bch_init()
> (3) removes selection between BCH8 and BCH4 h/w ecc-schemes via KConfig.
>     This selection is now based on ti,nand-ecc-opt and ti,elm-id DT bindings.
> 
> Signed-off-by: Pekon Gupta <pekon-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/mtd/nand/Kconfig | 30 ++-------------
>  drivers/mtd/nand/omap2.c | 96 +++++++++++-------------------------------------
>  2 files changed, 26 insertions(+), 100 deletions(-)
> 
> diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
> index d885298..5836039 100644
> --- a/drivers/mtd/nand/Kconfig
> +++ b/drivers/mtd/nand/Kconfig
> @@ -96,35 +96,13 @@ config MTD_NAND_OMAP2
>  
>  config MTD_NAND_OMAP_BCH
>  	depends on MTD_NAND && MTD_NAND_OMAP2 && ARCH_OMAP3
> -	tristate "Enable support for hardware BCH error correction"
> +	tristate "Support hardware based BCH error correction"
>  	default n
>  	select BCH
> -	select BCH_CONST_PARAMS

Do you know what will happen now if someone configures BCH_CONST_PARAMS?
Would this cause problems?

>  	help
> -	 Support for hardware BCH error correction.
> -
> -choice
> -	prompt "BCH error correction capability"
> -	depends on MTD_NAND_OMAP_BCH
> -
> -config MTD_NAND_OMAP_BCH8
> -	bool "8 bits / 512 bytes (recommended)"
> -	help
> -	 Support correcting up to 8 bitflips per 512-byte block.
> -	 This will use 13 bytes of spare area per 512 bytes of page data.
> -	 This is the recommended mode, as 4-bit mode does not work
> -	 on some OMAP3 revisions, due to a hardware bug.
> -
> -config MTD_NAND_OMAP_BCH4
> -	bool "4 bits / 512 bytes"
> -	help
> -	 Support correcting up to 4 bitflips per 512-byte block.
> -	 This will use 7 bytes of spare area per 512 bytes of page data.
> -	 Note that this mode does not work on some OMAP3 revisions, due to a
> -	 hardware bug. Please check your OMAP datasheet before selecting this
> -	 mode.
> -
> -endchoice
> +	  Some devices have built-in ELM hardware engine, which can be used to
> +	  locate and correct errors when using BCH ECC scheme. This enables the
> +	  driver support for same.
>  
>  if MTD_NAND_OMAP_BCH
>  config BCH_CONST_M

Do you need to to also kill of the Kconfig stuff for BCH_CONST_M and
BCH_CONST_T, which were tied to the MTD_NAND_OMAP_BCH4 and
MTD_NAND_OMAP_BCH8 configs you just removed?

> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> index 5f6e621..769ff65 100644
> --- a/drivers/mtd/nand/omap2.c
> +++ b/drivers/mtd/nand/omap2.c
> @@ -25,7 +25,7 @@
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  
> -#include <linux/bch.h>
> +#include <linux/mtd/nand_bch.h>
>  #include <linux/platform_data/elm.h>
>  
>  #include <linux/platform_data/mtd-nand-omap2.h>
> @@ -140,7 +140,6 @@
>  #define BCH_ECC_SIZE1		0x20	/* ecc_size1 = 32 */
>  
>  #define BADBLOCK_MARKER_LENGTH		2
> -#define OMAP_ECC_BCH8_POLYNOMIAL	0x201b
>  
>  #ifdef CONFIG_MTD_NAND_OMAP_BCH
>  static u_char bch8_vector[] = {0xf3, 0xdb, 0x14, 0x16, 0x8b, 0xd2, 0xbe, 0xcc,
> @@ -173,7 +172,6 @@ struct omap_nand_info {
>  	int					buf_len;
>  	struct gpmc_nand_regs		reg;
>  	/* fields specific for BCHx_HW ECC scheme */
> -	struct bch_control             *bch;
>  	bool				is_elm_used;
>  	struct device			*elm_dev;
>  	struct device_node		*of_node;
> @@ -1507,43 +1505,7 @@ static int omap_elm_correct_data(struct mtd_info *mtd, u_char *data,
>  
>  	return stat;
>  }
> -#endif /* CONFIG_MTD_NAND_OMAP_BCH */
>  
> -#ifdef CONFIG_MTD_NAND_ECC_BCH
> -/**
> - * omap3_correct_data_bch - Decode received data and correct errors
> - * @mtd: MTD device structure
> - * @data: page data
> - * @read_ecc: ecc read from nand flash
> - * @calc_ecc: ecc read from HW ECC registers
> - */
> -static int omap3_correct_data_bch(struct mtd_info *mtd, u_char *data,
> -				  u_char *read_ecc, u_char *calc_ecc)
> -{
> -	int i, count;
> -	/* cannot correct more than 8 errors */
> -	unsigned int errloc[8];
> -	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
> -						   mtd);
> -
> -	count = decode_bch(info->bch, NULL, 512, read_ecc, calc_ecc, NULL,
> -			   errloc);
> -	if (count > 0) {
> -		/* correct errors */
> -		for (i = 0; i < count; i++) {
> -			/* correct data only, not ecc bytes */
> -			if (errloc[i] < 8*512)
> -				data[errloc[i]/8] ^= 1 << (errloc[i] & 7);
> -			pr_debug("corrected bitflip %u\n", errloc[i]);
> -		}
> -	} else if (count < 0) {
> -		pr_err("ecc unrecoverable error\n");
> -	}
> -	return count;
> -}
> -#endif /* CONFIG_MTD_NAND_ECC_BCH */
> -
> -#ifdef CONFIG_MTD_NAND_OMAP_BCH
>  /**
>   * omap_write_page_bch - BCH ecc based write page function for entire page
>   * @mtd:		mtd info structure
> @@ -1660,28 +1622,6 @@ static int is_elm_present(struct omap_nand_info *info,
>  }
>  #endif /* CONFIG_MTD_NAND_ECC_BCH */
>  
> -#ifdef CONFIG_MTD_NAND_ECC_BCH
> -/**
> - * omap3_free_bch - Release BCH ecc resources
> - * @mtd: MTD device structure
> - */
> -static void omap3_free_bch(struct mtd_info *mtd)
> -{
> -	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
> -						   mtd);
> -	if (info->bch) {
> -		free_bch(info->bch);
> -		info->bch = NULL;
> -	}
> -}
> -
> -#else
> -
> -static void omap3_free_bch(struct mtd_info *mtd)
> -{
> -}
> -#endif /* CONFIG_MTD_NAND_ECC_BCH */
> -
>  static int omap_nand_probe(struct platform_device *pdev)
>  {
>  	struct omap_nand_info		*info;
> @@ -1714,13 +1654,13 @@ static int omap_nand_probe(struct platform_device *pdev)
>  	info->pdev		= pdev;
>  	info->gpmc_cs		= pdata->cs;
>  	info->reg		= pdata->reg;
> -	info->bch		= NULL;
>  	info->of_node		= pdata->of_node;
>  	mtd			= &info->mtd;
>  	mtd->priv		= &info->nand;
>  	mtd->name		= dev_name(&pdev->dev);
>  	mtd->owner		= THIS_MODULE;
>  	nand_chip		= &info->nand;
> +	nand_chip->ecc.priv	= NULL;
>  	nand_chip->options	|= NAND_SKIP_BBTSCAN | NAND_BUSWIDTH_AUTO;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> @@ -1910,7 +1850,7 @@ static int omap_nand_probe(struct platform_device *pdev)
>  		nand_chip->ecc.bytes		= 7;
>  		nand_chip->ecc.strength		= 4;
>  		nand_chip->ecc.hwctl		= omap3_enable_hwecc_bch;
> -		nand_chip->ecc.correct		= omap3_correct_data_bch;
> +		info->nand.ecc.correct		= nand_bch_correct_data;
>  		nand_chip->ecc.calculate	= omap3_calculate_ecc_bch4;
>  		/* define ECC layout */
>  		ecclayout->eccbytes		= nand_chip->ecc.bytes *
> @@ -1920,10 +1860,11 @@ static int omap_nand_probe(struct platform_device *pdev)
>  		ecclayout->oobfree->offset	= ecclayout->eccpos[0] +
>  							ecclayout->eccbytes;
>  		/* software bch library is used for locating errors */
> -		info->bch = init_bch(nand_chip->ecc.bytes,
> -					nand_chip->ecc.strength,
> -					OMAP_ECC_BCH8_POLYNOMIAL);
> -		if (!info->bch) {
> +		info->nand.ecc.priv		= nand_bch_init(mtd,
> +							info->nand.ecc.size,
> +							info->nand.ecc.bytes,
> +							&info->nand.ecc.layout);

Are you sure nand_bch_init() is a proper drop-in replacement for the
implementation you had based on init_bch()? It looks to me like they at
least use a differnt polynomial value (0x201b vs. 0). Is this a problem
for backwards compatibility?

> +		if (!info->nand.ecc.priv) {
>  			pr_err("nand: error: unable to use s/w BCH library\n");
>  			err = -EINVAL;
>  		}

[...]

> @@ -1985,10 +1926,11 @@ static int omap_nand_probe(struct platform_device *pdev)
>  		ecclayout->oobfree->offset	= ecclayout->eccpos[0] +
>  							ecclayout->eccbytes;
>  		/* software bch library is used for locating errors */
> -		info->bch = init_bch(nand_chip->ecc.bytes,
> -					nand_chip->ecc.strength,
> -					OMAP_ECC_BCH8_POLYNOMIAL);
> -		if (!info->bch) {
> +		info->nand.ecc.priv		= nand_bch_init(mtd,
> +							info->nand.ecc.size,
> +							info->nand.ecc.bytes,
> +							&info->nand.ecc.layout);

Same questions apply.

> +		if (!info->nand.ecc.priv) {
>  			pr_err("nand: error: unable to use s/w BCH library\n");
>  			err = -EINVAL;
>  			goto out_release_mem_region;

[...]

A related question: do we have any current users of this driver that can
provide testing results for this series? Or is this work just tested
with new hardware?

Brian
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
