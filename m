From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH] ARM: OMAP: replace checks for CONFIG_USB_GADGET_OMAP
Date: Fri, 16 May 2014 11:36:14 +0200
Message-ID: <1400232974.20342.22.camel@x220>
References: <1400187345.11786.28.camel@x220>
	 <20140515231229.GA25523@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cpsmtpb-ews02.kpnxchange.com ([213.75.39.5]:61619 "EHLO
	cpsmtpb-ews02.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756258AbaEPJgQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 May 2014 05:36:16 -0400
In-Reply-To: <20140515231229.GA25523@saruman.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org

Felipe,

On Thu, 2014-05-15 at 18:12 -0500, Felipe Balbi wrote:
> On Thu, May 15, 2014 at 10:55:45PM +0200, Paul Bolle wrote:
> > diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
> > index 65d2acb31498..57092bc7f4f1 100644
> > --- a/arch/arm/mach-omap1/board-h2.c
> > +++ b/arch/arm/mach-omap1/board-h2.c
> > @@ -346,7 +346,7 @@ static struct omap_usb_config h2_usb_config __initdata = {
> >  	/* usb1 has a Mini-AB port and external isp1301 transceiver */
> >  	.otg		= 2,
> >  
> > -#ifdef	CONFIG_USB_GADGET_OMAP
> > +#ifdef	CONFIG_USB_OMAP
> 
> CONFIG_USB_OMAP is tristate, it might be better to use
> IS_ENABLED(CONFIG_USB_OMAP) here. Likewise for the rest of the patch.

Will do shortly. That does increase the scope of the patch, a bit, but
since this code has been effectively dead since v3.1 that is hardly an
additional risk.

Thanks!


Paul Bolle

