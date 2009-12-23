From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 5/5] OMAP3EVM: Kconfig option added for selection
 between SVIDEO and CVBS
Date: Wed, 23 Dec 2009 20:42:20 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044A277575@dbde02.ent.ti.com>
References: <hvaibhav@ti.com>
	 <1261063176-20101-1-git-send-email-hvaibhav@ti.com>
 <1261483738.2108.96.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45069 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752682AbZLWPMa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Dec 2009 10:12:30 -0500
In-Reply-To: <1261483738.2108.96.camel@tubuntu.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>


> -----Original Message-----
> From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> Sent: Tuesday, December 22, 2009 5:39 PM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org; linux-fbdev@vger.kernel.org
> Subject: Re: [PATCH 5/5] OMAP3EVM: Kconfig option added for
> selection between SVIDEO and CVBS
> 
> Hi,
> 
> On Thu, 2009-12-17 at 16:19 +0100, ext hvaibhav@ti.com wrote:
> > From: Vaibhav Hiremath <hvaibhav@ti.com>
> >
> > Config option added to arch/arm/plat-omap/Kconfig for selection
> > of S-Video and Composite output interfaces. The default
> configuration would
> > be S-Video.
> 
> I don't think this is correct. You've made a board spesific Kconfig
> option, but it's under normal DSS options.
> 
[Hiremath, Vaibhav] Frankly, I wanted to initiate the discussion on this, so that I will have some inputs here -

Actually we should not have Kconfig options at all for such things but should be configurable from bootargs like other configuration along with SYSFS interface. 

SYSFS - 
/sys/devices/platform/omapdss/display1/output

Bootargs -
Omapdss_def_disp=tv:<output>

Where,
	Output = cvbs or svideo


> Normally the type of the analog tv-out is a board hardware feature.
> And
> so I don't see need for a generic kernel option to set the type, as
> it
> should be just defined in the board file.
> 
> Are there many boards with both outputs? If there's just one or two
> development boards that have both outputs, I think it's better to
> handle
> it with board spesific code.
> 
[Hiremath, Vaibhav] OMAP3EVM supports both the outputs and that's where we required some configurable option to choose between.

Thanks,
Vaibhav

>  Tomi
> 
> 
> >
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > ---
> >  arch/arm/mach-omap2/board-omap3evm.c |    4 ++++
> >  drivers/video/omap2/dss/Kconfig      |   15 +++++++++++++++
> >  2 files changed, 19 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-
> omap2/board-omap3evm.c
> > index e615254..549e58e 100644
> > --- a/arch/arm/mach-omap2/board-omap3evm.c
> > +++ b/arch/arm/mach-omap2/board-omap3evm.c
> > @@ -275,7 +275,11 @@ static struct omap_dss_device
> omap3_evm_tv_device = {
> >  	.name			= "tv",
> >  	.driver_name		= "venc",
> >  	.type			= OMAP_DISPLAY_TYPE_VENC,
> > +#if defined(CONFIG_OMAP2_VENC_OUT_TYPE_SVIDEO)
> >  	.phy.venc.type		= OMAP_DSS_VENC_TYPE_SVIDEO,
> > +#elif defined(CONFIG_OMAP2_VENC_OUT_TYPE_COMPOSITE)
> > +	.u.venc.type		= OMAP_DSS_VENC_TYPE_COMPOSITE,
> > +#endif
> >  	.platform_enable	= omap3_evm_enable_tv,
> >  	.platform_disable	= omap3_evm_disable_tv,
> >  };
> > diff --git a/drivers/video/omap2/dss/Kconfig
> b/drivers/video/omap2/dss/Kconfig
> > index 71d8dec..5b7a8bc 100644
> > --- a/drivers/video/omap2/dss/Kconfig
> > +++ b/drivers/video/omap2/dss/Kconfig
> > @@ -36,6 +36,21 @@ config OMAP2_DSS_VENC
> >          default y
> >  	help
> >  	  OMAP Video Encoder support.
> > +choice
> > +	prompt OMAP2_VENC_OUT_TYPE
> > +	depends on OMAP2_DSS_VENC
> > +	default OMAP2_VENC_OUT_TYPE_SVIDEO
> > +
> > +config OMAP2_VENC_OUT_TYPE_SVIDEO
> > +	bool "Use S-Video output interface"
> > +	help
> > +	  Select this option if you want to choose TV out over S-Video
> > +
> > +config OMAP2_VENC_OUT_TYPE_COMPOSITE
> > +	bool "Use Composite output interface"
> > +	help
> > +	  Select this option if you want to choose TV out over
> Composite
> > +endchoice
> >
> >  config OMAP2_DSS_SDI
> >  	bool "SDI support"
> 

