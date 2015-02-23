From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 2/2] ARM: omap2plus_defconfig: Fix SATA boot
Date: Mon, 23 Feb 2015 17:18:37 +0200
Message-ID: <1424704717-29728-3-git-send-email-rogerq@ti.com>
References: <1424704717-29728-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53133 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752082AbbBWPTa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Feb 2015 10:19:30 -0500
In-Reply-To: <1424704717-29728-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: balbi@ti.com, grinberg@compulab.co.il, grygorii.strashko@linaro.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>

SATA operation depends on PIPE3 PHY and if we want
to boot from SATA drives, we have to have the PIPE3 PHY
driver built-in.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/configs/omap2plus_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index b674245..088096f 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -375,7 +375,7 @@ CONFIG_PWM_TIEHRPWM=m
 CONFIG_PWM_TWL=m
 CONFIG_PWM_TWL_LED=m
 CONFIG_OMAP_USB2=m
-CONFIG_TI_PIPE3=m
+CONFIG_TI_PIPE3=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 # CONFIG_EXT3_FS_XATTR is not set
-- 
2.1.0

