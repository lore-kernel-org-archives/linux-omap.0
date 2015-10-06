From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC/PATCH 11/11] arm: boot: dts: omap: add missing default
 status for 32k counter
Date: Tue, 6 Oct 2015 08:18:06 -0700
Message-ID: <20151006151805.GR23801@atomide.com>
References: <1443559446-26969-1-git-send-email-balbi@ti.com>
 <20151005175230.GG18784@saruman.tx.rr.com>
 <87io6lf6i4.fsf@saruman.tx.rr.com>
 <13543270.oBfHhoNL28@wuerfel>
 <87612k3uza.fsf@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87612k3uza.fsf@saruman.tx.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, daniel.lezcano@linaro.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, tglx@linutronix.de, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <balbi@ti.com> [151006 08:02]:
> Arnd Bergmann <arnd@arndb.de> writes:
> 
> > On Monday 05 October 2015 14:41:07 Felipe Balbi wrote:
> >> 
> >> /**
> >>  * omap_get_timer_dt - get a timer using device-tree
> >>  * @match       - device-tree match structure for matching a device type
> >>  * @property    - optional timer property to match
> >>  *
> >>  * Helper function to get a timer during early boot using device-tree for use
> >>  * as kernel system timer. Optionally, the property argument can be used to
> >>  * select a timer with a specific property. Once a timer is found then mark
> >>  * the timer node in device-tree as disabled, to prevent the kernel from
> >>  * registering this timer as a platform device and so no one else can use it.
> >>  */
> >> static struct device_node * __init omap_get_timer_dt(const struct of_device_id *match,
> >>                                                      const char *property)
> >> {
> >>         struct device_node *np;
> >> 
> >>         for_each_matching_node(np, match) {
> >>                 if (!of_device_is_available(np))
> >>                         continue;
> >> 
> >>                 if (property && !of_get_property(np, property, NULL))
> >>                         continue;
> >> 
> >>                 if (!property && (of_get_property(np, "ti,timer-alwon", NULL) ||
> >>                                   of_get_property(np, "ti,timer-dsp", NULL) ||
> >>                                   of_get_property(np, "ti,timer-pwm", NULL) ||
> >>                                   of_get_property(np, "ti,timer-secure", NULL)))
> >>                         continue;
> >> 
> >>                 of_add_property(np, &device_disabled);
> >>                 return np;
> >>         }
> >> 
> >>         return NULL;
> >> }
> >> 
> >> I'll patch this up and drop $subject
> >> 
> >
> > Ah, good.
> >
> > I'm seeing the "ti,timer-alwon" property here, we probably need to take
> > that into account when setting the CLOCK_SOURCE_SUSPEND_NONSTOP flag, if
> > that isn't how it gets done already.
> 
> that flag is not set for 32k in any dts. Seems like it should, though,
> judging by the binding documentation:
> 
> - ti,timer-alwon:	Indicates the timer is in an alway-on power
>   domain.
> 
> Tony, care to comment if we should add timer-alwon to 32k ?

No that should not be needed for the 32k counter. We should be able
to do everything we want with CLOCK_SOURCE_SUSPEND_NONSTOP for the
32k counter.

We still need ti,timer-alwon for a while for gptimers 1 and 12 as
they are the only ones in the always-on domain. I guess that need
will eventually go away too once we have a proper interconnect
driver and are using genpd.

Regards,

Tony
