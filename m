From: Felipe Balbi <me@felipebalbi.com>
Subject: RE: [PATCH 1/2] ARM : OMAP: MUSB : Pass board specific data using
 a structure
Date: Wed, 30 Dec 2009 14:13:54 +0200
Message-ID: <1262175234.28789.193.camel@gandalf>
References: <1262169883-31226-1-git-send-email-x0082077@ti.com>
	 <19F8576C6E063C45BE387C64729E7394044A277B44@dbde02.ent.ti.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:58423 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752127AbZL3MOD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Dec 2009 07:14:03 -0500
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044A277B44@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Cc: "Mankad, Maulik Ojas" <x0082077@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@suse.de>

Hi,

On Wed, 2009-12-30 at 16:29 +0530, Gupta, Ajay Kumar wrote:
> Hi,
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Mankad, Maulik Ojas
> > Sent: Wednesday, December 30, 2009 4:15 PM
> > To: linux-omap@vger.kernel.org
> > Cc: linux-usb@vger.kernel.org; Mankad, Maulik Ojas; Felipe Balbi; Tony
> > Lindgren; Greg Kroah-Hartman
> > Subject: [PATCH 1/2] ARM : OMAP: MUSB : Pass board specific data using a
> > structure
> > 
> > ARM : OMAP: MUSB :Pass board specific data from board file
> > 
> > This patch proposes to pass board specific data for MUSB
> > (like interface_type, mode etc) from board file by defining
> > board specific structure.
> > 
> > Each board file can define this structure based on
> > its requirement and pass this information to the
> > driver.
> > 
> > It addresses a comment from Felipe and thus help
> > by preventing addition of too many fields in
> > musb_platform_data.
> > 
> > Signed-off-by: Maulik Mankad <x0082077@ti.com>
> > Cc: Felipe Balbi <felipe.balbi@nokia.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: Greg Kroah-Hartman <gregkh@suse.de>
> > 
> > Index: felipe_musb/arch/arm/mach-omap2/board-2430sdp.c
> > ===================================================================
> > --- felipe_musb.orig/arch/arm/mach-omap2/board-2430sdp.c
> > +++ felipe_musb/arch/arm/mach-omap2/board-2430sdp.c
> > @@ -195,6 +195,12 @@ static struct twl4030_hsmmc_info mmc[] _
> >  	{}	/* Terminator */
> >  };
> > 
> > +static struct musb_omap_data omap2430sdp_data = {
> > +.interface_type	= MUSB_INTERFACE_ULPI,
> > +.mode		= MUSB_OTG,
> > +.power		= 100,
> > +}
> > +

fix the indentation.

> > -extern void usb_musb_init(enum musb_mode mode, unsigned power);
> > +struct musb_omap_data {
> > +u8	interface_type;
> > +u8	mode;
> > +u8	power;
> > +};
> 
> It's board data so how about 'struct omap_musb_board_data'.

good point.

> > +
> > +enum musb_interface	{MUSB_INTERFACE_ULPI, MUSB_INTERFACE_UTMI};
> > +
> > +extern void usb_musb_init(void *);
> 
> Can be modified to:
> +extern void usb_musb_init(omap_musb_board_data *);

correct

> >  	if (cpu_is_omap243x())
> >  		musb_resources[0].start = OMAP243X_HS_BASE;
> >  	else
> > @@ -88,15 +90,16 @@ void __init usb_musb_init(enum musb_mode
> >  	 * musb_core.c have been converted to use use clkdev.
> >  	 */
> >  	musb_plat.clock = "ick";
> > -	musb_plat.power = power >> 1;
> > -	musb_plat.mode = mode;
> > +	musb_plat.arch_data = arch_data;
> 
> 
> Not needed.

why not ? we still want to pass interface_type down to omap2430.c,
right ?

> We don't need it as we will continue using 'power', 'mode', 'extvbus'
> From musb_plat only.

power and mode, yeah. extvbus is omap-only isn't it ? Then on omap2430.c
is interested in that ?!?

-- 
balbi

