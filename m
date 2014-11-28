From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH] ARM: OMAP2+: AM43x: Add ID for ES1.2
Date: Fri, 28 Nov 2014 09:02:07 +0530
Message-ID: <1417145527-31086-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51511 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750981AbaK1Ddr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Nov 2014 22:33:47 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, tony@atomide.com, nsekhar@ti.com, t-kristo@ti.com, nm@ti.com, lokeshvutla@ti.com

ES1.2 is a minor variant of ES1.1. Major changes since ES1.1 are
updating ROM for fixing the following boot modes:
- NAND boot
- UART boot
- Ethernet boot
- USB HOST/Client boot
This patch adds ID support for AM437x ES1.2 silicon.
There are no additional kernel fixes required for ES1.2 silicon.

Latest Technical Documentation can be found here:
http://www.ti.com/lsds/ti/arm/sitara_arm_cortex_a_processor/arm_cortex_a9_core/am437x_arm_cortex_a9/tech_docs.page

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 arch/arm/mach-omap2/id.c  | 8 ++++++--
 arch/arm/mach-omap2/soc.h | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 53841de..c25feba 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -471,11 +471,15 @@ void __init omap3xxx_check_revision(void)
 			cpu_rev = "1.0";
 			break;
 		case 1:
-		/* FALLTHROUGH */
-		default:
 			omap_revision = AM437X_REV_ES1_1;
 			cpu_rev = "1.1";
 			break;
+		case 2:
+		/* FALLTHROUGH */
+		default:
+			omap_revision = AM437X_REV_ES1_2;
+			cpu_rev = "1.2";
+			break;
 		}
 		break;
 	case 0xb8f2:
diff --git a/arch/arm/mach-omap2/soc.h b/arch/arm/mach-omap2/soc.h
index 4376f59..c1a3b44 100644
--- a/arch/arm/mach-omap2/soc.h
+++ b/arch/arm/mach-omap2/soc.h
@@ -446,6 +446,7 @@ IS_OMAP_TYPE(3430, 0x3430)
 #define AM437X_CLASS		0x43700000
 #define AM437X_REV_ES1_0	(AM437X_CLASS | (0x10 << 8))
 #define AM437X_REV_ES1_1	(AM437X_CLASS | (0x11 << 8))
+#define AM437X_REV_ES1_2	(AM437X_CLASS | (0x12 << 8))
 
 #define OMAP443X_CLASS		0x44300044
 #define OMAP4430_REV_ES1_0	(OMAP443X_CLASS | (0x10 << 8))
-- 
1.9.1

