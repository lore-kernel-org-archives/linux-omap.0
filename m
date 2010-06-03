From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH] OMAP3: PM: fix IO daisy chain enable to use PM_WKEN reg
Date: Thu,  3 Jun 2010 10:13:22 -0700
Message-ID: <1275585202-9637-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:55725 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752012Ab0FCRNZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jun 2010 13:13:25 -0400
Received: by pwj2 with SMTP id 2so174507pwj.19
        for <linux-omap@vger.kernel.org>; Thu, 03 Jun 2010 10:13:24 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Checking to se if the IO daisy chain is enabled should be checking the
PM_WKEN register, not the PM_WKST register.  Reading PM_WKST tells us
if an event occurred, not whether or not it is enabled.

Apparently, we've been lucky until now in that a pending event has not
been there during enable.  However, on 3630/Zoom3, I noticed because
of the WARN that this timeout was always happening.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
Applies to mainline v2.6.35-rc1, also in my pm-fixes branch.

 arch/arm/mach-omap2/pm34xx.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 2e96771..b88737f 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -99,7 +99,7 @@ static void omap3_enable_io_chain(void)
 		/* Do a readback to assure write has been done */
 		prm_read_mod_reg(WKUP_MOD, PM_WKEN);
 
-		while (!(prm_read_mod_reg(WKUP_MOD, PM_WKST) &
+		while (!(prm_read_mod_reg(WKUP_MOD, PM_WKEN) &
 			 OMAP3430_ST_IO_CHAIN_MASK)) {
 			timeout++;
 			if (timeout > 1000) {
@@ -108,7 +108,7 @@ static void omap3_enable_io_chain(void)
 				return;
 			}
 			prm_set_mod_reg_bits(OMAP3430_ST_IO_CHAIN_MASK,
-					     WKUP_MOD, PM_WKST);
+					     WKUP_MOD, PM_WKEN);
 		}
 	}
 }
-- 
1.7.0.2

