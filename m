From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH] omap3: Fix macros for 3515 and 3525 inversion
Date: Wed,  9 Dec 2009 16:33:06 +0530
Message-ID: <1260356586-25281-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45902 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755089AbZLILDE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Dec 2009 06:03:04 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sergey Lapin <slapinid@gmail.com>, Sanjeev Premi <premi@ti.com>

From: Sergey Lapin <slapinid@gmail.com>

The macros for detecting the cpu had same
inversion problem fixed in earlier patch.

 [1] omap3: id code detection 3525 vs 3515

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/plat-omap/include/plat/cpu.h |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index 8dd8801..1a80722 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -393,11 +393,11 @@ IS_OMAP_TYPE(3517, 0x3517)
 						(!omap3_has_iva()) &&	\
 						(!omap3_has_sgx()))
 # define cpu_is_omap3515()		(cpu_is_omap3430() &&		\
-						(omap3_has_iva()) &&	\
-						(!omap3_has_sgx()))
+						(!omap3_has_iva()) &&	\
+						(omap3_has_sgx()))
 # define cpu_is_omap3525()		(cpu_is_omap3430() &&		\
-						(omap3_has_sgx()) &&	\
-						(!omap3_has_iva()))
+						(!omap3_has_sgx()) &&	\
+						(omap3_has_iva()))
 # define cpu_is_omap3530()		(cpu_is_omap3430())
 # define cpu_is_am3505()		is_omap3505()
 # define cpu_is_am3517()		is_omap3517()
-- 
1.6.2.2

