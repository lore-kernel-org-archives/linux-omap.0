From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] usb: musb: Fix locking errors for host only mode
Date: Wed, 24 Aug 2016 12:15:09 -0700
Message-ID: <20160824191508.nf63okevka5kkfks@atomide.com>
References: <1471560038-6243-1-git-send-email-tony@atomide.com>
 <20160824184552.GB4050@uda0271908>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160824184552.GB4050@uda0271908>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Bin Liu <b-liu-l0cyMroinI0@public.gmane.org> [160824 11:47]:
> Hi,
> 
> On Thu, Aug 18, 2016 at 03:40:38PM -0700, Tony Lindgren wrote:
> > If we have USB gadgets disabled and USB_MUSB_HOST set, we get
> > errors "possible irq lock inverssion dependency detected"
> > errors during boot.
> 
> On which platform was this issue found? I am trying to replicate the
> issue on am335x, but have no luck yet - musb-hdrc does not load at all
> when usb gadget support is disabled.

It seems to be with a built-in MUSB and gadgets in the .config,
I'll forward you the one I got earlier from Ladis.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
