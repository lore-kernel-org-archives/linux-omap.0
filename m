From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] ARM: OMAP: Fix wrong SPI mode in N800 LCD
Date: Fri, 29 Jun 2007 00:20:17 -0700
Message-ID: <20070629072016.GA23421@atomide.com>
References: <11827667772695-git-send-email-Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <11827667772695-git-send-email-Hiroshi.DOYU@nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Hiroshi.DOYU@nokia.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Hiroshi.DOYU@nokia.com <Hiroshi.DOYU@nokia.com> [070625 03:27]:
> From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> 
> Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> ---
>  drivers/video/omap/lcd_mipid.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/omap/lcd_mipid.c b/drivers/video/omap/lcd_mipid.c
> index 569e18b..922e322 100644
> --- a/drivers/video/omap/lcd_mipid.c
> +++ b/drivers/video/omap/lcd_mipid.c
> @@ -565,7 +565,7 @@ static int mipid_spi_probe(struct spi_device *spi)
>  		return -ENOMEM;
>  	}
>  
> -	spi->mode = SPI_MODE_1;
> +	spi->mode = SPI_MODE_0;
>  	md->spi = spi;
>  	dev_set_drvdata(&spi->dev, md);
>  	md->panel = mipid_panel;
> -- 

Thanks, pushing today.

Tony
