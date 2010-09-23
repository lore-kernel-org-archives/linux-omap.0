From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCHv3 7/17] dmtimer: use list instead of static array
Date: Thu, 23 Sep 2010 11:43:23 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB032963EBF8@dbde02.ent.ti.com>
References: <1285059205-26466-1-git-send-email-tarun.kanti@ti.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94027863D706@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54958 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752777Ab0IWGN3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Sep 2010 02:13:29 -0400
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E94027863D706@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>


> -----Original Message-----
> From: G, Manjunath Kondaiah
> Sent: Thursday, September 23, 2010 12:30 AM
> To: DebBarma, Tarun Kanti; linux-omap@vger.kernel.org
> Cc: Cousson, Benoit; Paul Walmsley; Kevin Hilman; Tony Lindgren
> Subject: RE: [PATCHv3 7/17] dmtimer: use list instead of static array
> 
> 
> 
> 
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org
> > [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of
> > DebBarma, Tarun Kanti
> > Sent: Tuesday, September 21, 2010 2:23 PM
> > To: linux-omap@vger.kernel.org
> > Cc: DebBarma, Tarun Kanti; Cousson, Benoit; Paul Walmsley;
> > Kevin Hilman; Tony Lindgren
> > Subject: [PATCHv3 7/17] dmtimer: use list instead of static array
> >
> > This patch converts the use of dmtimers static array in
> > functions into list structure. Please note that the static
> > arrays will be completely removed in subsequent patches when
> > dmtimer is converted into a platform driver.
> >
> > Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> > Cc: Cousson, Benoit <b-cousson@ti.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > Cc: Kevin Hilman <khilman@deeprootsystems.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> > ---
> >  arch/arm/plat-omap/dmtimer.c |   61
> > ++++++++++++++++++++++--------------------
> >  1 files changed, 32 insertions(+), 29 deletions(-)
> >
> > diff --git a/arch/arm/plat-omap/dmtimer.c
> > b/arch/arm/plat-omap/dmtimer.c index a7b1679..2d4805d 100644
> > --- a/arch/arm/plat-omap/dmtimer.c
> > +++ b/arch/arm/plat-omap/dmtimer.c
> > @@ -169,6 +169,7 @@ struct omap_dm_timer {
> >  	unsigned enabled:1;
> >  	unsigned posted:1;
> >  	struct platform_device *pdev;
> > +	struct list_head node;
> >  };
> >
> >  static int dm_timer_count;
> > @@ -291,7 +292,8 @@ static struct omap_dm_timer *dm_timers;
> > static const char **dm_source_names;  static struct clk
> > **dm_source_clocks;
> >
> > -static spinlock_t dm_timer_lock;
> > +static LIST_HEAD(omap_timer_list);
> > +static DEFINE_SPINLOCK(dm_timer_lock);
> >
> >  /*
> >   * Reads timer registers in posted and non-posted mode. The
> > posted mode bit @@ -341,7 +343,7 @@ static void
> > omap_dm_timer_reset(struct omap_dm_timer *timer)  {
> >  	u32 l;
> >
> > -	if (!cpu_class_is_omap2() || timer != &dm_timers[0]) {
> > +	if (!cpu_class_is_omap2() || timer->id != 0) {
> >  		omap_dm_timer_write_reg(timer,
> > OMAP_TIMER_IF_CTRL_REG, 0x06);
> >  		omap_dm_timer_wait_for_reset(timer);
> >  	}
> > @@ -374,20 +376,17 @@ struct omap_dm_timer
> > *omap_dm_timer_request(void)  {
> >  	struct omap_dm_timer *timer = NULL;
> >  	unsigned long flags;
> > -	int i;
> >
> >  	spin_lock_irqsave(&dm_timer_lock, flags);
> > -	for (i = 0; i < dm_timer_count; i++) {
> > -		if (dm_timers[i].reserved)
> > +	list_for_each_entry(timer, &omap_timer_list, node) {
> > +		if (timer->reserved)
> >  			continue;
> > -
> > -		timer = &dm_timers[i];
> >  		timer->reserved = 1;
> >  		break;
> >  	}
> >  	spin_unlock_irqrestore(&dm_timer_lock, flags);
> >
> > -	if (timer != NULL)
> > +	if (timer)
> >  		omap_dm_timer_prepare(timer);
> >
> >  	return timer;
> > @@ -396,23 +395,20 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_request);
> >
> >  struct omap_dm_timer *omap_dm_timer_request_specific(int id)  {
> > -	struct omap_dm_timer *timer;
> > +	struct omap_dm_timer *timer = NULL;
> >  	unsigned long flags;
> >
> >  	spin_lock_irqsave(&dm_timer_lock, flags);
> > -	if (id <= 0 || id > dm_timer_count ||
> > dm_timers[id-1].reserved) {
> > -		spin_unlock_irqrestore(&dm_timer_lock, flags);
> > -		printk("BUG: warning at %s:%d/%s(): unable to
> > get timer %d\n",
> > -		       __FILE__, __LINE__, __func__, id);
> > -		dump_stack();
> > -		return NULL;
> > +	list_for_each_entry(timer, &omap_timer_list, node) {
> > +		if (timer->id == id - 1 && !timer->reserved) {
> > +			timer->reserved = 1;
> > +			break;
> > +		}
> >  	}
> > -
> > -	timer = &dm_timers[id-1];
> > -	timer->reserved = 1;
> >  	spin_unlock_irqrestore(&dm_timer_lock, flags);
> >
> > -	omap_dm_timer_prepare(timer);
> > +	if (timer)
> > +		omap_dm_timer_prepare(timer);
> 
> if timer is null, atleast warning message to the caller will be useful
> incase requested timer is not available.
I was expecting the client driver to validate the returned pointer and take appropriate action including printing error message.
However, I have no problem printing warning message here.
-tarun
