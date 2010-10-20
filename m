From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] spi/omap2_mcspi: disable channel after TX_ONLY
 transfer in PIO mode
Date: Wed, 20 Oct 2010 10:31:22 -0600
Message-ID: <20101020163122.GH7285@angua.secretlab.ca>
References: <1287482607-18912-1-git-send-email-jason77.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:45077 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490Ab0JTQb0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Oct 2010 12:31:26 -0400
Received: by gwb19 with SMTP id 19so115312gwb.19
        for <linux-omap@vger.kernel.org>; Wed, 20 Oct 2010 09:31:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1287482607-18912-1-git-send-email-jason77.wang@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jason Wang <jason77.wang@gmail.com>
Cc: tony@atomide.com, notasas@gmail.com, linux-omap@vger.kernel.org, spi-devel-general@lists.sourceforge.net

On Tue, Oct 19, 2010 at 06:03:27PM +0800, Jason Wang wrote:
> In the TX_ONLY transfer, the SPI controller also receives data
> simultaneously and saves them in the rx register. After the TX_ONLY
> transfer, the rx register will hold the random data received during
> the last tx transaction.
> 
> If the direct following transfer is RX_ONLY, this random data has the
> possibility to affect this transfer like this:
>   When the SPI controller is changed from TX_ONLY to RX_ONLY,
>   the random data makes the rx register full immediately and
>   triggers a dummy write automatically(in SPI RX_ONLY transfers,
>   we need a dummy write to trigger the first transaction).
> 
>   So the first data received in the RX_ONLY transfer will be that
>   random data instead of something meaningful.
> 
> We can avoid this by inserting a Disable/Re-enable toggle of the
> channel after the TX_ONLY transfer, since it purges the rx register.
> 
> Signed-off-by: Jason Wang <jason77.wang@gmail.com>
> Tested-by: Grazvydas Ignotas <notasas@gmail.com>
> Acked-by: Tony Lindgren <tony@atomide.com>

Applied, thanks.

g.

> ---
> Hi Grant,
> 
> The touchpanel driver can't work correctly on the omap3evm platform,
> This is due to a omap2_mcspi driver issue, now fix it.
> 
>  drivers/spi/omap2_mcspi.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
> index b3a94ca..43fab41 100644
> --- a/drivers/spi/omap2_mcspi.c
> +++ b/drivers/spi/omap2_mcspi.c
> @@ -644,6 +644,12 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
>  		} else if (mcspi_wait_for_reg_bit(chstat_reg,
>  				OMAP2_MCSPI_CHSTAT_EOT) < 0)
>  			dev_err(&spi->dev, "EOT timed out\n");
> +
> +		/* disable chan to purge rx datas received in TX_ONLY transfer,
> +		 * otherwise these rx datas will affect the direct following
> +		 * RX_ONLY transfer.
> +		 */
> +		omap2_mcspi_set_enable(spi, 0);
>  	}
>  out:
>  	omap2_mcspi_set_enable(spi, 1);
> -- 
> 1.5.6.5
> 
