From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 17/26] ARM: OMAP4: CM: move public definitions from cminst44xx.h to cm44xx.h
Date: Mon, 1 Sep 2014 21:09:06 +0300
Message-ID: <1409594955-1476-18-git-send-email-t-kristo@ti.com>
References: <1409594955-1476-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44843 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754691AbaIASKO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Sep 2014 14:10:14 -0400
In-Reply-To: <1409594955-1476-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

cminst44xx.h will be removed, thus move the public APIs to cm44xx.h header.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/cm44xx.h     |    3 +++
 arch/arm/mach-omap2/cminst44xx.h |    3 ---
 arch/arm/mach-omap2/io.c         |    2 +-
 arch/arm/mach-omap2/omap_hwmod.c |    1 -
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/cm44xx.h b/arch/arm/mach-omap2/cm44xx.h
index 3380bee..728d06a 100644
--- a/arch/arm/mach-omap2/cm44xx.h
+++ b/arch/arm/mach-omap2/cm44xx.h
@@ -23,4 +23,7 @@
 #define OMAP4_CM_CLKSTCTRL				0x0000
 #define OMAP4_CM_STATICDEP				0x0004
 
+void omap_cm_base_init(void);
+int omap4_cm_init(void);
+
 #endif
diff --git a/arch/arm/mach-omap2/cminst44xx.h b/arch/arm/mach-omap2/cminst44xx.h
index ffbd721..3ef3bf6 100644
--- a/arch/arm/mach-omap2/cminst44xx.h
+++ b/arch/arm/mach-omap2/cminst44xx.h
@@ -26,7 +26,4 @@ u32 omap4_cminst_clear_inst_reg_bits(u32 bits, u8 part, u16 inst,
 extern u32 omap4_cminst_read_inst_reg_bits(u8 part, u16 inst, s16 idx,
 					   u32 mask);
 
-extern void omap_cm_base_init(void);
-int omap4_cm_init(void);
-
 #endif
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index f1db801..cdbf337 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -46,11 +46,11 @@
 #include "cm2xxx.h"
 #include "cm3xxx.h"
 #include "cm33xx.h"
+#include "cm44xx.h"
 #include "prm.h"
 #include "cm.h"
 #include "prcm_mpu44xx.h"
 #include "prminst44xx.h"
-#include "cminst44xx.h"
 #include "prm2xxx.h"
 #include "prm3xxx.h"
 #include "prm33xx.h"
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 24d9599..1de87a7 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -153,7 +153,6 @@
 #include "powerdomain.h"
 #include "cm2xxx.h"
 #include "cm3xxx.h"
-#include "cminst44xx.h"
 #include "cm33xx.h"
 #include "prm.h"
 #include "prm3xxx.h"
-- 
1.7.9.5

