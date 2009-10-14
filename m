From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 21/27] OMAP: Store reboot mode in scratchpad on OMAP34xx
Date: Wed, 14 Oct 2009 14:58:04 -0700
Message-ID: <1255557490-16787-22-git-send-email-khilman@deeprootsystems.com>
References: <1255557490-16787-1-git-send-email-khilman@deeprootsystems.com>
 <1255557490-16787-2-git-send-email-khilman@deeprootsystems.com>
 <1255557490-16787-3-git-send-email-khilman@deeprootsystems.com>
 <1255557490-16787-4-git-send-email-khilman@deeprootsystems.com>
 <1255557490-16787-5-git-send-email-khilman@deeprootsystems.com>
 <1255557490-16787-6-git-send-email-khilman@deeprootsystems.com>
 <1255557490-16787-7-git-send-email-khilman@deeprootsystems.com>
 <1255557490-16787-8-git-send-email-khilman@deeprootsystems.com>
 <1255557490-16787-9-git-send-email-khilman@deeprootsystems.com>
 <1255557490-16787-10-git-send-email-khilman@deeprootsystems.com>
 <1255557490-16787-11-git-send-email-khilman@deeprootsystems.com>
 <1255557490-16787-12-git-send-email-khilman@deeprootsystems.com>
 <1255557490-16787-13-git-send-email-khilman@deeprootsystems.com>
 <1255557490-16787-14-git-send-email-khilman@deeprootsystems.com>
 <1255557490-16787-15-git-send-email-khilman@deeprootsystems.com>
 <1255557490-16787-16-git-send-email-khilman@deeprootsystems.com>
 <1255557490-16787-17-git-send-email-khilman@deeprootsystems.com>
 <1255557490-16787-18-git-send-email-khilman@deeprootsystems.com>
 <1255557490-16787-19-git-send-email-khilman@deeprootsystems.com>
 <1255557490-16787-20-git-send-email-khilman@deeprootsystems.com>
 <1255557490-16787-21-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f188.google.com ([209.85.222.188]:61533 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761279AbZJNV7Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Oct 2009 17:59:24 -0400
Received: by pzk26 with SMTP id 26so195893pzk.4
        for <linux-omap@vger.kernel.org>; Wed, 14 Oct 2009 14:58:48 -0700 (PDT)
In-Reply-To: <1255557490-16787-21-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Juha Yrjola <juha.yrjola@solidboot.com>, Tony Lindgren <tony@atomide.com>

From: Juha Yrjola <juha.yrjola@solidboot.com>

The reboot mode can be communicated to a bootloader (or the
kernel itself) with a scratchpad register. This functionality
is especially useful, if userspace is allowed to change
the reboot mode.

Signed-off-by: Juha Yrjola <juha.yrjola@solidboot.com>
Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/prcm.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index 99ff439..ce17eb1 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -134,9 +134,18 @@ void omap_prcm_arch_reset(char mode)
 
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
1.6.4.3

