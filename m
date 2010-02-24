From: Thara Gopinath <thara@ti.com>
Subject: [PATCH 16/16] OMAP3: PM: Enabling Smartreflex Class 3 driver by default in pm defconfig
Date: Wed, 24 Feb 2010 14:59:17 +0530
Message-ID: <1267003757-22456-17-git-send-email-thara@ti.com>
References: <1267003757-22456-1-git-send-email-thara@ti.com>
 <1267003757-22456-2-git-send-email-thara@ti.com>
 <1267003757-22456-3-git-send-email-thara@ti.com>
 <1267003757-22456-4-git-send-email-thara@ti.com>
 <1267003757-22456-5-git-send-email-thara@ti.com>
 <1267003757-22456-6-git-send-email-thara@ti.com>
 <1267003757-22456-7-git-send-email-thara@ti.com>
 <1267003757-22456-8-git-send-email-thara@ti.com>
 <1267003757-22456-9-git-send-email-thara@ti.com>
 <1267003757-22456-10-git-send-email-thara@ti.com>
 <1267003757-22456-11-git-send-email-thara@ti.com>
 <1267003757-22456-12-git-send-email-thara@ti.com>
 <1267003757-22456-13-git-send-email-thara@ti.com>
 <1267003757-22456-14-git-send-email-thara@ti.com>
 <1267003757-22456-15-git-send-email-thara@ti.com>
 <1267003757-22456-16-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43675 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756160Ab0BXJ3f (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Feb 2010 04:29:35 -0500
In-Reply-To: <1267003757-22456-16-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, nm@ti.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

This patch enables smartreflex class 3 driver in omap3_pm_defconfig.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/configs/omap3_pm_defconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/omap3_pm_defconfig b/arch/arm/configs/omap3_pm_defconfig
index c7fa3e1..61410b6 100644
--- a/arch/arm/configs/omap3_pm_defconfig
+++ b/arch/arm/configs/omap3_pm_defconfig
@@ -231,6 +231,7 @@ CONFIG_ARCH_OMAP3=y
 # OMAP Feature Selections
 #
 CONFIG_OMAP_SMARTREFLEX=y
+CONFIG_OMAP_SMARTREFLEX_CLASS3=y
 # CONFIG_OMAP_SMARTREFLEX_TESTING is not set
 CONFIG_OMAP_RESET_CLOCKS=y
 CONFIG_OMAP_MUX=y
-- 
1.7.0.rc1.33.g07cf0f

