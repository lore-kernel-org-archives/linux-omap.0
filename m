From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCHv3] usb: musb: Fix unbalanced platform_disable
Date: Mon, 24 Oct 2016 10:54:30 -0700
Message-ID: <20161024175429.zjhvko5mdxx5nscf@atomide.com>
References: <20160914181019.22937-1-tony@atomide.com>
 <20160916140339.GB15522@uda0271908>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160916140339.GB15522@uda0271908>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Bin Liu <b-liu-l0cyMroinI0@public.gmane.org> [160916 07:04]:
> Hi,
> 
> On Wed, Sep 14, 2016 at 11:10:19AM -0700, Tony Lindgren wrote:
> > Commit a83e17d0f73b ("usb: musb: Improve PM runtime and phy handling
> > for 2430 glue layer") moved PHY enable/disable calls to happen from
> > omap2430_musb_enable/disable(). That broke enumeration for several
> > devices as PM runtime in the PHY will never enable it.
> > 
> > The root cause of the problem is unpaired calls from musb_core.c to
> > musb_platform_enable/disable in musb_core.c as reported by
> > Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>.
> > 
> > As musb_platform_enable/disable are being called from various functions,
> > let's not attempt to make them paiered immediately. This would require
> > fixing all the callers like musb_remove.
> > 
> > Instead, let's first fix the regression in a minimal way by removing
> > the initial call to musb_platform_disable. To do that in a safe way,
> > we need to call the glue specific *_musb_disable() directly in the
> > glue layer *_musb_init() as noted by Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>.
> > 
> > AFAIK the initial musb_platform_disable call has always been just an
> > attempted workaround for the 2430 glue layer announcing itself too
> > early before the gadgets are configured. And that issue finally
> > got fixed with commit a118df07f5b1 ("usb: musb: Don't set d+ high
> > before enable for 2430 glue layer").
> > 
> > Further, most of the glue layers already do a reset of the musb
> > controller in the *_musb_init(), so later on we may want to
> > consider removing the calls to *__musb_disable() where a reset is
> > already done.
> > 
> > Note that we now also need to fix the twl4030-phy accordingly making
> > it's PM runtime call only needed in twl4030_phy_power_on and have it
> > autosuspend. The cable state will keep the phy active when connected.
> > 
> > Cc: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > Cc: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
> > Fixes: a83e17d0f73b ("usb: musb: Improve PM runtime and phy handling
> > for 2430 glue layer")
> > Reported-by: Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>
> > Acked-by: Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>
> > Reported-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
> > Tested-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
> > Acked-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
> > Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> > ---
> 
> If Kishon wants to take it, here is my
> 
> Acked-by: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>

To recap, this seems to be now only partially needed with
commit d8e5f0eca1e8 ("usb: musb: Fix hardirq-safe hardirq-unsafe
lock order error") heading into v4.9-rc2.

The rest of the changes in the $subject patch we should probably
wait on until we have things working in a sane way with PM runtime.

I'll be sending the phy-twl4030-usb related changes separately.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
