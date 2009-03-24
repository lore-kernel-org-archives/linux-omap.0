From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] OMAP3: MMC needs CONFIG_REGULATOR{,_TWL4030} now in
 defconfigs
Date: Tue, 24 Mar 2009 17:22:18 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0903241716030.9924@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37730 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753994AbZCXXWV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Mar 2009 19:22:21 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: David Brownell <david-b@pacbell.net>

    
MMC doesn't work after 3fe326511c66ab842ef0a09a1f4c564b1a8beecf unless 
CONFIG_REGULATOR, CONFIG_REGULATOR_TWL4030 are present in the .config.  
Add those in for all OMAP3 defconfigs.  Tested on BeagleBoard, but this is 
presumably needed for anything with MMC and TWL4030.
    
Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: David Brownell <david-b@pacbell.net>

---
 arch/arm/configs/omap3_beagle_defconfig  |    3 ++-
 arch/arm/configs/omap3_evm_defconfig     |    3 ++-
 arch/arm/configs/omap3_pandora_defconfig |    3 ++-
 arch/arm/configs/omap_3430sdp_defconfig  |    3 ++-
 arch/arm/configs/omap_ldp_defconfig      |    3 ++-
 arch/arm/configs/overo_defconfig         |    2 ++
 6 files changed, 12 insertions(+), 5 deletions(-)


diff --git a/arch/arm/configs/omap3_beagle_defconfig b/arch/arm/configs/omap3_beagle_defconfig
index 194eafa..aeeac33 100644
--- a/arch/arm/configs/omap3_beagle_defconfig
+++ b/arch/arm/configs/omap3_beagle_defconfig
@@ -1040,10 +1040,11 @@ CONFIG_RTC_DRV_TWL4030=y
 #
 # Voltage and Current regulators
 #
-# CONFIG_REGULATOR is not set
+CONFIG_REGULATOR=y
 # CONFIG_REGULATOR_FIXED_VOLTAGE is not set
 # CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
 # CONFIG_REGULATOR_BQ24022 is not set
+CONFIG_REGULATOR_TWL4030=y
 # CONFIG_UIO is not set
 
 #
diff --git a/arch/arm/configs/omap3_evm_defconfig b/arch/arm/configs/omap3_evm_defconfig
index f276c3a..018c9e1 100644
--- a/arch/arm/configs/omap3_evm_defconfig
+++ b/arch/arm/configs/omap3_evm_defconfig
@@ -1098,10 +1098,11 @@ CONFIG_RTC_LIB=y
 #
 # Voltage and Current regulators
 #
-# CONFIG_REGULATOR is not set
+CONFIG_REGULATOR=y
 # CONFIG_REGULATOR_FIXED_VOLTAGE is not set
 # CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
 # CONFIG_REGULATOR_BQ24022 is not set
+CONFIG_REGULATOR_TWL4030=y
 # CONFIG_UIO is not set
 
 #
diff --git a/arch/arm/configs/omap3_pandora_defconfig b/arch/arm/configs/omap3_pandora_defconfig
index 1c2b7a2..3c467fc 100644
--- a/arch/arm/configs/omap3_pandora_defconfig
+++ b/arch/arm/configs/omap3_pandora_defconfig
@@ -1156,10 +1156,11 @@ CONFIG_RTC_DRV_TWL4030=y
 #
 # Voltage and Current regulators
 #
-# CONFIG_REGULATOR is not set
+CONFIG_REGULATOR=y
 # CONFIG_REGULATOR_FIXED_VOLTAGE is not set
 # CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
 # CONFIG_REGULATOR_BQ24022 is not set
+CONFIG_REGULATOR_TWL4030=y
 # CONFIG_UIO is not set
 
 #
diff --git a/arch/arm/configs/omap_3430sdp_defconfig b/arch/arm/configs/omap_3430sdp_defconfig
index f7b1bd6..b686f34 100644
--- a/arch/arm/configs/omap_3430sdp_defconfig
+++ b/arch/arm/configs/omap_3430sdp_defconfig
@@ -1165,10 +1165,11 @@ CONFIG_RTC_DRV_TWL4030=y
 #
 # Voltage and Current regulators
 #
-# CONFIG_REGULATOR is not set
+CONFIG_REGULATOR=y
 # CONFIG_REGULATOR_FIXED_VOLTAGE is not set
 # CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
 # CONFIG_REGULATOR_BQ24022 is not set
+CONFIG_REGULATOR_TWL4030=y
 # CONFIG_UIO is not set
 
 #
diff --git a/arch/arm/configs/omap_ldp_defconfig b/arch/arm/configs/omap_ldp_defconfig
index d88e6d7..a41b844 100644
--- a/arch/arm/configs/omap_ldp_defconfig
+++ b/arch/arm/configs/omap_ldp_defconfig
@@ -1104,10 +1104,11 @@ CONFIG_RTC_DRV_TWL4030=y
 #
 # Voltage and Current regulators
 #
-# CONFIG_REGULATOR is not set
+CONFIG_REGULATOR=y
 # CONFIG_REGULATOR_FIXED_VOLTAGE is not set
 # CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
 # CONFIG_REGULATOR_BQ24022 is not set
+CONFIG_REGULATOR_TWL4030=y
 # CONFIG_UIO is not set
 
 #
diff --git a/arch/arm/configs/overo_defconfig b/arch/arm/configs/overo_defconfig
index 3bdbf94..dcca647 100644
--- a/arch/arm/configs/overo_defconfig
+++ b/arch/arm/configs/overo_defconfig
@@ -1601,9 +1601,11 @@ CONFIG_RTC_DRV_TWL4030=y
 # Voltage and Current regulators
 #
 # CONFIG_REGULATOR is not set
+CONFIG_REGULATOR=y
 # CONFIG_REGULATOR_FIXED_VOLTAGE is not set
 # CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
 # CONFIG_REGULATOR_BQ24022 is not set
+CONFIG_REGULATOR_TWL4030=y
 # CONFIG_UIO is not set
 
 #
