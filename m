From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH v5 3/3] OMAP: DSS2: OMAPFB: Allow usage of def_vrfb only
 for omap2,3
Date: Thu, 7 Oct 2010 18:33:22 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404AA21D132@dbde02.ent.ti.com>
References: <1286450155-1460-1-git-send-email-svadivu@ti.com>
	 <1286450155-1460-2-git-send-email-svadivu@ti.com>
	 <1286450155-1460-3-git-send-email-svadivu@ti.com>
	 <1286450155-1460-4-git-send-email-svadivu@ti.com>
 <1286456423.28499.1057.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:32833 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753524Ab0JGNDa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Oct 2010 09:03:30 -0400
In-Reply-To: <1286456423.28499.1057.camel@tubuntu.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>, "Guruswamy, Senthilvadivu" <svadivu@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> Sent: Thursday, October 07, 2010 6:30 PM
> To: Guruswamy, Senthilvadivu
> Cc: Hiremath, Vaibhav; linux-omap@vger.kernel.org
> Subject: Re: [PATCH v5 3/3] OMAP: DSS2: OMAPFB: Allow usage of def_vrfb
> only for omap2,3
> 
> On Thu, 2010-10-07 at 13:15 +0200, ext Guruswamy Senthilvadivu wrote:
> > From: Senthilvadivu Guruswamy <svadivu@ti.com>
> >
> > For Non-VRFB devices/platforms (omap2, omap3 family) force it to the
> > DMA based rotation.
> 
> This sounds a bit confusing, as if omap2 and omap3 are Non-VRFB devices.
> 
[Hiremath, Vaibhav] My bad. Mistakenly typed omap2/3 here. 

Thanks,
Vaibhav

> And I'm not sure it's exactly correct to say "forcing to DMA rotation".
> We're just disallowing the use of VRFB, not forcing to use DMA rotation.
> Of course DMA rotation is currently the only other option, but still.
> 
> I'd put it:
> 
> VRFB is supported on OMAP2 and OMAP3 platforms. If VRFB rotation is not
> supported by the hardware and the user requests VRFB rotation, print a
> warning and ignore the request from the user.
> 
> > Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
> > ---
> >  drivers/video/omap2/omapfb/omapfb-main.c |   10 ++++++++++
> >  1 files changed, 10 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/video/omap2/omapfb/omapfb-main.c
> b/drivers/video/omap2/omapfb/omapfb-main.c
> > index bddfca6..fcd9038 100644
> > --- a/drivers/video/omap2/omapfb/omapfb-main.c
> > +++ b/drivers/video/omap2/omapfb/omapfb-main.c
> > @@ -2198,6 +2198,16 @@ static int omapfb_probe(struct platform_device
> *pdev)
> >  		goto err0;
> >  	}
> >
> > +	/* TODO : Replace cpu check with omap_has_vrfb once HAS_FEATURE
> > +	*	 available for OMAP2 and OMAP3
> > +	*/
> > +	if (def_vrfb && (!cpu_is_omap24xx()) && (!cpu_is_omap34xx())) {
> 
> The parenthesis are extra around !cpu_is_xxxx calls.
> 
> > +		def_vrfb = 0;
> > +		dev_warn(&pdev->dev, "VRFB is not in this device,"
> > +				"using DMA for rotation\n");
> 
> How about: "VRFB is not supported by the hardware, ignoring vrfb=y
> module parameter".
> 
> Otherwise I think the patch set is ok. If you're fine with these
> changes, I can make them while applying these to my tree. Or send a new
> patch set, both are fine for me.
> 
>  Tomi
> 

