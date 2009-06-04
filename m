From: Imre Deak <imre.deak@nokia.com>
Subject: [PATCH 03/20] N770: Enable LCD MIPI-DCS in Kconfig
Date: Thu,  4 Jun 2009 20:52:28 +0300
Message-ID: <e9040774f324311979aebd3fa5fa71d20890d433.1244131952.git.imre.deak@nokia.com>
References: <1244137965-8937-1-git-send-email-imre.deak@nokia.com>
 <fab39c1a822c428466db6a19531be646d483664e.1244131952.git.imre.deak@nokia.com>
 <e7f92ea9f0a823f7be401e34243754141b7f72c1.1244131952.git.imre.deak@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:38457 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751088AbZFDRzN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Jun 2009 13:55:13 -0400
In-Reply-To: <e7f92ea9f0a823f7be401e34243754141b7f72c1.1244131952.git.imre.deak@nokia.com>
In-Reply-To: <fab39c1a822c428466db6a19531be646d483664e.1244131952.git.imre.deak@nokia.com>
References: <fab39c1a822c428466db6a19531be646d483664e.1244131952.git.imre.deak@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Antonino Daplas <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <Tomi.Valkeinen@nokia.com>, Imre Deak <imre.deak@nokia.com>, linux-arm-kernel@lists.arm.linux.org.uk

CC: linux-arm-kernel@lists.arm.linux.org.uk
Signed-off-by: Imre Deak <imre.deak@nokia.com>
---
 arch/arm/configs/n770_defconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/n770_defconfig b/arch/arm/configs/n770_defconfig
index 672f6db..a1657b7 100644
--- a/arch/arm/configs/n770_defconfig
+++ b/arch/arm/configs/n770_defconfig
@@ -875,7 +875,7 @@ CONFIG_FB_OMAP_LCDC_EXTERNAL=y
 CONFIG_FB_OMAP_LCDC_HWA742=y
 # CONFIG_FB_OMAP_LCDC_BLIZZARD is not set
 CONFIG_FB_OMAP_MANUAL_UPDATE=y
-# CONFIG_FB_OMAP_LCD_MIPID is not set
+CONFIG_FB_OMAP_LCD_MIPID=y
 # CONFIG_FB_OMAP_BOOTLOADER_INIT is not set
 CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE=2
 # CONFIG_FB_OMAP_DMA_TUNE is not set
-- 
1.6.3.1

