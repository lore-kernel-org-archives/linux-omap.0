From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 3/6] omap iommu: omap3 iommu device registration
Date: Mon, 18 May 2009 08:36:03 +0300 (EEST)
Message-ID: <20090518.083603.02283012.Hiroshi.DOYU@nokia.com>
References: <20090505124700.4583.69988.stgit@oreo.research.nokia.com>
	<20090516092036.GD15328@n2100.arm.linux.org.uk>
	<20090516095514.GJ15328@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:38336 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750706AbZERFgr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 May 2009 01:36:47 -0400
In-Reply-To: <20090516095514.GJ15328@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux@arm.linux.org.uk
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, h-kanigeri2@ti.com, omar.ramirez@ti.com, sakari.ailus@maxwell.research.nokia.com, tony@atomide.com

From: ext Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 3/6] omap iommu: omap3 iommu device registration
Date: Sat, 16 May 2009 11:55:14 +0200

> On Sat, May 16, 2009 at 10:20:36AM +0100, Russell King - ARM Linux wrote:
> > This looks all very convoluted.  Why not do something like:
> > 
> > static unsigned long iommu_base[] = {
> > 	OMAP3_MMU1_BASE,
> > 	OMAP3_MMU2_BASE,
> > };
> > 
> > static int iommu_irq[] = {
> > 	OMAP3_MMU1_IRQ,
> > 	OMAP3_MMU2_IRQ,
> > };
> 
> BTW, both of these can be __initdata.

OK, I'll send the update ones. Thank you for reviewing them.
