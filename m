From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 8/8] OMAP4: Fix the emif and dmm virtual mapping
Date: Thu, 8 Sep 2011 10:52:07 +0530
Message-ID: <1315459327-3285-9-git-send-email-santosh.shilimkar@ti.com>
References: <1315459327-3285-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46065 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752302Ab1IHFWa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Sep 2011 01:22:30 -0400
In-Reply-To: <1315459327-3285-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Girish S G <girishsg@ti.com>

Fix the address overlap with Emulation domain (EMU).

The previous mapping was entering into EMU mapping
and was not as per comments. Fix the mapping accordingly.

[girishsg@ti.com: Helped fixing comments.]
Signed-off-by: Girish S G <girishsg@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/plat-omap/include/plat/io.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/io.h b/arch/arm/plat-omap/include/plat/io.h
index d72ec85..a2f7d31 100644
--- a/arch/arm/plat-omap/include/plat/io.h
+++ b/arch/arm/plat-omap/include/plat/io.h
@@ -228,12 +228,12 @@
 
 #define OMAP44XX_EMIF2_PHYS	OMAP44XX_EMIF2_BASE
 						/* 0x4d000000 --> 0xfd200000 */
-#define OMAP44XX_EMIF2_VIRT	(OMAP44XX_EMIF2_PHYS + OMAP4_L3_PER_IO_OFFSET)
+#define OMAP44XX_EMIF2_VIRT	(OMAP44XX_EMIF1_VIRT + SZ_1M)
 #define OMAP44XX_EMIF2_SIZE	SZ_1M
 
 #define OMAP44XX_DMM_PHYS	OMAP44XX_DMM_BASE
 						/* 0x4e000000 --> 0xfd300000 */
-#define OMAP44XX_DMM_VIRT	(OMAP44XX_DMM_PHYS + OMAP4_L3_PER_IO_OFFSET)
+#define OMAP44XX_DMM_VIRT	(OMAP44XX_EMIF2_VIRT + SZ_1M)
 #define OMAP44XX_DMM_SIZE	SZ_1M
 /*
  * ----------------------------------------------------------------------------
-- 
1.7.4.1

