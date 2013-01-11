From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [RFC v2 12/18] ARM: OMAP2+: timer: Add suspend-resume callbacks
 for clockevent device
Date: Fri, 11 Jan 2013 04:37:10 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433ECE0D51@DBDE01.ent.ti.com>
References: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com>
 <1356959231-17335-13-git-send-email-vaibhav.bedia@ti.com>
 <50EC37FE.705@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34560 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753400Ab3AKEhV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Jan 2013 23:37:21 -0500
In-Reply-To: <50EC37FE.705@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Hunter, Jon" <jon-hunter@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "tony@atomide.com" <tony@atomide.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>

On Tue, Jan 08, 2013 at 20:45:10, Shilimkar, Santosh wrote:
> On Monday 31 December 2012 06:37 PM, Vaibhav Bedia wrote:
> > The current OMAP timer code registers two timers -
> > one as clocksource and one as clockevent.
> > AM33XX has only one usable timer in the WKUP domain
> > so one of the timers needs suspend-resume support
> > to restore the configuration to pre-suspend state.
> >
> > commit adc78e6 (timekeeping: Add suspend and resume
> > of clock event devices) introduced .suspend and .resume
> > callbacks for clock event devices. Leverages these
> > callbacks to have AM33XX clockevent timer which is
> > in not in WKUP domain to behave properly across system
> > suspend.
> >
> > Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> > Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > Cc: Benoit Cousson <b-cousson@ti.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > Cc: Kevin Hilman <khilman@deeprootsystems.com>
> > Cc: Vaibhav Hiremath <hvaibhav@ti.com>
> > Cc: Jon Hunter <jon-hunter@ti.com>
> > ---
> > v1->v2:
> > 	Get rid of harcoded timer id.
> > 	Note: since a platform device is not created for these timer
> > 	instances and because there's very minimal change needed for
> > 	restarting the timer a full blown context save and restore
> > 	has been skipped.
> >
> >   arch/arm/mach-omap2/timer.c |   33 +++++++++++++++++++++++++++++++++
> >   1 files changed, 33 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
> > index 691aa67..38f9cbc 100644
> > --- a/arch/arm/mach-omap2/timer.c
> > +++ b/arch/arm/mach-omap2/timer.c
> > @@ -128,6 +128,36 @@ static void omap2_gp_timer_set_mode(enum clock_event_mode mode,
> >   	}
> >   }
> >
> > +static void omap_clkevt_suspend(struct clock_event_device *unused)
> > +{
> > +	char name[10];
> > +	struct omap_hwmod *oh;
> > +
> > +	sprintf(name, "timer%d", clkev.id);
> > +	oh = omap_hwmod_lookup(name);
> > +	if (!oh)
> > +		return;
> > +
> > +	__omap_dm_timer_stop(&clkev, 1, clkev.rate);
> > +	omap_hwmod_idle(oh);
> > +}
> > +
> > +static void omap_clkevt_resume(struct clock_event_device *unused)
> > +{
> > +	char name[10];
> > +	struct omap_hwmod *oh;
> > +
> > +	sprintf(name, "timer%d", clkev.id);
> > +	oh = omap_hwmod_lookup(name);
> > +	if (!oh)
> > +		return;
> > +
> > +	omap_hwmod_enable(oh);
> > +	__omap_dm_timer_load_start(&clkev,
> > +			OMAP_TIMER_CTRL_ST | OMAP_TIMER_CTRL_AR, 0, 1);
> > +	__omap_dm_timer_int_enable(&clkev, OMAP_TIMER_INT_OVERFLOW);
> > +}
> > +
> Am still bit uncomfortable with direct hwmod usage in the suspend/resmue
> hooks.
> 
> Jon, Any alternatives you can think of ?
> 

Jon,

Any suggestions here?

Regards,
Vaibhav
