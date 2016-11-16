From: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv3 0/6] musb fixes for v4.9-rc cycle
Date: Wed, 16 Nov 2016 13:25:19 -0600
Message-ID: <20161116192500.GB9487@uda0271908>
References: <20161115213755.12316-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161115213755.12316-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Tue, Nov 15, 2016 at 01:37:49PM -0800, Tony Lindgren wrote:
> Hi all,
> 
> Here's v3 of musb fixes for issues that I've been able to track down.
> The PM changes merged for v4.9 popped up various issues reported by
> people that I had not seen earlier with my tests.
> 
> As many people depend on this driver, I'd like to have these merged
> for v4.9-rc cycle.
> 
> Regards,
> 
> Tony
> 
> 
> Changes since v2:
> 
> - Collect acks, update patch descriptions and remove one comment
>   line based on comments from Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> 
> Changes since v1:
> 
> - Numerous changes to patch 2/4 for the sleeping function fix
>   based on comments from Johan
> 
>   - Two new patches to fix issues with devices not always
>     enumerating by removing pointless PM runtime code
> 
> Tony Lindgren (6):
>   usb: musb: Fix broken use of static variable for multiple instances
>   usb: musb: Fix sleeping function called from invalid context for hdrc
>     glue
>   usb: musb: Fix PM for hub disconnect
>   usb: musb: Add missing pm_runtime_disable and drop 2430 PM timeout
>   usb: musb: Drop pointless PM runtime code for dsps glue
>   phy: twl4030-usb: Fix for musb session bit based PM
> 
>  drivers/phy/phy-twl4030-usb.c  |   4 +-
>  drivers/usb/musb/musb_core.c   | 147 ++++++++++++++++++++++++++++++++++++-----
>  drivers/usb/musb/musb_core.h   |  13 +++-
>  drivers/usb/musb/musb_dsps.c   |  58 ++++++++--------
>  drivers/usb/musb/musb_gadget.c |  39 +++++++++--
>  drivers/usb/musb/omap2430.c    |  10 ++-
>  drivers/usb/musb/tusb6010.c    |   6 +-
>  7 files changed, 209 insertions(+), 68 deletions(-)
> 
Applied and pushed out.

Thanks,
-Bin.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
