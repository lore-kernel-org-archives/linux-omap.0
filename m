From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH] OMAP3: keep SoC features on the same line
Date: Thu, 12 Nov 2009 15:35:48 -0800
Message-ID: <1258068948-32700-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f188.google.com ([209.85.216.188]:49108 "EHLO
	mail-px0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755478AbZKLXfo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Nov 2009 18:35:44 -0500
Received: by pxi26 with SMTP id 26so2017875pxi.21
        for <linux-omap@vger.kernel.org>; Thu, 12 Nov 2009 15:35:50 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

When listing the various SoC features, print them on the same line.
So, instead of this

OMAP3430/3530 ES3.1
 - l2cache : Y
 - iva : Y
 - sgx : Y
 - neon : Y
 - isp : Y

you get this:

OMAP3430/3530 ES3.1 (l2cache iva sgx neon isp )

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
Patch applies to current for-next branch.

 arch/arm/mach-omap2/id.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 441ca26..128e3f6 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -257,11 +257,8 @@ void __init omap3_check_revision(void)
 }
 
 #define OMAP3_SHOW_FEATURE(feat)		\
-	if (omap3_has_ ##feat()) {		\
-		pr_info (" - "#feat" : Y");	\
-	} else {				\
-		pr_info (" - "#feat" : N");	\
-	}
+	if (omap3_has_ ##feat())		\
+		printk(#feat" ");
 
 void __init omap3_cpuinfo(void)
 {
@@ -331,13 +328,15 @@ void __init omap3_cpuinfo(void)
 	/*
 	 * Print verbose information
 	 */
-	pr_info("%s ES%s\n", cpu_name, cpu_rev);
+	pr_info("%s ES%s (", cpu_name, cpu_rev);
 
 	OMAP3_SHOW_FEATURE(l2cache);
 	OMAP3_SHOW_FEATURE(iva);
 	OMAP3_SHOW_FEATURE(sgx);
 	OMAP3_SHOW_FEATURE(neon);
 	OMAP3_SHOW_FEATURE(isp);
+
+	printk(")\n");
 }
 
 /*
-- 
1.6.5.1

