From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v11 6/8] dmtimer: switch-over to platform device driver
Date: Fri, 4 Mar 2011 12:27:28 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037A3603C0@dbde02.ent.ti.com>
References: <1298546811-27055-1-git-send-email-tarun.kanti@ti.com>
	<1298546811-27055-7-git-send-email-tarun.kanti@ti.com>
 <87y64vllrh.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57052 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758960Ab1CDG5g convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Mar 2011 01:57:36 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p246vXxe002396
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 4 Mar 2011 00:57:35 -0600
In-Reply-To: <87y64vllrh.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Hilman, Kevin
> Sent: Friday, March 04, 2011 6:56 AM
> To: DebBarma, Tarun Kanti
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH v11 6/8] dmtimer: switch-over to platform device
> driver
> 
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
> 
> > switch-over to platform device driver through following changes:
> > (a) initiate dmtimer early initialization from omap2_gp_timer_init()
> > in timer-gp.c. This is equivalent of timer_init()->timer->init().
> > (b) modify plat-omap/dmtimer routines to use new register map and
> > platform data.
> >
> > Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> > Acked-by: Cousson, Benoit <b-cousson@ti.com>
> 
> [...]
> 
> > @@ -507,20 +394,22 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_start);
> >  void omap_dm_timer_stop(struct omap_dm_timer *timer)
> >  {
> >  	u32 l;
> > +	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
> >
> >  	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
> >  	if (l & OMAP_TIMER_CTRL_ST) {
> >  		l &= ~0x1;
> >  		omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
> > -#ifdef CONFIG_ARCH_OMAP2PLUS
> > -		/* Readback to make sure write has completed */
> > -		omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
> > -		 /*
> > -		  * Wait for functional clock period x 3.5 to make sure that
> > -		  * timer is stopped
> > -		  */
> > -		udelay(3500000 / clk_get_rate(timer->fclk) + 1);
> > -#endif
> > +
> > +		if (!pdata->is_omap16xx) {
> > +			/* Readback to make sure write has completed */
> > +			omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
> > +			/*
> > +			 * Wait for functional clock period x 3.5 to make
> > +			 * sure that timer is stopped
> > +			 */
> > +			udelay(3500000 / clk_get_rate(timer->fclk) + 1);
> > +		}
> 
> Can't this 'is_omap16xx' check just be using the IP revision?
OK, I will introduce a new version to cover this.

> 
> 
> >  	}
> 
> Kevin
