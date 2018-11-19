From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] ARM: OMAP1/2: fix SoC name printing
Date: Mon, 19 Nov 2018 21:46:41 +0200
Message-ID: <20181119194641.303-1-aaro.koskinen@iki.fi>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: linux-omap@vger.kernel.org

Currently we get extra newlines on OMAP1/2 when the SoC name is printed:

[    0.000000] OMAP1510
[    0.000000]  revision 2 handled as 15xx id: bc058c9b93111a16

[    0.000000] OMAP2420
[    0.000000]

Fix by using pr_cont.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/arm/mach-omap1/id.c | 6 +++---
 arch/arm/mach-omap2/id.c | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap1/id.c b/arch/arm/mach-omap1/id.c
index 52de382fc804..7e49dfda3d2f 100644
--- a/arch/arm/mach-omap1/id.c
+++ b/arch/arm/mach-omap1/id.c
@@ -200,10 +200,10 @@ void __init omap_check_revision(void)
 		printk(KERN_INFO "Unknown OMAP cpu type: 0x%02x\n", cpu_type);
 	}
 
-	printk(KERN_INFO "OMAP%04x", omap_revision >> 16);
+	pr_info("OMAP%04x", omap_revision >> 16);
 	if ((omap_revision >> 8) & 0xff)
-		printk(KERN_INFO "%x", (omap_revision >> 8) & 0xff);
-	printk(KERN_INFO " revision %i handled as %02xxx id: %08x%08x\n",
+		pr_cont("%x", (omap_revision >> 8) & 0xff);
+	pr_cont(" revision %i handled as %02xxx id: %08x%08x\n",
 	       die_rev, omap_revision & 0xff, system_serial_low,
 	       system_serial_high);
 }
diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 68ba5f472f6b..859c71c4e932 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -199,8 +199,8 @@ void __init omap2xxx_check_revision(void)
 
 	pr_info("%s", soc_name);
 	if ((omap_rev() >> 8) & 0x0f)
-		pr_info("%s", soc_rev);
-	pr_info("\n");
+		pr_cont("%s", soc_rev);
+	pr_cont("\n");
 }
 
 #define OMAP3_SHOW_FEATURE(feat)		\
-- 
2.17.0
