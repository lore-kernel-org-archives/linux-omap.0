From: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 0/2] Few PM fixes for MUSB for v4.9 merge window
Date: Wed, 21 Sep 2016 15:08:29 -0500
Message-ID: <20160921200802.GA3981@uda0271908>
References: <20160915162914.8164-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160915162914.8164-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Thu, Sep 15, 2016 at 09:29:12AM -0700, Tony Lindgren wrote:
> Hi,
> 
> I noticed few corner cases we're not handling properly with the
> musb hardware session bit based PM runtime heading for v4.9.
> 
> Probably the disconnect after unconfigure PM issue has always
> been there, but fixing it without the session bit based PM
> runtime would be a mess.
> 
> Regards,
> 
> Tony
> 
> Tony Lindgren (2):
>   usb: musb: Fix PM runtime for disconnect after unconfigure
>   usb: musb: Fix session based PM for first invalid VBUS
> 
>  drivers/usb/musb/musb_core.c   | 13 ++++++++-----
>  drivers/usb/musb/musb_core.h   |  1 +
>  drivers/usb/musb/musb_gadget.c |  3 +++
>  3 files changed, 12 insertions(+), 5 deletions(-)

Applied. Thanks.

Regards,
-Bin.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
