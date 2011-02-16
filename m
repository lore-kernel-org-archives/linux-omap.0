From: Shweta Gulati <shweta.gulati@ti.com>
Subject: [PATCH 1/3] OMAP4: Revise MPU Voltage rail values.
Date: Wed, 16 Feb 2011 11:47:26 +0530
Message-ID: <1297837046-8831-1-git-send-email-shweta.gulati@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60955 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751270Ab1BPGRb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Feb 2011 01:17:31 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1G6HRhc003816
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 16 Feb 2011 00:17:30 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Shweta Gulati <shweta.gulati@ti.com>

MPU voltage rail values are updated according to
latest OMAP4430 Data Manual Operating Condition Addendum.

Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
---
 arch/arm/plat-omap/include/plat/voltage.h |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/voltage.h b/arch/arm/plat-omap/include/plat/voltage.h
index 5bd204e..4d9bab1 100644
--- a/arch/arm/plat-omap/include/plat/voltage.h
+++ b/arch/arm/plat-omap/include/plat/voltage.h
@@ -46,10 +46,10 @@
 #define OMAP3630_VDD_CORE_OPP50_UV		1000000
 #define OMAP3630_VDD_CORE_OPP100_UV		1200000
 
-#define OMAP4430_VDD_MPU_OPP50_UV		930000
-#define OMAP4430_VDD_MPU_OPP100_UV		1100000
-#define OMAP4430_VDD_MPU_OPPTURBO_UV		1260000
-#define OMAP4430_VDD_MPU_OPPNITRO_UV		1350000
+#define OMAP4430_VDD_MPU_OPP50_UV		1025000
+#define OMAP4430_VDD_MPU_OPP100_UV		1200000
+#define OMAP4430_VDD_MPU_OPPTURBO_UV		1313000
+#define OMAP4430_VDD_MPU_OPPNITRO_UV		1375000
 
 #define OMAP4430_VDD_IVA_OPP50_UV		930000
 #define OMAP4430_VDD_IVA_OPP100_UV		1100000
-- 
1.7.0.4

