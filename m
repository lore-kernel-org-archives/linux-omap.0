From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH V2 2/4] ARM: OMAP2+: AM43x: Add ID for ES1.1
Date: Fri, 7 Feb 2014 15:51:24 +0530
Message-ID: <1391768486-2134-3-git-send-email-lokeshvutla@ti.com>
References: <1391768486-2134-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45397 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752569AbaBGKWD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Feb 2014 05:22:03 -0500
In-Reply-To: <1391768486-2134-1-git-send-email-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, nm@ti.com, tony@atomide.com, linux@arm.linux.org.uk, rnayak@ti.com, nsekhar@ti.com, lokeshvutla@ti.com

Adding ID for AM437x ES1.1 silicon.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 arch/arm/mach-omap2/id.c  |   14 ++++++++++++--
 arch/arm/mach-omap2/soc.h |    3 ++-
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 9428c5f..8a05eaf 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -465,8 +465,18 @@ void __init omap3xxx_check_revision(void)
 		}
 		break;
 	case 0xb98c:
-		omap_revision = AM437X_REV_ES1_0;
-		cpu_rev = "1.0";
+		switch (rev) {
+		case 0:
+			omap_revision = AM437X_REV_ES1_0;
+			cpu_rev = "1.0";
+			break;
+		case 1:
+		/* FALLTHROUGH */
+		default:
+			omap_revision = AM437X_REV_ES1_1;
+			cpu_rev = "1.1";
+			break;
+		}
 		break;
 	case 0xb8f2:
 		switch (rev) {
diff --git a/arch/arm/mach-omap2/soc.h b/arch/arm/mach-omap2/soc.h
index 076bd90..30abcc8 100644
--- a/arch/arm/mach-omap2/soc.h
+++ b/arch/arm/mach-omap2/soc.h
@@ -438,7 +438,8 @@ IS_OMAP_TYPE(3430, 0x3430)
 #define AM335X_REV_ES2_1	(AM335X_CLASS | (0x2 << 8))
 
 #define AM437X_CLASS		0x43700000
-#define AM437X_REV_ES1_0	AM437X_CLASS
+#define AM437X_REV_ES1_0	(AM437X_CLASS | (0x10 << 8))
+#define AM437X_REV_ES1_1	(AM437X_CLASS | (0x11 << 8))
 
 #define OMAP443X_CLASS		0x44300044
 #define OMAP4430_REV_ES1_0	(OMAP443X_CLASS | (0x10 << 8))
-- 
1.7.9.5

