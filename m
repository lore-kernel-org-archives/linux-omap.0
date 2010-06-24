From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: RE: [PATCH 08/13] OMAP4: hwmod: Enable omap_device build for OMAP4
Date: Thu, 24 Jun 2010 19:53:35 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB032366B0A0@dbde02.ent.ti.com>
References: <1277336563-24988-1-git-send-email-khilman@deeprootsystems.com>
 <1277336563-24988-9-git-send-email-khilman@deeprootsystems.com>
 <alpine.DEB.2.00.1006232310110.1550@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42929 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754058Ab0FXOXo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jun 2010 10:23:44 -0400
In-Reply-To: <alpine.DEB.2.00.1006232310110.1550@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>



> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Thursday, June 24, 2010 12:11 AM
> To: Nayak, Rajendra
> Cc: Kevin Hilman; linux-omap@vger.kernel.org; Cousson, Benoit
> Subject: Re: [PATCH 08/13] OMAP4: hwmod: Enable omap_device build for OMAP4
> 
> Hi Rajendra
> 
> On Wed, 23 Jun 2010, Kevin Hilman wrote:
> 
> > From: Rajendra Nayak <rnayak@ti.com>
> >
> 
> Please add a brief patch changelog entry here.  Maybe just say this is
> necessary for integration code using omap_device to work on OMAP4?

Yes, will do, not sure how that got missed. 
thanks

> 
> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> > Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> > ---
> >  arch/arm/plat-omap/Makefile |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
> > index 98f0191..9405831 100644
> > --- a/arch/arm/plat-omap/Makefile
> > +++ b/arch/arm/plat-omap/Makefile
> > @@ -15,6 +15,7 @@ obj-$(CONFIG_ARCH_OMAP16XX) += ocpi.o
> >  # omap_device support (OMAP2+ only at the moment)
> >  obj-$(CONFIG_ARCH_OMAP2) += omap_device.o
> >  obj-$(CONFIG_ARCH_OMAP3) += omap_device.o
> > +obj-$(CONFIG_ARCH_OMAP4) += omap_device.o
> >
> >  obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
> >  obj-$(CONFIG_OMAP_IOMMU) += iommu.o iovmm.o
> > --
> > 1.7.0.2
> >
> 
> 
> - Paul
