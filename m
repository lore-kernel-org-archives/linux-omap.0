From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [PATCH 2/5] omap mmc: Add better MMC low-level init
Date: Mon, 23 Mar 2009 18:47:39 +0100
Message-ID: <20090323174739.GD20944@localhost.localdomain>
References: <20081207213617.10456.43951.stgit@localhost> <20081207214747.10456.34844.stgit@localhost> <20090110224942.GA10556@michl.2n.cz> <20090110230059.GA10758@michl.2n.cz> <20090113134343.GK7344@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from virt.comanet.cz ([82.100.28.79]:50697 "EHLO virt.comanet.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750839AbZCWRSk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Mar 2009 13:18:40 -0400
Content-Disposition: inline
In-Reply-To: <20090113134343.GK7344@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Tue, Jan 13, 2009 at 03:43:44PM +0200, Tony Lindgren wrote:
> > diff --git a/arch/arm/plat-omap/include/mach/mmc.h b/arch/arm/plat-omap/include/mach/mmc.h
> > index 031250f..1129e97 100644
> > --- a/arch/arm/plat-omap/include/mach/mmc.h
> > +++ b/arch/arm/plat-omap/include/mach/mmc.h
> > @@ -51,7 +51,6 @@ struct omap_mmc_platform_data {
> >  	 * not supported */
> >  	int (* init)(struct device *dev);
> >  	void (* cleanup)(struct device *dev);
> > -	void (* shutdown)(struct device *dev);
> >  
> >  	/* To handle board related suspend/resume functionality for MMC */
> >  	int (*suspend)(struct device *dev, int slot);
> > @@ -77,10 +76,6 @@ struct omap_mmc_platform_data {
> >  
> >  		/* use the internal clock */
> >  		unsigned internal_clock:1;
> > -		s16 power_pin;
> > -
> > -		int switch_pin;			/* gpio (card detect) */
> > -		int gpio_wp;			/* gpio (write protect) */
> >  
> >  		int (* set_bus_mode)(struct device *dev, int slot, int bus_mode);
> >  		int (* set_power)(struct device *dev, int slot, int power_on, int vdd);
> 
> Hmm, aren't switch_pin and gpio_wp  used at least in the
> mmc-twl4030.c?

Yes, they are. I missed them completely. Sorry.

> I guess they could be internal to mmc-twl4030.c if not used
> in the drivers directly.

They could, but that's a bit more complicated. Will look at it later.

> > diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
> > index 67d7b7f..84de289 100644
> > --- a/drivers/mmc/host/omap.c
> > +++ b/drivers/mmc/host/omap.c
> > @@ -157,8 +157,6 @@ struct mmc_omap_host {
> >  	struct timer_list	dma_timer;
> >  	unsigned		dma_len;
> >  
> > -	short			power_pin;
> > -
> >  	struct mmc_omap_slot    *slots[OMAP_MMC_MAX_SLOTS];
> >  	struct mmc_omap_slot    *current_slot;
> >  	spinlock_t              slot_lock;
> > 
> 
> Looks like power_pin could go though.

Updated patch follows

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>

diff --git a/arch/arm/plat-omap/include/mach/mmc.h b/arch/arm/plat-omap/include/mach/mmc.h
index 4435bd4..81d5b36 100644
--- a/arch/arm/plat-omap/include/mach/mmc.h
+++ b/arch/arm/plat-omap/include/mach/mmc.h
@@ -79,7 +79,6 @@ struct omap_mmc_platform_data {
 
 		/* use the internal clock */
 		unsigned internal_clock:1;
-		s16 power_pin;
 
 		int switch_pin;			/* gpio (card detect) */
 		int gpio_wp;			/* gpio (write protect) */
diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 67d7b7f..e8e0e09 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -157,8 +157,6 @@ struct mmc_omap_host {
 	struct timer_list	dma_timer;
 	unsigned		dma_len;
 
-	short			power_pin;
-
 	struct mmc_omap_slot    *slots[OMAP_MMC_MAX_SLOTS];
 	struct mmc_omap_slot    *current_slot;
 	spinlock_t              slot_lock;

