From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: [PATCH]  ARM: OMAP: beagleboard defconfig: increase FB DMA size to 4MB so the 1024x768x24 default fits
Date: Thu, 29 May 2008 00:33:44 +0200
Message-ID: <1212014024-4698-1-git-send-email-k.kooi@student.utwente.nl>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx2.utsp.utwente.nl ([130.89.2.13]:40743 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752596AbYE1Weq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 May 2008 18:34:46 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Koen Kooi <koen@openembedded.org>

From: Koen Kooi <koen@openembedded.org>

beagleboard defconfig: increase FB DMA size to 4MB so the 1024x768x24 default fits

Signed-off-by: Koen Kooi <koen@openembedded.org>
---
 arch/arm/configs/omap3_beagle_defconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/omap3_beagle_defconfig b/arch/arm/configs/omap3_beagle_defconfig
index 6aec7b7..cce83e5 100644
--- a/arch/arm/configs/omap3_beagle_defconfig
+++ b/arch/arm/configs/omap3_beagle_defconfig
@@ -703,7 +703,7 @@ CONFIG_FB_CFB_IMAGEBLIT=y
 CONFIG_FB_OMAP=y
 # CONFIG_FB_OMAP_LCDC_EXTERNAL is not set
 # CONFIG_FB_OMAP_BOOTLOADER_INIT is not set
-CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE=2
+CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE=4
 # CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
-- 
1.5.4.3

