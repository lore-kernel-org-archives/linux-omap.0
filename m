From: jean.pihet@newoldbits.com
Subject: [PATCH 03/13] OMAP2+: PM: clean up usage of SRAM functions
Date: Wed, 18 May 2011 19:32:20 +0200
Message-ID: <1305739950-11695-4-git-send-email-j-pihet@ti.com>
References: <1305739950-11695-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:63275 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932910Ab1ERRcr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 May 2011 13:32:47 -0400
Received: by ywe9 with SMTP id 9so445875ywe.19
        for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 10:32:46 -0700 (PDT)
In-Reply-To: <1305739950-11695-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Jean Pihet <j-pihet@ti.com>

Clean-up SRAM functions usage to better isolate PM code, in order
to allow it to be used as a module.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c |    1 +
 arch/arm/plat-omap/sram.c    |    2 --
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 0c5e3a4..74169a2 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -456,6 +456,7 @@ void omap_sram_idle(void)
 			omap3_core_restore_context();
 			omap3_cm_restore_context();
 			omap3_sram_restore_context();
+			omap_push_sram_idle();
 			omap2_sms_restore_context();
 		}
 		omap_uart_resume_idle(0);
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index a3f50b3..f1a54bb 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -390,7 +390,6 @@ void omap3_sram_restore_context(void)
 	_omap3_sram_configure_core_dpll =
 		omap_sram_push(omap3_sram_configure_core_dpll,
 			       omap3_sram_configure_core_dpll_sz);
-	omap_push_sram_idle();
 }
 #endif /* CONFIG_PM */
 
@@ -399,7 +398,6 @@ static int __init omap34xx_sram_init(void)
 	_omap3_sram_configure_core_dpll =
 		omap_sram_push(omap3_sram_configure_core_dpll,
 			       omap3_sram_configure_core_dpll_sz);
-	omap_push_sram_idle();
 	return 0;
 }
 #else
-- 
1.7.4.1

