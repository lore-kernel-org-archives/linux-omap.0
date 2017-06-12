From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH RFC 2/5] ARM: dts: am335x-baltos: use IRQ_TYPE_* to
 specify irq flags
Date: Mon, 12 Jun 2017 00:32:27 -0700
Message-ID: <20170612073227.GS3730@atomide.com>
References: <20170526180609.2699-1-uwe@kleine-koenig.org>
 <20170526180609.2699-2-uwe@kleine-koenig.org>
 <20170531171932.GH3730@atomide.com>
 <CAGm1_ktJp+3t9ExuFJhKTmbM63yt-82PGP26KkEHGqK-tnfWRg@mail.gmail.com>
 <CAGm1_kuKxVOetzMLdnVO+xQ7egX+paqOHLS+ckz6nFwKD5QBuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAGm1_kuKxVOetzMLdnVO+xQ7egX+paqOHLS+ckz6nFwKD5QBuQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <uwe-rXY34ruvC2xidJT2blvkqNi2O/JbrIOy@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org> [170606 07:37]:
> On Wed, May 31, 2017 at 7:22 PM, Yegor Yefremov
> <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org> wrote:
> > Hi Uwe, Tony,
> >
> > On Wed, May 31, 2017 at 7:19 PM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
> >> * Uwe Kleine-König <uwe-rXY34ruvC2xidJT2blvkqNi2O/JbrIOy@public.gmane.org> [170526 11:09]:
> >>> According to the binding documentation and the source code the omap-gpio
> >>> controller takes IRQ_TYPE_* as its flags values, not GPIO_ACTIVE_*.
> >>>
> >>> This patch uses the right variable type which yields the same result
> >>> when compiled. Note that this might be wrong and actually
> >>> IRQ_TYPE_LEVEL_LOW is intended by the dt author.
> >>>
> >>> Signed-off-by: Uwe Kleine-König <uwe-rXY34ruvC2xidJT2blvkqNi2O/JbrIOy@public.gmane.org>
> >>> ---
> >>> Hello,
> >>>
> >>> can somebody with the hardware or it's documentation please check which
> >>> flag is the right one?
> >>
> >> I'll wait on this one until we have somebody test it.
> >
> > I'll look at it this week.
> 
> This is what works for me (at least it doesn't produce "irq 88: nobody
> cared (try booting with the "irqpoll" option)").
> 
> As for tca6416 it is working with all possible settings (from
> IRQ_TYPE_EDGE_RISING till IRQ_TYPE_LEVEL_LOW). "cat /proc/interrupts"
> always shows Level type:
> 
> 47:          5  44e07000.gpio  20 Level     1-0020

OK, can you please send a proper patch with description
and Signed-off-by? That is unless Uwe cares to update his
patch. Otherwise add Reported-by for Uwe :)

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
