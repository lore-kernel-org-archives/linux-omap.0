From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 24/28] OMAP: Store reboot mode in scratchpad on OMAP34xx
Date: Thu,  1 Oct 2009 16:58:54 -0700
Message-ID: <1254441538-9257-25-git-send-email-khilman@deeprootsystems.com>
References: <1254441538-9257-1-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-2-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-3-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-4-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-5-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-6-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-7-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-8-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-9-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-10-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-11-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-12-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-13-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-14-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-15-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-16-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-17-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-18-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-19-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-20-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-21-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-22-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-23-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-24-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.216.179]:51872 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756201AbZJAX7g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Oct 2009 19:59:36 -0400
Received: by mail-px0-f179.google.com with SMTP id 9so694314pxi.4
        for <linux-omap@vger.kernel.org>; Thu, 01 Oct 2009 16:59:41 -0700 (PDT)
In-Reply-To: <1254441538-9257-24-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Juha Yrjola <juha.yrjola@solidboot.com>, Tony Lindgren <tony@atomide.com>

From: Juha Yrjola <juha.yrjola@solidboot.com>

The reboot mode can be communicated to a bootloader (or the
kernel itself) with a scratchpad register. This functionality
is especially useful, if userspace is allowed to change
the reboot mode.

Signed-off-by: Juha Yrjola <juha.yrjola@solidboot.com>
Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
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

