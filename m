From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 4/9] omap: improve OMAP3_HAS_FEATURE
Date: Tue, 22 Jun 2010 21:16:10 -0500
Message-ID: <1277259375-18521-5-git-send-email-nm@ti.com>
References: <1277259375-18521-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45155 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945Ab0FWCQZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jun 2010 22:16:25 -0400
In-Reply-To: <1277259375-18521-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: Venkatraman S <svenkatr@ti.com>, Senthilvadivu Guruswamy <svadivu@ti.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Angelo Arrifano <miknix@gmail.com>, "Zebediah C. McClure" <zmc@lurian.net>, Alistair Buxton <a.j.buxton@gmail.com>, Paul Walmsley <paul@pwsan.com>, Sanjeev Premi <premi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, Aaro Koskinen <aaro.koskinen@nokia.com>, Vikram Pandita <vikram.pandita@ti.com>, Vishwanath S <vishwa.s@ti.com>, linux-omap@vger.kernel.org

Replace OMAP3_HAS_FEATURE with OMAP_HAS_FEATURE allowing
us to support multiple chip features

Cc: Tony Lindgren <tony@atomide.com>
Cc: Angelo Arrifano <miknix@gmail.com>
Cc: "Zebediah C. McClure" <zmc@lurian.net>
Cc: Alistair Buxton <a.j.buxton@gmail.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Sanjeev Premi <premi@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Senthilvadivu Gurusamy <svadivu@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: Vikram Pandita <vikram.pandita@ti.com>
Cc: Vishwanath S <vishwa.s@ti.com>
Cc: linux-omap@vger.kernel.org

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/plat-omap/include/plat/cpu.h |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index 5f12a0b..c71dbf4 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -444,6 +444,12 @@ static inline void omap1_check_revision(void) {}
 #endif
 void omap_check_revision(void);
 
+#define OMAP_HAS_FEATURE(rev, feat, flag)				\
+static inline unsigned int omap##rev##_has_ ##feat(void)		\
+{									\
+	return omap##rev##_features & OMAP##rev##_HAS_ ##flag;		\
+}									\
+
 /*
  * Runtime detection of OMAP3 features
  */
@@ -456,17 +462,11 @@ extern u32 omap3_features;
 #define OMAP3_HAS_ISP			BIT(4)
 #define OMAP3_HAS_192MHZ_CLK		BIT(5)
 
-#define OMAP3_HAS_FEATURE(feat,flag)			\
-static inline unsigned int omap3_has_ ##feat(void)	\
-{							\
-	return (omap3_features & OMAP3_HAS_ ##flag);	\
-}							\
-
-OMAP3_HAS_FEATURE(l2cache, L2CACHE)
-OMAP3_HAS_FEATURE(sgx, SGX)
-OMAP3_HAS_FEATURE(iva, IVA)
-OMAP3_HAS_FEATURE(neon, NEON)
-OMAP3_HAS_FEATURE(isp, ISP)
-OMAP3_HAS_FEATURE(192mhz_clk, 192MHZ_CLK)
+OMAP_HAS_FEATURE(3, l2cache, L2CACHE)
+OMAP_HAS_FEATURE(3, sgx, SGX)
+OMAP_HAS_FEATURE(3, iva, IVA)
+OMAP_HAS_FEATURE(3, neon, NEON)
+OMAP_HAS_FEATURE(3, isp, ISP)
+OMAP_HAS_FEATURE(3, 192mhz_clk, 192MHZ_CLK)
 
 #endif
-- 
1.6.3.3

