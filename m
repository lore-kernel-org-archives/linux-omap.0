From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v1 3/3] ARM:OMAP4 iommu:provide build support for omap4
	iommu
Date: Wed, 5 Aug 2009 08:52:20 +0100
Message-ID: <20090805075220.GA28203@n2100.arm.linux.org.uk>
References: <8F7AF80515AF0D4D93307E594F3CB40E3ABDBAC2@dlee03.ent.ti.com> <20090804224241.GA17716@n2100.arm.linux.org.uk> <20090805.073538.258116604.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:60258 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933169AbZHEHwd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Aug 2009 03:52:33 -0400
Content-Disposition: inline
In-Reply-To: <20090805.073538.258116604.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: h-kanigeri2@ti.com, linux-omap@vger.kernel.org, tony@atomide.com, santosh.shilimkar@ti.com

On Wed, Aug 05, 2009 at 07:35:38AM +0300, Hiroshi DOYU wrote:
> From: ext Russell King - ARM Linux <linux@arm.linux.org.uk>
> Subject: Re: [PATCH v1 3/3] ARM:OMAP4 iommu:provide build support for omap4 iommu
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
> http://lists.arm.linux.org.uk/lurker/message/20090518.130233.3f238e72.en.html

Quite.  I'm repeating myself.  So the question is why the original
discussion didn't produce a change.
