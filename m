From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH v1 3/3] ARM:OMAP4 iommu:provide build support for omap4
 iommu
Date: Wed, 5 Aug 2009 11:44:53 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E3ABDC0EF@dlee03.ent.ti.com>
References: <8F7AF80515AF0D4D93307E594F3CB40E3ABDBAC2@dlee03.ent.ti.com>
	<20090804224241.GA17716@n2100.arm.linux.org.uk>
 <20090805.073538.258116604.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33358 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934494AbZHEQpI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Aug 2009 12:45:08 -0400
In-Reply-To: <20090805.073538.258116604.Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

Hi Russell and Hiroshi,

Thanks for your comments. Please see my below comments.

> -----Original Message-----
> From: Hiroshi DOYU [mailto:Hiroshi.DOYU@nokia.com]
> Sent: Tuesday, August 04, 2009 11:36 PM
> To: Kanigeri, Hari
> Cc: linux-omap@vger.kernel.org; tony@atomide.com; linux@arm.linux.org.uk;
> Shilimkar, Santosh
> Subject: Re: [PATCH v1 3/3] ARM:OMAP4 iommu:provide build support for
> omap4 iommu
> 
> From: ext Russell King - ARM Linux <linux@arm.linux.org.uk>
> Subject: Re: [PATCH v1 3/3] ARM:OMAP4 iommu:provide build support for
> omap4 iommu
> Date: Wed, 5 Aug 2009 00:42:41 +0200
> 
> > On Tue, Aug 04, 2009 at 05:32:12PM -0500, Kanigeri, Hari wrote:
> > > diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
> > > index efe85d0..50aaefb 100644
> > > --- a/arch/arm/plat-omap/Kconfig
> > > +++ b/arch/arm/plat-omap/Kconfig
> > > @@ -118,8 +118,11 @@ config OMAP_MBOX_FWK
> > >  	  DSP, IVA1.0 and IVA2 in OMAP1/2/3.
> > >
> > >  config OMAP_IOMMU
> > > -	tristate
> > > -
> > > +	tristate "iommu"
> >
> > Insufficiently verbose description.  "OMAP IOMMU Support" would be
> > better.  I thought the idea here was to arrange for things to select
> > OMAP_IOMMU when they require it rather than offering it as a separate
> > configuration option.
> >
> > The former way has the advantage that you don't need to know that you
> > need IOMMU support to (eg) use the Camera - enabling the Camera
> > should automatically enable IOMMU support.
> 
> The following is the original discussion.
> 
> http://lists.arm.linux.org.uk/lurker/message/20090518.130233.3f238e72.en.h
> tml

-- I agree with your comments from OMAP3 point of view. 
For OMAP4, I guess Camera is not going to use IOMMU module. IOMMU modules will be used only by the IPC that are communicating with 2 remote Cores (Ducati and Tesla). Having said this, there might not be any clients of IOMMU in the Kernel space as we are looking at the option of using the IOMMU as a character driver from User-space. For this reason, I think we should have the configuration option to build iommu. Please let me know your comments.

Thank you,
Best regards,
Hari


