From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 01/13] OMAP24xx: CM: fix mask used for checking IDLEST status
Date: Wed, 23 Jun 2010 16:42:31 -0700
Message-ID: <1277336563-24988-2-git-send-email-khilman@deeprootsystems.com>
References: <1277336563-24988-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:42006 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753904Ab0FWXmr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Jun 2010 19:42:47 -0400
Received: by mail-px0-f174.google.com with SMTP id 7so469497pxi.19
        for <linux-omap@vger.kernel.org>; Wed, 23 Jun 2010 16:42:47 -0700 (PDT)
In-Reply-To: <1277336563-24988-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com

On OMAP24xx, the polarity for the IDLEST bits is opposite of OMAP3.
The mask used to check this was using the bit position instead of the
bit mask.

This patch fixes the problem by using the bit mask instead of the bit
field.

Cc: Paul Walmsley <paul@pwsan.com>
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

