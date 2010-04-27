From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCHv2 3/4] mach-omap1: Add SoC info data for OMAP1 into /proc/cpuinfo
Date: Tue, 27 Apr 2010 16:14:14 +0300
Message-ID: <1272374055-9656-4-git-send-email-eduardo.valentin@nokia.com>
References: <1272374055-9656-1-git-send-email-eduardo.valentin@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:43439 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752346Ab0D0NPS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Apr 2010 09:15:18 -0400
In-Reply-To: <1272374055-9656-1-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, Linux-OMAP <linux-omap@vger.kernel.org>
Cc: ext Tony Lindgren <tony@atomide.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, "\\\"De-Schrijver Peter (Nokia-D/Helsinki)\\\"" <Peter.De-Schrijver@nokia.com>, santosh.shilimkar@ti.com, Eduardo Valentin <eduardo.valentin@nokia.com>

From: Eduardo Valentin <eduardo.valentin@nokia.com>

Report OMAP data into system_soc_info. Now we get omap
information under /proc/cpuinfo.

Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 arch/arm/mach-omap1/id.c |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap1/id.c b/arch/arm/mach-omap1/id.c
index a0e3560..9622e9f 100644
--- a/arch/arm/mach-omap1/id.c
+++ b/arch/arm/mach-omap1/id.c
@@ -194,11 +194,17 @@ void __init omap_check_revision(void)
 		printk(KERN_INFO "Unknown OMAP cpu type: 0x%02x\n", cpu_type);
 	}
 
-	printk(KERN_INFO "OMAP%04x", omap_revision >> 16);
-	if ((omap_revision >> 8) & 0xff)
-		printk(KERN_INFO "%x", (omap_revision >> 8) & 0xff);
-	printk(KERN_INFO " revision %i handled as %02xxx id: %08x%08x\n",
-	       die_rev, omap_revision & 0xff, system_serial_low,
-	       system_serial_high);
+	snprintf(system_soc_info, SYSTEM_SOC_INFO_SIZE, "OMAP%04x",
+							 omap_revision >> 16);
+	if ((omap_revision >> 8) & 0xff) {
+		int sz = strlen(system_soc_info);
+
+		snprintf(system_soc_info + sz, SYSTEM_SOC_INFO_SIZE - sz,
+				"%x", (omap_revision >> 8) & 0xff);
+	}
+	pr_info("%s revision %i handled as %02xxx id: %08x%08x\n",
+		system_soc_info, die_rev, omap_revision & 0xff,
+		system_serial_low, system_serial_high);
+
 }
 
-- 
1.7.0.4.361.g8b5fe.dirty

