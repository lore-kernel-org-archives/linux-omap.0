From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: lcd_mipid: Fix OOM error reporting
Date: Mon, 1 Oct 2007 10:44:56 -0700
Message-ID: <20071001174456.GL24656@atomide.com>
References: <1190287903652-git-send-email-tsavola@movial.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <1190287903652-git-send-email-tsavola@movial.fi>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Timo Savola <tsavola@movial.fi>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Timo Savola <tsavola@movial.fi> [070920 04:32]:
> Do not try access a memory region when its allocation failed.
> 
> Signed-off-by: Timo Savola <tsavola@movial.fi>
> ---
>  drivers/video/omap/lcd_mipid.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/omap/lcd_mipid.c b/drivers/video/omap/lcd_mipid.c
> index 922e322..ef071a6 100644
> --- a/drivers/video/omap/lcd_mipid.c
> +++ b/drivers/video/omap/lcd_mipid.c
> @@ -561,7 +561,7 @@ static int mipid_spi_probe(struct spi_device *spi)
>  
>  	md = kzalloc(sizeof(*md), GFP_KERNEL);
>  	if (md == NULL) {
> -		dev_err(&md->spi->dev, "out of memory\n");
> +		dev_err(&spi->dev, "out of memory\n");
>  		return -ENOMEM;
>  	}
>  

Thanks, pushing today.

Tony
