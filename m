From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH] OMAP24xx: CM: fix mask used for checking IDLEST status
Date: Wed, 26 May 2010 15:59:52 -0700
Message-ID: <1274914792-28235-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:59828 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980Ab0EZW74 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 May 2010 18:59:56 -0400
Received: by pwi7 with SMTP id 7so429115pwi.19
        for <linux-omap@vger.kernel.org>; Wed, 26 May 2010 15:59:55 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

On OMAP24xx, the polarity for the IDLEST bits is opposite of OMAP3.
The mask used to check this was using the bit position instead of the
bit mask.

This patch fixes the problem by using the bit mask instead of the bit
field.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
Found when testing UART hwmods on OMAP2420 (n810)

 arch/arm/mach-omap2/cm.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/cm.c b/arch/arm/mach-omap2/cm.c
index 2d83565..721c3b6 100644
--- a/arch/arm/mach-omap2/cm.c
+++ b/arch/arm/mach-omap2/cm.c
@@ -50,15 +50,15 @@ int omap2_cm_wait_module_ready(s16 prcm_mod, u8 idlest_id, u8 idlest_shift)
 
 	cm_idlest_reg = cm_idlest_offs[idlest_id - 1];
 
+	mask = 1 << idlest_shift;
+
 	if (cpu_is_omap24xx())
-		ena = idlest_shift;
+		ena = mask;
 	else if (cpu_is_omap34xx())
 		ena = 0;
 	else
 		BUG();
 
-	mask = 1 << idlest_shift;
-
 	/* XXX should be OMAP2 CM */
 	omap_test_timeout(((cm_read_mod_reg(prcm_mod, cm_idlest_reg) & mask) == ena),
 			  MAX_MODULE_READY_TIME, i);
-- 
1.7.0.2

