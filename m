From: Charulatha V <charu@ti.com>
Subject: [PATCH:v4 02/13] OMAP: GPIO: Populate GPIO base address in omapxxxx.h
Date: Tue, 22 Jun 2010 20:31:45 +0530
Message-ID: <1277218916-15213-3-git-send-email-charu@ti.com>
References: <1277218916-15213-1-git-send-email-charu@ti.com>
 <1277218916-15213-2-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41817 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756450Ab0FVPB2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Jun 2010 11:01:28 -0400
In-Reply-To: <1277218916-15213-2-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, tony@atomide.com, rnayak@ti.com, p-basak2@ti.com, b-cousson@ti.com, Charulatha V <charu@ti.com>

This patch populates omap24xx.h, omap34xx.h and omap44xx.h files
with SoC specific GPIO base addresses. This would be later used
while creating GPIO hwmod structures.

Signed-off-by: Charulatha V <charu@ti.com>
Signed-off-by: Basak, Partha <p-basak2@ti.com>
---
 arch/arm/plat-omap/include/plat/omap24xx.h |   12 ++++++++++++
 arch/arm/plat-omap/include/plat/omap34xx.h |    8 ++++++++
 arch/arm/plat-omap/include/plat/omap44xx.h |    8 ++++++++
 3 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap24xx.h b/arch/arm/plat-omap/include/plat/omap24xx.h
index 7055672..4406bbe 100644
--- a/arch/arm/plat-omap/include/plat/omap24xx.h
+++ b/arch/arm/plat-omap/include/plat/omap24xx.h
@@ -85,5 +85,17 @@
 #define OMAP24XX_SEC_AES_BASE	(OMAP24XX_SEC_BASE + 0x6000)
 #define OMAP24XX_SEC_PKA_BASE	(OMAP24XX_SEC_BASE + 0x8000)
 
+/* GPIO controller*/
+#define OMAP242X_GPIO1_BASE	(L4_24XX_BASE + 0x18000)
+#define OMAP242X_GPIO2_BASE	(L4_24XX_BASE + 0x1a000)
+#define OMAP242X_GPIO3_BASE	(L4_24XX_BASE + 0x1c000)
+#define OMAP242X_GPIO4_BASE	(L4_24XX_BASE + 0x1e000)
+
+#define OMAP243X_GPIO1_BASE	(L4_WK_243X_BASE + 0xC000)
+#define OMAP243X_GPIO2_BASE	(L4_WK_243X_BASE + 0xE000)
+#define OMAP243X_GPIO3_BASE	(L4_WK_243X_BASE + 0x10000)
+#define OMAP243X_GPIO4_BASE	(L4_WK_243X_BASE + 0x12000)
+#define OMAP243X_GPIO5_BASE	(L4_24XX_BASE	 + 0xB6000)
+
 #endif /* __ASM_ARCH_OMAP2_H */
 
diff --git a/arch/arm/plat-omap/include/plat/omap34xx.h b/arch/arm/plat-omap/include/plat/omap34xx.h
index 98fc8b4..53279b8 100644
--- a/arch/arm/plat-omap/include/plat/omap34xx.h
+++ b/arch/arm/plat-omap/include/plat/omap34xx.h
@@ -87,5 +87,13 @@
 #define OMAP34XX_SEC_SHA1MD5_BASE	(OMAP34XX_SEC_BASE + 0x23000)
 #define OMAP34XX_SEC_AES_BASE	(OMAP34XX_SEC_BASE + 0x25000)
 
+/* GPIO controller*/
+#define OMAP34XX_GPIO1_BASE	(L4_WK_34XX_BASE  + 0x10000)
+#define OMAP34XX_GPIO2_BASE	(L4_PER_34XX_BASE + 0x50000)
+#define OMAP34XX_GPIO3_BASE	(L4_PER_34XX_BASE + 0x52000)
+#define OMAP34XX_GPIO4_BASE	(L4_PER_34XX_BASE + 0x54000)
+#define OMAP34XX_GPIO5_BASE	(L4_PER_34XX_BASE + 0x56000)
+#define OMAP34XX_GPIO6_BASE	(L4_PER_34XX_BASE + 0x58000)
+
 #endif /* __ASM_ARCH_OMAP3_H */
 
diff --git a/arch/arm/plat-omap/include/plat/omap44xx.h b/arch/arm/plat-omap/include/plat/omap44xx.h
index 8b3f12f..bec7d69 100644
--- a/arch/arm/plat-omap/include/plat/omap44xx.h
+++ b/arch/arm/plat-omap/include/plat/omap44xx.h
@@ -52,5 +52,13 @@
 #define OMAP4_MMU1_BASE			0x55082000
 #define OMAP4_MMU2_BASE			0x4A066000
 
+/* GPIO controller*/
+#define OMAP44XX_GPIO1_BASE             (L4_WK_44XX_BASE  + 0x10000)
+#define OMAP44XX_GPIO2_BASE             (L4_PER_44XX_BASE + 0x55000)
+#define OMAP44XX_GPIO3_BASE             (L4_PER_44XX_BASE + 0x57000)
+#define OMAP44XX_GPIO4_BASE             (L4_PER_44XX_BASE + 0x59000)
+#define OMAP44XX_GPIO5_BASE             (L4_PER_44XX_BASE + 0x5B000)
+#define OMAP44XX_GPIO6_BASE             (L4_PER_44XX_BASE + 0x5D000)
+
 #endif /* __ASM_ARCH_OMAP44XX_H */
 
-- 
1.6.3.3

