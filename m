From: Hari Kanigeri <h-kanigeri2@ti.com>
Subject: [PATCH] omap:hwmod-remove prm header from prm-regbits-xxxx headers
Date: Wed, 19 May 2010 17:10:29 -0500
Message-ID: <1274307029-22032-1-git-send-email-h-kanigeri2@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57070 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751359Ab0ESWEQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 May 2010 18:04:16 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Linux Omap <linux-omap@vger.kernel.org>
Cc: Hari Kanigeri <h-kanigeri2@ti.com>

The prm-regbits-xxxx.h header files are not dependent on prm.h
header file.

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    1 +
 arch/arm/mach-omap2/prm-regbits-24xx.h     |    1 -
 arch/arm/mach-omap2/prm-regbits-34xx.h     |    1 -
 arch/arm/mach-omap2/prm-regbits-44xx.h     |    1 -
 4 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 667633c..88cc9ca 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -26,6 +26,7 @@
 #include "omap_hwmod_common_data.h"
 
 #include "cm.h"
+#include "prm.h"
 #include "prm-regbits-44xx.h"
 
 /* Base offset for all OMAP4 interrupts external to MPUSS */
diff --git a/arch/arm/mach-omap2/prm-regbits-24xx.h b/arch/arm/mach-omap2/prm-regbits-24xx.h
index 4002051..fd763b5 100644
--- a/arch/arm/mach-omap2/prm-regbits-24xx.h
+++ b/arch/arm/mach-omap2/prm-regbits-24xx.h
@@ -14,7 +14,6 @@
  * published by the Free Software Foundation.
  */
 
-#include "prm.h"
 
 /* Bits shared between registers */
 
diff --git a/arch/arm/mach-omap2/prm-regbits-34xx.h b/arch/arm/mach-omap2/prm-regbits-34xx.h
index 8f21bae..ef7fd5e 100644
--- a/arch/arm/mach-omap2/prm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/prm-regbits-34xx.h
@@ -14,7 +14,6 @@
  * published by the Free Software Foundation.
  */
 
-#include "prm.h"
 
 /* Shared register bits */
 
diff --git a/arch/arm/mach-omap2/prm-regbits-44xx.h b/arch/arm/mach-omap2/prm-regbits-44xx.h
index 597be4a..ef7af7e 100644
--- a/arch/arm/mach-omap2/prm-regbits-44xx.h
+++ b/arch/arm/mach-omap2/prm-regbits-44xx.h
@@ -22,7 +22,6 @@
 #ifndef __ARCH_ARM_MACH_OMAP2_PRM_REGBITS_44XX_H
 #define __ARCH_ARM_MACH_OMAP2_PRM_REGBITS_44XX_H
 
-#include "prm.h"
 
 
 /*
-- 
1.7.0

