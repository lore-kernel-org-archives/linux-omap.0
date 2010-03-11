From: Sergio Aguirre <saaguirre@ti.com>
Subject: [RFC part1/2 merge v4][PATCH 04/11] ARM: OMAP3630: PRCM: Add UART4 control bits
Date: Wed, 10 Mar 2010 18:14:17 -0600
Message-ID: <1268266464-15702-5-git-send-email-saaguirre@ti.com>
References: <1268266464-15702-1-git-send-email-saaguirre@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36546 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932943Ab0CKANV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Mar 2010 19:13:21 -0500
In-Reply-To: <1268266464-15702-1-git-send-email-saaguirre@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Vikram Pandita <vikram.pandita@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <me@felipebalbi.com>, Sergio Aguirre <saaguirre@ti.com>

This bits are exclusive of omap 36xx family of chips.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 arch/arm/mach-omap2/cm-regbits-34xx.h |    2 ++
 arch/arm/mach-omap2/prcm-common.h     |    4 ++++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/cm-regbits-34xx.h b/arch/arm/mach-omap2/cm-regbits-34xx.h
index a3a3ca0..834b671 100644
--- a/arch/arm/mach-omap2/cm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/cm-regbits-34xx.h
@@ -649,6 +649,8 @@
 #define OMAP3430_ST_MCBSP2_MASK				(1 << 0)
 
 /* CM_AUTOIDLE_PER */
+#define OMAP3630_AUTO_UART4				(1 << 18)
+#define OMAP3630_AUTO_UART4_SHIFT			18
 #define OMAP3430_AUTO_GPIO6				(1 << 17)
 #define OMAP3430_AUTO_GPIO6_SHIFT			17
 #define OMAP3430_AUTO_GPIO5				(1 << 16)
diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
index 90f603d..c4e7bcb 100644
--- a/arch/arm/mach-omap2/prcm-common.h
+++ b/arch/arm/mach-omap2/prcm-common.h
@@ -390,6 +390,8 @@
 #define OMAP3430_EN_MPU_SHIFT				1
 
 /* CM_FCLKEN_PER, CM_ICLKEN_PER, PM_WKEN_PER shared bits */
+#define OMAP3630_EN_UART4				(1 << 18)
+#define OMAP3630_EN_UART4_SHIFT				18
 #define OMAP3430_EN_GPIO6				(1 << 17)
 #define OMAP3430_EN_GPIO6_SHIFT				17
 #define OMAP3430_EN_GPIO5				(1 << 16)
@@ -430,6 +432,8 @@
 #define OMAP3430_EN_MCBSP2_SHIFT			0
 
 /* CM_IDLEST_PER, PM_WKST_PER shared bits */
+#define OMAP3630_ST_UART4_SHIFT				18
+#define OMAP3630_ST_UART4_MASK				(1 << 18)
 #define OMAP3430_ST_GPIO6_SHIFT				17
 #define OMAP3430_ST_GPIO6_MASK				(1 << 17)
 #define OMAP3430_ST_GPIO5_SHIFT				16
-- 
1.6.3.3

