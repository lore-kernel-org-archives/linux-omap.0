From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 3/3] OMAP4: powerdomain data: Fix core mem states and missing cefuse flag
Date: Thu, 23 Jun 2011 18:45:44 +0200
Message-ID: <1308847544-2322-4-git-send-email-b-cousson@ti.com>
References: <1308847544-2322-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55149 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759384Ab1FWQqV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Jun 2011 12:46:21 -0400
In-Reply-To: <1308847544-2322-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, rnayak@ti.com
Cc: linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Since ES2.0, the core ocmram does not support a different state
than the main power domain anymore during both ON and RET power
domain state.
Since PM is not supported at all in ES1.0, update the common
structure.

LOWPOWERSTATECHANGE is supported by the cefuse power domain but
the flag was missing.
Add the PWRDM_HAS_LOWPOWERSTATECHANGE in flags field.

Indent all previous flags to be aligned with other fields.

Update the TI copyright date to 2011.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/powerdomains44xx_data.c |   25 +++++++++++++------------
 1 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomains44xx_data.c b/arch/arm/mach-omap2/powerdomains44xx_data.c
index c4222c7..8f46e7d 100644
--- a/arch/arm/mach-omap2/powerdomains44xx_data.c
+++ b/arch/arm/mach-omap2/powerdomains44xx_data.c
@@ -1,7 +1,7 @@
 /*
  * OMAP4 Power domains framework
  *
- * Copyright (C) 2009-2010 Texas Instruments, Inc.
+ * Copyright (C) 2009-2011 Texas Instruments, Inc.
  * Copyright (C) 2009-2011 Nokia Corporation
  *
  * Abhijit Pagare (abhijitpagare@ti.com)
@@ -41,19 +41,19 @@ static struct powerdomain core_44xx_pwrdm = {
 	.banks		  = 5,
 	.pwrsts_mem_ret	= {
 		[0] = PWRSTS_OFF,	/* core_nret_bank */
-		[1] = PWRSTS_OFF_RET,	/* core_ocmram */
+		[1] = PWRSTS_RET,	/* core_ocmram */
 		[2] = PWRSTS_RET,	/* core_other_bank */
 		[3] = PWRSTS_OFF_RET,	/* ducati_l2ram */
 		[4] = PWRSTS_OFF_RET,	/* ducati_unicache */
 	},
 	.pwrsts_mem_on	= {
 		[0] = PWRSTS_ON,	/* core_nret_bank */
-		[1] = PWRSTS_OFF_RET,	/* core_ocmram */
+		[1] = PWRSTS_ON,	/* core_ocmram */
 		[2] = PWRSTS_ON,	/* core_other_bank */
 		[3] = PWRSTS_ON,	/* ducati_l2ram */
 		[4] = PWRSTS_ON,	/* ducati_unicache */
 	},
-	.flags		= PWRDM_HAS_LOWPOWERSTATECHANGE,
+	.flags		  = PWRDM_HAS_LOWPOWERSTATECHANGE,
 };
 
 /* gfx_44xx_pwrdm: 3D accelerator power domain */
@@ -70,7 +70,7 @@ static struct powerdomain gfx_44xx_pwrdm = {
 	.pwrsts_mem_on	= {
 		[0] = PWRSTS_ON,	/* gfx_mem */
 	},
-	.flags		= PWRDM_HAS_LOWPOWERSTATECHANGE,
+	.flags		  = PWRDM_HAS_LOWPOWERSTATECHANGE,
 };
 
 /* abe_44xx_pwrdm: Audio back end power domain */
@@ -90,7 +90,7 @@ static struct powerdomain abe_44xx_pwrdm = {
 		[0] = PWRSTS_ON,	/* aessmem */
 		[1] = PWRSTS_ON,	/* periphmem */
 	},
-	.flags		= PWRDM_HAS_LOWPOWERSTATECHANGE,
+	.flags		  = PWRDM_HAS_LOWPOWERSTATECHANGE,
 };
 
 /* dss_44xx_pwrdm: Display subsystem power domain */
@@ -108,7 +108,7 @@ static struct powerdomain dss_44xx_pwrdm = {
 	.pwrsts_mem_on	= {
 		[0] = PWRSTS_ON,	/* dss_mem */
 	},
-	.flags		= PWRDM_HAS_LOWPOWERSTATECHANGE,
+	.flags		  = PWRDM_HAS_LOWPOWERSTATECHANGE,
 };
 
 /* tesla_44xx_pwrdm: Tesla processor power domain */
@@ -130,7 +130,7 @@ static struct powerdomain tesla_44xx_pwrdm = {
 		[1] = PWRSTS_ON,	/* tesla_l1 */
 		[2] = PWRSTS_ON,	/* tesla_l2 */
 	},
-	.flags		= PWRDM_HAS_LOWPOWERSTATECHANGE,
+	.flags		  = PWRDM_HAS_LOWPOWERSTATECHANGE,
 };
 
 /* wkup_44xx_pwrdm: Wake-up power domain */
@@ -241,7 +241,7 @@ static struct powerdomain ivahd_44xx_pwrdm = {
 		[2] = PWRSTS_ON,	/* tcm1_mem */
 		[3] = PWRSTS_ON,	/* tcm2_mem */
 	},
-	.flags		= PWRDM_HAS_LOWPOWERSTATECHANGE,
+	.flags		  = PWRDM_HAS_LOWPOWERSTATECHANGE,
 };
 
 /* cam_44xx_pwrdm: Camera subsystem power domain */
@@ -258,7 +258,7 @@ static struct powerdomain cam_44xx_pwrdm = {
 	.pwrsts_mem_on	= {
 		[0] = PWRSTS_ON,	/* cam_mem */
 	},
-	.flags		= PWRDM_HAS_LOWPOWERSTATECHANGE,
+	.flags		  = PWRDM_HAS_LOWPOWERSTATECHANGE,
 };
 
 /* l3init_44xx_pwrdm: L3 initators pheripherals power domain  */
@@ -276,7 +276,7 @@ static struct powerdomain l3init_44xx_pwrdm = {
 	.pwrsts_mem_on	= {
 		[0] = PWRSTS_ON,	/* l3init_bank1 */
 	},
-	.flags		= PWRDM_HAS_LOWPOWERSTATECHANGE,
+	.flags		  = PWRDM_HAS_LOWPOWERSTATECHANGE,
 };
 
 /* l4per_44xx_pwrdm: Target peripherals power domain */
@@ -296,7 +296,7 @@ static struct powerdomain l4per_44xx_pwrdm = {
 		[0] = PWRSTS_ON,	/* nonretained_bank */
 		[1] = PWRSTS_ON,	/* retained_bank */
 	},
-	.flags		= PWRDM_HAS_LOWPOWERSTATECHANGE,
+	.flags		  = PWRDM_HAS_LOWPOWERSTATECHANGE,
 };
 
 /*
@@ -318,6 +318,7 @@ static struct powerdomain cefuse_44xx_pwrdm = {
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 	.pwrsts		  = PWRSTS_OFF_ON,
+	.flags		  = PWRDM_HAS_LOWPOWERSTATECHANGE,
 };
 
 /*
-- 
1.7.0.4

