From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 2/4] ARM: dts: tps65217: Add power button interrupt to
 the common tps65217.dtsi file
Date: Tue, 13 Jun 2017 21:55:52 -0700
Message-ID: <20170614045551.GB3730@atomide.com>
References: <20170612212412.22719-1-enric.balletbo@collabora.com>
 <20170612212412.22719-2-enric.balletbo@collabora.com>
 <20170613073519.GA3730@atomide.com>
 <CAFqH_50syu5aHBQtJkh-Dpz8Yc_6w0X853DO46T3ZAAJ10F-Pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAFqH_50syu5aHBQtJkh-Dpz8Yc_6w0X853DO46T3ZAAJ10F-Pw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Enric Balletbo Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Enric Balletbo Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [170613 02:12]:
> Hi Tony,
> 
> 2017-06-13 9:35 GMT+02:00 Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>:
> > * Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org> [170612 14:28]:
> >> The interrupt for power button is static data that comes from the
> >> datasheet, there is no reason to need to define this value on every
> >> board so seams reasonable put this information into the common tps65217
> >> file.
> >
> > I think there's a problem with these patches where we no longer know
> > if the interrupts are wired up on a board. For example, if the USB PHY
> > VBUS interrupt is not connected, the phy driver needs poll the
> > cable state.
> >
> 
> Hmm, the tps65217 doesn't have a USB PHY like others tps, so not sure
> how could affect this patch. Did you see this issue in any board that
> uses tps65217 or any am335x based board which commonly uses this pmic?

Oh sorry I misread your patch. I thought you're removing
the interrupts from dts, but you're just moving the dts entries
to the common dtsi file :) So seems just fine with me.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
