From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 13/14] omap3: keep SoC features on the same line
Date: Thu, 12 Nov 2009 16:09:44 -0800
Message-ID: <20091113000944.9034.46974.stgit@localhost>
References: <20091113000444.9034.41293.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53214 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754595AbZKMAJk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Nov 2009 19:09:40 -0500
In-Reply-To: <20091113000444.9034.41293.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org

From: Kevin Hilman <khilman@deeprootsystems.com>

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
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/id.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 6c11b41..4984660 100644
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

