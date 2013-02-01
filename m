From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH] ARM: OMAP2: AM33XX: id: Add support for AM335x PG2.0
Date: Fri, 1 Feb 2013 15:58:22 +0530
Message-ID: <1359714502-21528-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47977 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756417Ab3BAK23 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Feb 2013 05:28:29 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, AnilKumar Ch <anilkumar@ti.com>

Add support for chip id recognition of AM335x PG2.0 silicon. By default
omap3xxx_check_revision() recognizes PG1.0, which is extended by adding
PG2.0 support

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/mach-omap2/id.c  |   14 ++++++++++++--
 arch/arm/mach-omap2/soc.h |    1 +
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 45cc7ed4..8a68f1e 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -399,8 +399,18 @@ void __init omap3xxx_check_revision(void)
 		}
 		break;
 	case 0xb944:
-		omap_revision = AM335X_REV_ES1_0;
-		cpu_rev = "1.0";
+		switch (rev) {
+		case 0:
+			omap_revision = AM335X_REV_ES1_0;
+			cpu_rev = "1.0";
+			break;
+		case 1:
+		/* FALLTHROUGH */
+		default:
+			omap_revision = AM335X_REV_ES2_0;
+			cpu_rev = "2.0";
+			break;
+		}
 		break;
 	case 0xb8f2:
 		switch (rev) {
diff --git a/arch/arm/mach-omap2/soc.h b/arch/arm/mach-omap2/soc.h
index 092aedd..c62116b 100644
--- a/arch/arm/mach-omap2/soc.h
+++ b/arch/arm/mach-omap2/soc.h
@@ -395,6 +395,7 @@ IS_OMAP_TYPE(3430, 0x3430)
 
 #define AM335X_CLASS		0x33500033
 #define AM335X_REV_ES1_0	AM335X_CLASS
+#define AM335X_REV_ES2_0	(AM335X_CLASS | (0x1 << 8))
 
 #define OMAP443X_CLASS		0x44300044
 #define OMAP4430_REV_ES1_0	(OMAP443X_CLASS | (0x10 << 8))
-- 
1.7.9.5

