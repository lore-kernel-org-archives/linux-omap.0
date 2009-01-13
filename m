From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/5] omap mmc: Add better MMC low-level init
Date: Tue, 13 Jan 2009 15:43:44 +0200
Message-ID: <20090113134343.GK7344@atomide.com>
References: <20081207213617.10456.43951.stgit@localhost> <20081207214747.10456.34844.stgit@localhost> <20090110224942.GA10556@michl.2n.cz> <20090110230059.GA10758@michl.2n.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:61645 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752837AbZAMNnr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Jan 2009 08:43:47 -0500
Content-Disposition: inline
In-Reply-To: <20090110230059.GA10758@michl.2n.cz>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: linux-omap@vger.kernel.org

* Ladislav Michl <ladis@linux-mips.org> [090111 01:03]:
> On Sat, Jan 10, 2009 at 11:49:42PM +0100, Ladislav Michl wrote:
> > On Sun, Dec 07, 2008 at 01:47:47PM -0800, Tony Lindgren wrote:
> > > diff --git a/arch/arm/mach-omap1/board-h2-mmc.c b/arch/arm/mach-omap1/board-h2-mmc.c
> > > index 504ae88..409fa56 100644
> > > --- a/arch/arm/mach-omap1/board-h2-mmc.c
> > > +++ b/arch/arm/mach-omap1/board-h2-mmc.c
> > [snip]
> > > +static void mmc_shutdown(struct device *dev)
> > > +{
> > > +	gpio_free(H2_TPS_GPIO_MMC_PWR_EN);
> > > +}
> > > +
> > > +/*
> > > + * H2 could use the following functions tested:
> > > + * - mmc_get_cover_state that uses OMAP_MPUIO(1)
> > > + * - mmc_get_wp that uses OMAP_MPUIO(3)
> > > + */
> > > +static struct omap_mmc_platform_data mmc1_data = {
> > > +	.nr_slots                       = 1,
> > > +	.init				= mmc_late_init,
> > > +	.shutdown			= mmc_shutdown,
> > It seems that shutdown is no-op, so what about patch below?
> 
> After all, lets remove some unused fields.
> 
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> 
> diff --git a/arch/arm/plat-omap/include/mach/mmc.h b/arch/arm/plat-omap/include/mach/mmc.h
> index 031250f..1129e97 100644
> --- a/arch/arm/plat-omap/include/mach/mmc.h
> +++ b/arch/arm/plat-omap/include/mach/mmc.h
> @@ -51,7 +51,6 @@ struct omap_mmc_platform_data {
>  	 * not supported */
>  	int (* init)(struct device *dev);
>  	void (* cleanup)(struct device *dev);
> -	void (* shutdown)(struct device *dev);
>  
>  	/* To handle board related suspend/resume functionality for MMC */
>  	int (*suspend)(struct device *dev, int slot);
> @@ -77,10 +76,6 @@ struct omap_mmc_platform_data {
>  
>  		/* use the internal clock */
>  		unsigned internal_clock:1;
> -		s16 power_pin;
> -
> -		int switch_pin;			/* gpio (card detect) */
> -		int gpio_wp;			/* gpio (write protect) */
>  
>  		int (* set_bus_mode)(struct device *dev, int slot, int bus_mode);
>  		int (* set_power)(struct device *dev, int slot, int power_on, int vdd);

Hmm, aren't switch_pin and gpio_wp  used at least in the
mmc-twl4030.c?

I guess they could be internal to mmc-twl4030.c if not used
in the drivers directly.

> diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
> index 67d7b7f..84de289 100644
> --- a/drivers/mmc/host/omap.c
> +++ b/drivers/mmc/host/omap.c
> @@ -157,8 +157,6 @@ struct mmc_omap_host {
>  	struct timer_list	dma_timer;
>  	unsigned		dma_len;
>  
> -	short			power_pin;
> -
>  	struct mmc_omap_slot    *slots[OMAP_MMC_MAX_SLOTS];
>  	struct mmc_omap_slot    *current_slot;
>  	spinlock_t              slot_lock;
> 

Looks like power_pin could go though.

Tony
