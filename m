From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH] arm: omap: code cleanup to id.c
Date: Thu, 12 Nov 2009 11:21:38 +0200
Message-ID: <1258017698-30095-1-git-send-email-felipe.balbi@nokia.com>
References: <20091111024943.GC1386@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:54312 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322AbZKLJX0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Nov 2009 04:23:26 -0500
In-Reply-To: <20091111024943.GC1386@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com
Cc: Felipe Balbi <felipe.balbi@nokia.com>

Cleanup the coding style in id.c while avoiding unneeded switch()
statements.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
refreshed on top of Today's linux-omap (0aaf4859f62d2ead2dd949646d12b0216439facd)

this patch was compile-tested only with all omap defconfigs, it would be
nice to see it boot-tested on several boards before we apply it.

 arch/arm/mach-omap2/id.c |   61 ++++++++++++++++------------------------------
 1 files changed, 21 insertions(+), 40 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 441ca26..cb75b32 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -53,11 +53,11 @@ int omap_type(void)
 {
 	u32 val = 0;
 
-	if (cpu_is_omap24xx())
+	if (cpu_is_omap24xx()) {
 		val = omap_ctrl_readl(OMAP24XX_CONTROL_STATUS);
-	else if (cpu_is_omap34xx())
+	} else if (cpu_is_omap34xx()) {
 		val = omap_ctrl_readl(OMAP343X_CONTROL_STATUS);
-	else {
+	} else {
 		pr_err("Cannot detect omap type!\n");
 		goto out;
 	}
@@ -224,24 +224,12 @@ void __init omap3_check_revision(void)
 			omap_revision = OMAP3430_REV_ES3_0;
 			break;
 		case 4:
-			omap_revision = OMAP3430_REV_ES3_1;
-			break;
+		/* FALLTHROUGH */
 		default:
 			/* Use the latest known revision as default */
 			omap_revision = OMAP3430_REV_ES3_1;
 		}
 		break;
-	case 0xb891:
-		/* Handle 36xx devices */
-		switch (rev) {
-		case 0:
-			omap_revision = OMAP3630_REV_ES1_0;
-			break;
-		default:
-			/* Use the latest known revision as default */
-			omap_revision = OMAP3630_REV_ES1_0;
-		}
-		break;
 	case 0xb868:
 		/* Handle OMAP35xx/AM35xx devices
 		 *
@@ -250,6 +238,8 @@ void __init omap3_check_revision(void)
 		 */
 		omap_revision = OMAP3505_REV(rev);
 		break;
+	case 0xb891:
+	/* FALLTHROUGH */
 	default:
 		/* Unknown default to latest silicon rev as default*/
 		omap_revision = OMAP3630_REV_ES1_0;
@@ -274,35 +264,29 @@ void __init omap3_cpuinfo(void)
 	 * on available features. Upon detection, update the CPU id
 	 * and CPU class bits.
 	 */
-	if (cpu_is_omap3630())
+	if (cpu_is_omap3630()) {
 		strcpy(cpu_name, "OMAP3630");
-	else if (cpu_is_omap3505()) {
+	} else if (cpu_is_omap3505()) {
 		/*
 		 * AM35xx devices
 		 */
 		if (omap3_has_sgx()) {
 			omap_revision = OMAP3517_REV(rev);
 			strcpy(cpu_name, "AM3517");
-		}
-		else {
+		} else {
 			/* Already set in omap3_check_revision() */
 			strcpy(cpu_name, "AM3505");
 		}
-	}
-	/*
-	 * OMAP3430, OMAP3525, OMAP3515, OMAP3503 devices
-	 */
-	else if (omap3_has_iva() && omap3_has_sgx())
+	} else if (omap3_has_iva() && omap3_has_sgx()) {
+		/* OMAP3430, OMAP3525, OMAP3515, OMAP3503 devices */
 		strcpy(cpu_name, "OMAP3430/3530");
-	else if (omap3_has_sgx()) {
+	} else if (omap3_has_sgx()) {
 		omap_revision = OMAP3525_REV(rev);
 		strcpy(cpu_name, "OMAP3525");
-	}
-	else if (omap3_has_iva()) {
+	} else if (omap3_has_iva()) {
 		omap_revision = OMAP3515_REV(rev);
 		strcpy(cpu_name, "OMAP3515");
-	}
-	else {
+	} else {
 		omap_revision = OMAP3503_REV(rev);
 		strcpy(cpu_name, "OMAP3503");
 	}
@@ -321,16 +305,13 @@ void __init omap3_cpuinfo(void)
 		strcpy(cpu_rev, "3.0");
 		break;
 	case OMAP_REVBITS_40:
-		strcpy(cpu_rev, "3.1");
-		break;
+	/* FALLTHROUGH */
 	default:
 		/* Use the latest known revision as default */
 		strcpy(cpu_rev, "3.1");
 	}
 
-	/*
-	 * Print verbose information
-	 */
+	/* Print verbose information */
 	pr_info("%s ES%s\n", cpu_name, cpu_rev);
 
 	OMAP3_SHOW_FEATURE(l2cache);
@@ -349,18 +330,18 @@ void __init omap2_check_revision(void)
 	 * At this point we have an idea about the processor revision set
 	 * earlier with omap2_set_globals_tap().
 	 */
-	if (cpu_is_omap24xx())
+	if (cpu_is_omap24xx()) {
 		omap24xx_check_revision();
-	else if (cpu_is_omap34xx()) {
+	} else if (cpu_is_omap34xx()) {
 		omap3_check_features();
 		omap3_check_revision();
 		omap3_cpuinfo();
-	}
-	else if (cpu_is_omap44xx()) {
+	} else if (cpu_is_omap44xx()) {
 		printk(KERN_INFO "FIXME: CPU revision = OMAP4430\n");
 		return;
-	} else
+	} else {
 		pr_err("OMAP revision unknown, please fix!\n");
+	}
 
 	/*
 	 * OK, now we know the exact revision. Initialize omap_chip bits
-- 
1.6.4.2.253.g0b1fac

