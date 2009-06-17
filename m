From: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
Subject: [PATCH] SDRC: Remove SDRC_POWER register configuration from SDRC init.
Date: Wed, 17 Jun 2009 16:35:21 +0300
Message-ID: <1245245721-7052-1-git-send-email-Artem.Bityutskiy@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:60556 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933524AbZFQNff (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Jun 2009 09:35:35 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Samu Onkalo <samu.p.onkalo@nokia.com>

From: Samu Onkalo <samu.p.onkalo@nokia.com>

Bootloader must configure proper settings for SDRC before starting
kernel from SDRAM. Furthermore, removed lines violated omap3430 and
omap2420 SDRC errata (see errata 1.150)

Signed-off-by: Samu Onkalo <samu.p.onkalo@nokia.com>
---
 arch/arm/mach-omap2/sdrc.c |   10 ++--------
 1 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/sdrc.c b/arch/arm/mach-omap2/sdrc.c
index 2045441..0874687 100644
--- a/arch/arm/mach-omap2/sdrc.c
+++ b/arch/arm/mach-omap2/sdrc.c
@@ -86,8 +86,8 @@ void __init omap2_set_globals_sdrc(struct omap_globals *omap2_globals)
  * @sp: pointer to a null-terminated list of struct omap_sdrc_params
  *
  * Turn on smart idle modes for SDRAM scheduler and controller.
- * Program a known-good configuration for the SDRC to deal with buggy
- * bootloaders.
+ * Bootloaders should make proper configuration for SDRC since kernel
+ * is running from SDRAM.
  */
 void __init omap2_sdrc_init(struct omap_sdrc_params *sp)
 {
@@ -104,10 +104,4 @@ void __init omap2_sdrc_init(struct omap_sdrc_params *sp)
 	sdrc_write_reg(l, SDRC_SYSCONFIG);
 
 	sdrc_init_params = sp;
-
-	/* XXX Enable SRFRONIDLEREQ here also? */
-	l = (1 << SDRC_POWER_EXTCLKDIS_SHIFT) |
-		(1 << SDRC_POWER_PWDENA_SHIFT) |
-		(1 << SDRC_POWER_PAGEPOLICY_SHIFT);
-	sdrc_write_reg(l, SDRC_POWER);
 }
-- 
1.6.0.6

