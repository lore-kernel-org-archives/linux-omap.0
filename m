From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 01/26] ARM: DRA7: PRM: add voltage processor check behind a prm_feature flag
Date: Mon, 1 Sep 2014 21:08:50 +0300
Message-ID: <1409594955-1476-2-git-send-email-t-kristo@ti.com>
References: <1409594955-1476-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37228 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754579AbaIASJu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Sep 2014 14:09:50 -0400
In-Reply-To: <1409594955-1476-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

This is done in attempt to get rid of cpu_is_X calls from the PRM core.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/prm.h     |    1 +
 arch/arm/mach-omap2/prm44xx.c |   10 ++++++----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
index 48480d5..9f4d747 100644
--- a/arch/arm/mach-omap2/prm.h
+++ b/arch/arm/mach-omap2/prm.h
@@ -29,6 +29,7 @@ int of_prcm_init(void);
  * PRM_HAS_VOLTAGE: has voltage domains
  */
 #define PRM_HAS_IO_WAKEUP	(1 << 0)
+#define PRM_HAS_VOLTAGE		(1 << 1)
 
 /*
  * MAX_MODULE_SOFTRESET_WAIT: Maximum microseconds to wait for OMAP
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index 0958d07..76e75aa 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -652,11 +652,10 @@ static int omap4_pwrdm_wait_transition(struct powerdomain *pwrdm)
 
 static int omap4_check_vcvp(void)
 {
-	/* No VC/VP on dra7xx devices */
-	if (soc_is_dra7xx())
-		return 0;
+	if (prm_features & PRM_HAS_VOLTAGE)
+		return 1;
 
-	return 1;
+	return 0;
 }
 
 struct pwrdm_ops omap4_pwrdm_operations = {
@@ -696,6 +695,9 @@ int __init omap44xx_prm_init(void)
 	if (cpu_is_omap44xx() || soc_is_omap54xx() || soc_is_dra7xx())
 		prm_features |= PRM_HAS_IO_WAKEUP;
 
+	if (!soc_is_dra7xx())
+		prm_features |= PRM_HAS_VOLTAGE;
+
 	return prm_register(&omap44xx_prm_ll_data);
 }
 
-- 
1.7.9.5

