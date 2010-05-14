From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 1/2] omap3 nand: cleanup for not to use GPMC virtual
 address
Date: Fri, 14 May 2010 16:58:52 -0700
Message-ID: <20100514235852.GN3428@atomide.com>
References: <s-ghorai@ti.com>
 <1273850591-19040-1-git-send-email-s-ghorai@ti.com>
 <1273850591-19040-2-git-send-email-s-ghorai@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:62054 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755123Ab0ENX65 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 May 2010 19:58:57 -0400
Content-Disposition: inline
In-Reply-To: <1273850591-19040-2-git-send-email-s-ghorai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sukumar Ghorai <s-ghorai@ti.com>
Cc: linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, sakoman@gmail.com, mike@compulab.co.il, Artem.Bityutskiy@nokia.com

Few more comments below.

* Sukumar Ghorai <s-ghorai@ti.com> [100514 08:18]:
> +
> +/**
> + * gmpc_ecc_init - Initialize the HW ECC for NAND flash in GPMC controller
> + * @cs: Chip select number
> + * @ecc_size: bytes for which ECC will be generated
> + */
> +void gpmc_ecc_init(int cs, int ecc_size)
> +{
> +	unsigned int val = 0x0;
> +
> +	/* Read from ECC Control Register */
> +	val = gpmc_read_reg(GPMC_ECC_CONTROL);
> +
> +	/* Clear all ECC | Enable Reg1 */
> +	val = ((0x00000001<<8) | 0x00000001);
> +	gpmc_write_reg(GPMC_ECC_CONTROL, val);
> +
> +	/* Read from ECC Size Config Register */
> +	val = gpmc_read_reg(GPMC_ECC_SIZE_CONFIG);
> +	/* ECCSIZE1=512 | Select eccResultsize[0-3] */
> +	val = ((((ecc_size >> 1) - 1) << 22) | (0x0000000F));
> +	gpmc_write_reg(GPMC_ECC_SIZE_CONFIG, val);
> +}

There should be some locking as only one chipselect can use
the ECC or prefetch engine at a time. If you have NAND in
two chipselects, bad things would happen..

Maybe something like:

int gpmc_ecc_request(int cs);
void gpmc_ecc_free(int cs);
int gpmc_prefetch_request(int cs);
void gpmc_prefetch_free(int cs);

Other than that, looks like a good clean-up so we can easily
add the platform init code for all the board files.

Regards,

Tony
