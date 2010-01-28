From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 4/4] OMAP2/3: PRCM: fix misc. compiler warnings
Date: Thu, 28 Jan 2010 09:17:16 -0800
Message-ID: <1264699036-5491-5-git-send-email-khilman@deeprootsystems.com>
References: <1264699036-5491-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:54167 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756325Ab0A1RR1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jan 2010 12:17:27 -0500
Received: by mail-pw0-f42.google.com with SMTP id 21so625474pwi.21
        for <linux-omap@vger.kernel.org>; Thu, 28 Jan 2010 09:17:27 -0800 (PST)
In-Reply-To: <1264699036-5491-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

- missing return in omap_prcm_get_reset_sources()
- potential use of uninitialized variable in omap_prcm_arch_reset()

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/prcm.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index e8e121a..4b7286f 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -127,13 +127,15 @@ u32 omap_prcm_get_reset_sources(void)
 		return prm_read_mod_reg(WKUP_MOD, OMAP2_RM_RSTST) & 0x7f;
 	if (cpu_is_omap44xx())
 		return prm_read_mod_reg(WKUP_MOD, OMAP4_RM_RSTST) & 0x7f;
+
+	return 0;
 }
 EXPORT_SYMBOL(omap_prcm_get_reset_sources);
 
 /* Resets clock rates and reboots the system. Only called from system.h */
 void omap_prcm_arch_reset(char mode)
 {
-	s16 prcm_offs;
+	s16 prcm_offs = 0;
 
 	if (cpu_is_omap24xx()) {
 		omap2xxx_clk_prepare_for_reboot();
-- 
1.6.6

