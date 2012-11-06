From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [PATCH 12/15] ARM: OMAP: timer: Add suspend-resume callbacks
 for clockevent device
Date: Tue, 6 Nov 2012 07:32:19 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EC045C5@DBDE01.ent.ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
 <1351859566-24818-13-git-send-email-vaibhav.bedia@ti.com>
 <509829C5.100@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59141 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752631Ab2KFHcZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Nov 2012 02:32:25 -0500
In-Reply-To: <509829C5.100@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "tony@atomide.com" <tony@atomide.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>

Hi Jon,

On Tue, Nov 06, 2012 at 02:34:05, Hunter, Jon wrote:
[...]
> >  static struct clock_event_device clockevent_gpt = {
> >  	.name		= "gp_timer",
> >  	.features       = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
> > @@ -142,6 +171,8 @@ static struct clock_event_device clockevent_gpt = {
> >  	.rating		= 300,
> >  	.set_next_event	= omap2_gp_timer_set_next_event,
> >  	.set_mode	= omap2_gp_timer_set_mode,
> > +	.suspend	= omap_clkevt_suspend,
> > +	.resume		= omap_clkevt_resume,
> 
> So these suspend/resume callbacks are going to be called for all OMAP2+
> and AMxxxx devices? I don't think we want that. AFAIK OMAP timers will
> idle on their own when stopped and don't require this.
> 

IMO instead of skipping the callback registration we could have checks in the
suspend/resume callbacks to decide what to do. 

I'll check if the idling part is AM33xx specific. If not, based on the recent timer
changes that you did, perhaps checking if the clockevent selected doesn't have the
"ti,timer-alwon" capability will be good enough. What do you think?

Regards.
Vaibhav
