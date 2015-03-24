From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH] ARM: omap2plus_defconfig: Enable EXTCON_USB_GPIO
Date: Tue, 24 Mar 2015 12:19:19 +0200
Message-ID: <1427192359-19168-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35468 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752042AbbCXKTY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Mar 2015 06:19:24 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: nm@ti.com, balbi@ti.com, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>

We need to enable EXTCON_USB_GPIO_USB and not
EXTCON_GPIO_USB.

Fixes: c08a54c0ebeb ("ARM: omap2plus_defconfig: Enable EXTCON_GPIO_USB")

Reported-by: Nishant Menon <nm@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/configs/omap2plus_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 04b4c8e..daf9412 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -391,7 +391,7 @@ CONFIG_TI_EDMA=y
 CONFIG_DMA_OMAP=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_EXTCON=m
-CONFIG_EXTCON_GPIO=m
+CONFIG_EXTCON_USB_GPIO=m
 CONFIG_EXTCON_PALMAS=m
 CONFIG_TI_EMIF=m
 CONFIG_PWM=y
-- 
2.1.0

