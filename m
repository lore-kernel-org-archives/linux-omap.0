From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 30/35] irqchip: add irq-omap-intc.h header
Date: Tue, 29 Jul 2014 08:28:38 -0700
Message-ID: <20140729152838.GW29045@atomide.com>
References: <1406582183-696-1-git-send-email-balbi@ti.com>
 <1406582183-696-31-git-send-email-balbi@ti.com>
 <20140729120133.GQ29045@atomide.com>
 <20140729141045.GA17808@saruman.home>
 <20140729150655.GU29045@atomide.com>
 <20140729151936.GC17808@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140729151936.GC17808-HgARHv6XitL9zxVx7UNMDg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> [140729 08:22]:
> On Tue, Jul 29, 2014 at 08:06:55AM -0700, Tony Lindgren wrote:
> > * Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> [140729 07:13]:
> > > This is the third time I rebase the series after a long hiatus and it
> > > always comes out to the same result -> "let's wait some more".
> > 
> > Nope, it's always been "this series causes PM regressions"
> 
> you just said that we haven't been in any position to really test this,
> so can it be that the status has always been "this series causes PM
> regressions". We couldn't test that before, right ?

It's been working for legacy booting for years with the mainline
kernel, but not for device tree based booting until with v3.16-rc4.
I believe I tested your earlier series with my pending DT patches
though.
 
> > and few other minor comments. And we have not been in any
> > position to really test that until with v3.16-rc4. And then
> > you always run out of time and nobody else does anything :)
> 
> sure, I have other stuff to do as well.

Right :) I and others can provide some help here, but it's
the mr. patch author that needs to follow up on this series
too :p

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
