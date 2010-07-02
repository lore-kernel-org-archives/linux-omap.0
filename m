From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 10/20] OMAP4: hwmod: Enable omap_device build for OMAP4
Date: Fri, 02 Jul 2010 09:29:27 -0600
Message-ID: <20100702152925.6221.36970.stgit@localhost.localdomain>
References: <20100702152703.6221.33529.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45282 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758893Ab0GBPbE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Jul 2010 11:31:04 -0400
In-Reply-To: <20100702152703.6221.33529.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

Enable omap_device layer support for OMAP4, so that drivers can
use them to enable/idle/shutdown devices.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/Makefile |    2 +-
 arch/arm/plat-omap/Makefile  |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 6c6d7c6..2fa3418 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -15,7 +15,7 @@ clock-common				= clock.o clock_common_data.o \
 
 obj-$(CONFIG_ARCH_OMAP2) += $(omap-2-3-common) $(prcm-common) $(hwmod-common)
 obj-$(CONFIG_ARCH_OMAP3) += $(omap-2-3-common) $(prcm-common) $(hwmod-common)
-obj-$(CONFIG_ARCH_OMAP4) += $(prcm-common)
+obj-$(CONFIG_ARCH_OMAP4) += $(prcm-common) $(hwmod-common)
 
 obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
 
diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index 98f0191..9405831 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_ARCH_OMAP16XX) += ocpi.o
 # omap_device support (OMAP2+ only at the moment)
 obj-$(CONFIG_ARCH_OMAP2) += omap_device.o
 obj-$(CONFIG_ARCH_OMAP3) += omap_device.o
+obj-$(CONFIG_ARCH_OMAP4) += omap_device.o
 
 obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
 obj-$(CONFIG_OMAP_IOMMU) += iommu.o iovmm.o


