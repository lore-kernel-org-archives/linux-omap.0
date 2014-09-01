From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 21/26] ARM: AM33xx: PRM: make direct register access functions static
Date: Mon, 1 Sep 2014 21:09:10 +0300
Message-ID: <1409594955-1476-22-git-send-email-t-kristo@ti.com>
References: <1409594955-1476-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35730 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754711AbaIASKV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Sep 2014 14:10:21 -0400
In-Reply-To: <1409594955-1476-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

These should not be accessed outside driver, thus removed the APIs
from the header file and made the implementation static.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/prm33xx.c |    6 +++---
 arch/arm/mach-omap2/prm33xx.h |    3 ---
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/prm33xx.c b/arch/arm/mach-omap2/prm33xx.c
index 03960bc..4a843f7 100644
--- a/arch/arm/mach-omap2/prm33xx.c
+++ b/arch/arm/mach-omap2/prm33xx.c
@@ -28,19 +28,19 @@
 #define AM33XX_RST_GLOBAL_WARM_SW_MASK		(1 << 0)
 
 /* Read a register in a PRM instance */
-u32 am33xx_prm_read_reg(s16 inst, u16 idx)
+static u32 am33xx_prm_read_reg(s16 inst, u16 idx)
 {
 	return readl_relaxed(prm_base + inst + idx);
 }
 
 /* Write into a register in a PRM instance */
-void am33xx_prm_write_reg(u32 val, s16 inst, u16 idx)
+static void am33xx_prm_write_reg(u32 val, s16 inst, u16 idx)
 {
 	writel_relaxed(val, prm_base + inst + idx);
 }
 
 /* Read-modify-write a register in PRM. Caller must lock */
-u32 am33xx_prm_rmw_reg_bits(u32 mask, u32 bits, s16 inst, s16 idx)
+static u32 am33xx_prm_rmw_reg_bits(u32 mask, u32 bits, s16 inst, s16 idx)
 {
 	u32 v;
 
diff --git a/arch/arm/mach-omap2/prm33xx.h b/arch/arm/mach-omap2/prm33xx.h
index 49ad5b8..937d56e 100644
--- a/arch/arm/mach-omap2/prm33xx.h
+++ b/arch/arm/mach-omap2/prm33xx.h
@@ -118,9 +118,6 @@
 #define AM33XX_PM_CEFUSE_PWRSTST		AM33XX_PRM_REGADDR(AM33XX_PRM_CEFUSE_MOD, 0x0004)
 
 #ifndef __ASSEMBLER__
-extern u32 am33xx_prm_read_reg(s16 inst, u16 idx);
-extern void am33xx_prm_write_reg(u32 val, s16 inst, u16 idx);
-extern u32 am33xx_prm_rmw_reg_bits(u32 mask, u32 bits, s16 inst, s16 idx);
 extern void am33xx_prm_global_warm_sw_reset(void);
 int am33xx_prm_init(void);
 
-- 
1.7.9.5

