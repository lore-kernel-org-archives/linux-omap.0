From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] OMAP3: I2C: Enable I2C wakeups
Date: Fri, 21 Nov 2008 13:38:52 -0800
Message-ID: <20081121213851.GZ4927@atomide.com>
References: <1227022994-8288-1-git-send-email-ext-kalle.jokiniemi@nokia.com> <1227022994-8288-2-git-send-email-ext-kalle.jokiniemi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:55307 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969AbYKUVix (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Nov 2008 16:38:53 -0500
Content-Disposition: inline
In-Reply-To: <1227022994-8288-2-git-send-email-ext-kalle.jokiniemi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com

* Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com> [081118 07:42]:
> I2C_WE registers were not configured, which caused huge delays in
> I2C operations while cpu idle was enabled and omap entered WFI.
> 
> This patch enables all I2C wakeup sources.

Pushing to l-o tree and adding to i2c-omap upstream queue.

Tony

> Signed-off-by: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
> ---
>  drivers/i2c/busses/i2c-omap.c |   27 +++++++++++++++++++++++++++
>  1 files changed, 27 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index d012ad7..99be16f 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -52,6 +52,8 @@
>  #define OMAP_I2C_IE_REG			0x04
>  #define OMAP_I2C_STAT_REG		0x08
>  #define OMAP_I2C_IV_REG			0x0c
> +/* For OMAP3 I2C_IV has changed to I2C_WE (wakeup enable) */
> +#define OMAP_I2C_WE_REG			0x0c
>  #define OMAP_I2C_SYSS_REG		0x10
>  #define OMAP_I2C_BUF_REG		0x14
>  #define OMAP_I2C_CNT_REG		0x18
> @@ -89,6 +91,24 @@
>  #define OMAP_I2C_STAT_NACK	(1 << 1)	/* No ack interrupt enable */
>  #define OMAP_I2C_STAT_AL	(1 << 0)	/* Arbitration lost int ena */
>  
> +/* I2C WE wakeup enable register */
> +#define OMAP_I2C_WE_XDR_WE	(1 << 14)	/* TX drain wakup */
> +#define OMAP_I2C_WE_RDR_WE	(1 << 13)	/* RX drain wakeup */
> +#define OMAP_I2C_WE_AAS_WE	(1 << 9)	/* Address as slave wakeup*/
> +#define OMAP_I2C_WE_BF_WE	(1 << 8)	/* Bus free wakeup */
> +#define OMAP_I2C_WE_STC_WE	(1 << 6)	/* Start condition wakeup */
> +#define OMAP_I2C_WE_GC_WE	(1 << 5)	/* General call wakeup */
> +#define OMAP_I2C_WE_DRDY_WE	(1 << 3)	/* TX/RX data ready wakeup */
> +#define OMAP_I2C_WE_ARDY_WE	(1 << 2)	/* Reg access ready wakeup */
> +#define OMAP_I2C_WE_NACK_WE	(1 << 1)	/* No acknowledgment wakeup */
> +#define OMAP_I2C_WE_AL_WE	(1 << 0)	/* Arbitration lost wakeup */
> +
> +#define OMAP_I2C_WE_ALL		(OMAP_I2C_WE_XDR_WE | OMAP_I2C_WE_RDR_WE | \
> +				OMAP_I2C_WE_AAS_WE | OMAP_I2C_WE_BF_WE | \
> +				OMAP_I2C_WE_STC_WE | OMAP_I2C_WE_GC_WE | \
> +				OMAP_I2C_WE_DRDY_WE | OMAP_I2C_WE_ARDY_WE | \
> +				OMAP_I2C_WE_NACK_WE | OMAP_I2C_WE_AL_WE)
> +
>  /* I2C Buffer Configuration Register (OMAP_I2C_BUF): */
>  #define OMAP_I2C_BUF_RDMA_EN	(1 << 15)	/* RX DMA channel enable */
>  #define OMAP_I2C_BUF_RXFIF_CLR	(1 << 14)	/* RX FIFO Clear */
> @@ -292,6 +312,13 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
>  			      __ffs(SYSC_CLOCKACTIVITY_MASK));
>  
>  			omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG, v);
> +			/*
> +			 * Enabling all wakup sources to stop I2C freezing on
> +			 * WFI instruction.
> +			 * REVISIT: Some wkup sources might not be needed.
> +			 */
> +			omap_i2c_write_reg(dev, OMAP_I2C_WE_REG,
> +							OMAP_I2C_WE_ALL);
>  
>  		}
>  	}
> -- 
> 1.5.4.3
> 
