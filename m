From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH v1 3/3] ARM:OMAP4 iommu:provide build support for omap4
 iommu
Date: Wed, 05 Aug 2009 07:35:38 +0300 (EEST)
Message-ID: <20090805.073538.258116604.Hiroshi.DOYU@nokia.com>
References: <8F7AF80515AF0D4D93307E594F3CB40E3ABDBAC2@dlee03.ent.ti.com>
	<20090804224241.GA17716@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:24140 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282AbZHEEgU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Aug 2009 00:36:20 -0400
In-Reply-To: <20090804224241.GA17716@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: h-kanigeri2@ti.com
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux@arm.linux.org.uk, santosh.shilimkar@ti.com

From: ext Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v1 3/3] ARM:OMAP4 iommu:provide build support for omap4 iommu
Date: Wed, 5 Aug 2009 00:42:41 +0200

> On Tue, Aug 04, 2009 at 05:32:12PM -0500, Kanigeri, Hari wrote:
> > diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
> > index efe85d0..50aaefb 100644
> > --- a/arch/arm/plat-omap/Kconfig
> > +++ b/arch/arm/plat-omap/Kconfig
> > @@ -118,8 +118,11 @@ config OMAP_MBOX_FWK
> >  	  DSP, IVA1.0 and IVA2 in OMAP1/2/3.
> >  
> >  config OMAP_IOMMU
> > -	tristate
> > -
> > +	tristate "iommu"
> 
> Insufficiently verbose description.  "OMAP IOMMU Support" would be
> better.  I thought the idea here was to arrange for things to select
> OMAP_IOMMU when they require it rather than offering it as a separate
> configuration option.
> 
> The former way has the advantage that you don't need to know that you
> need IOMMU support to (eg) use the Camera - enabling the Camera
> should automatically enable IOMMU support.

The following is the original discussion.

http://lists.arm.linux.org.uk/lurker/message/20090518.130233.3f238e72.en.html
