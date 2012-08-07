From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] spi: omap2-mcspi: In case of dma errors fall back to
 pio
Date: Tue, 7 Aug 2012 00:47:40 -0700
Message-ID: <20120807074740.GR11011@atomide.com>
References: <1343197229-15188-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1343197229-15188-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Shubhrajyoti D <shubhrajyoti@ti.com> [120724 23:26]:
> In case there are dma errors currently the driver exits.
> Make the spi driver fall back to pio mode in case of dma errors.
> 
> If the DMA engine is not selected the driver
> exits.This patch makes the spi fall back to pio in that case.
> 
> Also adds a field dma_unusable to struct omap2_mcspi.
>  
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
>  drivers/spi/spi-omap2-mcspi.c |   21 +++++++++++++--------
>  1 files changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
> index bc47781..f243a39 100644
> --- a/drivers/spi/spi-omap2-mcspi.c
> +++ b/drivers/spi/spi-omap2-mcspi.c
> @@ -129,6 +129,7 @@ struct omap2_mcspi {
>  	struct omap2_mcspi_dma	*dma_channels;
>  	struct device		*dev;
>  	struct omap2_mcspi_regs ctx;
> +	int dma_unusable;
>  };

Don't you need to check separately for rx and tx dma? There's a slight
chance that you get a channel for one but not for the other..

Tony
