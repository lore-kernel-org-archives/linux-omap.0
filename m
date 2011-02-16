From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v9 10/11] OMAP: dmtimer: pm_runtime support
Date: Wed, 16 Feb 2011 15:54:01 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03745CAA0F@dbde02.ent.ti.com>
References: <1297423040-19917-1-git-send-email-tarun.kanti@ti.com>
	<1297423040-19917-11-git-send-email-tarun.kanti@ti.com>
 <8762slte2n.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54128 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754727Ab1BPKYJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Feb 2011 05:24:09 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1GAO6ml007200
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 16 Feb 2011 04:24:08 -0600
In-Reply-To: <8762slte2n.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Basak, Partha" <p-basak2@ti.com>

> -----Original Message-----
> From: Hilman, Kevin
> Sent: Tuesday, February 15, 2011 10:45 PM
> To: DebBarma, Tarun Kanti
> Cc: linux-omap@vger.kernel.org; Basak, Partha
> Subject: Re: [PATCH v9 10/11] OMAP: dmtimer: pm_runtime support
> 
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
> 
> > Add pm_runtime support to dmtimer. Since dmtimer is used during
> > early boot before pm_runtime is initialized completely there are
> > provisions to enable/disable clocks directly in the code during
> > early boot.
> >
> > Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> > [p-basak2@ti.com: added pm_runtime logic in probe()]
> > Signed-off-by: Partha Basak <p-basak2@ti.com>
> > Reviewed-by: Varadarajan, Charulatha <charu@ti.com>
> > Acked-by: Cousson, Benoit <b-cousson@ti.com>
> > ---
> >  arch/arm/plat-omap/dmtimer.c |   60
> +++++++++++++++++++++++++++++++++++------
> >  1 files changed, 51 insertions(+), 9 deletions(-)
> >
> > diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
> > index ed4aada..4de473b 100644
> > --- a/arch/arm/plat-omap/dmtimer.c
> > +++ b/arch/arm/plat-omap/dmtimer.c
> > @@ -39,6 +39,7 @@
> >  #include <linux/delay.h>
> >  #include <linux/io.h>
> >  #include <linux/slab.h>
> > +#include <linux/pm_runtime.h>
> >  #include <linux/err.h>
> >  #include <linux/platform_device.h>
> >  #include <plat/dmtimer.h>
> > @@ -211,13 +212,16 @@ static void omap_dm_timer_prepare(struct
> omap_dm_timer *timer)
> >  {
> >  	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
> >
> > -	timer->fclk = clk_get(&timer->pdev->dev, "fck");
> > -	if (WARN_ON_ONCE(IS_ERR_OR_NULL(timer->fclk))) {
> > -		dev_err(&timer->pdev->dev, ": No fclk handle.\n");
> > -		return;
> > +	if (!pdata->is_omap16xx) {
> > +		timer->fclk = clk_get(&timer->pdev->dev, "fck");
> > +		if (WARN_ON_ONCE(IS_ERR_OR_NULL(timer->fclk))) {
> > +			dev_err(&timer->pdev->dev, ": No fclk handle.\n");
> > +			return;
> > +		}
> >  	}
> >
> > -	omap_dm_timer_enable(timer);
> > +	if (!pdata->is_omap16xx)
> > +		omap_dm_timer_enable(timer);
> >
> >  	if (pdata->dm_timer_reset)
> >  		pdata->dm_timer_reset(timer);
> > @@ -289,10 +293,22 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_free);
> >
> >  void omap_dm_timer_enable(struct omap_dm_timer *timer)
> >  {
> > +	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
> > +
> >  	if (timer->enabled)
> >  		return;
> >
> > -	clk_enable(timer->fclk);
> > +	if (unlikely(pdata->is_early_init)) {
> > +		clk_enable(timer->fclk);
> > +		timer->enabled = 1;
> > +		return;
> > +	}
> > +
> > +	if (pm_runtime_get_sync(&timer->pdev->dev) < 0) {
> > +		dev_err(&timer->pdev->dev, "%s: pm_runtime_get_sync() FAILED\n",
> > +			__func__);
> > +		return;
> > +	}
> >
> >  	timer->enabled = 1;
> >  }
> > @@ -300,10 +316,22 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_enable);
> >
> >  void omap_dm_timer_disable(struct omap_dm_timer *timer)
> >  {
> > +	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
> > +
> >  	if (!timer->enabled)
> >  		return;
> >
> > -	clk_disable(timer->fclk);
> > +	if (unlikely(pdata->is_early_init)) {
> > +		clk_disable(timer->fclk);
> > +		timer->enabled = 0;
> > +		return;
> > +	}
> > +
> > +	if (pm_runtime_put_sync(&timer->pdev->dev) < 0) {
> > +		dev_err(&timer->pdev->dev, "%s: pm_runtime_put_sync() FAILED\n",
> > +			__func__);
> > +		return;
> > +	}
> >
> >  	timer->enabled = 0;
> >  }
> > @@ -422,10 +450,12 @@ int omap_dm_timer_set_source(struct omap_dm_timer
> *timer, int source)
> >  	if (source < 0 || source >= 3)
> >  		return -EINVAL;
> >
> > -	omap_dm_timer_disable(timer);
> > +	if (!pdata->is_omap16xx)
> > +		omap_dm_timer_disable(timer);
> >  	/* change the timer clock source */
> >  	ret = pdata->set_timer_src(timer->pdev, source);
> > -	omap_dm_timer_enable(timer);
> > +	if (!pdata->is_omap16xx)
> > +		omap_dm_timer_enable(timer);
> >
> >  	/*
> >  	 * When the functional clock disappears, too quick writes seem
> > @@ -597,11 +627,21 @@ static int __devinit omap_dm_timer_probe(struct
> platform_device *pdev)
> >  		return -ENODEV;
> >  	}
> >
> > +	/* OMAP2+
> 
> please fix multi-line comment style
OK, thanks.

> 
> > +	 * Early timers are already registered and in list.
> > +	 * What we need to do during second phase of probe
> > +	 * is to assign the newly allocated/configured pdev
> > +	 * to timer->pdev. We also call pm_runtime_enable()
> > +	 * for each device because it could not be called
> > +	 * during early boot because pm_runtime framework
> > +	 * was not yet up and running.
> > +	 */
> >  	spin_lock_irqsave(&dm_timer_lock, flags);
> >  	list_for_each_entry(timer, &omap_timer_list, node)
> >  		if (!pdata->is_early_init && timer->id == pdev->id) {
> >  			timer->pdev = pdev;
> >  			spin_unlock_irqrestore(&dm_timer_lock, flags);
> > +			pm_runtime_enable(&pdev->dev);
> >  			dev_dbg(&pdev->dev, "Regular Probed\n");
> >  			return 0;
> >  		}
> 
> > @@ -652,6 +692,8 @@ static int __devinit omap_dm_timer_probe(struct
> platform_device *pdev)
> >  		pdata->dm_timer_read_reg = omap_dm_timer_read_reg;
> >  		pdata->dm_timer_write_reg = omap_dm_timer_write_reg;
> >  		pdata->is_early_init = 0;
> > +		pm_runtime_enable(&pdev->dev);
> > +		dev_dbg(&pdev->dev, " pm_runtime enabled\n");
This will be removed since PM runtime is not applicable on OMAP1.

