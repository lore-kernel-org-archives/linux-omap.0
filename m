From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 7/7] ARM: OMAP2+: PRCM: remove omap_prcm_get_reset_sources()
Date: Mon, 15 Oct 2012 19:32:57 -0600
Message-ID: <20121016013253.21844.93902.stgit@dusk.lan>
References: <20121016012448.21844.92339.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:42866 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755534Ab2JPBe3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Oct 2012 21:34:29 -0400
In-Reply-To: <20121016012448.21844.92339.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

omap_prcm_get_reset_sources() is now unused; so, remove it.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/prcm.c             |   12 ------------
 arch/arm/plat-omap/include/plat/prcm.h |    1 -
 2 files changed, 13 deletions(-)

diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index 0f51e03..0a2c33b 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -46,18 +46,6 @@ void __iomem *prcm_mpu_base;
 
 #define MAX_MODULE_ENABLE_WAIT		100000
 
-u32 omap_prcm_get_reset_sources(void)
-{
-	/* XXX This presumably needs modification for 34XX */
-	if (cpu_is_omap24xx() || cpu_is_omap34xx())
-		return omap2_prm_read_mod_reg(WKUP_MOD, OMAP2_RM_RSTST) & 0x7f;
-	if (cpu_is_omap44xx())
-		return omap2_prm_read_mod_reg(WKUP_MOD, OMAP4_RM_RSTST) & 0x7f;
-
-	return 0;
-}
-EXPORT_SYMBOL(omap_prcm_get_reset_sources);
-
 /* Resets clock rates and reboots the system. Only called from system.h */
 void omap_prcm_restart(char mode, const char *cmd)
 {
diff --git a/arch/arm/plat-omap/include/plat/prcm.h b/arch/arm/plat-omap/include/plat/prcm.h
index 267f43b..a76cbd4 100644
--- a/arch/arm/plat-omap/include/plat/prcm.h
+++ b/arch/arm/plat-omap/include/plat/prcm.h
@@ -27,7 +27,6 @@
 #ifndef __ASM_ARM_ARCH_OMAP_PRCM_H
 #define __ASM_ARM_ARCH_OMAP_PRCM_H
 
-u32 omap_prcm_get_reset_sources(void);
 int omap2_cm_wait_idlest(void __iomem *reg, u32 mask, u8 idlest,
 			 const char *name);
 


