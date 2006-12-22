From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] ARM: OMAP: fix workqueue changes
Date: Fri, 22 Dec 2006 10:24:54 -0800
Message-ID: <200612221024.54833.david-b@pacbell.net>
References: <33307024.396441166765952040.JavaMail.weblogic@ep_ml29>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <33307024.396441166765952040.JavaMail.weblogic@ep_ml29>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com, kyungmin.park@samsung.com
List-Id: linux-omap@vger.kernel.org

On Thursday 21 December 2006 9:39 pm, Kyungmin Park wrote:
> [PATCH] ARM: OMAP: fix workqueue changes

This kind of patch needs to get submitted upstream ASAP, since
that's where the breakage is coming from ... as an MMC patch,
I think that means it should goto Pierre Ossman.


> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> 
> --
> 
> diff --git a/drivers/mmc/omap.c b/drivers/mmc/omap.c
> index 1852268..f46aed7 100644
> --- a/drivers/mmc/omap.c
> +++ b/drivers/mmc/omap.c
> @@ -582,9 +582,9 @@ static void mmc_omap_switch_timer(unsigned long arg)
>  	schedule_work(&host->switch_work);
>  }
>  
> -static void mmc_omap_switch_handler(void *data)
> +static void mmc_omap_switch_handler(struct work_struct *work)
>  {
> -	struct mmc_omap_host *host = (struct mmc_omap_host *) data;
> +	struct mmc_omap_host *host = container_of(work, struct mmc_omap_host, switch_work);
>  	struct mmc_card *card;
>  	static int complained = 0;
>  	int cards = 0, cover_open;
> @@ -1122,7 +1122,7 @@ static int __init mmc_omap_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, host);
>  
>  	if (host->switch_pin >= 0) {
> -		INIT_WORK(&host->switch_work, mmc_omap_switch_handler, host);
> +		INIT_WORK(&host->switch_work, mmc_omap_switch_handler);
>  		init_timer(&host->switch_timer);
>  		host->switch_timer.function = mmc_omap_switch_timer;
>  		host->switch_timer.data = (unsigned long) host;
> diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
> index 634aca1..b8d0ec0 100644
> --- a/drivers/spi/omap2_mcspi.c
> +++ b/drivers/spi/omap2_mcspi.c
> @@ -634,7 +634,7 @@ static int omap2_mcspi_setup(struct spi_device *spi)
>  	mcspi_dma = &mcspi->dma_channels[spi->chip_select];
>  
>  	if (!cs) {
> -		cs = kzalloc(sizeof *cs, SLAB_KERNEL);
> +		cs = kzalloc(sizeof *cs, GFP_KERNEL);
>  		if (!cs)
>  			return -ENOMEM;
>  		spi->controller_state = cs;
> @@ -669,9 +669,9 @@ static void omap2_mcspi_cleanup(const struct spi_device *spi)
>  }
>  
>  
> -static void omap2_mcspi_work(void * arg)
> +static void omap2_mcspi_work(struct work_struct *work)
>  {
> -	struct omap2_mcspi	*mcspi = (struct omap2_mcspi *) arg;
> +	struct omap2_mcspi	*mcspi = container_of(work, struct omap2_mcspi, work);
>  	unsigned long		flags;
>  
>  	spin_lock_irqsave(&mcspi->lock, flags);
> @@ -820,7 +820,7 @@ static int __devinit omap2_mcspi_probe(struct platform_device *pdev)
>  	
>  	mcspi->base = io_p2v(r->start);
>  
> -	INIT_WORK(&mcspi->work, omap2_mcspi_work, mcspi);
> +	INIT_WORK(&mcspi->work, omap2_mcspi_work);
>  
>  	spin_lock_init(&mcspi->lock);
>  	INIT_LIST_HEAD(&mcspi->msg_queue);
