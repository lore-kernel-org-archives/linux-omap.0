From: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 10/15] usb: musb: Don't set d+ high before enable for
 2430 glue layer
Date: Fri, 13 May 2016 16:03:34 -0500
Message-ID: <20160513210334.GC1665@uda0271908>
References: <1463014396-4095-1-git-send-email-tony@atomide.com>
 <1463014396-4095-11-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1463014396-4095-11-git-send-email-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Wed, May 11, 2016 at 05:53:11PM -0700, Tony Lindgren wrote:
> At least 2430 glue layer pulls d+ high on start up even if there are
> no gadgets configured. This is bad at least for anything using a separate
> battery charger chip as it can confuse the charger detection.
> 
> Let's fix the issue by getting rid of omap2430_musb_set_mode() and only

By doing so, you lost the feature of switching mode from sysfs, I am not
sure if there is anyone using it though, still, it is a regression.

> write session bit in omap2430_musb_enable().

I don't think session bit needs to be set in _enable(), musb_start() in
core takes care of this bit.

> 
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/usb/musb/omap2430.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
> index 79e4cd7..958ae6a 100644
> --- a/drivers/usb/musb/omap2430.c
> +++ b/drivers/usb/musb/omap2430.c
> @@ -122,16 +122,6 @@ static void omap2430_musb_set_vbus(struct musb *musb, int is_on)
>  		musb_readb(musb->mregs, MUSB_DEVCTL));
>  }
>  
> -static int omap2430_musb_set_mode(struct musb *musb, u8 musb_mode)
> -{
> -	u8	devctl = musb_readb(musb->mregs, MUSB_DEVCTL);
> -
> -	devctl |= MUSB_DEVCTL_SESSION;
> -	musb_writeb(musb->mregs, MUSB_DEVCTL, devctl);

In stead of removing it, session bit should only be set when musb_mode
== MUSB_HOST, will this fix the D+ pullup problem?

> -
> -	return 0;
> -}
> -
>  static inline void omap2430_low_level_exit(struct musb *musb)
>  {
>  	u32 l;
> @@ -428,6 +418,9 @@ static void omap2430_musb_enable(struct musb *musb)
>  
>  	case MUSB_VBUS_VALID:
>  		omap_control_usb_set_mode(glue->control_otghs, USB_MODE_DEVICE);
> +		devctl = musb_readb(musb->mregs, MUSB_DEVCTL);
> +		devctl |= MUSB_DEVCTL_SESSION;
> +		musb_writeb(musb->mregs, MUSB_DEVCTL, devctl);

session bit is only set for host mode, VBUS_VALID is not a signal for
host mode. So you don't have to set the bit here.

>  		break;
>  
>  	default:
> @@ -472,7 +465,6 @@ static const struct musb_platform_ops omap2430_ops = {
>  	.init		= omap2430_musb_init,
>  	.exit		= omap2430_musb_exit,
>  
> -	.set_mode	= omap2430_musb_set_mode,
>  	.set_vbus	= omap2430_musb_set_vbus,
>  
>  	.enable		= omap2430_musb_enable,
> -- 
> 2.8.1
> 

Regards,
-Bin.

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
