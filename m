From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 4/7] ARM: dts: Enable N950 keyboard sleep leds by default
Date: Wed, 30 Mar 2016 12:35:21 -0700
Message-ID: <20160330193520.GY9329@atomide.com>
References: <1457827580-16919-1-git-send-email-sre@kernel.org>
 <1457827580-16919-5-git-send-email-sre@kernel.org>
 <20160329105128.GA30184@amd>
 <20160329145209.GB31858@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160329145209.GB31858@earth>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [160329 07:53]:
> Hi,
> 
> On Tue, Mar 29, 2016 at 12:51:28PM +0200, Pavel Machek wrote:
> > For 1-3 in the series, Acked-by: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
> > 
> > > Like the Nokia N900, the N950 has leds to show
> > > the state of sys_clkreq and sys_off_mode pins.
> > > 
> > > A detailed description for the LEDs and
> > > OMAP's sleep states can be found in Tony's
> > > commit for the Nokia N900:
> > > 
> > > c1be2032f66df9e1238bd5bc4ca666de88a62abc
> > 
> > I must say I've seen it on N900, and yes, it is useful, but no, I
> > don't think this is right.
> >
> > This is not a LED. This is a interface that changes meaning of two
> > other LEDs. I guess it should go to debugfs somewhere.

Eh that sounds like a GPIO LED to me :) And it already has a
/sys/class/leds/debug interface.

The two LEDs this GPIO controls are hardwired to sys_clkreq and
sys_off_mode pins that are the control signals between the SoC
and PMIC.

In theory you could steal the sys_clkreq and sys_off_mode pins
from the PMIC at the cost of breaking PM. But I doubt anybody
wants to do that considering it's a battery operated device.

> I don't think we should diverge N900 and N950 userspace
> APIs in this regard.
> 
> Actually the correct way would be a custom trigger
> for the leds IMHO. I don't know if the led framework
> supports per led custom triggers, though.

Sure, there are something like 10 triggers already. And
you can already change them using:

echo none > /sys/class/leds/debug::sleep/trigger

That still does not change the fact that the LEDs trigger
based on the state of sys_clkreq and sys_off_mode.

Maybe I'm not following what you guys are trying to achieve
here though :) If so, please let me know.

Regards,

Tony


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
