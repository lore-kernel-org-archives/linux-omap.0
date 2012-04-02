From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH] OMAP4: Adding ID for OMAP4460 ES1.1
Date: Mon, 2 Apr 2012 11:59:57 +0300
Message-ID: <1333357197-6354-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45637 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751082Ab2DBJAB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 2 Apr 2012 05:00:01 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Chris Lalancette <clalancette@gmail.com>, Roger Quadros <rogerq@ti.com>

From: Chris Lalancette <clalancette@gmail.com>

Signed-off-by: Chris Lalancette <clalancette@gmail.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/mach-omap2/id.c              |    5 ++++-
 arch/arm/plat-omap/include/plat/cpu.h |    1 +
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 0e79b7b..f139817 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -478,9 +478,12 @@ void __init omap4xxx_check_revision(void)
 	case 0xb94e:
 		switch (rev) {
 		case 0:
-		default:
 			omap_revision = OMAP4460_REV_ES1_0;
 			break;
+		case 2:
+		default:
+			omap_revision = OMAP4460_REV_ES1_1;
+			break;
 		}
 		break;
 	case 0xb975:
diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index dc6a86b..4bdf14e 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -445,6 +445,7 @@ IS_OMAP_TYPE(3517, 0x3517)
 
 #define OMAP446X_CLASS		0x44600044
 #define OMAP4460_REV_ES1_0	(OMAP446X_CLASS | (0x10 << 8))
+#define OMAP4460_REV_ES1_1	(OMAP446X_CLASS | (0x11 << 8))
 
 #define OMAP447X_CLASS		0x44700044
 #define OMAP4470_REV_ES1_0	(OMAP447X_CLASS | (0x10 << 8))
-- 
1.7.4.1

