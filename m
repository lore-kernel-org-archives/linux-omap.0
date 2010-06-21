From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH v3 2/3] OMAP: DSS2: OMAPFB: make VRFB depends on OMAP2,3
Date: Mon, 21 Jun 2010 14:27:16 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E91BF03@dbde02.ent.ti.com>
References: <1276778702-15280-1-git-send-email-svadivu@ti.com>
	 <1276778702-15280-2-git-send-email-svadivu@ti.com>
	 <1276778702-15280-3-git-send-email-svadivu@ti.com>
 <1277110241.2526.31.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36540 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756529Ab0FUI50 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Jun 2010 04:57:26 -0400
In-Reply-To: <1277110241.2526.31.camel@tubuntu.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>, "Guruswamy, Senthilvadivu" <svadivu@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-dev@vger.kernel.org" <linux-dev@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

> -----Original Message-----
> From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> Sent: Monday, June 21, 2010 2:21 PM
> To: Guruswamy, Senthilvadivu
> Cc: linux-omap@vger.kernel.org; linux-dev@vger.kernel.org; tony@atomide.com;
> Hiremath, Vaibhav
> Subject: Re: [PATCH v3 2/3] OMAP: DSS2: OMAPFB: make VRFB depends on OMAP2,3
> 
> On Thu, 2010-06-17 at 14:45 +0200, ext Guruswamy Senthilvadivu wrote:
> > From: Senthilvadivu Guruswamy <svadivu@ti.com>
> >
> > config VRFB should depend on ARCH_OMAP2 or ARCH_OMAP3.
> >
> > Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
> > ---
> >  drivers/video/omap2/Kconfig            |    4 ++++
> >  drivers/video/omap2/omapfb/Kconfig     |    1 -
> >  2 files changed,  4 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/video/omap2/Kconfig b/drivers/video/omap2/Kconfig
> > index d877c36..18bb835 100644
> > --- a/drivers/video/omap2/Kconfig
> > +++ b/drivers/video/omap2/Kconfig
> > @@ -3,6 +3,10 @@ config OMAP2_VRAM
> >
> >  config OMAP2_VRFB
> >  	bool
> > +	depends on ARCH_OMAP2 || ARCH_OMAP3
> > +	default y if FB_OMAP2
> > +	help
> > +	  OMAP VRFB buffer support is efficient for rotation
> >
> >  source "drivers/video/omap2/dss/Kconfig"
> >  source "drivers/video/omap2/omapfb/Kconfig"
> > diff --git a/drivers/video/omap2/omapfb/Kconfig
> b/drivers/video/omap2/omapfb/Kconfig
> > index a3ed15c..f186c2b 100644
> > --- a/drivers/video/omap2/omapfb/Kconfig
> > +++ b/drivers/video/omap2/omapfb/Kconfig
> > @@ -3,7 +3,6 @@ menuconfig FB_OMAP2
> >          depends on FB && OMAP2_DSS
> >
> >  	select OMAP2_VRAM
> > -	select OMAP2_VRFB
> >          select FB_CFB_FILLRECT
> >          select FB_CFB_COPYAREA
> >          select FB_CFB_IMAGEBLIT
> 
> This is second patch set marked as v3. Please update the version for
> every patch set.
> 
> I think the config selection is now a bit confusing. I think it should
> either be:
> 
> The omap2/Kconfig left as it is, and omapfb/Kconfig changed to:
> select OMAP2_VRFB if ARCH_OMAP2 || ARCH_OMAP3
> 
[Hiremath, Vaibhav] If you are doing something like this, then please do not forget to change V4L2 Display driver also.

Thanks,
Vaibhav

> or
> 
> Let the user select VRFB.
> 
>  Tomi
> 

