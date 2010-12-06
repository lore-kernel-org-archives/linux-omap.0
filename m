From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] OMAP2: PRCM: fix some SHIFT macros that were actually
 bitmasks
Date: Mon, 6 Dec 2010 13:52:40 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012061351430.13430@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:54286 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753086Ab0LFUwl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Dec 2010 15:52:41 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Charulatha Varadarajan <charu@ti.com>


After Charu's GPIO hwmod patches, GPIO initialization on N800 emits
the following messages for all GPIO banks:

omap_hwmod: gpio1: cannot be enabled (3)

This is due to OMAP24XX_ST_GPIOS_SHIFT being defined as a bitmask.
Fix this and also fix two other macros that had the same problem.

Thanks to Tony Lindgren <tony@atomide.com> for originally reporting
this bug.

Signed-off-by: Paul Walmsley <paul@pwsan.com
Cc: Tony Lindgren <tony@atomide.com>
Cc: Charulatha Varadarajan <charu@ti.com>
---
 arch/arm/mach-omap2/prcm-common.h |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
index a837824..87486f5 100644
--- a/arch/arm/mach-omap2/prcm-common.h
+++ b/arch/arm/mach-omap2/prcm-common.h
@@ -171,13 +171,14 @@
 #define OMAP24XX_EN_GPT1_MASK				(1 << 0)
 
 /* PM_WKST_WKUP, CM_IDLEST_WKUP shared bits */
-#define OMAP24XX_ST_GPIOS_SHIFT				(1 << 2)
-#define OMAP24XX_ST_GPIOS_MASK				2
-#define OMAP24XX_ST_GPT1_SHIFT				(1 << 0)
-#define OMAP24XX_ST_GPT1_MASK				0
+#define OMAP24XX_ST_GPIOS_SHIFT				2
+#define OMAP24XX_ST_GPIOS_MASK				(1 << 2)
+#define OMAP24XX_ST_GPT1_SHIFT				0
+#define OMAP24XX_ST_GPT1_MASK				(1 << 0)
 
 /* CM_IDLEST_MDM and PM_WKST_MDM shared bits */
-#define OMAP2430_ST_MDM_SHIFT				(1 << 0)
+#define OMAP2430_ST_MDM_SHIFT				0
+#define OMAP2430_ST_MDM_MASK				(1 << 0)
 
 
 /* 3430 register bits shared between CM & PRM registers */
-- 
1.7.2.3

