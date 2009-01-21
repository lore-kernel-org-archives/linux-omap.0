From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3 McSPI:  Adds context save/restore
Date: Wed, 21 Jan 2009 09:16:36 -0800
Message-ID: <87eiywr34b.fsf@deeprootsystems.com>
References: <64283.10.24.255.17.1232533474.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.29]:37879 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751926AbZAURQl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Jan 2009 12:16:41 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1745469yxm.1
        for <linux-omap@vger.kernel.org>; Wed, 21 Jan 2009 09:16:39 -0800 (PST)
In-Reply-To: <64283.10.24.255.17.1232533474.squirrel@dbdmail.itg.ti.com> (Hemanth V.'s message of "Wed\, 21 Jan 2009 15\:54\:34 +0530 \(IST\)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hemanth V <hemanthv@ti.com>
Cc: linux-omap@vger.kernel.org

"Hemanth V" <hemanthv@ti.com> writes:

> From: Hemanth V <hemanthv@ti.com>
>
> This patch adds context save/restore feature to McSPI driver. This has been
> tested by instrumenting the driver code i.e by adding a McSPI softreset
> in omap2_mcspi_disable_clocks function.

Were you able to test this on the PM branch with off-mode enabled?

Some general comments:

The save/restore only affects a small number of registers and ones
that do not change very often.

So, I think the save/restore would be more efficiently done by getting
rid of the 'save_ctx' and using shadow regs in memory.  IOW, when ever
the registers are changed in the code, just update the copy in
omap2_mcspi_ctx.  Then you do not need a save_ctx function, you only
need a restore.

Also, the restore should normally check whether its powerdomain
actually went off before restoring.  The OMAP PM layer has the
function omap_pm_get_last_off_on_transaction_id() for this.

However, In the case of this driver, for only 4 registers it's
probably faster to just always restore.

> Signed-off-by: Hemanth V <hemanthv@ti.com>
>
> ---
>  drivers/spi/omap2_mcspi.c |   88 +++++++++++++++++++++++++++++++++++++++-------
>  1 files changed, 76 insertions(+), 12 deletions(-)
>
> Index: linux-omap-2.6/drivers/spi/omap2_mcspi.c
> ===================================================================
> --- linux-omap-2.6.orig/drivers/spi/omap2_mcspi.c	2009-01-21 15:03:12.000000000
> +0530
> +++ linux-omap-2.6/drivers/spi/omap2_mcspi.c	2009-01-21 15:05:20.000000000 +0530
> @@ -133,6 +133,15 @@
>  	int			word_len;
>  };
>
> +struct omap2_mcspi_regs {
> +	u32 sysconfig;
> +	u32 modulctrl;
> +	u32 chconf0;
> +	u32 wakeupenable;
> +};
> +
> +static struct omap2_mcspi_regs omap2_mcspi_ctx[4];
> +

Can you use a symbolic constant here instead of 4?  Something like
MAX_SPI_CONTROLLERS with a comment saying someting about omap2 having
3 and omap3 having 4.

