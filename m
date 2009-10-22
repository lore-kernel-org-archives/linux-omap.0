From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH v2 21/32] OMAP: Store reboot mode in scratchpad on OMAP34xx
Date: Thu, 22 Oct 2009 16:09:42 -0700
Message-ID: <1256252993-24328-22-git-send-email-khilman@deeprootsystems.com>
References: <1256252993-24328-1-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-2-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-3-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-4-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-5-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-6-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-7-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-8-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-9-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-10-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-11-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-12-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-13-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-14-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-15-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-16-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-17-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-18-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-19-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-20-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-21-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.25]:3282 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755530AbZJVXLJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Oct 2009 19:11:09 -0400
Received: by qw-out-2122.google.com with SMTP id 9so1260502qwb.37
        for <linux-omap@vger.kernel.org>; Thu, 22 Oct 2009 16:11:14 -0700 (PDT)
In-Reply-To: <1256252993-24328-21-git-send-email-khilman@deeprootsystems.com>
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
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/prcm.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index 221eed1..029d376 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -135,9 +135,18 @@ void omap_prcm_arch_reset(char mode)
 
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

