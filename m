From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 14/14] omap3: Fix OMAP35XX_REV macros
Date: Fri, 11 Dec 2009 16:10:21 -0800
Message-ID: <20091212001021.GG24013@atomide.com>
References: <20091211234919.3189.95607.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:57410 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755773AbZLLAKP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Dec 2009 19:10:15 -0500
Content-Disposition: inline
In-Reply-To: <20091211234919.3189.95607.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

From: Sanjeev Premi <premi@ti.com>
Date: Thu, 10 Dec 2009 14:51:35 +0000
Subject: [PATCH] omap3: Fix OMAP35XX_REV macros

In original implementation, the revision passed to
these macros contained revision number in lower nibble.

But, later the revision bits (OMAP_REVBITS_XX) were
defined to use omap_revision[15:08] where revision
number is containied in higher nibble.

This patch updates the macros; else incorrect revision
is detected for OMAP35xx devices.

Signed-off-by: Sanjeev Premi <premi@ti.com>

diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index 0da076d..9a028bd 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -438,12 +438,12 @@ IS_OMAP_TYPE(3517, 0x3517)
 #define OMAP3630_REV_ES1_0	0x36300034
 
 #define OMAP35XX_CLASS		0x35000034
-#define OMAP3503_REV(v)		(OMAP35XX_CLASS | (0x3503 << 16) | (v << 12))
-#define OMAP3515_REV(v)		(OMAP35XX_CLASS | (0x3515 << 16) | (v << 12))
-#define OMAP3525_REV(v)		(OMAP35XX_CLASS | (0x3525 << 16) | (v << 12))
-#define OMAP3530_REV(v)		(OMAP35XX_CLASS | (0x3530 << 16) | (v << 12))
-#define OMAP3505_REV(v)		(OMAP35XX_CLASS | (0x3505 << 16) | (v << 12))
-#define OMAP3517_REV(v)		(OMAP35XX_CLASS | (0x3517 << 16) | (v << 12))
+#define OMAP3503_REV(v)		(OMAP35XX_CLASS | (0x3503 << 16) | (v << 8))
+#define OMAP3515_REV(v)		(OMAP35XX_CLASS | (0x3515 << 16) | (v << 8))
+#define OMAP3525_REV(v)		(OMAP35XX_CLASS | (0x3525 << 16) | (v << 8))
+#define OMAP3530_REV(v)		(OMAP35XX_CLASS | (0x3530 << 16) | (v << 8))
+#define OMAP3505_REV(v)		(OMAP35XX_CLASS | (0x3505 << 16) | (v << 8))
+#define OMAP3517_REV(v)		(OMAP35XX_CLASS | (0x3517 << 16) | (v << 8))
 
 #define OMAP443X_CLASS		0x44300044
 #define OMAP4430_REV_ES1_0	0x44300044
