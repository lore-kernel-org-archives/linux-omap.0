From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 10/15] usb: musb: Don't set d+ high before enable for
 2430 glue layer
Date: Fri, 13 May 2016 14:17:39 -0700
Message-ID: <20160513211739.GE5995@atomide.com>
References: <1463014396-4095-1-git-send-email-tony@atomide.com>
 <1463014396-4095-11-git-send-email-tony@atomide.com>
 <20160513210334.GC1665@uda0271908>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160513210334.GC1665@uda0271908>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Bin Liu <b-liu-l0cyMroinI0@public.gmane.org> [160513 14:05]:
> Hi,
> 
> On Wed, May 11, 2016 at 05:53:11PM -0700, Tony Lindgren wrote:
> > At least 2430 glue layer pulls d+ high on start up even if there are
> > no gadgets configured. This is bad at least for anything using a separate
> > battery charger chip as it can confuse the charger detection.
> > 
> > Let's fix the issue by getting rid of omap2430_musb_set_mode() and only
> 
> By doing so, you lost the feature of switching mode from sysfs, I am not
> sure if there is anyone using it though, still, it is a regression.

Oh right, that's a good point.

How about we change musb_core to call the optional set_mode() if implemented,
and then set the session bit in host mode only? That way we can get rid of
the musb core tinkering in the glue layer drivers eventually?

> > write session bit in omap2430_musb_enable().
> 
> I don't think session bit needs to be set in _enable(), musb_start() in
> core takes care of this bit.

OK sounds like that should just work then.

> > -static int omap2430_musb_set_mode(struct musb *musb, u8 musb_mode)
> > -{
> > -	u8	devctl = musb_readb(musb->mregs, MUSB_DEVCTL);
> > -
> > -	devctl |= MUSB_DEVCTL_SESSION;
> > -	musb_writeb(musb->mregs, MUSB_DEVCTL, devctl);
> 
> In stead of removing it, session bit should only be set when musb_mode
> == MUSB_HOST, will this fix the D+ pullup problem?

Good point, I forgot about it being specific to host mode. I'll check.

> >  static inline void omap2430_low_level_exit(struct musb *musb)
> >  {
> >  	u32 l;
> > @@ -428,6 +418,9 @@ static void omap2430_musb_enable(struct musb *musb)
> >  
> >  	case MUSB_VBUS_VALID:
> >  		omap_control_usb_set_mode(glue->control_otghs, USB_MODE_DEVICE);
> > +		devctl = musb_readb(musb->mregs, MUSB_DEVCTL);
> > +		devctl |= MUSB_DEVCTL_SESSION;
> > +		musb_writeb(musb->mregs, MUSB_DEVCTL, devctl);
> 
> session bit is only set for host mode, VBUS_VALID is not a signal for
> host mode. So you don't have to set the bit here.

OK thanks.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
