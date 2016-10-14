From: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 0/2] Fixes for two more musb regressions
Date: Fri, 14 Oct 2016 13:43:15 -0500
Message-ID: <20161014184254.GA4035@uda0271908>
References: <20160930181010.3829-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160930181010.3829-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Fri, Sep 30, 2016 at 11:10:08AM -0700, Tony Lindgren wrote:
> Hi all,
> 
> Looks like we have two more regressions caused by my attempts
> to make musb PM simpler. As it's very close to the merge window
> opening, these are against current Linux next.
> 
> Once reviewed, tested and merged to the mainline kernel we can
> request these to be included also into v4.8.y kernel. Maybe Bin
> can tag these as cc stable v4.8 already when applying.
> 
> Regards,
> 
> Tony
> 
> Tony Lindgren (2):
>   usb: musb: Fix hardirq-safe hardirq-unsafe lock order error
>   usb: musb: Call pm_runtime from musb_gadget_queue

Applied.

Regards,
-Bin.

> 
>  drivers/usb/musb/musb_gadget.c | 4 ++++
>  drivers/usb/musb/omap2430.c    | 7 ++-----
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 
> -- 
> 2.9.3
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
