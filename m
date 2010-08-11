From: Charulatha V <charu@ti.com>
Subject: [PATCH 1/6 v2] OMAP2PLUS: WDT: Add ICLKEN, FCLKEN, WKEN shared bits for WDT
Date: Wed, 11 Aug 2010 15:41:06 +0530
Message-ID: <1281521471-15802-2-git-send-email-charu@ti.com>
References: <1281521471-15802-1-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49975 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758026Ab0HKKIi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Aug 2010 06:08:38 -0400
In-Reply-To: <1281521471-15802-1-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: wim@iguana.be, khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, rnayak@ti.com, p-basak2@ti.com, Charulatha V <charu@ti.com>

This patch adds the CM_FCLKEN_WKUP, CM_ICLKEN_WKUP, PM_WKEN_WKUP
shared bits for OMAP2PLUS watchdog timer module

Signed-off-by: Charulatha V <charu@ti.com>
Signed-off-by: Basak, Partha <p-basak2@ti.com>
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
1.6.3.3

