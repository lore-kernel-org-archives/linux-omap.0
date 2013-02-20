From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 1/8] ARM: OMAP5: Update SOC id detection code for ES2
Date: Wed, 20 Feb 2013 20:57:07 +0530
Message-ID: <1361374034-21831-2-git-send-email-santosh.shilimkar@ti.com>
References: <1361374034-21831-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53688 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933698Ab3BTPZz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Feb 2013 10:25:55 -0500
In-Reply-To: <1361374034-21831-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

Update OMAP5 ES2 idcode and make ES2 as default detection.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/id.c  |   16 +++++++++++++---
 arch/arm/mach-omap2/soc.h |    2 ++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 45cc7ed4..ed6f407 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -519,22 +519,32 @@ void __init omap5xxx_check_revision(void)
 	case 0xb942:
 		switch (rev) {
 		case 0:
-		default:
 			omap_revision = OMAP5430_REV_ES1_0;
+			break;
+		case 1:
+			omap_revision = OMAP5430_REV_ES2_0;
+			break;
+		default:
+			omap_revision = OMAP5430_REV_ES2_0;
 		}
 		break;
 
 	case 0xb998:
 		switch (rev) {
 		case 0:
-		default:
 			omap_revision = OMAP5432_REV_ES1_0;
+			break;
+		case 1:
+			omap_revision = OMAP5432_REV_ES2_0;
+			break;
+		default:
+			omap_revision = OMAP5432_REV_ES2_0;
 		}
 		break;
 
 	default:
 		/* Unknown default to latest silicon rev as default*/
-		omap_revision = OMAP5430_REV_ES1_0;
+		omap_revision = OMAP5430_REV_ES2_0;
 	}
 
 	pr_info("OMAP%04x ES%d.0\n",
diff --git a/arch/arm/mach-omap2/soc.h b/arch/arm/mach-omap2/soc.h
index f31d907..4c90b3b 100644
--- a/arch/arm/mach-omap2/soc.h
+++ b/arch/arm/mach-omap2/soc.h
@@ -404,7 +404,9 @@ IS_OMAP_TYPE(3430, 0x3430)
 
 #define OMAP54XX_CLASS		0x54000054
 #define OMAP5430_REV_ES1_0	(OMAP54XX_CLASS | (0x30 << 16) | (0x10 << 8))
+#define OMAP5430_REV_ES2_0	(OMAP54XX_CLASS | (0x30 << 16) | (0x20 << 8))
 #define OMAP5432_REV_ES1_0	(OMAP54XX_CLASS | (0x32 << 16) | (0x10 << 8))
+#define OMAP5432_REV_ES2_0	(OMAP54XX_CLASS | (0x32 << 16) | (0x20 << 8))
 
 void omap2xxx_check_revision(void);
 void omap3xxx_check_revision(void);
-- 
1.7.9.5

