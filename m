From: "Guruswamy, Senthilvadivu" <svadivu@ti.com>
Subject: RE: [PATCH v4 3/3] OMAP: DSS2: OMAPFB: Allow usage of def_vrfb only
 for omap2,3
Date: Thu, 7 Oct 2010 16:02:21 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087034B94AF5A@dbde02.ent.ti.com>
References: <1286442535-28308-1-git-send-email-svadivu@ti.com>
 <1286442535-28308-2-git-send-email-svadivu@ti.com>
 <1286442535-28308-3-git-send-email-svadivu@ti.com>
 <1286442535-28308-4-git-send-email-svadivu@ti.com>
 <19F8576C6E063C45BE387C64729E739404AA21D04F@dbde02.ent.ti.com>
 <FCCFB4CDC6E5564B9182F639FC356087034B94AF34@dbde02.ent.ti.com>
 <19F8576C6E063C45BE387C64729E739404AA21D08B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54301 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751485Ab0JGKcc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Oct 2010 06:32:32 -0400
In-Reply-To: <19F8576C6E063C45BE387C64729E739404AA21D08B@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: Hiremath, Vaibhav
> 
> > -----Original Message-----
> > From: Guruswamy, Senthilvadivu
> >
> >
> >
> > > -----Original Message-----
> > > From: Hiremath, Vaibhav
> > >
> > >
> > > > -----Original Message-----
> > > > From: Guruswamy, Senthilvadivu
> > > >
> > > > From: Senthilvadivu Guruswamy <svadivu@ti.com>
> > > >
> > > > Force def_vrfb to 0 for non omap2, omap3 devices
> > > >
> > >
> > > Can we reword the commit description to something like,
> > >
> > > "For Non-VRFB devices/platforms (omap2, omap3 family) force it to the
> > DMA
> > > based rotation."
> > >
> > [Senthil] Yes, taken.
> > > > Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
> > > > ---
> > > >  drivers/video/omap2/omapfb/omapfb-main.c |   10 ++++++++++
> > > >  1 files changed, 10 insertions(+), 0 deletions(-)
> > > >
> > > > diff --git a/drivers/video/omap2/omapfb/omapfb-main.c
> > > > b/drivers/video/omap2/omapfb/omapfb-main.c
> > > > index 4b4506d..0f79db8 100644
> > > > --- a/drivers/video/omap2/omapfb/omapfb-main.c
> > > > +++ b/drivers/video/omap2/omapfb/omapfb-main.c
> > > > @@ -2128,6 +2128,16 @@ static int omapfb_probe(struct
> platform_device
> > > > *pdev)
> > > >  		goto err0;
> > > >  	}
> > > >
> > > > +	/* TODO : Replace cpu check with omap_has_vrfb once
> HAS_FEATURE
> > > > +	*	 available for OMAP2 and OMAP3
> > > > +	*/
> > >
> > > This patch may conflict with Archit HAS_FEATURE patch sets. And if I
> > > understand correctly it has almost making it to DSS2 tree.
> > [Senthil] As Archit replied in the other thread, HAS_FEATURE of DSS does
> > not cover VRFB, so this would be dependant on the HAS_FEATURE OMAP once
> it
> > is developed.
> >
> > >
> > > > +	if (def_vrfb && (!cpu_is_omap24xx()) && (!cpu_is_omap34xx()))
> {
> > > [Hiremath, Vaibhav] Any way we are forcing to DMA based rotation, then
> > why
> > > to check for def_vrfb in the above condition. It can be something
> > >
> > > if (!cpu_is_omap24xx() && !cpu_is_omap34xx()) {
> > > 	def_vrfb = 0;
> > > 	...
> > > }
> > >
> > > Does it make sense to you?
> > [Senthil] The intention of this check is to warn the user if def_vrfb is
> > given as bootarg by chance on wrong omap devices.  That's why the if
> > condition is framed like this.
> 
> Ok, no issues.
> 
> > If this is considered as an ACK then I could generate v5 with the change
> > in the description alone.
> >
> 
> Yes I think I am ok here, unless Tomi has any comments here.
> 
> Acked-by: Vaibhav Hiremath <hvaibhav@ti.com>
> 
[Senthil]  Thanks, All of Tomi's comments were incorporated in v4 itself.  Will send v5 in a short while.
> Thanks,
> Vaibhav
> 
> 
> > > Thanks,
> > > Vaibhav
> > >
> > > > +		def_vrfb = 0;
> > > > +		dev_warn(&pdev->dev, "VRFB is not in this device,"
> > > > +				"using DMA for rotation\n");
> > > > +	}
> > > > +
> > > > +
> > > >  	mutex_init(&fbdev->mtx);
> > > >
> > > >  	fbdev->dev = &pdev->dev;
> > > > --
> > > > 1.6.3.3

