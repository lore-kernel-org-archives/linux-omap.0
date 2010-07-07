From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v3]OMAP:GPTIMER:1ms tick generation correction
Date: Wed, 7 Jul 2010 19:43:16 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0323830CE0@dbde02.ent.ti.com>
References: <1277239078-31386-1-git-send-email-tarun.kanti@ti.com>
 <20100707115946.GM1920@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50252 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753408Ab0GGONW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jul 2010 10:13:22 -0400
In-Reply-To: <20100707115946.GM1920@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "R, Sricharan" <r.sricharan@ti.com>

Tony,
Thanks for the comments! Please see my response.

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Wednesday, July 07, 2010 5:30 PM
> To: DebBarma, Tarun Kanti
> Cc: linux-omap@vger.kernel.org; R, Sricharan
> Subject: Re: [PATCH v3]OMAP:GPTIMER:1ms tick generation correction
> 
> * Tarun Kanti DebBarma <tarun.kanti@ti.com> [100622 12:35]:
> > +/**
> > + * omap_dm_timer_ms_correction - hardware correction for millisecond
> timer
> > + * @timer: GPTIMER on which the correction support is to be applied
> > + * @load: timer load value, used here to extract the expiry count
> > + */
> > +static void omap_dm_timer_ms_correction(struct omap_dm_timer *timer,
> u32 load)
> > +{
> > +	int pos_increment, neg_increment;
> > +	unsigned int count = (0xFFFFFFFF - load) * 1024;
> > +
> > +	pos_increment = (DIV_ROUND_UP(count, 1000) * 1000000) \
> > +			- (count * 1000);
> > +	neg_increment = ((DIV_ROUND_UP(count, 1000) - 1) * 1000000) \
> > +			- (count * 1000);
> > +	omap_dm_timer_write_reg(timer, OMAP_TIMER_TICK_POS_REG,
> pos_increment);
> > +	omap_dm_timer_write_reg(timer, OMAP_TIMER_TICK_NEG_REG,
> neg_increment);
> > +}
> >
> >  struct omap_dm_timer *omap_dm_timer_request(void)
> >  {
> > @@ -612,6 +639,10 @@ void omap_dm_timer_set_load_start(struct
> omap_dm_timer *timer, int autoreload,
> >  {
> >  	u32 l;
> >
> > +#ifdef CONFIG_ARCH_OMAP2PLUS
> > +	if (timer->ms_correction)
> > +		omap_dm_timer_ms_correction(timer, load);
> > +#endif
> >  	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
> >  	if (autoreload) {
> >  		l |= OMAP_TIMER_CTRL_AR;
> 
> How do you know that the timer is configured to use the 32KiHZ source?
> 

[Tarun]
At this point we do not know. The point is we need not know.
The caller function calculates the load based upon the source clock frequency. Viz. sys_clk or 32Khz. Please note that correction is needed both for sys_clk and 32Khz clock.

> Also, since omap2_gp_timer_set_next_event calls all the time,
> we don't want to do this calculation for every tick.. So we should
> make it a separate optional function.

[Tarun]
Agreed, but need some clarification here. 
At first my intention was to make the call to omap_dm_timer_ms_correction() just once since the tick period is supposed to be constant. However, during testing it was found that the caller of omap2_gp_timer_set_next_event(unsigned long cycles,...) passes different values for cycles and so different load value. This gave me the impression that caller framework is programming for counts related to different number ticks with the necessity to apply omap_dm_timer_ms_correction() every time.

I would be glad to get feedback on my observation.

> 
> Or can we somehow calculate this drift once during init?
> 
As described, for a constant tick we would need to compute and program just once, during initialization.


> Regards,
> 
> Tony
