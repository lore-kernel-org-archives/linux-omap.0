From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCHv2 2/4] mach-omap2: Add SoC info data for OMAP2,3,4 into /proc/cpuinfo
Date: Tue, 27 Apr 2010 16:14:13 +0300
Message-ID: <1272374055-9656-3-git-send-email-eduardo.valentin@nokia.com>
References: <1272374055-9656-1-git-send-email-eduardo.valentin@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:43435 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752230Ab0D0NPR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Apr 2010 09:15:17 -0400
In-Reply-To: <1272374055-9656-1-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, Linux-OMAP <linux-omap@vger.kernel.org>
Cc: ext Tony Lindgren <tony@atomide.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, "\\\"De-Schrijver Peter (Nokia-D/Helsinki)\\\"" <Peter.De-Schrijver@nokia.com>, santosh.shilimkar@ti.com, Eduardo Valentin <eduardo.valentin@nokia.com>

From: Eduardo Valentin <eduardo.valentin@nokia.com>

Report OMAP2,3,4 data into system_soc_info. Now we get omap
information under /proc/cpuinfo.

Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 arch/arm/mach-omap2/id.c |   21 +++++++++++++++------
 1 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 37b8a1a..75e36a5 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -152,10 +152,15 @@ void __init omap24xx_check_revision(void)
 		j = i;
 	}
 
-	pr_info("OMAP%04x", omap_rev() >> 16);
-	if ((omap_rev() >> 8) & 0x0f)
-		pr_info("ES%x", (omap_rev() >> 12) & 0xf);
-	pr_info("\n");
+	snprintf(system_soc_info, SYSTEM_SOC_INFO_SIZE, "OMAP%04x",
+							omap_rev() >> 16);
+	if ((omap_rev() >> 8) & 0x0f) {
+		int sz = strlen(system_soc_info);
+
+		snprintf(system_soc_info + sz, SYSTEM_SOC_INFO_SIZE - sz,
+				"ES%x",	(omap_rev() >> 12) & 0xf);
+	}
+	pr_info("%s\n", system_soc_info);
 }
 
 #define OMAP3_CHECK_FEATURE(status,feat)				\
@@ -286,7 +291,9 @@ void __init omap4_check_revision(void)
 	if ((hawkeye == 0xb852) && (rev == 0x0)) {
 		omap_revision = OMAP4430_REV_ES1_0;
 		omap_chip.oc |= CHIP_IS_OMAP4430ES1;
-		pr_info("OMAP%04x %s\n", omap_rev() >> 16, rev_name);
+		snprintf(system_soc_info, SYSTEM_SOC_INFO_SIZE, "OMAP%04x %s\n",
+				omap_rev() >> 16, rev_name);
+		pr_info("%s\n", system_soc_info);
 		return;
 	}
 
@@ -356,7 +363,9 @@ void __init omap3_cpuinfo(void)
 	}
 
 	/* Print verbose information */
-	pr_info("%s ES%s (", cpu_name, cpu_rev);
+	snprintf(system_soc_info, SYSTEM_SOC_INFO_SIZE, "%s ES%s", cpu_name,
+			cpu_rev);
+	pr_info("%s (", system_soc_info);
 
 	OMAP3_SHOW_FEATURE(l2cache);
 	OMAP3_SHOW_FEATURE(iva);
-- 
1.7.0.4.361.g8b5fe.dirty

