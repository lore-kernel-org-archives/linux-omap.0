From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 3/7] ARM: OMAP4: Remove un-used WakeupGen register defines.
Date: Wed, 2 May 2012 15:18:09 +0530
Message-ID: <1335952093-12541-4-git-send-email-santosh.shilimkar@ti.com>
References: <1335952093-12541-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35249 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750695Ab2EBJsb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 May 2012 05:48:31 -0400
In-Reply-To: <1335952093-12541-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, tony@atomide.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

Current OMAP code doesn't use any of the OMAP_WKG_ENB_SECURE_*
registers.

So remove those defines.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/include/mach/omap-wakeupgen.h |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/include/mach/omap-wakeupgen.h b/arch/arm/mach-omap2/include/mach/omap-wakeupgen.h
index d79321b..548de90b 100644
--- a/arch/arm/mach-omap2/include/mach/omap-wakeupgen.h
+++ b/arch/arm/mach-omap2/include/mach/omap-wakeupgen.h
@@ -16,18 +16,10 @@
 #define OMAP_WKG_ENB_B_0			0x14
 #define OMAP_WKG_ENB_C_0			0x18
 #define OMAP_WKG_ENB_D_0			0x1c
-#define OMAP_WKG_ENB_SECURE_A_0			0x20
-#define OMAP_WKG_ENB_SECURE_B_0			0x24
-#define OMAP_WKG_ENB_SECURE_C_0			0x28
-#define OMAP_WKG_ENB_SECURE_D_0			0x2c
 #define OMAP_WKG_ENB_A_1			0x410
 #define OMAP_WKG_ENB_B_1			0x414
 #define OMAP_WKG_ENB_C_1			0x418
 #define OMAP_WKG_ENB_D_1			0x41c
-#define OMAP_WKG_ENB_SECURE_A_1			0x420
-#define OMAP_WKG_ENB_SECURE_B_1			0x424
-#define OMAP_WKG_ENB_SECURE_C_1			0x428
-#define OMAP_WKG_ENB_SECURE_D_1			0x42c
 #define OMAP_AUX_CORE_BOOT_0			0x800
 #define OMAP_AUX_CORE_BOOT_1			0x804
 #define OMAP_PTMSYNCREQ_MASK			0xc00
-- 
1.7.5.4

