From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: [PATCH v6 1/7] OMAP2PLUS: WDT: Add ICLKEN, FCLKEN, WKEN shared bits for WDT
Date: Fri, 17 Sep 2010 19:48:50 +0530
Message-ID: <1284733136-20952-2-git-send-email-charu@ti.com>
References: <1284733136-20952-1-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39133 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752159Ab0IQOTV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Sep 2010 10:19:21 -0400
In-Reply-To: <1284733136-20952-1-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, wim@iguana.be, linux-watchdog@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, rnayak@ti.com, p-basak2@ti.com, linux-omap@vger.kernel.org, "Varadarajan, Charulatha" <charu@ti.com>

This patch adds the CM_FCLKEN_WKUP, CM_ICLKEN_WKUP, PM_WKEN_WKUP
shared bits for OMAP2PLUS watchdog timer module.

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/mach-omap2/prcm-common.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
index 995b7ed..e190c64 100644
--- a/arch/arm/mach-omap2/prcm-common.h
+++ b/arch/arm/mach-omap2/prcm-common.h
@@ -237,6 +237,8 @@
 #define OMAP24XX_ST_USB_MASK				(1 << 0)
 
 /* CM_FCLKEN_WKUP, CM_ICLKEN_WKUP, PM_WKEN_WKUP shared bits */
+#define OMAP24XX_EN_WDT2_SHIFT				3
+#define OMAP24XX_EN_WDT2_MASK				(1 << 3)
 #define OMAP24XX_EN_GPIOS_SHIFT				2
 #define OMAP24XX_EN_GPIOS_MASK				(1 << 2)
 #define OMAP24XX_EN_GPT1_SHIFT				0
@@ -344,6 +346,8 @@
 #define OMAP3430_ST_D2D_MASK				(1 << 3)
 
 /* CM_FCLKEN_WKUP, CM_ICLKEN_WKUP, PM_WKEN_WKUP shared bits */
+#define OMAP3430_EN_WDT2_SHIFT				5
+#define OMAP3430_EN_WDT2_MASK				(1 << 5)
 #define OMAP3430_EN_GPIO1_MASK				(1 << 3)
 #define OMAP3430_EN_GPIO1_SHIFT				3
 #define OMAP3430_EN_GPT12_MASK				(1 << 1)
-- 
1.7.0.4

