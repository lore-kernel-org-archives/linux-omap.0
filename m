From: Juha Yrjola <juha.yrjola@solidboot.com>
Subject: [PATCH v2] OMAP: Store reboot mode in scratchpad on OMAP34xx
Date: Mon,  9 Mar 2009 23:21:01 +0200
Message-ID: <1236633661-11911-1-git-send-email-juha.yrjola@solidboot.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:39122 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753973AbZCIVUq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Mar 2009 17:20:46 -0400
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
 arch/arm/mach-omap2/prcm.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index f945156..2f828cb 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -43,9 +43,18 @@ void omap_prcm_arch_reset(char mode)
 
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
+		 * with the boot ROM. A pointer to a data structure
+		 * describing the boot process can be stored there,
+		 * cf. OMAP34xx TRM, Initialization / Software Booting
+		 * Configuration. */
+		omap_writel(l, OMAP343X_SCRATCHPAD + 4);
+	} else
 		WARN_ON(1);
 
 	prm_set_mod_reg_bits(OMAP_RST_DPLL3, prcm_offs, RM_RSTCTRL);
-- 
1.6.1.3

