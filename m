From: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 0/4] Implement PM runtime for musb-core based on session
 bit
Date: Fri, 2 Sep 2016 09:00:33 -0500
Message-ID: <20160902140016.GA22318@uda0271908>
References: <1471560410-6428-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1471560410-6428-1-git-send-email-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Aug 18, 2016 at 03:46:46PM -0700, Tony Lindgren wrote:
> Hi all,
> 
> Here's a series of patches to simplify musb PM runtime support further.
> 
> I finally figured out that we can get rid of most of the glue layer
> specific workarounds by following the devctl session bit in musb core.
> 
> The series also adds PM runtime support to the musb dsps glue layer
> for the PIO mode.
> 
> I've tested basic plugging of cables in peripheral and host mode
> on omap3 and am335x using omap2plus_defconfig. Please test if you
> can.
> 
> Regards,
> 
> Tony
> 
> 
> Tony Lindgren (4):
>   usb: musb: Implement session bit based runtime PM for musb-core
>   usb: musb: Prepare dsps glue layer for PM runtime support
>   usb: musb: Add PM runtime support for MUSB DSPS glue layer
>   usb: musb: Simplify PM runtime for 2430 glue layer
> 
>  drivers/usb/musb/musb_core.c | 70 +++++++++++++++++++++++++++++++++++++
>  drivers/usb/musb/musb_core.h |  1 +
>  drivers/usb/musb/musb_dsps.c | 82 +++++++++++++++++++-------------------------
>  drivers/usb/musb/omap2430.c  | 76 ++++++----------------------------------
>  4 files changed, 117 insertions(+), 112 deletions(-)
 
Signed-off-by: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
with minor tweaks in patch 1/4 and 2/4.

Regards,
-Bin.

> -- 
> 2.8.1
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
