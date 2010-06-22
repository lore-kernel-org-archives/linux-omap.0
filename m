From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH v3 2/3] OMAP: DSS2: OMAPFB: make VRFB depends on OMAP2,3
Date: Tue, 22 Jun 2010 19:48:39 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E91C3FE@dbde02.ent.ti.com>
References: <1276778702-15280-1-git-send-email-svadivu@ti.com>
	 <1276778702-15280-2-git-send-email-svadivu@ti.com>
	 <1276778702-15280-3-git-send-email-svadivu@ti.com>
 <1277110241.2526.31.camel@tubuntu.research.nokia.com>
 <19F8576C6E063C45BE387C64729E7394044E91BF03@dbde02.ent.ti.com>
  <FCCFB4CDC6E5564B9182F639FC3560870304288933@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39345 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756212Ab0FVOSy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jun 2010 10:18:54 -0400
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC3560870304288933@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guruswamy, Senthilvadivu" <svadivu@ti.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-dev@vger.kernel.org" <linux-dev@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>


> -----Original Message-----
> From: Guruswamy, Senthilvadivu
> Sent: Tuesday, June 22, 2010 5:29 PM
> To: Guruswamy, Senthilvadivu; Hiremath, Vaibhav; Tomi Valkeinen
> Cc: linux-omap@vger.kernel.org; linux-dev@vger.kernel.org; tony@atomide.com
> Subject: RE: [PATCH v3 2/3] OMAP: DSS2: OMAPFB: make VRFB depends on OMAP2,3
> 
> 
> 
> > -----Original Message-----
> > From: Guruswamy, Senthilvadivu
> > Sent: Monday, June 21, 2010 2:52 PM
> > To: Hiremath, Vaibhav; Tomi Valkeinen
> > Cc: linux-omap@vger.kernel.org; linux-dev@vger.kernel.org;
> > tony@atomide.com
> > Subject: RE: [PATCH v3 2/3] OMAP: DSS2: OMAPFB: make VRFB
> > depends on OMAP2,3
> >
> >
> >
> > > -----Original Message-----
> > > From: Hiremath, Vaibhav
> > > Sent: Monday, June 21, 2010 2:27 PM
> > > To: Tomi Valkeinen; Guruswamy, Senthilvadivu
> > > Cc: linux-omap@vger.kernel.org; linux-dev@vger.kernel.org;
> > > tony@atomide.com
> > > Subject: RE: [PATCH v3 2/3] OMAP: DSS2: OMAPFB: make VRFB
> > > depends on OMAP2,3
> > >
> > > > -----Original Message-----
> > > > From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> > > > Sent: Monday, June 21, 2010 2:21 PM
> > > > To: Guruswamy, Senthilvadivu
> > > > Cc: linux-omap@vger.kernel.org; linux-dev@vger.kernel.org;
> > > tony@atomide.com;
> > > > Hiremath, Vaibhav
> > > > Subject: Re: [PATCH v3 2/3] OMAP: DSS2: OMAPFB: make VRFB
> > > depends on OMAP2,3
> > > >
> > > > On Thu, 2010-06-17 at 14:45 +0200, ext Guruswamy
> > > Senthilvadivu wrote:
> > > > > From: Senthilvadivu Guruswamy <svadivu@ti.com>
> > > > >
> > > > > config VRFB should depend on ARCH_OMAP2 or ARCH_OMAP3.
> > > > >
> > > > > Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
> > > > > ---
> > > > >  drivers/video/omap2/Kconfig            |    4 ++++
> > > > >  drivers/video/omap2/omapfb/Kconfig     |    1 -
> > > > >  2 files changed,  4 insertions(+), 1 deletions(-)
> <snip>
> > > > The omap2/Kconfig left as it is, and omapfb/Kconfig changed to:
> > > > select OMAP2_VRFB if ARCH_OMAP2 || ARCH_OMAP3
> > > >
> > > [Hiremath, Vaibhav] If you are doing something like this,
> > > then please do not forget to change V4L2 Display driver also.
> > [Senthil]  Yes, I would send a patch with a similar change in
> > media/video/omap/Kconfig also.
> [Senthil]  This V4L2 related patch would be along with the V4L2 change
> set, as it requires some work on the omap_vout.c also along with the kconfig
> change.
> 
[Hiremath, Vaibhav] I think we are creating confusion here, on Fbdev side it looks clean, but on V4L2 side you are still enabling VRFB. So if you try to enable V4L2 display driver then it automatically enabled VRFB.

I still feel changes in V4L2 driver should be part of this patch series to maintain consistency.

Thanks,
Vaibhav

> Regards,
> Senthil
