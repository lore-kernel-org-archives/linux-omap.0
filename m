From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH PM 1/1] OMAP3 McSPI: Fix to restore chconf for all CSs
Date: Fri, 27 Feb 2009 10:27:23 -0800
Message-ID: <20090227182723.GG11594@atomide.com>
References: <1233668121-32200-1-git-send-email-jouni.hogander@nokia.com> <1233668121-32200-2-git-send-email-jouni.hogander@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:60406 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757165AbZB0S13 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Feb 2009 13:27:29 -0500
Content-Disposition: inline
In-Reply-To: <1233668121-32200-2-git-send-email-jouni.hogander@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jouni Hogander <jouni.hogander@nokia.com>
Cc: linux-omap@vger.kernel.org

* Jouni Hogander <jouni.hogander@nokia.com> [090203 05:37]:
> This patch saves/restores chconf0 for all CSs instead of only for CS0

This should be sent to David Brownell to LKML for integration to
the mainline tree. For the right mailing list, please take a look
at "SPI SUBSYSTEM" in the MAINTAINERS file.

Regards,

Tony
 
> Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
> ---
>  drivers/spi/omap2_mcspi.c |   14 +++++++-------
>  1 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
> index a7ee3b7..45632dd 100644
> --- a/drivers/spi/omap2_mcspi.c
> +++ b/drivers/spi/omap2_mcspi.c
> @@ -142,7 +142,7 @@ struct omap2_mcspi_cs {
>  struct omap2_mcspi_regs {
>  	u32 sysconfig;
>  	u32 modulctrl;
> -	u32 chconf0;
> +	u32 chconf0[4];
>  	u32 wakeupenable;
>  };
>  
> @@ -238,8 +238,8 @@ static void omap2_mcspi_set_master_mode(struct spi_master *master)
>  
>  static void omap2_mcspi_restore_ctx(struct omap2_mcspi *mcspi)
>  {
> -	struct spi_master *spi_cntrl;
> -	spi_cntrl = mcspi->master;
> +	struct spi_master *spi_cntrl = mcspi->master;
> +	int i;
>  
>  	/* McSPI: context restore */
>  	mcspi_write_reg(spi_cntrl, OMAP2_MCSPI_MODULCTRL,
> @@ -248,9 +248,9 @@ static void omap2_mcspi_restore_ctx(struct omap2_mcspi *mcspi)
>  	mcspi_write_reg(spi_cntrl, OMAP2_MCSPI_SYSCONFIG,
>  			omap2_mcspi_ctx[spi_cntrl->bus_num - 1].sysconfig);
>  
> -	mcspi_write_reg(spi_cntrl, OMAP2_MCSPI_CHCONF0,
> -			omap2_mcspi_ctx[spi_cntrl->bus_num - 1].chconf0);
> -
> +	for (i = 0; i < spi_cntrl->num_chipselect; i++)
> +		mcspi_write_reg(spi_cntrl, i * 0x14 + OMAP2_MCSPI_CHCONF0,
> +				omap2_mcspi_ctx[spi_cntrl->bus_num - 1].chconf0[i]);
>  
>  	mcspi_write_reg(spi_cntrl, OMAP2_MCSPI_WAKEUPENABLE,
>  			omap2_mcspi_ctx[spi_cntrl->bus_num - 1].wakeupenable);
> @@ -593,7 +593,7 @@ static int omap2_mcspi_setup_transfer(struct spi_device *spi,
>  
>  	mcspi_write_cs_reg(spi, OMAP2_MCSPI_CHCONF0, l);
>  
> -	omap2_mcspi_ctx[spi_cntrl->bus_num - 1].chconf0 = l;
> +	omap2_mcspi_ctx[spi_cntrl->bus_num - 1].chconf0[spi->chip_select] = l;
>  
>  	dev_dbg(&spi->dev, "setup: speed %d, sample %s edge, clk %s\n",
>  			OMAP2_MCSPI_MAX_FREQ / (1 << div),
> -- 
> 1.6.0.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
