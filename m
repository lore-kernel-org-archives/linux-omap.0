From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Latest OMAP4 build errors
Date: Tue, 28 Feb 2012 09:02:09 +0000
Message-ID: <20120228090209.GC18045@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:45590 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755821Ab2B1JCP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Feb 2012 04:02:15 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

This is from my tree plus arm-soc's for-next.  This build error was
introduced in arm-soc:

In file included from arch/arm/mach-omap2/iommu2.c:22:
arch/arm/plat-omap/include/plat/iommu.h: In function 'dev_to_omap_iommu':
arch/arm/plat-omap/include/plat/iommu.h:135: error: 'struct dev_archdata' has no member named 'iommu'
In file included from arch/arm/mach-omap2/omap-iommu.c:17:
arch/arm/plat-omap/include/plat/iommu.h: In function 'dev_to_omap_iommu':
arch/arm/plat-omap/include/plat/iommu.h:135: error: 'struct dev_archdata' has no member named 'iommu'

The problem appears to be that OMAP_IOMMU is selected without IOMMU_API.
This is done by:

config OMAP_REMOTEPROC
        tristate "OMAP remoteproc support"
        depends on ARCH_OMAP4
        select OMAP_IOMMU
...
        default m

This is wrong for two reasons:

1. It selects OMAP_IOMMU which may not have its dependencies satisfied.

warning: (OMAP_REMOTEPROC) selects OMAP_IOMMU which has unmet direct dependencies (IOMMU_SUPPORT && ARCH_OMAP)

2. It's a new feature.  It is experimental.  It should not default to 'm'
