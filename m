From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] ARM: OMAP: board-omap3beagle: set i2c-3 to 100kHz
Date: Fri, 23 Jan 2009 01:52:16 -0800
Message-ID: <200901230152.17239.david-b@pacbell.net>
References: <1232047837-23052-1-git-send-email-koen@openembedded.net> <A11F15D6-F171-4D62-ADB9-1508B57037E4@beagleboard.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp115.sbc.mail.sp1.yahoo.com ([69.147.64.88]:31750 "HELO
	smtp115.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756549AbZAWJwT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 Jan 2009 04:52:19 -0500
In-Reply-To: <A11F15D6-F171-4D62-ADB9-1508B57037E4@beagleboard.org>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen@beagleboard.org>
Cc: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, Beagle Board <beagleboard@googlegroups.com>

On Friday 23 January 2009, Koen Kooi wrote:
> 
> Op 15 jan 2009, om 20:30 heeft Koen Kooi het volgende geschreven:
> 
> > From: Koen Kooi <koen@beagleboard.org>
> >
> > Changing it to 100kHz is needed to make more devices works properly.  
> > Controlling the TI DLP Pico projector[1] doesn't work properly at  
> > 400kHz, 100kHz and lower work fine. EDID readout is unaffected by  
> > this change.
> >
> > [1] http://focus.ti.com/dlpdmd/docs/dlpdiscovery.tsp?sectionId=60&tabId=2234
> >
> > Signed-off-by: Koen Kooi <koen@beagleboard.org>
> 
> Any comments on this patch?

I2C-3 is only used for talking on DVI, right?
Which means EDID ... and maybe DLP/Pico, unless
someone uses it as an I2C adapter.  (Which some
folk hack together on PCs...)

Seems harmless to me, but I'd add a comment
explaining why just 100 MHz.  (The Pico manual
says 400 KHz should work.)

- Dave


> 
> regards,
> 
> Koen
> 
> 
> 
> 
> >
> > ---
> > arch/arm/mach-omap2/board-omap3beagle.c |    2 +-
> > 1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach- 
> > omap2/board-omap3beagle.c
> > index fe97bab..f279404 100644
> > --- a/arch/arm/mach-omap2/board-omap3beagle.c
> > +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> > @@ -227,7 +227,7 @@ static int __init omap3_beagle_i2c_init(void)
> > #ifdef CONFIG_I2C2_OMAP_BEAGLE
> > 	omap_register_i2c_bus(2, 400, NULL, 0);
> > #endif
> > -	omap_register_i2c_bus(3, 400, NULL, 0);
> > +	omap_register_i2c_bus(3, 100, NULL, 0);
> > 	return 0;
> > }
> >
> > -- 
> > 1.5.6.3
