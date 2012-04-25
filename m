From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] ARM: OMAP3: gpmc: add BCH ecc api and modes
Date: Wed, 25 Apr 2012 10:03:14 -0700
Message-ID: <20120425170313.GW3739@atomide.com>
References: <1334861024-27386-1-git-send-email-ivan.djelic@parrot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:25472 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754374Ab2DYRDS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Apr 2012 13:03:18 -0400
Content-Disposition: inline
In-Reply-To: <1334861024-27386-1-git-send-email-ivan.djelic@parrot.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ivan Djelic <ivan.djelic@parrot.com>
Cc: linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org

Hi,

Few comments below.

* Ivan Djelic <ivan.djelic@parrot.com> [120419 11:49]:
> 
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index 00d5108..e3a91a1 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -49,6 +49,7 @@
>  #define GPMC_ECC_CONTROL	0x1f8
>  #define GPMC_ECC_SIZE_CONFIG	0x1fc
>  #define GPMC_ECC1_RESULT        0x200
> +#define GPMC_ECC_BCH_RESULT_0   0x240

Can you please add a comment here saying something like:

#define GPMC_ECC_BCH_RESULT_0   0x240	/* Not available on omap2 */
  

> @@ -920,3 +921,150 @@ int gpmc_calculate_ecc(int cs, const u_char *dat, u_char *ecc_code)
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(gpmc_calculate_ecc);
> +
> +#ifdef CONFIG_ARCH_OMAP3
> +
> +/**
> + * gpmc_enable_hwecc_bch - enable hardware BCH ecc functionality
> + * @cs: chip select number
> + * @mode: read/write mode
> + * @dev_width: device bus width(1 for x16, 0 for x8)
> + * @nsectors: how many 512-byte sectors to process
> + * @nerrors: how many errors to correct per sector (4 or 8)
> + */
> +int gpmc_enable_hwecc_bch(int cs, int mode, int dev_width, int nsectors,
> +			  int nerrors)
> +{
> +	unsigned int val;
> +
> +	/* check if ecc module is in use */
> +	if (gpmc_ecc_used != -EINVAL)
> +		return -EINVAL;
> +	/*
> +	 * FIXME: some OMAP3 revisions have a hardware bug which prevents
> +	 * the 4-bit BCH mode from working properly. Such revisions could be
> +	 * detected and rejected here.
> +	 */

This should then be disabled to avoid corruption. Maybe only allow it
initially on omaps that have been tested? And for omap2 it should return
error  for sure.

Or do you know the broken omap3 versions?

Also, should you first request this feature in case multiple drivers
need to share it?

Other than that, looks good to me.

Regards,

Tony
