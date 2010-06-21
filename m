From: Ernesto Ramos <ernesto@ti.com>
Subject: [PATCH 1/5] DSPBRIDGE: Remove unused typedefs.
Date: Mon, 21 Jun 2010 17:07:10 -0500
Message-ID: <1277158034-21843-1-git-send-email-ernesto@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55000 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755626Ab0FUWE2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Jun 2010 18:04:28 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: felipe.contreras@nokia.com, ameya.palande@nokia.com, hiroshi.doyu@nokia.com, Ernesto Ramos <ernesto@ti.com>

Remove unused typedefs in dspbridge.

Signed-off-by: Ernesto Ramos <ernesto@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/dbtype.h |    1 -
 drivers/dsp/bridge/core/_tiomap.h             |    2 --
 2 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/dbtype.h b/arch/arm/plat-omap/include/dspbridge/dbtype.h
index de65a82..ddcb6ee 100644
--- a/arch/arm/plat-omap/include/dspbridge/dbtype.h
+++ b/arch/arm/plat-omap/include/dspbridge/dbtype.h
@@ -74,7 +74,6 @@
 
 #ifndef OMAPBRIDGE_TYPES
 #define OMAPBRIDGE_TYPES
-typedef volatile unsigned short reg_uword16;
 #endif
 
 #define TEXT(x) x
diff --git a/drivers/dsp/bridge/core/_tiomap.h b/drivers/dsp/bridge/core/_tiomap.h
index bf0164e..5d9b8a1 100644
--- a/drivers/dsp/bridge/core/_tiomap.h
+++ b/drivers/dsp/bridge/core/_tiomap.h
@@ -295,8 +295,6 @@ static const struct bpwr_clk_t bpwr_clks[] = {
 #define LOW_LEVEL                       false
 
 /* Macro's */
-#define REG16(A)    (*(reg_uword16 *)(A))
-
 #define CLEAR_BIT(reg, mask)             (reg &= ~mask)
 #define SET_BIT(reg, mask)               (reg |= mask)
 
-- 
1.5.4.5

