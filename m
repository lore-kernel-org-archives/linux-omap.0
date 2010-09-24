From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] omap: fix section mismatch errors
Date: Fri, 24 Sep 2010 10:41:22 -0700
Message-ID: <20100924174122.GD4211@atomide.com>
References: <1281972677-1636-1-git-send-email-premi@ti.com>
 <20100923163644.GK4211@atomide.com>
 <1285317611.2468.65.camel@tubuntu.research.nokia.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301F7075390@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50709 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752647Ab0IXRl1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Sep 2010 13:41:27 -0400
Content-Disposition: inline
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301F7075390@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Premi, Sanjeev <premi@ti.com> [100924 07:01]:
> > -----Original Message-----
> > From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com] 
> > Sent: Friday, September 24, 2010 2:10 PM
> > To: ext Tony Lindgren
> > Cc: Premi, Sanjeev; linux-omap@vger.kernel.org
> > Subject: Re: [PATCH 1/1] omap: fix section mismatch errors
> > 
> > On Thu, 2010-09-23 at 18:36 +0200, ext Tony Lindgren wrote:
> > > * Sanjeev Premi <premi@ti.com> [100816 08:24]:
> > > > This patch fixes miltiple section mismatch errors
> > > > observed with the latest master.
> > > 
> > > Few comments below.
> > >  
> > > > @@ -134,7 +134,7 @@ static inline void board_smc91x_init(void)
> > > >  
> > > >  #endif
> > > >  
> > > > -static struct omap_board_config_kernel sdp2430_config[] = {
> > > > +static struct omap_board_config_kernel sdp2430_config[] 
> > __initdata = {
> > > >  	{OMAP_TAG_LCD, &sdp2430_lcd_config},
> > > >  };
> > > ...
> > >   
> > > Let's just get rid of omap_get_config stuff. The OMAP_TAG_LCD
> > > and OMAP_TAG_FBMEM are the last remaining legacy tags. They should
> > > be replaced with just platform_data. And while at it, it should
> > > be done for all the boards.
> > > 
> > > Tomi, do you see any problems with that?
> > 
> > OMAP_TAG_LCD and OMAP_TAG_FBMEM are used by the old omapfb driver.
> > 
> > I don't see any problem in changing them to platform data, except that
> > it's some work and somebody should do it =).
> > 
> >  Tomi
> > 
> Tony,
> 
> Can we do this as a separate patch? Or should I go down this path in
> same context?... it may delay this patch.

Sounds like a separate patch. But let's not create noise about
OMAP_TAG_LCD related warnings if we intent to remove them later on
anyways.

Tony