>  static struct workqueue_struct *omap2_mcspi_wq;
>
>  #define MOD_REG_BIT(val, mask, set) do { \
> @@ -219,6 +228,63 @@
>  	mcspi_write_reg(master, OMAP2_MCSPI_MODULCTRL, l);
>  }
>
> +static void omap2_mcspi_save_ctx(struct omap2_mcspi *mcspi)
> +{
> +	struct spi_master *spi_cntrl;
> +	spi_cntrl = mcspi->master;
> +
> +	/* McSPI : context save */
> +	omap2_mcspi_ctx[spi_cntrl->bus_num - 1].modulctrl =
> +		mcspi_read_reg(spi_cntrl, OMAP2_MCSPI_MODULCTRL);
> +
> +	omap2_mcspi_ctx[spi_cntrl->bus_num - 1].sysconfig =
> +		mcspi_read_reg(spi_cntrl, OMAP2_MCSPI_SYSCONFIG);
> +
> +	omap2_mcspi_ctx[spi_cntrl->bus_num - 1].chconf0 =
> +		mcspi_read_reg(spi_cntrl, OMAP2_MCSPI_CHCONF0);
> +
> +	omap2_mcspi_ctx[spi_cntrl->bus_num - 1].wakeupenable =
> +		mcspi_read_reg(spi_cntrl, OMAP2_MCSPI_WAKEUPENABLE);
> +}
> +
> +static void omap2_mcspi_restore_ctx(struct omap2_mcspi *mcspi)
> +{
> +	struct spi_master *spi_cntrl;
> +	spi_cntrl = mcspi->master;
> +
> +	/*McSPI : context restore */
> +	mcspi_write_reg(spi_cntrl, OMAP2_MCSPI_MODULCTRL,
> +			omap2_mcspi_ctx[spi_cntrl->bus_num - 1].modulctrl);
> +
> +	mcspi_write_reg(spi_cntrl, OMAP2_MCSPI_SYSCONFIG,
> +			omap2_mcspi_ctx[spi_cntrl->bus_num - 1].sysconfig);
> +
> +	mcspi_write_reg(spi_cntrl, OMAP2_MCSPI_CHCONF0,
> +			omap2_mcspi_ctx[spi_cntrl->bus_num - 1].chconf0);
> +
> +	mcspi_write_reg(spi_cntrl, OMAP2_MCSPI_WAKEUPENABLE,
> +			omap2_mcspi_ctx[spi_cntrl->bus_num - 1].wakeupenable);
> +}
> +static void omap2_mcspi_disable_clocks(struct omap2_mcspi *mcspi)
> +{
> +	omap2_mcspi_save_ctx(mcspi);
> +
> +	clk_disable(mcspi->ick);
> +	clk_disable(mcspi->fck);
> +}
> +
> +static int omap2_mcspi_enable_clocks(struct omap2_mcspi *mcspi)
> +{
> +	if (clk_enable(mcspi->ick))
> +		return -ENODEV;
> +	if (clk_enable(mcspi->fck))
> +		return -ENODEV;
> +
> +	omap2_mcspi_restore_ctx(mcspi);
> +
> +	return 0;
> +}
> +
>  static unsigned
>  omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
>  {
> @@ -649,11 +715,11 @@
>  			return ret;
>  	}
>
> -	clk_enable(mcspi->ick);
> -	clk_enable(mcspi->fck);
> +	if (omap2_mcspi_enable_clocks(mcspi))
> +		return -ENODEV;
> +
>  	ret = omap2_mcspi_setup_transfer(spi, NULL);
> -	clk_disable(mcspi->fck);
> -	clk_disable(mcspi->ick);
> +	omap2_mcspi_disable_clocks(mcspi);
>
>  	return ret;
>  }
> @@ -685,8 +751,8 @@
>  	mcspi = container_of(work, struct omap2_mcspi, work);
>  	spin_lock_irq(&mcspi->lock);
>
> -	clk_enable(mcspi->ick);
> -	clk_enable(mcspi->fck);
> +	if (omap2_mcspi_enable_clocks(mcspi))
> +		return;
>
>  	/* We only enable one channel at a time -- the one whose message is
>  	 * at the head of the queue -- although this controller would gladly
> @@ -788,8 +854,7 @@
>  		spin_lock_irq(&mcspi->lock);
>  	}
>
> -	clk_disable(mcspi->fck);
> -	clk_disable(mcspi->ick);
> +	omap2_mcspi_disable_clocks(mcspi);
>
>  	spin_unlock_irq(&mcspi->lock);
>  }
> @@ -877,8 +942,8 @@
>  	struct spi_master	*master = mcspi->master;
>  	u32			tmp;
>
> -	clk_enable(mcspi->ick);
> -	clk_enable(mcspi->fck);
> +	if (omap2_mcspi_enable_clocks(mcspi))
> +		return -1;
>
>  	mcspi_write_reg(master, OMAP2_MCSPI_SYSCONFIG,
>  			OMAP2_MCSPI_SYSCONFIG_SOFTRESET);
> @@ -896,8 +961,7 @@
>
>  	omap2_mcspi_set_master_mode(master);
>
> -	clk_disable(mcspi->fck);
> -	clk_disable(mcspi->ick);
> +	omap2_mcspi_disable_clocks(mcspi);
>  	return 0;
>  }
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
