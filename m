From: "Iziumtsev, Leonid" <x0153368@ti.com>
Subject: [PATCH] OMAP4: ID: Chip detection for OMAP4470
Date: Thu, 10 Nov 2011 17:54:55 +0300
Message-ID: <CALROJkn5CyENpvvO3bp4WL7m8nUuMusmYzt0JUcCWkfYJhvoGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:50404 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933896Ab1KJOy5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Nov 2011 09:54:57 -0500
Received: by yenl7 with SMTP id l7so2009517yen.3
        for <linux-omap@vger.kernel.org>; Thu, 10 Nov 2011 06:54:55 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Leonid Iziumtsev <x0153368@ti.com>

Add support for detection of the next chip in the OMAP4 family: OMAP4470 ES1.0

For more details on OMAP4470, visit:
http://focus.ti.com/general/docs/wtbu/wtbuproductcontent.tsp?templateId=6123&navigationId=12869&contentId=123362

Signed-off-by: Leonid Iziumtsev <x0153368@ti.com>
---
 arch/arm/mach-omap2/id.c              |   10 +++++++++-
 arch/arm/plat-omap/include/plat/cpu.h |    8 ++++++++
 2 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 7f47092..c8667c0 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -367,7 +367,7 @@ static void __init omap4_check_revision(void)
 	 * Few initial 4430 ES2.0 samples IDCODE is same as ES1.0
 	 * Use ARM register to detect the correct ES version
 	 */
-	if (!rev && (hawkeye != 0xb94e)) {
+	if (!rev && (hawkeye != 0xb94e) && (hawkeye != 0xb975)) {
 		idcode = read_cpuid(CPUID_ID);
 		rev = (idcode & 0xf) - 1;
 	}
@@ -401,6 +401,14 @@ static void __init omap4_check_revision(void)
 			break;
 		}
 		break;
+	case 0xb975:
+		switch (rev) {
+		case 0:
+		default:
+			omap_revision = OMAP4470_REV_ES1_0;
+			break;
+		}
+		break;
 	default:
 		/* Unknown default to latest silicon rev as default */
 		omap_revision = OMAP4430_REV_ES2_2;
diff --git a/arch/arm/plat-omap/include/plat/cpu.h
b/arch/arm/plat-omap/include/plat/cpu.h
index aa52d1e..d99b3be 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -69,6 +69,7 @@ unsigned int omap_rev(void);
  * cpu_is_omap343x():	True for OMAP3430
  * cpu_is_omap443x():	True for OMAP4430
  * cpu_is_omap446x():	True for OMAP4460
+ * cpu_is_omap447x():	True for OMAP4470
  */
 #define GET_OMAP_CLASS	(omap_rev() & 0xff)

@@ -120,6 +121,7 @@ IS_OMAP_SUBCLASS(343x, 0x343)
 IS_OMAP_SUBCLASS(363x, 0x363)
 IS_OMAP_SUBCLASS(443x, 0x443)
 IS_OMAP_SUBCLASS(446x, 0x446)
+IS_OMAP_SUBCLASS(447x, 0x447)

 IS_TI_SUBCLASS(816x, 0x816)
 IS_AM_SUBCLASS(335x, 0x335)
@@ -138,6 +140,7 @@ IS_AM_SUBCLASS(335x, 0x335)
 #define cpu_is_omap44xx()		0
 #define cpu_is_omap443x()		0
 #define cpu_is_omap446x()		0
+#define cpu_is_omap447x()		0

 #if defined(MULTI_OMAP1)
 # if defined(CONFIG_ARCH_OMAP730)
@@ -368,9 +371,11 @@ IS_OMAP_TYPE(3517, 0x3517)
 # undef cpu_is_omap44xx
 # undef cpu_is_omap443x
 # undef cpu_is_omap446x
+# undef cpu_is_omap447x
 # define cpu_is_omap44xx()		is_omap44xx()
 # define cpu_is_omap443x()		is_omap443x()
 # define cpu_is_omap446x()		is_omap446x()
+# define cpu_is_omap447x()		is_omap447x()
 # endif

 /* Macros to detect if we have OMAP1 or OMAP2 */
@@ -420,6 +425,9 @@ IS_OMAP_TYPE(3517, 0x3517)
 #define OMAP446X_CLASS		0x44600044
 #define OMAP4460_REV_ES1_0	(OMAP446X_CLASS | (0x10 << 8))

+#define OMAP447X_CLASS		0x44700044
+#define OMAP4470_REV_ES1_0	(OMAP447X_CLASS | (0x10 << 8))
+
 void omap2_check_revision(void);

 /*
-- 
1.7.1
