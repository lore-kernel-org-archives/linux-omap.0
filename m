From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH] omap3: Fix macro definitions
Date: Wed, 28 Oct 2009 18:39:42 +0530
Message-ID: <1256735382-18709-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53845 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753447AbZJ1NJl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Oct 2009 09:09:41 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n9SD9hbs030085
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2009 08:09:46 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

This fix avoids the compile errors in
specific cases. Found the problem while
creating the v2 patch for AM35xx.

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/plat-omap/include/plat/cpu.h |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index 7cb0556..f4f7a2f 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -381,16 +381,16 @@ IS_OMAP_TYPE(3430, 0x3430)
 # undef cpu_is_omap3525
 # undef cpu_is_omap3530
 # define cpu_is_omap3430()		is_omap3430()
-# define cpu_is_omap3503		(cpu_is_omap3430() &&		\
+# define cpu_is_omap3503()		(cpu_is_omap3430() &&		\
 						(!omap3_has_iva()) &&	\
 						(!omap3_has_sgx()))
-# define cpu_is_omap3515		(cpu_is_omap3430() &&		\
+# define cpu_is_omap3515()		(cpu_is_omap3430() &&		\
 						(omap3_has_iva()) &&	\
 						(!omap3_has_sgx()))
-# define cpu_is_omap3525		(cpu_is_omap3430() &&		\
+# define cpu_is_omap3525()		(cpu_is_omap3430() &&		\
 						(omap3_has_sgx()) &&	\
 						(!omap3_has_iva()))
-# define cpu_is_omap3530		(cpu_is_omap3430())
+# define cpu_is_omap3530()		(cpu_is_omap3430())
 # undef cpu_is_omap3630
 # define cpu_is_omap3630()		is_omap363x()
 #endif
-- 
1.6.2.2

