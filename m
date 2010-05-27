From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 4/5] OMAP24xx: CM: fix mask used for checking IDLEST status
Date: Thu, 27 May 2010 14:13:35 -0700
Message-ID: <1274994816-30335-5-git-send-email-khilman@deeprootsystems.com>
References: <1274994816-30335-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:61906 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756733Ab0E0VNq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 May 2010 17:13:46 -0400
Received: by mail-pv0-f174.google.com with SMTP id 11so82342pvg.19
        for <linux-omap@vger.kernel.org>; Thu, 27 May 2010 14:13:46 -0700 (PDT)
In-Reply-To: <1274994816-30335-1-git-send-email-khilman@deeprootsystems.com>
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

