From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5/5] omap: Allow testing for omap type with omap_has_feature
Date: Thu, 08 Jul 2010 12:38:04 +0300
Message-ID: <20100708093804.16352.82935.stgit@baageli.muru.com>
References: <20100708093405.16352.11814.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:53508 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754492Ab0GHJiG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jul 2010 05:38:06 -0400
In-Reply-To: <20100708093405.16352.11814.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: nm@ti.com

Allow testing for omap type with omap_has_feature. This
can be used to leave out cpu_is_omapxxxx checks.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/include/plat/cpu.h |   38 ++++++++++++++++++++++++++-------
 1 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index 96eac4d..c117c3c 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -437,14 +437,36 @@ int omap_chip_is(struct omap_chip_id oci);
 void omap2_check_revision(void);
 
 /*
- * Runtime detection of OMAP3 features
+ * Runtime detection of OMAP features
  */
-#define OMAP3_HAS_L2CACHE		BIT(0)
-#define OMAP3_HAS_IVA			BIT(1)
-#define OMAP3_HAS_SGX			BIT(2)
-#define OMAP3_HAS_NEON			BIT(3)
-#define OMAP3_HAS_ISP			BIT(4)
-#define OMAP3_HAS_192MHZ_CLK		BIT(5)
-#define OMAP3_HAS_IO_WAKEUP		BIT(6)
+#define OMAP_FEAT_CLASS_OMAP1		BIT(24)
+#define OMAP_FEAT_CLASS_OMAP2		BIT(25)
+#define OMAP_FEAT_CLASS_OMAP3		BIT(26)
+#define OMAP_FEAT_CLASS_OMAP4		BIT(27)
+
+#define OMAP_HAS_L2CACHE		BIT(0)
+#define OMAP_HAS_IVA			BIT(1)
+#define OMAP_HAS_SGX			BIT(2)
+#define OMAP_HAS_NEON			BIT(3)
+#define OMAP_HAS_ISP			BIT(4)
+#define OMAP_HAS_192MHZ_CLK		BIT(5)
+#define OMAP_HAS_IO_WAKEUP		BIT(6)
+
+#define OMAP2_HAS_IVA			OMAP_FEAT_CLASS_OMAP2 | OMAP_HAS_IVA
+#define OMAP2_HAS_SGX			OMAP_FEAT_CLASS_OMAP2 | OMAP_HAS_SGX
+
+#define OMAP3_HAS_L2CACHE		OMAP_FEAT_CLASS_OMAP3 | OMAP_HAS_L2CACHE
+#define OMAP3_HAS_IVA			OMAP_FEAT_CLASS_OMAP3 | OMAP_HAS_IVA
+#define OMAP3_HAS_SGX			OMAP_FEAT_CLASS_OMAP3 | OMAP_HAS_SGX
+#define OMAP3_HAS_NEON			OMAP_FEAT_CLASS_OMAP3 | OMAP_HAS_NEON
+#define OMAP3_HAS_ISP			OMAP_FEAT_CLASS_OMAP3 | OMAP_HAS_ISP
+#define OMAP3_HAS_192MHZ_CLK		OMAP_FEAT_CLASS_OMAP3 | OMAP_HAS_192MHZ_CLK
+#define OMAP3_HAS_IO_WAKEUP		OMAP_FEAT_CLASS_OMAP3 | OMAP_HAS_IOWAKEUP
+
+#define OMAP4_HAS_L2CACHE		OMAP_FEAT_CLASS_OMAP4 | OMAP_HAS_L2CACHE
+#define OMAP4_HAS_IVA			OMAP_FEAT_CLASS_OMAP4 | OMAP_HAS_IVA
+#define OMAP4_HAS_SGX			OMAP_FEAT_CLASS_OMAP4 | OMAP_HAS_SGX
+#define OMAP4_HAS_NEON			OMAP_FEAT_CLASS_OMAP4 | OMAP_HAS_NEON
+#define OMAP4_HAS_ISP			OMAP_FEAT_CLASS_OMAP4 | OMAP_HAS_ISP
 
 #endif

