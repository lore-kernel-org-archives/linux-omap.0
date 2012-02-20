From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: More build errors and warnings
Date: Mon, 20 Feb 2012 07:53:22 +0000
Message-ID: <20120220075322.GA22675@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:36409 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751235Ab2BTHx0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Feb 2012 02:53:26 -0500
Received: from n2100.arm.linux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:35743)
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.76)
	(envelope-from <linux@arm.linux.org.uk>)
	id 1RzO3n-0000yZ-VR
	for linux-omap@vger.kernel.org; Mon, 20 Feb 2012 07:53:24 +0000
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.76)
	(envelope-from <linux@n2100.arm.linux.org.uk>)
	id 1RzO3m-00050k-Ob
	for linux-omap@vger.kernel.org; Mon, 20 Feb 2012 07:53:22 +0000
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Errors:

arch/arm/mach-omap2/built-in.o: In function `n8x0_mmc_callback': twl-common.c:(.text+0x108a0): undefined reference to `omap_mmc_notify_cover_event'</pre><h2>Warnings

Warnings:

drivers/iommu/omap-iommu-debug.c:271: warning: passing argument 1 of 'omap_find_iovm_area' from incompatible pointer type
drivers/iommu/omap-iommu-debug.c:308: warning: passing argument 1 of 'omap_find_iovm_area' from incompatible pointer type

These two are a serious problem, which needs fixing for -rc:

omap-iommu-debug.c:
        struct omap_iommu *obj = file->private_data;

        area = omap_find_iovm_area(obj, (u32)ppos);

arch/arm/plat-omap/include/plat/iovmm.h:extern struct iovm_struct *omap_find_iovm_area(struct device *dev, u32 da);

Config file (for the next 7 days):
http://www.arm.linux.org.uk/developer/build/file.php?type=config&idx=170
