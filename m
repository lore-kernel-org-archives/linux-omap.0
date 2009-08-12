From: "S, Venkatraman" <svenkatr@ti.com>
Subject: [RFC][PATCH 1/2] OMAP4: sDMA drvier: adding OMAP kConfig option
 CONFIG_OMAP_DMA_DESCRIPTOR_LOAD
Date: Thu, 13 Aug 2009 01:31:34 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C003790C62AD@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42105 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752218AbZHLUBy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Aug 2009 16:01:54 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "S, Venkatraman" <svenkatr@ti.com>

The hardware feature is available on OMAP4430 and also expected to be 
in OMAP3630. Hence the feature flag will control the inclusion of the additional functions.

Addition of omap kconfig option CONFIG_OMAP_DMA_DESCRIPTOR_LOAD.

Signed-off-by: Venkatraman S <svenkatr@ti.com>
---
 arch/arm/configs/omap_4430sdp_defconfig |    1 +
 arch/arm/plat-omap/Kconfig              |    7 +++++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/omap_4430sdp_defconfig b/arch/arm/configs/omap_4430sdp_defconfig
index 23e43ea..bea9dcb 100644
--- a/arch/arm/configs/omap_4430sdp_defconfig
+++ b/arch/arm/configs/omap_4430sdp_defconfig
@@ -182,6 +182,7 @@ CONFIG_ARCH_OMAP4=y
 #
 # OMAP Feature Selections
 #
+CONFIG_OMAP_DMA_DESCRIPTOR_LOAD=y
 # CONFIG_OMAP_RESET_CLOCKS is not set
 # CONFIG_OMAP_MUX is not set
 # CONFIG_OMAP_MCBSP is not set
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index efe85d0..885b8b8 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -53,6 +53,13 @@ config OMAP_DEBUG_POWERDOMAIN
 	  for every powerdomain register write.  However, the
 	  extra detail costs some memory.
 
+config OMAP_DMA_DESCRIPTOR_LOAD
+	bool "sDMA descriptor loading feature"
+	depends on ARCH_OMAP4
+	help
+	  Say Y here if you want to include the DMA descriptor
+	  autoloading feature. Supported only in OMAP4
+
 config OMAP_DEBUG_CLOCKDOMAIN
 	bool "Emit debug messages from clockdomain layer"
 	depends on ARCH_OMAP2 || ARCH_OMAP3
