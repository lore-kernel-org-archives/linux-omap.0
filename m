From: Tony Lindgren <tony@atomide.com>
Subject: Re: More build errors and warnings
Date: Mon, 20 Feb 2012 09:55:32 -0800
Message-ID: <20120220175532.GL18185@atomide.com>
References: <20120220075322.GA22675@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:36948 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103Ab2BTRzh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Feb 2012 12:55:37 -0500
Content-Disposition: inline
In-Reply-To: <20120220075322.GA22675@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-omap@vger.kernel.org

Hi Russell & Ohad,

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120219 23:22]:
> Errors:
> 
> arch/arm/mach-omap2/built-in.o: In function `n8x0_mmc_callback': twl-common.c:(.text+0x108a0): undefined reference to `omap_mmc_notify_cover_event'</pre><h2>Warnings

I'll post a fix to do a warning here if the cover events
are unavailable. The long term fix is to let the MMC driver
register the callback with the PMIC to do this.

> Warnings:
> 
> drivers/iommu/omap-iommu-debug.c:271: warning: passing argument 1 of 'omap_find_iovm_area' from incompatible pointer type
> drivers/iommu/omap-iommu-debug.c:308: warning: passing argument 1 of 'omap_find_iovm_area' from incompatible pointer type
> 
> These two are a serious problem, which needs fixing for -rc:
> 
> omap-iommu-debug.c:
>         struct omap_iommu *obj = file->private_data;
> 
>         area = omap_find_iovm_area(obj, (u32)ppos);
> 
> arch/arm/plat-omap/include/plat/iovmm.h:extern struct iovm_struct *omap_find_iovm_area(struct device *dev, u32 da);
> 
> Config file (for the next 7 days):
> http://www.arm.linux.org.uk/developer/build/file.php?type=config&idx=170

Ohad, care to look into fixing these for the -rc series?

Regards,

Tony