> >  	}
> >
> >  	timer->id = pdev->id;
> 
> Somehow, you need to also update runtime PM for early timers that were
> enabled.  For the PM runtime userspace info to be correct, I think you
> also need to do a 'get' here if the timer has also been enabled.
Yes, I have done in the second pass of probe for timers which are used.

> 
> Otherwise, upon boot, checking runtime PM sysfs it looks like no timers
> are active, or ever have been active:
Here is the result after change.
/ # cat /sys/devices/platform/omap/omap_timer.*/power/runtime_status
active
suspended
suspended
suspended
suspended
suspended
suspended
suspended
suspended
suspended
suspended
/ #
# cat /sys/devices/platform/omap/omap_timer.*/power/runtime_active_time
45187
0
0
0
0
0
0
0
0
0
0

--
Tarun
> 
> 
> / # cat /sys/devices/platform/omap/omap_timer.*/power/runtime_status
> suspended
> suspended
> suspended
> suspended
> suspended
> suspended
> suspended
> suspended
> suspended
> suspended
> suspended
> suspended
> / # cat /sys/devices/platform/omap/omap_timer.*/power/runtime_active_time
> 0
> 0
> 0
> 0
> 0
> 0
> 0
> 0
> 0
> 0
> 0
> 0
> / #
> 
> Kevin
