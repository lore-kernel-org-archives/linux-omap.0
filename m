From: Thara Gopinath <thara@ti.com>
Subject: [PATCH 4/4] OMAP3: PM: Enabling Smartreflex Class 3 driver by default in pm defconfig
Date: Sat, 29 May 2010 22:16:54 +0530
Message-ID: <1275151614-16634-5-git-send-email-thara@ti.com>
References: <1275151614-16634-1-git-send-email-thara@ti.com>
 <1275151614-16634-2-git-send-email-thara@ti.com>
 <1275151614-16634-3-git-send-email-thara@ti.com>
 <1275151614-16634-4-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39051 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753893Ab0E2QrC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 29 May 2010 12:47:02 -0400
In-Reply-To: <1275151614-16634-4-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

This patch enables smartreflex class 3 driver in omap3_pm_defconfig.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/configs/omap3_pm_defconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/omap3_pm_defconfig b/arch/arm/configs/omap3_pm_defconfig
index 6e86a06..300ac48 100644
--- a/arch/arm/configs/omap3_pm_defconfig
+++ b/arch/arm/configs/omap3_pm_defconfig
@@ -246,6 +246,7 @@ CONFIG_ARCH_OMAP4=y
 # OMAP Feature Selections
 #
 CONFIG_OMAP_SMARTREFLEX=y
+CONFIG_OMAP_SMARTREFLEX_CLASS3=y
 # CONFIG_OMAP_SMARTREFLEX_TESTING is not set
 CONFIG_OMAP_RESET_CLOCKS=y
 CONFIG_OMAP_MUX=y
-- 
1.7.0.rc1.33.g07cf0f

