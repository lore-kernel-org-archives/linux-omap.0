From: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 10/15] usb: musb: Don't set d+ high before enable for
 2430 glue layer
Date: Sat, 14 May 2016 23:47:16 -0500
Message-ID: <20160515044716.GC20689@uda0271908>
References: <1463014396-4095-1-git-send-email-tony@atomide.com>
 <1463014396-4095-11-git-send-email-tony@atomide.com>
 <20160513210334.GC1665@uda0271908>
 <20160513211739.GE5995@atomide.com>
 <20160513223540.GH5995@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160513223540.GH5995-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Fri, May 13, 2016 at 03:35:40PM -0700, Tony Lindgren wrote:
> * Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [160513 14:19]:
> > * Bin Liu <b-liu-l0cyMroinI0@public.gmane.org> [160513 14:05]:
> > > In stead of removing it, session bit should only be set when musb_mode
> > > == MUSB_HOST, will this fix the D+ pullup problem?
> > 
> > Good point, I forgot about it being specific to host mode. I'll check.
> 
> Yeah good call, the patch below fixes the issue. Then we can remove the

Good to know it fixes the issue.

> set_mode later if the generic approach looks OK to you.

I don't think we need to add the generic approach which sets session bit
in core set_mode(), at least for now, because only omap2430 glue needs
to set the session bit in its set_mode(), no one else does so.

Regards,
-Bin.

> 
> Regards,
> 
> Tony
> 
> 8< ----------------------
> From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> Date: Fri, 13 May 2016 07:59:35 -0700
> Subject: [PATCH] usb: musb: Don't set d+ high before enable for 2430 glue
>  layer
> 
> At least 2430 glue layer pulls d+ high on start up even if there are
> no gadgets configured. This is bad at least for anything using a separate
> battery charger chip as it can confuse the charger detection.
> 
> Let's fix the issue by only setting the SESSION bit in host mode
> as suggested by Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>.
> 
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> 
> --- a/drivers/usb/musb/omap2430.c
> +++ b/drivers/usb/musb/omap2430.c
> @@ -124,8 +124,12 @@ static void omap2430_musb_set_vbus(struct musb *musb, int is_on)
>  
>  static int omap2430_musb_set_mode(struct musb *musb, u8 musb_mode)
>  {
> -	u8	devctl = musb_readb(musb->mregs, MUSB_DEVCTL);
> +	u8 devctl;
>  
> +	if (musb_mode != MUSB_HOST)
> +		return 0;
> +
> +	devctl = musb_readb(musb->mregs, MUSB_DEVCTL);
>  	devctl |= MUSB_DEVCTL_SESSION;
>  	musb_writeb(musb->mregs, MUSB_DEVCTL, devctl);
>  
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
