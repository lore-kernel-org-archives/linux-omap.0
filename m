From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/4] Add prototypes for public functions or declare private
	functions static:
Date: Thu, 17 Jul 2008 20:52:35 -0600
Message-ID: <20080718025233.20613.46368.stgit@localhost.localdomain>
References: <20080718024832.20613.30050.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42272 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252AbYGRDNF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Jul 2008 23:13:05 -0400
In-Reply-To: <20080718024832.20613.30050.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Fix the following sparse warnings:

arch/arm/mach-omap2/pm.c:58:6: warning: symbol 'omap2_block_sleep' was not declared. Should it be static?
arch/arm/mach-omap2/pm.c:63:6: warning: symbol 'omap2_allow_sleep' was not declared. Should it be static?
arch/arm/mach-omap2/pm.c:71:12: warning: symbol 'omap_pm_init' was not declared. Should it be static?

arch/arm/mach-omap2/pm34xx.c:49:6: warning: symbol '_omap_sram_idle' was not declared. Should it be static?

arch/arm/mach-omap2/prcm.c:96:5: warning: symbol 'cm_read_mod_reg' was not declared. Should it be static?
arch/arm/mach-omap2/prcm.c:103:6: warning: symbol 'cm_write_mod_reg' was not declared. Should it be static?
arch/arm/mach-omap2/prcm.c:110:5: warning: symbol 'cm_rmw_mod_reg_bits' was not declared. Should it be static?

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---

 arch/arm/mach-omap2/pm.c         |    2 +-
 arch/arm/mach-omap2/pm.h         |    4 ++++
 arch/arm/mach-omap2/pm34xx.c     |    2 +-
 include/asm-arm/arch-omap/prcm.h |    4 ++++
 4 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index b7434df..f699826 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -89,7 +89,7 @@ void omap2_allow_sleep(void)
 	BUG_ON(i < 0);
 }
 
-int __init omap_pm_init(void)
+static int __init omap_pm_init(void)
 {
 	int error = -1;
 
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 0aeb461..31712f4 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -20,6 +20,10 @@ extern unsigned short enable_dyn_sleep;
 extern unsigned short clocks_off_while_idle;
 extern atomic_t sleep_block;
 
+extern void omap2_block_sleep(void);
+extern void omap2_allow_sleep(void);
+
+
 #ifdef CONFIG_PM_DEBUG
 extern u32 omap2_read_32k_sync_counter(void);
 extern void omap2_pm_dump(int mode, int resume, unsigned int us);
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 449e7b5..4d5f619 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -47,7 +47,7 @@ struct power_state {
 
 static LIST_HEAD(pwrst_list);
 
-void (*_omap_sram_idle)(u32 *addr, int save_state);
+static void (*_omap_sram_idle)(u32 *addr, int save_state);
 
 static void (*saved_idle)(void);
 
diff --git a/include/asm-arm/arch-omap/prcm.h b/include/asm-arm/arch-omap/prcm.h
index b707af7..9a772a9 100644
--- a/include/asm-arm/arch-omap/prcm.h
+++ b/include/asm-arm/arch-omap/prcm.h
@@ -26,6 +26,10 @@
 u32 omap_prcm_get_reset_sources(void);
 void omap_prcm_arch_reset(char mode);
 
+void cm_write_mod_reg(u32 val, s16 module, u16 idx);
+u32 cm_read_mod_reg(s16 module, u16 idx);
+u32 cm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx);
+
 #endif
 
 


