From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH] Enable CONFIG_GPIO_TWL4030=y
Date: Fri, 10 Oct 2008 16:37:06 +0530
Message-ID: <1223636826-10107-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40399 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753147AbYJJLHQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Oct 2008 07:07:16 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id m9AB78LF027687
	for <linux-omap@vger.kernel.org>; Fri, 10 Oct 2008 06:07:14 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

Without this option, kernel builds would fail, with
errors similar to:

hsmmc.c:50: undefined reference to `twl4030_get_gpio_datain'
hsmmc.c:82: undefined reference to `twl4030_free_gpio'
hsmmc.c:63: undefined reference to `twl4030_request_gpio'
hsmmc.c:67: undefined reference to `twl4030_set_gpio_debounce'

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/configs/omap2_evm_defconfig    |    1 +
 arch/arm/configs/omap3_beagle_defconfig |    1 +
 arch/arm/configs/omap3_evm_defconfig    |    1 +
 arch/arm/configs/omap_3430sdp_defconfig |    1 +
 arch/arm/configs/omap_ldp_defconfig     |    1 +
 5 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/omap2_evm_defconfig b/arch/arm/configs/omap2_evm_defconfig
index 61f0965..b52426a 100644
--- a/arch/arm/configs/omap2_evm_defconfig
+++ b/arch/arm/configs/omap2_evm_defconfig
@@ -795,6 +795,7 @@ CONFIG_GPIOLIB=y
 # CONFIG_GPIO_MAX732X is not set
 # CONFIG_GPIO_PCA953X is not set
 # CONFIG_GPIO_PCF857X is not set
+CONFIG_GPIO_TWL4030=y
 
 #
 # PCI GPIO expanders:
diff --git a/arch/arm/configs/omap3_beagle_defconfig b/arch/arm/configs/omap3_beagle_defconfig
index 7805995..0d2f770 100644
--- a/arch/arm/configs/omap3_beagle_defconfig
+++ b/arch/arm/configs/omap3_beagle_defconfig
@@ -709,6 +709,7 @@ CONFIG_HAVE_GPIO_LIB=y
 #
 # CONFIG_GPIO_PCA953X is not set
 # CONFIG_GPIO_PCF857X is not set
+CONFIG_GPIO_TWL4030=y
 
 #
 # SPI GPIO expanders:
diff --git a/arch/arm/configs/omap3_evm_defconfig b/arch/arm/configs/omap3_evm_defconfig
index ebeaef3..507a689 100644
--- a/arch/arm/configs/omap3_evm_defconfig
+++ b/arch/arm/configs/omap3_evm_defconfig
@@ -779,6 +779,7 @@ CONFIG_HAVE_GPIO_LIB=y
 #
 # CONFIG_GPIO_PCA953X is not set
 # CONFIG_GPIO_PCF857X is not set
+CONFIG_GPIO_TWL4030=y
 
 #
 # SPI GPIO expanders:
diff --git a/arch/arm/configs/omap_3430sdp_defconfig b/arch/arm/configs/omap_3430sdp_defconfig
index 11c0cf7..bd6006c 100644
--- a/arch/arm/configs/omap_3430sdp_defconfig
+++ b/arch/arm/configs/omap_3430sdp_defconfig
@@ -790,6 +790,7 @@ CONFIG_HAVE_GPIO_LIB=y
 #
 # CONFIG_GPIO_PCA953X is not set
 # CONFIG_GPIO_PCF857X is not set
+CONFIG_GPIO_TWL4030=y
 
 #
 # SPI GPIO expanders:
diff --git a/arch/arm/configs/omap_ldp_defconfig b/arch/arm/configs/omap_ldp_defconfig
index 9a90975..fd34367 100644
--- a/arch/arm/configs/omap_ldp_defconfig
+++ b/arch/arm/configs/omap_ldp_defconfig
@@ -549,6 +549,7 @@ CONFIG_HAVE_GPIO_LIB=y
 #
 # CONFIG_GPIO_PCA953X is not set
 # CONFIG_GPIO_PCF857X is not set
+CONFIG_GPIO_TWL4030=y
 
 #
 # SPI GPIO expanders:
-- 
1.5.6

