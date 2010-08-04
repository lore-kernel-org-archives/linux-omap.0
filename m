From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] OMAP3630: Add ES1.1 and ES1.2 detection
Date: Wed, 4 Aug 2010 13:30:30 +0300
Message-ID: <20100804103029.GI9881@atomide.com>
References: <20100803073940.GS12293@atomide.com>
 <1280865564-6456-1-git-send-email-gadiyar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="IS0zKkzwUGydFO0o"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:63627 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932117Ab0HDKaE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Aug 2010 06:30:04 -0400
Content-Disposition: inline
In-Reply-To: <1280865564-6456-1-git-send-email-gadiyar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anand Gadiyar <gadiyar@ti.com>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, Manjunatha GK <manjugk@ti.com>


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Anand Gadiyar <gadiyar@ti.com> [100803 22:52]:
> Add revision detection for ES1.1 and ES1.2. Set default
> revision as ES1.2.
> 
> Add CHIP_GE_OMAP3630ES1_1 to detect revisions 1.1 and later.
> This is needed for at least one feature that is broken in
> 3630ES1.0 but exists on older (3430 ES3.1) and newer revisions.
> 
> Additionally, update some of the CHIP_GE_* macros to use other
> macros for ease of maintenance.

Thanks, I've updated it a bit more for the fallthrough handling,
here's the updated version.

Regards,

Tony

--IS0zKkzwUGydFO0o
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="omap-3630-es12.patch"

>From 1b7fe944881114a78d04c98188b56852140480d4 Mon Sep 17 00:00:00 2001
From: Anand Gadiyar <gadiyar@ti.com>
Date: Tue, 3 Aug 2010 19:59:24 +0000
Subject: [PATCH] OMAP3630: Add ES1.1 and ES1.2 detection

Add revision detection for ES1.1 and ES1.2. Set default
revision as ES1.2.

Add CHIP_GE_OMAP3630ES1_1 to detect revisions 1.1 and later.
This is needed for at least one feature that is broken in
3630ES1.0 but exists on older (3430 ES3.1) and newer revisions.

Additionally, update some of the CHIP_GE_* macros to use other
macros for ease of maintenance.

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Manjunatha GK <manjugk@ti.com>
[tony@atomide.com: update fallthrough handling]
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index fd1904b..0a0ff0c 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -269,11 +269,29 @@ static void __init omap3_check_revision(void)
 		omap_chip.oc |= CHIP_IS_OMAP3430ES3_1;
 		break;
 	case 0xb891:
+		/* Handle 36xx devices */
+		omap_chip.oc |= CHIP_IS_OMAP3630ES1;
+
+		switch(rev) {
+		case 0: /* Take care of early samples */
+			omap_revision = OMAP3630_REV_ES1_0;
+			break;
+		case 1:
+			omap_revision = OMAP3630_REV_ES1_1;
+			omap_chip.oc |= CHIP_IS_OMAP3630ES1_1;
+			break;
+		case 2:
+			omap_revision =  OMAP3630_REV_ES1_2;
+			omap_chip.oc |= CHIP_IS_OMAP3630ES1_2;
+			break;
+		default:
+			/* FALLTHROUGH */
+		}
 	/* FALLTHROUGH */
 	default:
 		/* Unknown default to latest silicon rev as default*/
-		omap_revision = OMAP3630_REV_ES1_0;
-		omap_chip.oc |= CHIP_IS_OMAP3630ES1;
+		omap_revision =  OMAP3630_REV_ES1_2;
+		omap_chip.oc |= CHIP_IS_OMAP3630ES1_2;
 	}
 }
 
@@ -349,6 +367,12 @@ static void __init omap3_cpuinfo(void)
 	case OMAP_REVBITS_00:
 		strcpy(cpu_rev, "1.0");
 		break;
+	case OMAP_REVBITS_01:
+		strcpy(cpu_rev, "1.1");
+		break;
+	case OMAP_REVBITS_02:
+		strcpy(cpu_rev, "1.2");
+		break;
 	case OMAP_REVBITS_10:
 		strcpy(cpu_rev, "2.0");
 		break;
diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index aa2f4f0..2e2ae53 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -66,6 +66,8 @@ unsigned int omap_rev(void);
  * family. This difference can be handled separately.
  */
 #define OMAP_REVBITS_00		0x00
+#define OMAP_REVBITS_01		0x01
+#define OMAP_REVBITS_02		0x02
 #define OMAP_REVBITS_10		0x10
 #define OMAP_REVBITS_20		0x20
 #define OMAP_REVBITS_30		0x30
@@ -376,6 +378,8 @@ IS_OMAP_TYPE(3517, 0x3517)
 #define OMAP3430_REV_ES3_1_2	0x34305034
 
 #define OMAP3630_REV_ES1_0	0x36300034
+#define OMAP3630_REV_ES1_1	0x36300134
+#define OMAP3630_REV_ES1_2	0x36300234
 
 #define OMAP35XX_CLASS		0x35000034
 #define OMAP3503_REV(v)		(OMAP35XX_CLASS | (0x3503 << 16) | (v << 8))
@@ -411,6 +415,8 @@ IS_OMAP_TYPE(3517, 0x3517)
 #define CHIP_IS_OMAP3430ES3_1		(1 << 6)
 #define CHIP_IS_OMAP3630ES1		(1 << 7)
 #define CHIP_IS_OMAP4430ES1		(1 << 8)
+#define CHIP_IS_OMAP3630ES1_1           (1 << 9)
+#define CHIP_IS_OMAP3630ES1_2           (1 << 10)
 
 #define CHIP_IS_OMAP24XX		(CHIP_IS_OMAP2420 | CHIP_IS_OMAP2430)
 
@@ -424,11 +430,12 @@ IS_OMAP_TYPE(3517, 0x3517)
  */
 #define CHIP_GE_OMAP3430ES2		(CHIP_IS_OMAP3430ES2 | \
 					 CHIP_IS_OMAP3430ES3_0 | \
-					 CHIP_IS_OMAP3430ES3_1 | \
-					 CHIP_IS_OMAP3630ES1)
+					 CHIP_GE_OMAP3430ES3_1)
 #define CHIP_GE_OMAP3430ES3_1		(CHIP_IS_OMAP3430ES3_1 | \
-					 CHIP_IS_OMAP3630ES1)
-
+					 CHIP_IS_OMAP3630ES1 | \
+					 CHIP_GE_OMAP3630ES1_1)
+#define CHIP_GE_OMAP3630ES1_1		(CHIP_IS_OMAP3630ES1_1 | \
+					 CHIP_IS_OMAP3630ES1_2)
 
 int omap_chip_is(struct omap_chip_id oci);
 void omap2_check_revision(void);

--IS0zKkzwUGydFO0o--
