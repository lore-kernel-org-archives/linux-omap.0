From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH v1 3/3] ARM:OMAP4 iommu:provide build support for omap4
 iommu
Date: Wed, 05 Aug 2009 12:15:23 +0300 (EEST)
Message-ID: <20090805.121523.27800958.Hiroshi.DOYU@nokia.com>
References: <20090804224241.GA17716@n2100.arm.linux.org.uk>
	<20090805.073538.258116604.Hiroshi.DOYU@nokia.com>
	<20090805075220.GA28203@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:47402 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933716AbZHEJPf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Aug 2009 05:15:35 -0400
In-Reply-To: <20090805075220.GA28203@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: h-kanigeri2@ti.com, linux@arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, tony@atomide.com, santosh.shilimkar@ti.com

From: ext Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v1 3/3] ARM:OMAP4 iommu:provide build support for omap4 iommu
Date: Wed, 5 Aug 2009 09:52:20 +0200

> On Wed, Aug 05, 2009 at 07:35:38AM +0300, Hiroshi DOYU wrote:
> > From: ext Russell King - ARM Linux <linux@arm.linux.org.uk>
> > Subject: Re: [PATCH v1 3/3] ARM:OMAP4 iommu:provide build support for omap4 iommu
> > Date: Wed, 5 Aug 2009 00:42:41 +0200
> > 
> > > On Tue, Aug 04, 2009 at 05:32:12PM -0500, Kanigeri, Hari wrote:
> > > > diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
> > > > index efe85d0..50aaefb 100644
> > > > --- a/arch/arm/plat-omap/Kconfig
> > > > +++ b/arch/arm/plat-omap/Kconfig
> > > > @@ -118,8 +118,11 @@ config OMAP_MBOX_FWK
> > > >  	  DSP, IVA1.0 and IVA2 in OMAP1/2/3.
> > > >  
> > > >  config OMAP_IOMMU
> > > > -	tristate
> > > > -
> > > > +	tristate "iommu"
> > > 
> > > Insufficiently verbose description.  "OMAP IOMMU Support" would be
> > > better.  I thought the idea here was to arrange for things to select
> > > OMAP_IOMMU when they require it rather than offering it as a separate
> > > configuration option.
> > > 
> > > The former way has the advantage that you don't need to know that you
> > > need IOMMU support to (eg) use the Camera - enabling the Camera
> > > should automatically enable IOMMU support.
> > 
> > The following is the original discussion.
> > 
> > http://lists.arm.linux.org.uk/lurker/message/20090518.130233.3f238e72.en.html
> 
> Quite.  I'm repeating myself.  So the question is why the original
> discussion didn't produce a change.

The original discussion was applied and can be kept for OMAP4 as well like:

config SOME_NEW_DEVICE_USE_IOMMU
       ...
       select OMAP_IOMMU
       ...

Just setting the above select line would be ok. For example,

http://marc.info/?l=linux-omap&m=124867965731465&w=2
