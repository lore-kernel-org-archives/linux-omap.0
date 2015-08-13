From: Nishanth Menon <nm@ti.com>
Subject: [PATCH] ARM: DRA752: Add ID detect for ES2.0
Date: Thu, 13 Aug 2015 09:32:20 -0500
Message-ID: <1439476340-20141-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Vishal Mahaveer <vishalm@ti.com>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Vishal Mahaveer <vishalm@ti.com>

ES2.0 is a minor variant of ES1.1. ES2.0 is an incremental revision
with various fixes including the following:
	- reset logic fixes
	- few assymetric aging logic fixes
	- MMC clock rate fixes
	- Ethernet speed fixes
	- edma fixes for mcasp

NOTE: even though we use a compatible of dra742 and dra752, the usage in
the Linux kernel is more or less interchangable - we use dra752 more
often in the linux kernel compared to dra742 and 4.2-rc6

Signed-off-by: Vishal Mahaveer <vishalm@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
based on linux-next next-20150812, applies to v4.2-rc6 as well.
Definetly not a 4.2 material, for 4.3, this probably missed the first merge
window for 4.3, will be great if it could be considered for the second merge
window.

 arch/arm/mach-omap2/id.c  | 8 ++++++--
 arch/arm/mach-omap2/soc.h | 2 ++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index e3f713ffb06b..54a5ba54d2ff 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -653,8 +653,12 @@ void __init dra7xxx_check_revision(void)
 			omap_revision = DRA752_REV_ES1_0;
 			break;
 		case 1:
-		default:
 			omap_revision = DRA752_REV_ES1_1;
+			break;
+		case 2:
+		default:
+			omap_revision = DRA752_REV_ES2_0;
+			break;
 		}
 		break;
 
@@ -674,7 +678,7 @@ void __init dra7xxx_check_revision(void)
 		/* Unknown default to latest silicon rev as default*/
 		pr_warn("%s: unknown idcode=0x%08x (hawkeye=0x%08x,rev=0x%x)\n",
 			__func__, idcode, hawkeye, rev);
-		omap_revision = DRA752_REV_ES1_1;
+		omap_revision = DRA752_REV_ES2_0;
 	}
 
 	sprintf(soc_name, "DRA%03x", omap_rev() >> 16);
diff --git a/arch/arm/mach-omap2/soc.h b/arch/arm/mach-omap2/soc.h
index f97654d11ea5..2d1d3845253c 100644
--- a/arch/arm/mach-omap2/soc.h
+++ b/arch/arm/mach-omap2/soc.h
@@ -469,6 +469,8 @@ IS_OMAP_TYPE(3430, 0x3430)
 #define DRA7XX_CLASS		0x07000000
 #define DRA752_REV_ES1_0	(DRA7XX_CLASS | (0x52 << 16) | (0x10 << 8))
 #define DRA752_REV_ES1_1	(DRA7XX_CLASS | (0x52 << 16) | (0x11 << 8))
+#define DRA752_REV_ES2_0	(DRA7XX_CLASS | (0x52 << 16) | (0x20 << 8))
+#define DRA722_REV_ES1_0	(DRA7XX_CLASS | (0x22 << 16) | (0x10 << 8))
 #define DRA722_REV_ES1_0	(DRA7XX_CLASS | (0x22 << 16) | (0x10 << 8))
 
 void omap2xxx_check_revision(void);
-- 
2.1.4
