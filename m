From: Felipe Balbi <me@felipebalbi.com>
Subject: RE: [PATCH 7/8] arm: omap: musb: pass board mode to usb_musb_init
Date: Wed, 30 Dec 2009 14:06:35 +0200
Message-ID: <1262174795.28789.190.camel@gandalf>
References: <1261998590-6639-1-git-send-email-felipe.balbi@nokia.com>
	 <1261998590-6639-8-git-send-email-felipe.balbi@nokia.com>
	 <19F8576C6E063C45BE387C64729E7394044A277AD4@dbde02.ent.ti.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:56621 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820AbZL3MGm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Dec 2009 07:06:42 -0500
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044A277AD4@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Wed, 2009-12-30 at 10:14 +0530, Gupta, Ajay Kumar wrote:
> Hi,
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Felipe Balbi
> > Sent: Monday, December 28, 2009 4:40 PM
> > To: Tony Lindgren
> > Cc: Linux OMAP Mailing List; Felipe Balbi
> > Subject: [PATCH 7/8] arm: omap: musb: pass board mode to usb_musb_init
> > 
> > each board will have a different mode which is peculiar
> > to that board.
> > 
> > Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> > ---
> <snip>
> 
> > 
> >  #include <mach/hardware.h>
> >  #include <asm/mach-types.h>
> > @@ -203,7 +204,7 @@ static void __init omap_2430sdp_init(void)
> >  	platform_add_devices(sdp2430_devices, ARRAY_SIZE(sdp2430_devices));
> >  	omap_serial_init();
> >  	twl4030_mmc_init(mmc);
> > -	usb_musb_init(100);
> > +	usb_musb_init(MUSB_OTG, 100);
> 
> Similarly, we would need another parameter 'extvbus' which is required by
> OMAP3EVM Rev >= E. This way the parameter list would keep increasing and
> would look ugly.
> 
> So how about passing a "struct musb_board_data" structure completely ? It
> Can be generic across the musb platforms or we can have it only for OMAP
> platforms.


I suggested that off list already. We will add some void * to
musb_platform_data which would allow archs to pass whatever data
structure they want down to drivers/usb/musb/<arch>.c

-- 
balbi

