From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v5 3/3] ARM: dts: igep00x0: add wl18xx bindings
Date: Wed, 11 Mar 2015 08:11:38 -0700
Message-ID: <20150311151138.GU5264@atomide.com>
References: <1425915402-10012-1-git-send-email-eliad@wizery.com>
 <6286151.8rcX893TN6@wuerfel>
 <CABxcv=mPVxW=BqL2PUL=AtS74kcqMG1yxC1WqMpxGiNOqGAnyQ@mail.gmail.com>
 <2353601.si5uCETVn2@wuerfel>
 <CABxcv==yx3dy-beEF9cf1mKo1vjCh_LU6iLuvn1z-SKz9xG0qA@mail.gmail.com>
 <CAB3XZEfi49qMsB7A3p4Y7r9emzSbeyUGVy4-njzey1UnJU0qzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAB3XZEfi49qMsB7A3p4Y7r9emzSbeyUGVy4-njzey1UnJU0qzA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eliad Peller <eliad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Cc: Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Eliad Peller <eliad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org> [150311 06:39]:
> On Wed, Mar 11, 2015 at 3:21 PM, Javier Martinez Canillas
> <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org> wrote:
> > On Wed, Mar 11, 2015 at 2:17 PM, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
> >> On Wednesday 11 March 2015 14:07:11 Javier Martinez Canillas wrote:
> >>>
> >>> Right now it seems that all boards in mainline with a WiLink6 part are
> >>> using internal clocks. So as a first step I think that adding an
> >>> optional refclock-frequency and tcxoclock-frequency properties should
> >>> be enough.
> >>>
> >>> It would be good if the driver supports getting the refclock and
> >>> tcxoclock from an external provider in case a board gets these from
> >>> external clocks but that can be done as a followup if there are boards
> >>> in the future using that design.
> >>>
> >>> But please bear in mind that I'm not familiar with the clock handling
> >>> in WiLink6 since the WiLink8 part used in the IGEP boards does not
> >>> need these clocks and I only looked at Luciano's previous patches and
> >>> the WiLink today driver today. So it would be good if Eliad can double
> >>> check my assumptions to see if those are correct.
> >>
> sounds right. that's what i know as well.
> 
> >> Sounds good. I'd also be fine with not implementing the case for
> >> external clocks in the code until we need (and can test) it, but
> >> I think it should be specified in the binding from the start.
> >>
> > Agreed.
> >
> great. so i'll implement the internal clocks case only.

OK great sounds good to me also.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
