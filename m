From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: musb RPM sleep-while-atomic in 4.9-rc1
Date: Fri, 21 Oct 2016 02:49:05 -0700
Message-ID: <20161021094904.q66kjsl33yzf2kir@atomide.com>
References: <20161020153749.GC12413@localhost>
 <20161021070848.rum7wrlihjayqdbh@atomide.com>
 <20161021092530.GO2765@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161021092530.GO2765@localhost>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [161021 02:26]:
> On Fri, Oct 21, 2016 at 12:08:49AM -0700, Tony Lindgren wrote:
> > * Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [161020 08:38]:
> > > Hi Tony,
> > > 
> > > I'm getting the splat below when booting 4.9-rc1 on a BBB and
> > > tracked it down to 65b3f50ed6fa ("usb: musb: Add PM runtime support for
> > > MUSB DSPS glue layer") which added a synchronous RPM get in a timer
> > > callback:
> > 
> > OK, sorry to hear about that. Care to email me your .config and how
> > to reproduce and what do you have connected like a hub? Also do
> > you use built-in gadgets or configure them via configfs?
> 
> It happens even with no devices connected to the host port, and with no
> gadgets configured (or the peripheral port simply disabled). Whenever
> the glue timer fires and calls pm_runtime_get_sync() I get the splat.
> For some reason the might_sleep() in get_sync() does not trigger the
> first time, which means that I see this four seconds after probe, and
> then every other second when the timer fires.

OK. I'm totally baffled how come I did not hit this earlier with
my tests. I did have some extra patches for using the pmic vbus irq
for cable detection, but that's only for the peripheral instance and
the host instance is still using timer.

> Attaching my defconfig.

Not seeing anything special there, musb built in, using dma. And no
reason why this should not always happen when polling the cable status.

> > > Setting the irq_safe flag seems to do the trick, but not sure that's
> > > what you intended to do.
> > 
> > That's what we want to avoid as it keep the parent device permanently
> > enabled. To avoid that we want to just queue things and deal with them
> > from pm_runtime_resume.
> 
> I figured, so then that pm_runtime_get_sync() in the dsps timer callback
> needs to go.

Agreed, that is clearly wrong to call from softirq context. I need to
figure out what is right fix here but don't have access to my bbb
until next week.

> > > I saw you posted some regression fixes lately, but they did not look
> > > related to this at first glance at least.
> > 
> > Yeah this seems different. Can you still try v4.9-rc + patches from
> > thread "[PATCH 0/2] Fixes for two more musb regressions"?
> 
> As expected, those two fixes makes no difference.

Yeah thanks for checking.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
