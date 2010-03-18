From: Thara Gopinath <thara@ti.com>
Subject: [PATCHv2 17/17] OMAP3: PM: Enabling Smartreflex Class 3 driver by default in pm defconfig
Date: Thu, 18 Mar 2010 14:45:55 +0530
Message-ID: <1268903755-4151-18-git-send-email-thara@ti.com>
References: <1268903755-4151-1-git-send-email-thara@ti.com>
 <1268903755-4151-2-git-send-email-thara@ti.com>
 <1268903755-4151-3-git-send-email-thara@ti.com>
 <1268903755-4151-4-git-send-email-thara@ti.com>
 <1268903755-4151-5-git-send-email-thara@ti.com>
 <1268903755-4151-6-git-send-email-thara@ti.com>
 <1268903755-4151-7-git-send-email-thara@ti.com>
 <1268903755-4151-8-git-send-email-thara@ti.com>
 <1268903755-4151-9-git-send-email-thara@ti.com>
 <1268903755-4151-10-git-send-email-thara@ti.com>
 <1268903755-4151-11-git-send-email-thara@ti.com>
 <1268903755-4151-12-git-send-email-thara@ti.com>
 <1268903755-4151-13-git-send-email-thara@ti.com>
 <1268903755-4151-14-git-send-email-thara@ti.com>
 <1268903755-4151-15-git-send-email-thara@ti.com>
 <1268903755-4151-16-git-send-email-thara@ti.com>
 <1268903755-4151-17-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57340 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751210Ab0CRJQJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Mar 2010 05:16:09 -0400
In-Reply-To: <1268903755-4151-17-git-send-email-thara@ti.com>
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

