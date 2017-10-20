From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v2] mtd: nand: omap2: Fix subpage write
Date: Fri, 20 Oct 2017 13:25:03 +0200
Message-ID: <20171020132503.229b821b@bbrezillon>
References: <1508402489-7436-1-git-send-email-rogerq@ti.com>
        <76f4dd14-7cc8-4990-23e6-4caa1fee71df@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <76f4dd14-7cc8-4990-23e6-4caa1fee71df@ti.com>
Sender: stable-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: richard@nod.at, tony@atomide.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, "# v4 . 12+" <stable@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Fri, 20 Oct 2017 12:59:31 +0300
Roger Quadros <rogerq@ti.com> wrote:

> Since v4.12, NAND subpage writes were causing a NULL pointer
> dereference on OMAP platforms (omap2-nand) using OMAP_ECC_BCH4_CODE_HW,
> OMAP_ECC_BCH8_CODE_HW and OMAP_ECC_BCH16_CODE_HW.
> 
> This is because for those ECC modes, omap_calculate_ecc_bch()
> generates ECC bytes for the entire (multi-sector) page and this can
> overflow the ECC buffer provided by nand_write_subpage_hwecc()
> as it expects ecc.calculate() to return ECC bytes for just one sector.
> 
> However, the root cause of the problem is present much before
> v4.12 but was not seen then as NAND buffers were being allocated
> as one big chunck prior to
> commit 3deb9979c731 ("mtd: nand: allocate aligned buffers if NAND_OWN_BUFFERS is unset")
> 
> Fix the issue by providing a OMAP optimized write_subpage() implementation.
> 

Fixes: xxxx ("yyyy")

xxx being the commit that introduced the omap_calculate_ecc_bch() and
assign chip->ecc.calculate to it.

> cc: <stable@vger.kernel.org> # v4.12+

Shouldn't we try to backport the patch to pre-4.12 versions? I mean,
the buffer overflow exist there as well, and we don't know what it
corrupts exactly, but it's potentially harmful.

> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
> Changelog:
> v2
> - set ecc.calculate() to NULL for BCH4/8/16 with HW correction as in this
> mode we don't support/need single sector ECC calculations to be used by NAND core.
> - call omap_calculate_ecc_bch_multi() directly from omap_read/write_page_bch().
> 
>  drivers/mtd/nand/omap2.c | 338 +++++++++++++++++++++++++++++++----------------
>  1 file changed, 225 insertions(+), 113 deletions(-)
> 
> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> index 54540c8..a0bd456 100644
> --- a/drivers/mtd/nand/omap2.c
> +++ b/drivers/mtd/nand/omap2.c
> @@ -1133,129 +1133,172 @@ static u8  bch8_polynomial[] = {0xef, 0x51, 0x2e, 0x09, 0xed, 0x93, 0x9a, 0xc2,
>  				0x97, 0x79, 0xe5, 0x24, 0xb5};
>  
>  /**
> - * omap_calculate_ecc_bch - Generate bytes of ECC bytes
> + * _omap_calculate_ecc_bch - Generate ECC bytes for one sector
>   * @mtd:	MTD device structure
>   * @dat:	The pointer to data on which ecc is computed
>   * @ecc_code:	The ecc_code buffer
> + * @i:		The sector number (for a multi sector page)
>   *
> - * Support calculating of BCH4/8 ecc vectors for the page
> + * Support calculating of BCH4/8/16 ECC vectors for one sector
> + * within a page. Sector number is in @i.
>   */
> -static int __maybe_unused omap_calculate_ecc_bch(struct mtd_info *mtd,
> -					const u_char *dat, u_char *ecc_calc)
> +static int _omap_calculate_ecc_bch(struct mtd_info *mtd,
> +				   const u_char *dat, u_char *ecc_calc, int i)
>  {
>  	struct omap_nand_info *info = mtd_to_omap(mtd);
>  	int eccbytes	= info->nand.ecc.bytes;
>  	struct gpmc_nand_regs	*gpmc_regs = &info->reg;
>  	u8 *ecc_code;
> -	unsigned long nsectors, bch_val1, bch_val2, bch_val3, bch_val4;
> +	unsigned long bch_val1, bch_val2, bch_val3, bch_val4;
>  	u32 val;
> -	int i, j;
> +	int j;
> +
> +	ecc_code = ecc_calc;
> +	switch (info->ecc_opt) {
> +	case OMAP_ECC_BCH8_CODE_HW_DETECTION_SW:
> +	case OMAP_ECC_BCH8_CODE_HW:
> +		bch_val1 = readl(gpmc_regs->gpmc_bch_result0[i]);
> +		bch_val2 = readl(gpmc_regs->gpmc_bch_result1[i]);
> +		bch_val3 = readl(gpmc_regs->gpmc_bch_result2[i]);
> +		bch_val4 = readl(gpmc_regs->gpmc_bch_result3[i]);
> +		*ecc_code++ = (bch_val4 & 0xFF);
> +		*ecc_code++ = ((bch_val3 >> 24) & 0xFF);
> +		*ecc_code++ = ((bch_val3 >> 16) & 0xFF);
> +		*ecc_code++ = ((bch_val3 >> 8) & 0xFF);
> +		*ecc_code++ = (bch_val3 & 0xFF);
> +		*ecc_code++ = ((bch_val2 >> 24) & 0xFF);
> +		*ecc_code++ = ((bch_val2 >> 16) & 0xFF);
> +		*ecc_code++ = ((bch_val2 >> 8) & 0xFF);
> +		*ecc_code++ = (bch_val2 & 0xFF);
> +		*ecc_code++ = ((bch_val1 >> 24) & 0xFF);
> +		*ecc_code++ = ((bch_val1 >> 16) & 0xFF);
> +		*ecc_code++ = ((bch_val1 >> 8) & 0xFF);
> +		*ecc_code++ = (bch_val1 & 0xFF);
> +		break;
> +	case OMAP_ECC_BCH4_CODE_HW_DETECTION_SW:
> +	case OMAP_ECC_BCH4_CODE_HW:
> +		bch_val1 = readl(gpmc_regs->gpmc_bch_result0[i]);
> +		bch_val2 = readl(gpmc_regs->gpmc_bch_result1[i]);
> +		*ecc_code++ = ((bch_val2 >> 12) & 0xFF);
> +		*ecc_code++ = ((bch_val2 >> 4) & 0xFF);
> +		*ecc_code++ = ((bch_val2 & 0xF) << 4) |
> +			((bch_val1 >> 28) & 0xF);
> +		*ecc_code++ = ((bch_val1 >> 20) & 0xFF);
> +		*ecc_code++ = ((bch_val1 >> 12) & 0xFF);
> +		*ecc_code++ = ((bch_val1 >> 4) & 0xFF);
> +		*ecc_code++ = ((bch_val1 & 0xF) << 4);
> +		break;
> +	case OMAP_ECC_BCH16_CODE_HW:
> +		val = readl(gpmc_regs->gpmc_bch_result6[i]);
> +		ecc_code[0]  = ((val >>  8) & 0xFF);
> +		ecc_code[1]  = ((val >>  0) & 0xFF);
> +		val = readl(gpmc_regs->gpmc_bch_result5[i]);
> +		ecc_code[2]  = ((val >> 24) & 0xFF);
> +		ecc_code[3]  = ((val >> 16) & 0xFF);
> +		ecc_code[4]  = ((val >>  8) & 0xFF);
> +		ecc_code[5]  = ((val >>  0) & 0xFF);
> +		val = readl(gpmc_regs->gpmc_bch_result4[i]);
> +		ecc_code[6]  = ((val >> 24) & 0xFF);
> +		ecc_code[7]  = ((val >> 16) & 0xFF);
> +		ecc_code[8]  = ((val >>  8) & 0xFF);
> +		ecc_code[9]  = ((val >>  0) & 0xFF);
> +		val = readl(gpmc_regs->gpmc_bch_result3[i]);
> +		ecc_code[10] = ((val >> 24) & 0xFF);
> +		ecc_code[11] = ((val >> 16) & 0xFF);
> +		ecc_code[12] = ((val >>  8) & 0xFF);
> +		ecc_code[13] = ((val >>  0) & 0xFF);
> +		val = readl(gpmc_regs->gpmc_bch_result2[i]);
> +		ecc_code[14] = ((val >> 24) & 0xFF);
> +		ecc_code[15] = ((val >> 16) & 0xFF);
> +		ecc_code[16] = ((val >>  8) & 0xFF);
> +		ecc_code[17] = ((val >>  0) & 0xFF);
> +		val = readl(gpmc_regs->gpmc_bch_result1[i]);
> +		ecc_code[18] = ((val >> 24) & 0xFF);
> +		ecc_code[19] = ((val >> 16) & 0xFF);
> +		ecc_code[20] = ((val >>  8) & 0xFF);
> +		ecc_code[21] = ((val >>  0) & 0xFF);
> +		val = readl(gpmc_regs->gpmc_bch_result0[i]);
> +		ecc_code[22] = ((val >> 24) & 0xFF);
> +		ecc_code[23] = ((val >> 16) & 0xFF);
> +		ecc_code[24] = ((val >>  8) & 0xFF);
> +		ecc_code[25] = ((val >>  0) & 0xFF);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	/* ECC scheme specific syndrome customizations */
> +	switch (info->ecc_opt) {
> +	case OMAP_ECC_BCH4_CODE_HW_DETECTION_SW:
> +		/* Add constant polynomial to remainder, so that
> +		 * ECC of blank pages results in 0x0 on reading back
> +		 */
> +		for (j = 0; j < eccbytes; j++)
> +			ecc_calc[j] ^= bch4_polynomial[j];
> +		break;
> +	case OMAP_ECC_BCH4_CODE_HW:
> +		/* Set  8th ECC byte as 0x0 for ROM compatibility */
> +		ecc_calc[eccbytes - 1] = 0x0;
> +		break;
> +	case OMAP_ECC_BCH8_CODE_HW_DETECTION_SW:
> +		/* Add constant polynomial to remainder, so that
> +		 * ECC of blank pages results in 0x0 on reading back
> +		 */
> +		for (j = 0; j < eccbytes; j++)
> +			ecc_calc[j] ^= bch8_polynomial[j];
> +		break;
> +	case OMAP_ECC_BCH8_CODE_HW:
> +		/* Set 14th ECC byte as 0x0 for ROM compatibility */
> +		ecc_calc[eccbytes - 1] = 0x0;
> +		break;
> +	case OMAP_ECC_BCH16_CODE_HW:
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * omap_calculate_ecc_bch_sw - ECC generator for sector for SW based correction
> + * @mtd:	MTD device structure
> + * @dat:	The pointer to data on which ecc is computed
> + * @ecc_code:	The ecc_code buffer
> + *
> + * Support calculating of BCH4/8/16 ECC vectors for one sector. This is used
> + * when SW based correction is required as ECC is required for one sector
> + * at a time.
> + */
> +static int omap_calculate_ecc_bch_sw(struct mtd_info *mtd,
> +				     const u_char *dat, u_char *ecc_calc)
> +{
> +	return _omap_calculate_ecc_bch(mtd, dat, ecc_calc, 0);
> +}
> +
> +/**
> + * omap_calculate_ecc_bch_multi - Generate ECC for multiple sectors
> + * @mtd:	MTD device structure
> + * @dat:	The pointer to data on which ecc is computed
> + * @ecc_code:	The ecc_code buffer
> + *
> + * Support calculating of BCH4/8/16 ecc vectors for the entire page in one go.
> + */
> +static int omap_calculate_ecc_bch_multi(struct mtd_info *mtd,
> +					const u_char *dat, u_char *ecc_calc)
> +{
> +	struct omap_nand_info *info = mtd_to_omap(mtd);
> +	int eccbytes = info->nand.ecc.bytes;
> +	unsigned long nsectors;
> +	int i, ret;
>  
>  	nsectors = ((readl(info->reg.gpmc_ecc_config) >> 4) & 0x7) + 1;
>  	for (i = 0; i < nsectors; i++) {
> -		ecc_code = ecc_calc;
> -		switch (info->ecc_opt) {
> -		case OMAP_ECC_BCH8_CODE_HW_DETECTION_SW:
> -		case OMAP_ECC_BCH8_CODE_HW:
> -			bch_val1 = readl(gpmc_regs->gpmc_bch_result0[i]);
> -			bch_val2 = readl(gpmc_regs->gpmc_bch_result1[i]);
> -			bch_val3 = readl(gpmc_regs->gpmc_bch_result2[i]);
> -			bch_val4 = readl(gpmc_regs->gpmc_bch_result3[i]);
> -			*ecc_code++ = (bch_val4 & 0xFF);
> -			*ecc_code++ = ((bch_val3 >> 24) & 0xFF);
> -			*ecc_code++ = ((bch_val3 >> 16) & 0xFF);
> -			*ecc_code++ = ((bch_val3 >> 8) & 0xFF);
> -			*ecc_code++ = (bch_val3 & 0xFF);
> -			*ecc_code++ = ((bch_val2 >> 24) & 0xFF);
> -			*ecc_code++ = ((bch_val2 >> 16) & 0xFF);
> -			*ecc_code++ = ((bch_val2 >> 8) & 0xFF);
> -			*ecc_code++ = (bch_val2 & 0xFF);
> -			*ecc_code++ = ((bch_val1 >> 24) & 0xFF);
> -			*ecc_code++ = ((bch_val1 >> 16) & 0xFF);
> -			*ecc_code++ = ((bch_val1 >> 8) & 0xFF);
> -			*ecc_code++ = (bch_val1 & 0xFF);
> -			break;
> -		case OMAP_ECC_BCH4_CODE_HW_DETECTION_SW:
> -		case OMAP_ECC_BCH4_CODE_HW:
> -			bch_val1 = readl(gpmc_regs->gpmc_bch_result0[i]);
> -			bch_val2 = readl(gpmc_regs->gpmc_bch_result1[i]);
> -			*ecc_code++ = ((bch_val2 >> 12) & 0xFF);
> -			*ecc_code++ = ((bch_val2 >> 4) & 0xFF);
> -			*ecc_code++ = ((bch_val2 & 0xF) << 4) |
> -				((bch_val1 >> 28) & 0xF);
> -			*ecc_code++ = ((bch_val1 >> 20) & 0xFF);
> -			*ecc_code++ = ((bch_val1 >> 12) & 0xFF);
> -			*ecc_code++ = ((bch_val1 >> 4) & 0xFF);
> -			*ecc_code++ = ((bch_val1 & 0xF) << 4);
> -			break;
> -		case OMAP_ECC_BCH16_CODE_HW:
> -			val = readl(gpmc_regs->gpmc_bch_result6[i]);
> -			ecc_code[0]  = ((val >>  8) & 0xFF);
> -			ecc_code[1]  = ((val >>  0) & 0xFF);
> -			val = readl(gpmc_regs->gpmc_bch_result5[i]);
> -			ecc_code[2]  = ((val >> 24) & 0xFF);
> -			ecc_code[3]  = ((val >> 16) & 0xFF);
> -			ecc_code[4]  = ((val >>  8) & 0xFF);
> -			ecc_code[5]  = ((val >>  0) & 0xFF);
> -			val = readl(gpmc_regs->gpmc_bch_result4[i]);
> -			ecc_code[6]  = ((val >> 24) & 0xFF);
> -			ecc_code[7]  = ((val >> 16) & 0xFF);
> -			ecc_code[8]  = ((val >>  8) & 0xFF);
> -			ecc_code[9]  = ((val >>  0) & 0xFF);
> -			val = readl(gpmc_regs->gpmc_bch_result3[i]);
> -			ecc_code[10] = ((val >> 24) & 0xFF);
> -			ecc_code[11] = ((val >> 16) & 0xFF);
> -			ecc_code[12] = ((val >>  8) & 0xFF);
> -			ecc_code[13] = ((val >>  0) & 0xFF);
> -			val = readl(gpmc_regs->gpmc_bch_result2[i]);
> -			ecc_code[14] = ((val >> 24) & 0xFF);
> -			ecc_code[15] = ((val >> 16) & 0xFF);
> -			ecc_code[16] = ((val >>  8) & 0xFF);
> -			ecc_code[17] = ((val >>  0) & 0xFF);
> -			val = readl(gpmc_regs->gpmc_bch_result1[i]);
> -			ecc_code[18] = ((val >> 24) & 0xFF);
> -			ecc_code[19] = ((val >> 16) & 0xFF);
> -			ecc_code[20] = ((val >>  8) & 0xFF);
> -			ecc_code[21] = ((val >>  0) & 0xFF);
> -			val = readl(gpmc_regs->gpmc_bch_result0[i]);
> -			ecc_code[22] = ((val >> 24) & 0xFF);
> -			ecc_code[23] = ((val >> 16) & 0xFF);
> -			ecc_code[24] = ((val >>  8) & 0xFF);
> -			ecc_code[25] = ((val >>  0) & 0xFF);
> -			break;
> -		default:
> -			return -EINVAL;
> -		}
> -
> -		/* ECC scheme specific syndrome customizations */
> -		switch (info->ecc_opt) {
> -		case OMAP_ECC_BCH4_CODE_HW_DETECTION_SW:
> -			/* Add constant polynomial to remainder, so that
> -			 * ECC of blank pages results in 0x0 on reading back */
> -			for (j = 0; j < eccbytes; j++)
> -				ecc_calc[j] ^= bch4_polynomial[j];
> -			break;
> -		case OMAP_ECC_BCH4_CODE_HW:
> -			/* Set  8th ECC byte as 0x0 for ROM compatibility */
> -			ecc_calc[eccbytes - 1] = 0x0;
> -			break;
> -		case OMAP_ECC_BCH8_CODE_HW_DETECTION_SW:
> -			/* Add constant polynomial to remainder, so that
> -			 * ECC of blank pages results in 0x0 on reading back */
> -			for (j = 0; j < eccbytes; j++)
> -				ecc_calc[j] ^= bch8_polynomial[j];
> -			break;
> -		case OMAP_ECC_BCH8_CODE_HW:
> -			/* Set 14th ECC byte as 0x0 for ROM compatibility */
> -			ecc_calc[eccbytes - 1] = 0x0;
> -			break;
> -		case OMAP_ECC_BCH16_CODE_HW:
> -			break;
> -		default:
> -			return -EINVAL;
> -		}
> +		ret = _omap_calculate_ecc_bch(mtd, dat, ecc_calc, i);
> +		if (ret)
> +			return ret;
>  
> -	ecc_calc += eccbytes;
> +		ecc_calc += eccbytes;
>  	}
>  
>  	return 0;
> @@ -1509,6 +1552,72 @@ static int omap_write_page_bch(struct mtd_info *mtd, struct nand_chip *chip,
>  }
>  
>  /**
> + * omap_write_subpage_bch - BCH hardware ECC based subpage write
> + * @mtd:	mtd info structure
> + * @chip:	nand chip info structure
> + * @offset:	column address of subpage within the page
> + * @data_len:	data length
> + * @buf:	data buffer
> + * @oob_required: must write chip->oob_poi to OOB
> + * @page: page number to write
> + *
> + * OMAP optimized subpage write method.
> + */
> +static int omap_write_subpage_bch(struct mtd_info *mtd,
> +				  struct nand_chip *chip, u32 offset,
> +				  u32 data_len, const u8 *buf,
> +				  int oob_required, int page)
> +{
> +	u8 *ecc_calc = chip->buffers->ecccalc;
> +	int ecc_size      = chip->ecc.size;
> +	int ecc_bytes     = chip->ecc.bytes;
> +	int ecc_steps     = chip->ecc.steps;
> +	u32 start_step = offset / ecc_size;
> +	u32 end_step   = (offset + data_len - 1) / ecc_size;
> +	int step, ret = 0;
> +
> +	/*
> +	 * Write entire page at one go as it would be optimal
> +	 * as ECC is calculated by hardware.
> +	 * ECC is calculated for all subpages but we choose
> +	 * only what we want.
> +	 */
> +
> +	/* Enable GPMC ECC engine */
> +	chip->ecc.hwctl(mtd, NAND_ECC_WRITE);
> +
> +	/* Write data */
> +	chip->write_buf(mtd, buf, mtd->writesize);
> +
> +	for (step = 0; step < ecc_steps; step++) {
> +		/* mask ECC of un-touched subpages by padding 0xFF */
> +		if (step < start_step || step > end_step)
> +			memset(ecc_calc, 0xff, ecc_bytes);
> +		else
> +			ret = _omap_calculate_ecc_bch(mtd, buf, ecc_calc, step);
> +
> +		if (ret)
> +			return ret;
> +
> +		buf += ecc_size;
> +		ecc_calc += ecc_bytes;
> +	}
> +
> +	/* copy calculated ECC for whole page to chip->buffer->oob */
> +	/* this include masked-value(0xFF) for unwritten subpages */
> +	ecc_calc = chip->buffers->ecccalc;
> +	ret = mtd_ooblayout_set_eccbytes(mtd, ecc_calc, chip->oob_poi, 0,
> +					 chip->ecc.total);
> +	if (ret)
> +		return ret;
> +
> +	/* write OOB buffer to NAND device */
> +	chip->write_buf(mtd, chip->oob_poi, mtd->oobsize);
> +
> +	return 0;
> +}
> +
> +/**
>   * omap_read_page_bch - BCH ecc based page read function for entire page
>   * @mtd:		mtd info structure
>   * @chip:		nand chip info structure
> @@ -2044,7 +2153,7 @@ static int omap_nand_probe(struct platform_device *pdev)
>  		nand_chip->ecc.strength		= 4;
>  		nand_chip->ecc.hwctl		= omap_enable_hwecc_bch;
>  		nand_chip->ecc.correct		= nand_bch_correct_data;
> -		nand_chip->ecc.calculate	= omap_calculate_ecc_bch;
> +		nand_chip->ecc.calculate	= omap_calculate_ecc_bch_sw;
>  		mtd_set_ooblayout(mtd, &omap_sw_ooblayout_ops);
>  		/* Reserve one byte for the OMAP marker */
>  		oobbytes_per_step		= nand_chip->ecc.bytes + 1;
> @@ -2066,9 +2175,10 @@ static int omap_nand_probe(struct platform_device *pdev)
>  		nand_chip->ecc.strength		= 4;
>  		nand_chip->ecc.hwctl		= omap_enable_hwecc_bch;
>  		nand_chip->ecc.correct		= omap_elm_correct_data;
> -		nand_chip->ecc.calculate	= omap_calculate_ecc_bch;
> +		nand_chip->ecc.calculate	= omap_calculate_ecc_bch_multi;

It's still wrong. Didn't you say you would leave ecc->calculate
unassigned in this case?

>  		nand_chip->ecc.read_page	= omap_read_page_bch;
>  		nand_chip->ecc.write_page	= omap_write_page_bch;
> +		nand_chip->ecc.write_subpage	= omap_write_subpage_bch;
>  		mtd_set_ooblayout(mtd, &omap_ooblayout_ops);
>  		oobbytes_per_step		= nand_chip->ecc.bytes;
>  
> @@ -2087,7 +2197,7 @@ static int omap_nand_probe(struct platform_device *pdev)
>  		nand_chip->ecc.strength		= 8;
>  		nand_chip->ecc.hwctl		= omap_enable_hwecc_bch;
>  		nand_chip->ecc.correct		= nand_bch_correct_data;
> -		nand_chip->ecc.calculate	= omap_calculate_ecc_bch;
> +		nand_chip->ecc.calculate	= omap_calculate_ecc_bch_sw;
>  		mtd_set_ooblayout(mtd, &omap_sw_ooblayout_ops);
>  		/* Reserve one byte for the OMAP marker */
>  		oobbytes_per_step		= nand_chip->ecc.bytes + 1;
> @@ -2109,9 +2219,10 @@ static int omap_nand_probe(struct platform_device *pdev)
>  		nand_chip->ecc.strength		= 8;
>  		nand_chip->ecc.hwctl		= omap_enable_hwecc_bch;
>  		nand_chip->ecc.correct		= omap_elm_correct_data;
> -		nand_chip->ecc.calculate	= omap_calculate_ecc_bch;
> +		nand_chip->ecc.calculate	= omap_calculate_ecc_bch_multi;
>  		nand_chip->ecc.read_page	= omap_read_page_bch;
>  		nand_chip->ecc.write_page	= omap_write_page_bch;
> +		nand_chip->ecc.write_subpage	= omap_write_subpage_bch;
>  		mtd_set_ooblayout(mtd, &omap_ooblayout_ops);
>  		oobbytes_per_step		= nand_chip->ecc.bytes;
>  
> @@ -2131,9 +2242,10 @@ static int omap_nand_probe(struct platform_device *pdev)
>  		nand_chip->ecc.strength		= 16;
>  		nand_chip->ecc.hwctl		= omap_enable_hwecc_bch;
>  		nand_chip->ecc.correct		= omap_elm_correct_data;
> -		nand_chip->ecc.calculate	= omap_calculate_ecc_bch;
> +		nand_chip->ecc.calculate	= omap_calculate_ecc_bch_multi;
>  		nand_chip->ecc.read_page	= omap_read_page_bch;
>  		nand_chip->ecc.write_page	= omap_write_page_bch;
> +		nand_chip->ecc.write_subpage	= omap_write_subpage_bch;
>  		mtd_set_ooblayout(mtd, &omap_ooblayout_ops);
>  		oobbytes_per_step		= nand_chip->ecc.bytes;
>  
