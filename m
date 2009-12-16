From: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 1/4] musb: get rid of unneeded musb->config->dyn_fifo
Date: Wed, 16 Dec 2009 10:36:29 +0530
Message-ID: <19F8576C6E063C45BE387C64729E73940449F43579@dbde02.ent.ti.com>
References: <1260883909-26836-1-git-send-email-ajay.gupta@ti.com>
 <20091215173950.GI4575@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20091215173950.GI4575-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

> -----Original Message-----
> From: Tony Lindgren [mailto:tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org]
> Sent: Tuesday, December 15, 2009 11:10 PM
> To: Gupta, Ajay Kumar
> Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
> Subject: Re: [PATCH 1/4] musb: get rid of unneeded musb->config->dyn_fifo
> 
> * Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org> [091215 05:31]:
> > We can get dynamic FIFO information from CONFIGDATA register and
> > thus there is no need for any user defiend dyn_fifo.
> 
> Have you tested this?
> 
> $ grep dyn_fifo arch/arm/mach-omap2/*.c
> arch/arm/mach-omap2/usb-musb.c: .dyn_fifo       = 1,

I did test but with this arch specific compilation fixes. 

We are still waiting a response from Greg if he will accept these arch specific changes with USB patch set.

-Ajay
> 
> Tony
> 
> > Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
> > ---
> >  drivers/usb/musb/musb_core.c |   19 ++++---------------
> >  include/linux/usb/musb.h     |    1 -
> >  2 files changed, 4 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> > index 49f2346..2858940 100644
> > --- a/drivers/usb/musb/musb_core.c
> > +++ b/drivers/usb/musb/musb_core.c
> > @@ -1404,21 +1404,10 @@ static int __init musb_core_init(u16 musb_type,
> struct musb *musb)
> >  	musb->nr_endpoints = 1;
> >  	musb->epmask = 1;
> >
> > -	if (reg & MUSB_CONFIGDATA_DYNFIFO) {
> > -		if (musb->config->dyn_fifo)
> > -			status = ep_config_from_table(musb);
> > -		else {
> > -			ERR("reconfigure software for Dynamic FIFOs\n");
> > -			status = -ENODEV;
> > -		}
> > -	} else {
> > -		if (!musb->config->dyn_fifo)
> > -			status = ep_config_from_hw(musb);
> > -		else {
> > -			ERR("reconfigure software for static FIFOs\n");
> > -			return -ENODEV;
> > -		}
> > -	}
> > +	if (reg & MUSB_CONFIGDATA_DYNFIFO)
> > +		status = ep_config_from_table(musb);
> > +	else
> > +		status = ep_config_from_hw(musb);
> >
> >  	if (status < 0)
> >  		return status;
> > diff --git a/include/linux/usb/musb.h b/include/linux/usb/musb.h
> > index d437556..c5f006e 100644
> > --- a/include/linux/usb/musb.h
> > +++ b/include/linux/usb/musb.h
> > @@ -30,7 +30,6 @@ struct musb_hdrc_eps_bits {
> >  struct musb_hdrc_config {
> >  	/* MUSB configuration-specific details */
> >  	unsigned	multipoint:1;	/* multipoint device */
> > -	unsigned	dyn_fifo:1;	/* supports dynamic fifo sizing */
> >  	unsigned	soft_con:1;	/* soft connect required */
> >  	unsigned	utm_16:1;	/* utm data witdh is 16 bits */
> >  	unsigned	big_endian:1;	/* true if CPU uses big-endian */
> > --
> > 1.6.2.4
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
