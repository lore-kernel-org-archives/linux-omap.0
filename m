From: "Santhapuri, Damodar" <damodar.santhapuri-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v2 1/3] arm: omap: hwmod: add new memory resource for
 usb phy control
Date: Thu, 12 Jul 2012 08:52:07 +0000
Message-ID: <BF1B1853A762164888C918AB089265E4282FCD@DBDE01.ent.ti.com>
References: <4FFD7533.8010807@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4FFD7533.8010807-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


Hi,
> 
> Hello.
> 
> On 11-07-2012 14:29, Damodar Santhapuri wrote:
> 
> > From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
> 
> > Added usb_ctrl0 and usb_ctrl1 base address as new memory resources
> > which will be used at am335x musb driver glue layer to turn on or
> > off builin PHY untill we have a separate system control module
> > driver.
> 
> > Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
> > Singed-off-by: Damodar Santhapuri <x0132156-l0cyMroinI0@public.gmane.org>
> > ---
> > Changes from v0:
> > Reordered the layout based on Kishon's comment on not using
> > platform_get_resources_by_name.
> 
> >   arch/arm/mach-omap2/omap_hwmod_33xx_data.c |   12 ++++++++++++
> >   1 files changed, 12 insertions(+), 0 deletions(-)
> 
> > diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-
> omap2/omap_hwmod_33xx_data.c
> > index df888fe..ec9e9df 100644
> > --- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> > +++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> > @@ -3269,11 +3269,23 @@ static struct omap_hwmod_addr_space
> am33xx_usbss_addr_space[] = {
> >   		.flags		= ADDR_TYPE_RT
> >   	},
> >   	{
> > +		.name		= "usb_ctrl0",
> > +		.pa_start	= 0x44E10620,
> > +		.pa_end		= 0x44E10624,
> 
>    Not 0x44E10623?
> 
> > +		.flags		= ADDR_TYPE_RT
> > +	},
> > +	{
> >   		.name		= "musb1",
> >   		.pa_start	= 0x47401800,
> >   		.pa_end		= 0x47401800 + SZ_2K - 1,
> >   		.flags		= ADDR_TYPE_RT
> >   	},
> > +	{
> > +		.name		= "usb_ctrl1",
> > +		.pa_start	= 0x44E10628,
> > +		.pa_end		= 0x44E1062c,
> 
>     Not 0x44E1062B?

I will fix this and send you updated patch.

Damodar .
> 
> WBR, Sergei
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
