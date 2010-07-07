From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 1/3] omap3 gpmc: functionality enhancement
Date: Wed, 7 Jul 2010 13:18:41 +0300
Message-ID: <20100707101840.GF1920@atomide.com>
References: <s-ghorai@ti.com>
 <1275637205-489-1-git-send-email-s-ghorai@ti.com>
 <1275637205-489-2-git-send-email-s-ghorai@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53943 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752766Ab0GGKSx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jul 2010 06:18:53 -0400
Content-Disposition: inline
In-Reply-To: <1275637205-489-2-git-send-email-s-ghorai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sukumar Ghorai <s-ghorai@ti.com>
Cc: linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, mike@compulab.co.il

* Sukumar Ghorai <s-ghorai@ti.com> [100604 10:34]:
> few functions added in gpmc module and to be used by other drivers like NAND.
> E.g.: - ioctl function
>       - ecc functions

Uhh, let's leave out ioctl from the description.. Otherwise people
think you're adding new ioctls in this patch.
 
> @@ -46,8 +46,9 @@
>  #define GPMC_ECC_CONFIG		0x1f4
>  #define GPMC_ECC_CONTROL	0x1f8
>  #define GPMC_ECC_SIZE_CONFIG	0x1fc
> +#define GPMC_ECC1_RESULT        0x200
>  
> -#define GPMC_CS0		0x60
> +#define GPMC_CS0_BASE		0x60
>  #define GPMC_CS_SIZE		0x30
>  
>  #define GPMC_MEM_START		0x00000000

Why changing GPMC_CS0 to GPMC_CS0_BASE? Should it rather be
GPMC_CS0_OFFSET?

> @@ -419,8 +437,100 @@ void gpmc_cs_free(int cs)
>  EXPORT_SYMBOL(gpmc_cs_free);
>  
>  /**
> + * gpmc_hwcontrol - hardware specific access (read/ write) control
> + * @cs: chip select number
> + * @cmd: command type
> + * @write: 1 for write; 0 for read
> + * @wval: value to write
> + * @rval: read pointer
> + */
> +int gpmc_hwcontrol(int cs, int cmd, int write, int wval, int *rval)
> +{
> +	u32 regval = 0;
> +
> +	if (!write && !rval)
> +		return -EINVAL;

You pass int write, then return immediately if it's not set?

> +	switch (cmd) {
> +	case GPMC_STATUS_BUFFER:
> +		regval = gpmc_read_reg(GPMC_STATUS);
> +		/* 1 : buffer is available to write */
> +		*rval = regval & GPMC_STATUS_BUFF_EMPTY;
> +		break;
> +
> +	case GPMC_GET_SET_IRQ_STATUS:
> +		if (write)
> +			gpmc_write_reg(GPMC_IRQSTATUS, wval);
> +		else
> +			*rval = gpmc_read_reg(GPMC_IRQSTATUS);
> +		break;
> +
> +	case GPMC_PREFETCH_FIFO_CNT:
> +		regval = gpmc_read_reg(GPMC_PREFETCH_STATUS);
> +		*rval = GPMC_PREFETCH_STATUS_FIFO_CNT(regval);
> +		break;
> +
> +	case GPMC_PREFETCH_COUNT:
> +		regval = gpmc_read_reg(GPMC_PREFETCH_STATUS);
> +		*rval = GPMC_PREFETCH_STATUS_COUNT(regval);
> +		break;
> +
> +	case GPMC_CONFIG_WP:
> +		regval = gpmc_read_reg(GPMC_CONFIG);
> +		if (wval)
> +			regval &= ~GPMC_CONFIG_WRITEPROTECT; /* WP is ON */
> +		else
> +			regval |= GPMC_CONFIG_WRITEPROTECT;  /* WP is OFF */
> +		gpmc_write_reg(GPMC_CONFIG, regval);
> +		break;
> +
> +	case GPMC_CONFIG_RDY_BSY:
> +		regval  = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
> +		regval |= WR_RD_PIN_MONITORING;
> +		gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1, regval);
> +		break;
> +
> +	case GPMC_CONFIG_DEV_SIZE:
> +		regval  = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
> +		regval |= GPMC_CONFIG1_DEVICESIZE(wval);
> +		gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1, regval);
> +		break;
> +
> +	case GPMC_CONFIG_DEV_TYPE:
> +		regval  = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
> +		regval |= GPMC_CONFIG1_DEVICETYPE(wval);
> +		if (wval == GPMC_DEVICETYPE_NOR)
> +			regval |= GPMC_CONFIG1_MUXADDDATA;
> +		gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1, regval);
> +		break;
> +
> +	case GPMC_NAND_COMMAND:
> +		gpmc_cs_write_byte(cs, GPMC_CS_NAND_COMMAND, wval);
> +		break;
> +
> +	case GPMC_NAND_ADDRESS:
> +		gpmc_cs_write_byte(cs, GPMC_CS_NAND_ADDRESS, wval);
> +		break;
> +
> +	case GPMC_NAND_DATA:
> +		if (write)
> +			gpmc_cs_write_byte(cs, GPMC_CS_NAND_DATA, wval);
> +		else
> +			*rval = gpmc_cs_read_byte(cs, GPMC_CS_NAND_DATA);
> +		break;
> +
> +	default:
> +		printk(KERN_ERR "gpmc_hwcontrol: Not supported\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(gpmc_hwcontrol);

You should just replace this function with simple functions like we already
have in gpmc.c rather than trying to pack everything into one function.
Just add various gpmc_xxx_get/set functions rather than pass int *rval.

Regards,

Tony
