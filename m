From: pekon <pekon@pek-sem.com>
Subject: Re: [PATCH 2/3] nand: omap2: Remove horrible ifdefs to fix module
 probe
Date: Sun, 07 Sep 2014 02:40:52 +0530
Message-ID: <540B785C.3070400@pek-sem.com>
References: <1410033389-32357-1-git-send-email-ezequiel@vanguardiasur.com.ar> <1410033389-32357-3-git-send-email-ezequiel@vanguardiasur.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from us2.outbound.mailhostbox.com ([162.210.70.57]:47456 "EHLO
	us2.outbound.mailhostbox.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751496AbaIFVLK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 6 Sep 2014 17:11:10 -0400
In-Reply-To: <1410033389-32357-3-git-send-email-ezequiel@vanguardiasur.com.ar>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, Roger Quadros <rogerq@ti.com>
Cc: Brian Norris <computersforpeace@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-mtd@lists.infradead.org, =?ISO-8859-1?Q?Guido_Mart=EDnez?= <guido@vanguardiasur.com.ar>, linux-omap <linux-omap@vger.kernel.org>

+ linux-omap, as this patch touches arch/arm/mach-omap2/gpmc.c

Hi Ezequiel,

On Sunday 07 September 2014 01:26 AM, Ezequiel Garcia wrote:
> The current code abuses ifdefs to determine if the selected ECC scheme
> is supported by the running kernel. As a result the code is hard to read,
> and it also fails to load as a module.
>
> This commit removes all the ifdefs and instead introduces a function
> omap2_nand_ecc_check() to check if the ECC is supported by using
> IS_ENABLED(CONFIG_xxx).
>
Yup, true.
Thanks for cleaning up OMAP2 NAND driver, but few feedbacks.

Just for record, current version of omap2.c NAND driver has so
many #ifdef because:

(1) Many ECC schemes like HAM1 and BCH4_xx, BCH8_SW are supported
only for compatibility with old platforms like OMAP3. And these legacy
schemes have significant amount of code and data foot-print
(as compared to whole driver), so it does not make sense to keep
driver bulky for all new platforms which do not use legacy ECC schemes.

(2) Specifically, BCH4_SW and BCH8_SW ECC schemes used software library
/lib/bch.c "directly". Due to which if BCH4_SW or BCH8_SW was include
in code, /lib/bch.c was included implicitly.

Later from following following commit nand_bch.c wrapper was used which
took care to exclude /lib/bch.c when CONFIG_MTD_NAND_ECC_BCH was not
defined, but #ifdef continued :-( (My bad, I accept ..)

	commit 32d42a855a6f1445373f3d680e9125344aca294c
	mtd: nand: omap: use drivers/mtd/nand/nand_bch.c wrapper for BCH ECC 
instead of lib/bch.c


> Since IS_ENABLED() is true when a config is =y or =m, this change fixes the
> module so it can be loaded with no issues.
>
> Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> ---
>   drivers/mtd/nand/omap2.c          | 134 +++++++++++++++++++++-----------------
>   include/linux/platform_data/elm.h |  14 ++++
>   2 files changed, 87 insertions(+), 61 deletions(-)

[...]

> @@ -1593,33 +1590,71 @@ static int omap_read_page_bch(struct mtd_info *mtd, struct nand_chip *chip,
>   /**
>    * is_elm_present - checks for presence of ELM module by scanning DT nodes
>    * @omap_nand_info: NAND device structure containing platform data
> - * @bch_type: 0x0=BCH4, 0x1=BCH8, 0x2=BCH16
>    */
> -static int is_elm_present(struct omap_nand_info *info,
> -			struct device_node *elm_node, enum bch_ecc bch_type)
> +static bool is_elm_present(struct omap_nand_info *info,
> +			   struct device_node *elm_node)
>   {
>   	struct platform_device *pdev;
> -	struct nand_ecc_ctrl *ecc = &info->nand.ecc;
> -	int err;
> +
>   	/* check whether elm-id is passed via DT */
>   	if (!elm_node) {
> -		pr_err("nand: error: ELM DT node not found\n");
> -		return -ENODEV;
> +		dev_err(&info->pdev->dev, "ELM devicetree node not found\n");
> +		return false;
>   	}
>   	pdev = of_find_device_by_node(elm_node);
>   	/* check whether ELM device is registered */
>   	if (!pdev) {
> -		pr_err("nand: error: ELM device not found\n");
> -		return -ENODEV;
> +		dev_err(&info->pdev->dev, "ELM device not found\n");
> +		return false;
>   	}

Thanks, for this clean-up of replacing pr_err() to dev_err().
Just that if you can resend this as separate patch then I'll surely Ack it.

[...]

> +static bool omap2_nand_ecc_check(struct omap_nand_info *info,
> +				 struct omap_nand_platform_data	*pdata)
> +{
> +	bool ecc_needs_bch, ecc_needs_omap_bch, ecc_needs_elm;
> +
> +	switch (info->ecc_opt) {
> +	case OMAP_ECC_BCH4_CODE_HW_DETECTION_SW:
> +	case OMAP_ECC_BCH8_CODE_HW_DETECTION_SW:
> +		ecc_needs_omap_bch = false;
> +		ecc_needs_bch = true;
> +		ecc_needs_elm = false;
> +		break;
> +	case OMAP_ECC_BCH4_CODE_HW:
> +	case OMAP_ECC_BCH8_CODE_HW:
> +	case OMAP_ECC_BCH16_CODE_HW:
> +		ecc_needs_omap_bch = true;
> +		ecc_needs_bch = false;
> +		ecc_needs_elm = true;
> +		break;
> +	default:
> +		ecc_needs_omap_bch = false;
> +		ecc_needs_bch = false;
> +		ecc_needs_elm = false;
> +		break;
> +	}
> +
> +	if (ecc_needs_bch && !IS_ENABLED(CONFIG_MTD_NAND_ECC_BCH)) {
> +		dev_err(&info->pdev->dev,
> +			"CONFIG_MTD_NAND_ECC_BCH not enabled\n");
> +		return false;
> +	}
> +	if (ecc_needs_omap_bch && !IS_ENABLED(CONFIG_MTD_NAND_OMAP_BCH)) {
> +		dev_err(&info->pdev->dev,
> +			"CONFIG_MTD_NAND_OMAP_BCH not enabled\n");
> +		return false;
> +	}
> +	if (ecc_needs_elm && !is_elm_present(info, pdata->elm_of_node)) {
> +		dev_err(&info->pdev->dev, "ELM not available\n");
> +		return false;
> +	}
> +
> +	return true;
>   }

Actually this new function is not required.
We already have this check in GPMC driver when we select the ecc-scheme.
Plz refer: File: /arch/arm/mach-omap2/gpmc.c
	@@ static int gpmc_probe_nand_child(...)
	...
	/* select ecc-scheme for NAND */

is_elm_enabled() is a misnomer here. It actually does not check
for ELM DTS node, because that check is already done in GPMC driver.
It rather checks if ELM device is correctly binded and driver
"initialized" before NAND driver is probed.

Though ELM is not required during NAND probe because there is no error
checking/correction required during NAND probe, but this again comes
from the history of maintaining back-ward compatibility with board-file
(non DTS) approach. Once we move to all DTS approach may be this can be
removed (but on case-by case basis).

[...]

> diff --git a/include/linux/platform_data/elm.h b/include/linux/platform_data/elm.h
> index 780d1e9..25d1bca 100644
> --- a/include/linux/platform_data/elm.h
> +++ b/include/linux/platform_data/elm.h
> @@ -42,8 +42,22 @@ struct elm_errorvec {
>   	int error_loc[16];
>   };
>
> +#if IS_ENABLED(CONFIG_MTD_NAND_OMAP_BCH)
>   void elm_decode_bch_error_page(struct device *dev, u8 *ecc_calc,
>   		struct elm_errorvec *err_vec);
>   int elm_config(struct device *dev, enum bch_ecc bch_type,
>   	int ecc_steps, int ecc_step_size, int ecc_syndrome_size);
> +#else
> +void elm_decode_bch_error_page(struct device *dev, u8 *ecc_calc,
> +		struct elm_errorvec *err_vec)
> +{
> +}
> +
> +int elm_config(struct device *dev, enum bch_ecc bch_type,
> +	int ecc_steps, int ecc_step_size, int ecc_syndrome_size)
> +{
> +	return -ENOSYS;
> +}
> +#endif /* CONFIG_MTD_NAND_ECC_BCH */
> +
>   #endif /* __ELM_H */
>
If I'm not wrong, this is all you need in this patch
empty functions for CONFIG_MTD_NAND_ECC_BCH exposed symbols are already
handled in /include/linux/mtd/nand_bch.h

So, after this change, you can most of #ifdefs and IS_ENABLED()
and this patch should be simplified.


with regards, pekon

------------------------
Powered by BigRock.com

