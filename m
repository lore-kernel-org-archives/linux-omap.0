From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 2/4] usb: musb: Prepare dsps glue layer for PM runtime
 support
Date: Fri, 2 Sep 2016 07:59:21 -0700
Message-ID: <20160902145921.3cnff53q7bnsm4be@atomide.com>
References: <1471560410-6428-1-git-send-email-tony@atomide.com>
 <1471560410-6428-3-git-send-email-tony@atomide.com>
 <20160902140537.GC22318@uda0271908>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160902140537.GC22318@uda0271908>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Bin Liu <b-liu-l0cyMroinI0@public.gmane.org> [160902 07:05]:
> On Thu, Aug 18, 2016 at 03:46:48PM -0700, Tony Lindgren wrote:
> > +	case OTG_STATE_A_WAIT_BCON:
> >  		mod_timer(&glue->timer, jiffies +
> > -				msecs_to_jiffies(wrp->poll_timeout));
> > +			  msecs_to_jiffies(wrp->poll_timeout));
> 
> Unintentional change? I undo'ed it in my tree.

Yes that's not needed thanks.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
