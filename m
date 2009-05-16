From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 3/6] omap iommu: omap3 iommu device registration
Date: Sat, 16 May 2009 10:55:14 +0100
Message-ID: <20090516095514.GJ15328@n2100.arm.linux.org.uk>
References: <20090505123905.4583.69865.stgit@oreo.research.nokia.com> <20090505124700.4583.69988.stgit@oreo.research.nokia.com> <20090516092036.GD15328@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:48416 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754749AbZEPJzd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 May 2009 05:55:33 -0400
Content-Disposition: inline
In-Reply-To: <20090516092036.GD15328@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, h-kanigeri2@ti.com, omar.ramirez@ti.com, sakari.ailus@maxwell.research.nokia.com, tony@atomide.com

On Sat, May 16, 2009 at 10:20:36AM +0100, Russell King - ARM Linux wrote:
> This looks all very convoluted.  Why not do something like:
> 
> static unsigned long iommu_base[] = {
> 	OMAP3_MMU1_BASE,
> 	OMAP3_MMU2_BASE,
> };
> 
> static int iommu_irq[] = {
> 	OMAP3_MMU1_IRQ,
> 	OMAP3_MMU2_IRQ,
> };

BTW, both of these can be __initdata.
