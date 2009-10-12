From: Vikram Pandita <vikram.pandita@ti.com>
Subject: [PATCH] [RFC] omap: 3630: default cpu_is_omap3630 to zero
Date: Mon, 12 Oct 2009 15:51:25 -0500
Message-ID: <1255380685-26765-1-git-send-email-vikram.pandita@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33617 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750745AbZJLUyu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Oct 2009 16:54:50 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n9CKsEvo007102
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 12 Oct 2009 15:54:14 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: nm@ti.com
Cc: linux-omap@vger.kernel.org, Vikram Pandita <vikram.pandita@ti.com>

make default cpu_is_omap3630() return zero

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
---
 arch/arm/plat-omap/include/mach/cpu.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/cpu.h b/arch/arm/plat-omap/include/mach/cpu.h
index da9e8f8..940946e 100644
--- a/arch/arm/plat-omap/include/mach/cpu.h
+++ b/arch/arm/plat-omap/include/mach/cpu.h
@@ -322,6 +322,7 @@ IS_OMAP_TYPE(3430, 0x3430)
 #define cpu_is_omap2423()		0
 #define cpu_is_omap2430()		0
 #define cpu_is_omap3430()		0
+#define cpu_is_omap3630()		0
 
 /*
  * Whether we have MULTI_OMAP1 or not, we still need to distinguish
@@ -386,6 +387,7 @@ IS_OMAP_TYPE(3430, 0x3430)
 						(omap3_has_sgx()) &	\
 						(!omap3_has_iva()))
 # define cpu_is_omap3530		(cpu_is_omap3430())
+# undef cpu_is_omap3630()
 # define cpu_is_omap3630()		is_omap363x()
 #endif
 
-- 
1.6.5.rc1.19.g8426

