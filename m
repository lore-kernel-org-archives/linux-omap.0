From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH v2] AM35xx: Update the macro names
Date: Wed,  9 Dec 2009 19:18:15 +0530
Message-ID: <1260366495-9874-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54904 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755826AbZLINsN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Dec 2009 08:48:13 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id nB9DmHTt007179
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 9 Dec 2009 07:48:19 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

Devices AM3505 and AM3517 will be more commonly available.
Also, with more devices planned in this family, it is better
to rename the macros to follow cpu_is_amXXX() naming.

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/id.c              |    6 +++---
 arch/arm/plat-omap/include/plat/cpu.h |    4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 4fad192..d1bd8ba 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -233,7 +233,7 @@ void __init omap3_check_revision(void)
 	case 0xb868:
 		/* Handle OMAP35xx/AM35xx devices
 		 *
-		 * Set the device to be OMAP3505 here. Actual device
+		 * Set the device to be AM3505/OMAP3505 here. Actual device
 		 * is identified later based on the features.
 		 */
 		omap_revision = OMAP3505_REV(rev);
@@ -263,7 +263,7 @@ void __init omap3_cpuinfo(void)
 	 */
 	if (cpu_is_omap3630()) {
 		strcpy(cpu_name, "OMAP3630");
-	} else if (cpu_is_omap3505()) {
+	} else if (cpu_is_am3505()) {
 		/*
 		 * AM35xx devices
 		 */
@@ -352,7 +352,7 @@ void __init omap2_check_revision(void)
 	} else if (cpu_is_omap242x()) {
 		/* Currently only supports 2420ES2.1.1 and 2420-all */
 		omap_chip.oc |= CHIP_IS_OMAP2420;
-	} else if (cpu_is_omap3505() || cpu_is_omap3517()) {
+	} else if (cpu_is_am3505() || cpu_is_am3517()) {
 		omap_chip.oc = CHIP_IS_OMAP3430 | CHIP_IS_OMAP3430ES3_1;
 	} else if (cpu_is_omap343x()) {
 		omap_chip.oc = CHIP_IS_OMAP3430;
diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index 2e17890..8dd8801 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -399,8 +399,8 @@ IS_OMAP_TYPE(3517, 0x3517)
 						(omap3_has_sgx()) &&	\
 						(!omap3_has_iva()))
 # define cpu_is_omap3530()		(cpu_is_omap3430())
-# define cpu_is_omap3505()		is_omap3505()
-# define cpu_is_omap3517()		is_omap3517()
+# define cpu_is_am3505()		is_omap3505()
+# define cpu_is_am3517()		is_omap3517()
 # undef cpu_is_omap3630
 # define cpu_is_omap3630()		is_omap363x()
 #endif
-- 
1.6.2.2

