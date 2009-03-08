From: Juha Yrjola <juha.yrjola@solidboot.com>
Subject: [PATCH] OMAP: Store reboot mode in scratchpad on OMAP34xx
Date: Sun,  8 Mar 2009 19:20:39 +0200
Message-ID: <1236532839-3696-1-git-send-email-juha.yrjola@solidboot.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:24723 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752859AbZCHRUL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 8 Mar 2009 13:20:11 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Juha Yrjola <juha.yrjola@solidboot.com>

The reboot mode can be communicated to a bootloader (or the
kernel itself) with a scratchpad register. This functionality
is especially useful, if userspace is allowed to change
the reboot mode.

Signed-off-by: Juha Yrjola <juha.yrjola@solidboot.com>
---
 arch/arm/mach-omap2/prcm.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index f945156..2bd239e 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -43,9 +43,15 @@ void omap_prcm_arch_reset(char mode)
 
 	if (cpu_is_omap24xx())
 		prcm_offs = WKUP_MOD;
-	else if (cpu_is_omap34xx())
+	else if (cpu_is_omap34xx()) {
+		u32 l;
+
 		prcm_offs = OMAP3430_GR_MOD;
-	else
+		l = ('B' << 24) | ('M' << 16) | mode;
+		/* Reserve the first word in scratchpad for communicating
+		 * with the boot ROM. */
+		omap_writel(l, OMAP343X_SCRATCHPAD + 4);
+	} else
 		WARN_ON(1);
 
 	prm_set_mod_reg_bits(OMAP_RST_DPLL3, prcm_offs, RM_RSTCTRL);
-- 
1.6.1.3

