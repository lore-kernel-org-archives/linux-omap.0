From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 10/15] usb: musb: Don't set d+ high before enable for
 2430 glue layer
Date: Fri, 13 May 2016 14:39:01 -0700
Message-ID: <20160513213900.GF5995@atomide.com>
References: <1463014396-4095-1-git-send-email-tony@atomide.com>
 <1463014396-4095-11-git-send-email-tony@atomide.com>
 <20160513210334.GC1665@uda0271908>
 <20160513211739.GE5995@atomide.com>
 <20160513212252.GA1659@uda0271908>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160513212252.GA1659@uda0271908>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Bin Liu <b-liu-l0cyMroinI0@public.gmane.org> [160513 14:24]:
> Hi,
> 
> On Fri, May 13, 2016 at 02:17:39PM -0700, Tony Lindgren wrote:
> > * Bin Liu <b-liu-l0cyMroinI0@public.gmane.org> [160513 14:05]:
> > > Hi,
> > > 
> > > On Wed, May 11, 2016 at 05:53:11PM -0700, Tony Lindgren wrote:
> > > > At least 2430 glue layer pulls d+ high on start up even if there are
> > > > no gadgets configured. This is bad at least for anything using a separate
> > > > battery charger chip as it can confuse the charger detection.
> > > > 
> > > > Let's fix the issue by getting rid of omap2430_musb_set_mode() and only
> > > 
> > > By doing so, you lost the feature of switching mode from sysfs, I am not
> > > sure if there is anyone using it though, still, it is a regression.
> > 
> > Oh right, that's a good point.
> > 
> > How about we change musb_core to call the optional set_mode() if implemented,
> 
> The core already does so. Please check musb_core.h.

Oh do you have some pending patches for this already not yet
in Linux next?

> > and then set the session bit in host mode only? That way we can get rid of
> > the musb core tinkering in the glue layer drivers eventually?

So currently we have this in musb_core.h:

static inline int musb_platform_set_mode(struct musb *musb, u8 mode)
{
	if (!musb->ops->set_mode)
		return 0;

	return musb->ops->set_mode(musb, mode);
}

What I meant is we could add generic support for the session bit:

static inline int musb_platform_set_mode(struct musb *musb, u8 mode)
{
	if (!musb->ops->set_mode)
		return musb_default_set_mode(musb, mode);

	return musb->ops->set_mode(musb, mode);
}

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
