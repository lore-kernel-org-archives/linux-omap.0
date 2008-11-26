From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: MCSPI: Enable mcspi wake-up v2.
Date: Wed, 26 Nov 2008 09:57:10 -0800
Message-ID: <20081126175709.GS11997@atomide.com>
References: <873ahotc5t.fsf@trdhcp146196.ntc.nokia.com> <1227080924-11555-1-git-send-email-jouni.hogander@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:60111 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752747AbYKZR5L (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Nov 2008 12:57:11 -0500
Content-Disposition: inline
In-Reply-To: <1227080924-11555-1-git-send-email-jouni.hogander@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jouni Hogander <jouni.hogander@nokia.com>, David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

* Jouni Hogander <jouni.hogander@nokia.com> [081118 23:48]:
> Currently mcspi wake-ups are not enabled. This might cause case where
> OMAP is not waking up on mcspi events.

Dave, I assume you're picking these for your SPI queue? Will only
apply to l-o if you ack and tell me so.

Tony


> Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
> ---
>  drivers/spi/omap2_mcspi.c |   11 +++++++++--
>  1 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
> index 454a271..d7e519c 100644
> --- a/drivers/spi/omap2_mcspi.c
> +++ b/drivers/spi/omap2_mcspi.c
> @@ -59,6 +59,8 @@
>  
>  /* per-register bitmasks: */
>  
> +#define OMAP2_MCSPI_SYSCONFIG_SMARTIDLE	(2 << 3)
> +#define OMAP2_MCSPI_SYSCONFIG_ENAWAKEUP	(1 << 2)
>  #define OMAP2_MCSPI_SYSCONFIG_AUTOIDLE	(1 << 0)
>  #define OMAP2_MCSPI_SYSCONFIG_SOFTRESET	(1 << 1)
>  
> @@ -90,6 +92,7 @@
>  
>  #define OMAP2_MCSPI_CHCTRL_EN		(1 << 0)
>  
> +#define OMAP2_MCSPI_WAKEUPENABLE_WKEN	(1 << 0)
>  
>  /* We have 2 DMA channels per CS, one for RX and one for TX */
>  struct omap2_mcspi_dma {
> @@ -884,8 +887,12 @@ static int __init omap2_mcspi_reset(struct omap2_mcspi *mcspi)
>  	} while (!(tmp & OMAP2_MCSPI_SYSSTATUS_RESETDONE));
>  
>  	mcspi_write_reg(master, OMAP2_MCSPI_SYSCONFIG,
> -			/* (3 << 8) | (2 << 3) | */
> -			OMAP2_MCSPI_SYSCONFIG_AUTOIDLE);
> +			OMAP2_MCSPI_SYSCONFIG_AUTOIDLE |
> +			OMAP2_MCSPI_SYSCONFIG_ENAWAKEUP |
> +			OMAP2_MCSPI_SYSCONFIG_SMARTIDLE);
> +
> +	mcspi_write_reg(master, OMAP2_MCSPI_WAKEUPENABLE,
> +			OMAP2_MCSPI_WAKEUPENABLE_WKEN);
>  
>  	omap2_mcspi_set_master_mode(master);
>  
> -- 
> 1.6.0.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
