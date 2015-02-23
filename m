From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 1/2] ARM: omap2plus_defconfig: Enable OMAP NAND BCH driver
Date: Mon, 23 Feb 2015 17:18:36 +0200
Message-ID: <1424704717-29728-2-git-send-email-rogerq@ti.com>
References: <1424704717-29728-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58748 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751618AbbBWPT3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Feb 2015 10:19:29 -0500
In-Reply-To: <1424704717-29728-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: balbi@ti.com, grinberg@compulab.co.il, grygorii.strashko@linaro.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>

Without this NAND doesn't work on most EVMs.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/configs/omap2plus_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index b738652..b674245 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -114,6 +114,7 @@ CONFIG_MTD_PHYSMAP_OF=y
 CONFIG_MTD_NAND=y
 CONFIG_MTD_NAND_ECC_BCH=y
 CONFIG_MTD_NAND_OMAP2=y
+CONFIG_MTD_NAND_OMAP_BCH=y
 CONFIG_MTD_ONENAND=y
 CONFIG_MTD_ONENAND_VERIFY_WRITE=y
 CONFIG_MTD_ONENAND_OMAP2=y
-- 
2.1.0

