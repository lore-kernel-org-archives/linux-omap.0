From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Request OMAP MMC Write-protect pin
Date: Wed, 18 Oct 2006 22:12:50 +0300
Message-ID: <20061018191249.GB4669@atomide.com>
References: <fb249edb0609221308t5669679cra80f9888b895a346@mail.gmail.com>
	<fb249edb0609221310y33ac7b4dse744a587d5b9d2bb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <fb249edb0609221310y33ac7b4dse744a587d5b9d2bb@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: balrogg@gmail.com
Cc: Linux-OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi,

* andrzej zaborowski <balrog@zabor.org> [060922 23:17]:
> [Sorry, forgot about the actual diff]
> 
> Adds code that requests and frees the WP GPIO pin in OMAP MMC host
> driver, similarly to how the MMC Power and MMC Cover-switch GPIOs are
> treated.
> 
> Signed-off-by: Andrzej Zaborowski <balrog@zabor.org>
> 
> diff --git a/drivers/mmc/omap.c b/drivers/mmc/omap.c
> index ae08a37..a01682b 100644
> --- a/drivers/mmc/omap.c
> +++ b/drivers/mmc/omap.c
> @@ -1009,7 +1009,7 @@ static int mmc_omap_get_ro(struct mmc_ho
>  {
>  	struct mmc_omap_host *host = mmc_priv(mmc);
>  
> -	return host->wp_pin && omap_get_gpio_datain(host->wp_pin);
> +	return (host->wp_pin >= 0) && omap_get_gpio_datain(host->wp_pin);
>  }

...

This all looks OK, but let's wait on this as I believe there are
some patches coming to deal with it in board-*.c files.

Regards,

Tony
