From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: am335x-baltos: add LED support
Date: Mon, 27 Mar 2017 10:45:05 -0700
Message-ID: <20170327174504.GO10760@atomide.com>
References: <1490368503-4798-1-git-send-email-yegorslists@googlemail.com>
 <20170327173852.GN10760@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170327173852.GN10760-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [170327 10:42]:
> * yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org> [170324 08:17]:
> > From: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
> > 
> > All three devices provide GPIO based LEDs named power,
> > wlan and app.
> > 
> > Place the same definition in all three DTS files, as
> > there are other devices (not currently upstreamed), that
> > use am335x-baltos.dtsi but use different GPIOs for these
> > LEDs.
> 
> How about just add am335x-baltos-leds.dtsi and include
> it for the three boards to avoid duplication?

Or maybe even am335x-baltos-xyz-devices.dtsi or something if
you have more devices that are shared across some group
of baltos devices.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
