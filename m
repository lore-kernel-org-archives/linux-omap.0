From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v2 3/6] OMAP4: hwmod: Enable omap_device build for OMAP4
Date: Wed, 12 May 2010 17:54:38 +0200
Message-ID: <1273679681-27549-4-git-send-email-b-cousson@ti.com>
References: <1273679681-27549-1-git-send-email-b-cousson@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35139 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756354Ab0ELPy4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 May 2010 11:54:56 -0400
In-Reply-To: <1273679681-27549-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

From: Rajendra Nayak <rnayak@ti.com>

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/plat-omap/Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

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
-- 
1.6.1.3

