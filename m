From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/2] leds: lp55xx: handle enable pin in driver
Date: Wed, 23 Oct 2013 01:19:58 -0700
Message-ID: <20131023081957.GB16686@atomide.com>
References: <1382446896-28436-1-git-send-email-sre@debian.org>
 <1382446896-28436-2-git-send-email-sre@debian.org>
 <20131022170604.GP15154@atomide.com>
 <CAK5ve-KWdJFuJsvQ+JS2y7bpa9j4hGdU=ceb4nAz8BKQ1M9_XA@mail.gmail.com>
 <20131022173742.GQ15154@atomide.com>
 <CAK5ve-JhehHHAU_2tN-RVb8+u2AbUS_Yx=k+i0Ponnm9Wir+OQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAK5ve-JhehHHAU_2tN-RVb8+u2AbUS_Yx=k+i0Ponnm9Wir+OQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Sebastian Reichel <sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-GFxCN5SEZAc@public.gmane.org>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Milo Kim <milo.kim-l0cyMroinI0@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux LED Subsystem <linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [131022 10:47]:
> On Tue, Oct 22, 2013 at 10:37 AM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
> > * Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [131022 10:23]:
> >> On Tue, Oct 22, 2013 at 10:06 AM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
> >> > * Sebastian Reichel <sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org> [131022 06:02]:
> >> >> This patch moves the handling of the chip's enable pin from the board
> >> >> code into the driver. It also updates all board-code files using the
> >> >> driver to incorporate this change.
> >> >>
> >> >> This is needed for device tree support of the enable pin.
> >> >
> >> > This seems safe to merge along with the other LED patches, the
> >> > changes to arch/arm/mach-omap2 should not conflict with anything.
> >> >
> >> > So for the arch/arm/mach-omap2 changes:
> >> >
> >> > Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> >>
> >> I'm OK for LED parts, will this patch go through omap tree? If so,
> >> please add my ack.
> >>
> >> Acked-by: Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >
> > It's probably best that you take it via with the LED patches.
> >
> 
> OK, I will do it. what about PATCH 2 of this patch set? Will you take
> care of it?

Benoit should take that one, otherwise there's a good chance of
pointless merge conflicts with the .dts files.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
