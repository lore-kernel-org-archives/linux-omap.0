From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v3 2/6] OMAP3: id: remove useless strcpy()s
Date: Wed, 14 Sep 2011 15:58:12 -0600
Message-ID: <20110914215808.4790.81475.stgit@dusk>
References: <20110914215512.4790.34446.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36460 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755358Ab1INV72 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Sep 2011 17:59:28 -0400
In-Reply-To: <20110914215512.4790.34446.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Abhilash Koyamangalath <abhilash.kv@ti.com>, Sanjeev Premi <premi@ti.com>, Igor Grinberg <grinberg@compulab.co.il>

omap3_cpuinfo() is filled with useless strcpy() calls; remove them.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Sanjeev Premi <premi@ti.com>
Tested-by: Igor Grinberg <grinberg@compulab.co.il>
Tested-by: Abhilash Koyamangalath <abhilash.kv@ti.com>
---
 arch/arm/mach-omap2/id.c |   48 +++++++++++++++++++++-------------------------
 1 files changed, 22 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 3f3f998..9fae4de 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -429,84 +429,80 @@ static void __init omap4_check_revision(void)
 static void __init omap3_cpuinfo(void)
 {
 	u8 rev = GET_OMAP_REVISION();
-	char cpu_name[16], cpu_rev[16];
+	const char *cpu_name, *cpu_rev;
 
-	/* OMAP3430 and OMAP3530 are assumed to be same.
+	/*
+	 * OMAP3430 and OMAP3530 are assumed to be same.
 	 *
 	 * OMAP3525, OMAP3515 and OMAP3503 can be detected only based
 	 * on available features. Upon detection, update the CPU id
 	 * and CPU class bits.
 	 */
 	if (cpu_is_omap3630()) {
-		strcpy(cpu_name, "OMAP3630");
+		cpu_name = "OMAP3630";
 	} else if (cpu_is_omap3517()) {
-		/*
-		 * AM35xx devices
-		 */
-		if (omap3_has_sgx())
-			strcpy(cpu_name, "AM3517");
-		else
-			strcpy(cpu_name, "AM3505");
+		/* AM35xx devices */
+		cpu_name = (omap3_has_sgx()) ? "AM3517" : "AM3505";
 	} else if (cpu_is_ti816x()) {
-		strcpy(cpu_name, "TI816X");
+		cpu_name = "TI816X";
 	} else if (omap3_has_iva() && omap3_has_sgx()) {
 		/* OMAP3430, OMAP3525, OMAP3515, OMAP3503 devices */
-		strcpy(cpu_name, "OMAP3430/3530");
+		cpu_name = "OMAP3430/3530";
 	} else if (omap3_has_iva()) {
-		strcpy(cpu_name, "OMAP3525");
+		cpu_name = "OMAP3525";
 	} else if (omap3_has_sgx()) {
-		strcpy(cpu_name, "OMAP3515");
+		cpu_name = "OMAP3515";
 	} else {
-		strcpy(cpu_name, "OMAP3503");
+		cpu_name = "OMAP3503";
 	}
 
 	if (cpu_is_omap3630() || cpu_is_ti816x()) {
 		switch (rev) {
 		case OMAP_REVBITS_00:
-			strcpy(cpu_rev, "1.0");
+			cpu_rev = "1.0";
 			break;
 		case OMAP_REVBITS_01:
-			strcpy(cpu_rev, "1.1");
+			cpu_rev = "1.1";
 			break;
 		case OMAP_REVBITS_02:
 			/* FALLTHROUGH */
 		default:
 			/* Use the latest known revision as default */
-			strcpy(cpu_rev, "1.2");
+			cpu_rev = "1.2";
 		}
 	} else if (cpu_is_omap3505() || cpu_is_omap3517()) {
 		switch (rev) {
 		case OMAP_REVBITS_00:
-			strcpy(cpu_rev, "1.0");
+			cpu_rev = "1.0";
 			break;
 		case OMAP_REVBITS_01:
 			/* FALLTHROUGH */
 		default:
 			/* Use the latest known revision as default */
-			strcpy(cpu_rev, "1.1");
+			cpu_rev = "1.1";
 		}
 	} else {
 		switch (rev) {
 		case OMAP_REVBITS_00:
-			strcpy(cpu_rev, "1.0");
+			cpu_rev = "1.0";
 			break;
 		case OMAP_REVBITS_01:
-			strcpy(cpu_rev, "2.0");
+			cpu_rev = "2.0";
 			break;
 		case OMAP_REVBITS_02:
-			strcpy(cpu_rev, "2.1");
+			cpu_rev = "2.1";
 			break;
 		case OMAP_REVBITS_03:
-			strcpy(cpu_rev, "3.0");
+			cpu_rev = "3.0";
 			break;
 		case OMAP_REVBITS_04:
-			strcpy(cpu_rev, "3.1");
+			cpu_rev = "3.1";
 			break;
 		case OMAP_REVBITS_05:
 			/* FALLTHROUGH */
 		default:
 			/* Use the latest known revision as default */
-			strcpy(cpu_rev, "3.1.2");
+			cpu_rev = "3.1.2";
 		}
 	}
 


