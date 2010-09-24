From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH 1/1] omap: fix section mismatch errors
Date: Fri, 24 Sep 2010 11:40:11 +0300
Message-ID: <1285317611.2468.65.camel@tubuntu.research.nokia.com>
References: <1281972677-1636-1-git-send-email-premi@ti.com>
	 <20100923163644.GK4211@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mgw-sa02.nokia.com ([147.243.1.48]:60438 "EHLO
	mgw-sa02.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750835Ab0IXIkQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Sep 2010 04:40:16 -0400
In-Reply-To: <20100923163644.GK4211@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: Sanjeev Premi <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 2010-09-23 at 18:36 +0200, ext Tony Lindgren wrote:
> * Sanjeev Premi <premi@ti.com> [100816 08:24]:
> > This patch fixes miltiple section mismatch errors
> > observed with the latest master.
> 
> Few comments below.
>  
> > @@ -134,7 +134,7 @@ static inline void board_smc91x_init(void)
> >  
> >  #endif
> >  
> > -static struct omap_board_config_kernel sdp2430_config[] = {
> > +static struct omap_board_config_kernel sdp2430_config[] __initdata = {
> >  	{OMAP_TAG_LCD, &sdp2430_lcd_config},
> >  };
> ...
>   
> Let's just get rid of omap_get_config stuff. The OMAP_TAG_LCD
> and OMAP_TAG_FBMEM are the last remaining legacy tags. They should
> be replaced with just platform_data. And while at it, it should
> be done for all the boards.
> 
> Tomi, do you see any problems with that?

OMAP_TAG_LCD and OMAP_TAG_FBMEM are used by the old omapfb driver.

I don't see any problem in changing them to platform data, except that
it's some work and somebody should do it =).

 Tomi


