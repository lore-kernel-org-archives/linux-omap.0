From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH v4 3/4] mtd: nand: omap: add support for BCH16_ECC - NAND
 driver updates
Date: Tue, 20 May 2014 18:36:32 -0700
Message-ID: <20140521013632.GD22233@ld-irv-0074>
References: <1400486082-4345-1-git-send-email-pekon@ti.com>
 <1400486082-4345-4-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:49594 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735AbaEUBgf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 May 2014 21:36:35 -0400
Received: by mail-pd0-f182.google.com with SMTP id r10so861326pdi.27
        for <linux-omap@vger.kernel.org>; Tue, 20 May 2014 18:36:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1400486082-4345-4-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pekon Gupta <pekon@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-mtd <linux-mtd@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Stefan Roese <sr@denx.de>, Felipe Balbi <balbi@ti.com>

On Mon, May 19, 2014 at 01:24:41PM +0530, Pekon Gupta wrote:
> --- a/drivers/mtd/nand/omap2.c
> +++ b/drivers/mtd/nand/omap2.c
> @@ -1201,6 +1219,41 @@ static int __maybe_unused omap_calculate_ecc_bch(struct mtd_info *mtd,
>  			*ecc_code++ = ((bch_val1 >> 4) & 0xFF);
>  			*ecc_code++ = ((bch_val1 & 0xF) << 4);
>  			break;
> +		case OMAP_ECC_BCH16_CODE_HW:
> +			val = readl(gpmc_regs->gpmc_bch_result6[i]);

For all of these 'gpmc_bch_resultX' fields, couldn't you make this into
a 2-D array? So to access BCH result 6 at sector i, it would be:

			val = readl(gpmc_regs->gpmc_bch_result[6][i];

This could help you to rewrite some of this stuff as loops, instead of
giant blocks of copy-paste-modify.

> +			ecc_code[0]  = ((val >>  8) & 0xFF);
> +			ecc_code[1]  = ((val >>  0) & 0xFF);
> +			val = readl(gpmc_regs->gpmc_bch_result5[i]);
> +			ecc_code[2]  = ((val >> 24) & 0xFF);
> +			ecc_code[3]  = ((val >> 16) & 0xFF);
> +			ecc_code[4]  = ((val >>  8) & 0xFF);
> +			ecc_code[5]  = ((val >>  0) & 0xFF);

A lot of this code can be rewritten to use the endian swapping macros, I
expect. Something like this looks equivalent:

			*((uint32_t *)&ecc_code[2]) = cpu_to_be32(val);

You could probably fix the types up to make this look a little nicer.

> +			val = readl(gpmc_regs->gpmc_bch_result4[i]);
> +			ecc_code[6]  = ((val >> 24) & 0xFF);
> +			ecc_code[7]  = ((val >> 16) & 0xFF);
> +			ecc_code[8]  = ((val >>  8) & 0xFF);
> +			ecc_code[9]  = ((val >>  0) & 0xFF);
> +			val = readl(gpmc_regs->gpmc_bch_result3[i]);
> +			ecc_code[10] = ((val >> 24) & 0xFF);
> +			ecc_code[11] = ((val >> 16) & 0xFF);
> +			ecc_code[12] = ((val >>  8) & 0xFF);
> +			ecc_code[13] = ((val >>  0) & 0xFF);
> +			val = readl(gpmc_regs->gpmc_bch_result2[i]);
> +			ecc_code[14] = ((val >> 24) & 0xFF);
> +			ecc_code[15] = ((val >> 16) & 0xFF);
> +			ecc_code[16] = ((val >>  8) & 0xFF);
> +			ecc_code[17] = ((val >>  0) & 0xFF);
> +			val = readl(gpmc_regs->gpmc_bch_result1[i]);
> +			ecc_code[18] = ((val >> 24) & 0xFF);
> +			ecc_code[19] = ((val >> 16) & 0xFF);
> +			ecc_code[20] = ((val >>  8) & 0xFF);
> +			ecc_code[21] = ((val >>  0) & 0xFF);
> +			val = readl(gpmc_regs->gpmc_bch_result0[i]);
> +			ecc_code[22] = ((val >> 24) & 0xFF);
> +			ecc_code[23] = ((val >> 16) & 0xFF);
> +			ecc_code[24] = ((val >>  8) & 0xFF);
> +			ecc_code[25] = ((val >>  0) & 0xFF);
> +			break;
>  		default:
>  			return -EINVAL;
>  		}

Brian
