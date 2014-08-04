From: Hans Wennborg <hans@hanshq.net>
Subject: [PATCH 01/19] ARM: OMAP: fix %d confusingly prefixed with 0x in format string
Date: Sun,  3 Aug 2014 17:18:03 -0700
Message-ID: <1407111483-14512-1-git-send-email-hans@hanshq.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Hans Wennborg <hans@hanshq.net>
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Hans Wennborg <hans@hanshq.net>
---
 arch/arm/mach-omap2/id.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index d42022f..53841de 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -663,7 +663,7 @@ void __init dra7xxx_check_revision(void)
 
 	default:
 		/* Unknown default to latest silicon rev as default*/
-		pr_warn("%s: unknown idcode=0x%08x (hawkeye=0x%08x,rev=0x%d)\n",
+		pr_warn("%s: unknown idcode=0x%08x (hawkeye=0x%08x,rev=0x%x)\n",
 			__func__, idcode, hawkeye, rev);
 		omap_revision = DRA752_REV_ES1_1;
 	}
-- 
2.0.0.526.g5318336
