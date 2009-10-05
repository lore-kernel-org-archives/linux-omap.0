From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH] Beagle: CONFIG_ISP1301_OMAP redefined in defconfig
Date: Mon,  5 Oct 2009 21:21:40 +0530
Message-ID: <1254757900-13397-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53118 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752239AbZJEPwW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Oct 2009 11:52:22 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n95FpgSh011442
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 5 Oct 2009 10:51:45 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

The symbol CONFIG_ISP1301_OMAP was defined twice in the
defconfig. This was causing the warning:
arch/arm/configs/omap3_beagle_defconfig:972:warning:
 override: reassigning to symbol ISP1301_OMAP

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/configs/omap3_beagle_defconfig |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/omap3_beagle_defconfig b/arch/arm/configs/omap3_beagle_defconfig
index 357d402..b3c8cce 100644
--- a/arch/arm/configs/omap3_beagle_defconfig
+++ b/arch/arm/configs/omap3_beagle_defconfig
@@ -969,7 +969,6 @@ CONFIG_USB_ETH_RNDIS=y
 #
 CONFIG_USB_OTG_UTILS=y
 # CONFIG_USB_GPIO_VBUS is not set
-# CONFIG_ISP1301_OMAP is not set
 CONFIG_TWL4030_USB=y
 # CONFIG_NOP_USB_XCEIV is not set
 CONFIG_MMC=y
-- 
1.6.2.2

