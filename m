From: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 02/10] usb: musb: Fix idling after host mode by
 increasing autosuspend delay
Date: Thu, 5 May 2016 12:47:42 -0500
Message-ID: <20160505174742.GF22575@uda0271908>
References: <1461864800-29979-1-git-send-email-tony@atomide.com>
 <1461864800-29979-3-git-send-email-tony@atomide.com>
 <20160505150159.GA25950@uda0271908>
 <20160505170439.GX5995@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160505170439.GX5995-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Thu, May 05, 2016 at 10:04:39AM -0700, Tony Lindgren wrote:
> * Bin Liu <b-liu-l0cyMroinI0@public.gmane.org> [160505 08:04]:
> > Hi,
> > 
> > On Thu, Apr 28, 2016 at 10:33:12AM -0700, Tony Lindgren wrote:
> > > Looks like at least 2430 glue won't idle reliably with the 200 ms
> > > autosuspend delay. This causes deeper idle states being blocked for
> > > the whole SoC when disconnecting OTG A cable.
> > > 
> > > Increasing the delay to 500 ms seems to idle both MUSB and the PHY
> > > reliably. This is probably because of time needed by the hardware
> > > based negotiation between MUSB and the PHY.
> > 
> > Unless we know other glues also have the same issue, this change
> > affects other glues, right? Can we just increase it for 2430 only?
> 
> Well it's hard to say with no PM working with other glue layers right
> now. I would not be suprised if similar issue exists with other phys

Right.

> too talking with musb.
> 
> Does the current 200 ms autosuspend timeout relate to anything real
> other than what I found out with my measurements?

Not sure, I didn't checkk where the 200ms comes from.

> 
> If there's no other data available for the 200 ms timeout, I suggest
> we just set it to 500 ms and add comments there that at least 2430
> glue needs that. If things are not idling properly for the whole
> SoC because musb, the power consumption will be way worse than any
> power savings between 200 and 500 ms :)

Yeah, make sense.

> 
> BTW, I noticed 300 ms did not make a difference there, and 500 ms
> seems to work so far.
> 
> Regards,
> 
> Tony

Regards,
-Bin.

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
