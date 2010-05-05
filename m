From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [RESEND PATCHv3 3/4] mach-omap1: Add SoC info data for OMAP1 into /proc/cpuinfo
Date: Wed,  5 May 2010 11:42:07 +0300
Message-ID: <1273048928-6105-4-git-send-email-eduardo.valentin@nokia.com>
References: <1273048928-6105-1-git-send-email-eduardo.valentin@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:37648 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933838Ab0EEIl3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 04:41:29 -0400
In-Reply-To: <1273048928-6105-1-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, Linux-OMAP <linux-omap@vger.kernel.org>
Cc: ext Tony Lindgren <tony@atomide.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, "\\\"De-Schrijver Peter (Nokia-D/Helsinki)\\\"" <Peter.De-Schrijver@nokia.com>, santosh.shilimkar@ti.com, felipe.balbi@nokia.com, Eduardo Valentin <eduardo.valentin@nokia.com>

From: Eduardo Valentin <eduardo.valentin@nokia.com>

Report OMAP data into system_soc_info. Now we get omap
information under /proc/cpuinfo.

Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 arch/arm/mach-omap1/id.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap1/id.c b/arch/arm/mach-omap1/id.c
index a0e3560..9a84347 100644
--- a/arch/arm/mach-omap1/id.c
+++ b/arch/arm/mach-omap1/id.c
@@ -120,7 +120,7 @@ static u8 __init omap_get_die_rev(void)
 
 void __init omap_check_revision(void)
 {
-	int i;
+	int i, sz;
 	u16 jtag_id;
 	u8 die_rev;
 	u32 omap_id;
@@ -194,11 +194,14 @@ void __init omap_check_revision(void)
 		printk(KERN_INFO "Unknown OMAP cpu type: 0x%02x\n", cpu_type);
 	}
 
-	printk(KERN_INFO "OMAP%04x", omap_revision >> 16);
+	sz = snprintf(system_soc_info, SYSTEM_SOC_INFO_SIZE, "OMAP%04x",
+							 omap_revision >> 16);
 	if ((omap_revision >> 8) & 0xff)
-		printk(KERN_INFO "%x", (omap_revision >> 8) & 0xff);
-	printk(KERN_INFO " revision %i handled as %02xxx id: %08x%08x\n",
-	       die_rev, omap_revision & 0xff, system_serial_low,
-	       system_serial_high);
+		snprintf(system_soc_info + sz, SYSTEM_SOC_INFO_SIZE - sz,
+				"%x", (omap_revision >> 8) & 0xff);
+	pr_info("%s revision %i handled as %02xxx id: %08x%08x\n",
+		system_soc_info, die_rev, omap_revision & 0xff,
+		system_serial_low, system_serial_high);
+
 }
 
-- 
1.7.0.4.361.g8b5fe.dirty

