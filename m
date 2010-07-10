From: Vikram Pandita <vikram.pandita@ti.com>
Subject: [PATCH 2/3] omap4: fix omap_type() function
Date: Sat, 10 Jul 2010 02:08:32 -0500
Message-ID: <1278745713-31255-3-git-send-email-vikram.pandita@ti.com>
References: <1278745713-31255-1-git-send-email-vikram.pandita@ti.com>
 <1278745713-31255-2-git-send-email-vikram.pandita@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33405 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751654Ab0GJHHL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 10 Jul 2010 03:07:11 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o6A77Aoa018643
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Sat, 10 Jul 2010 02:07:10 -0500
In-Reply-To: <1278745713-31255-2-git-send-email-vikram.pandita@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vikram Pandita <vikram.pandita@ti.com>

Following patch added the omap_type() functionality for omap4
	737daa03: omap4: Fix omap_type() for omap4

However the omap_type() function would not work as:
1) the base address for CONTROL_STATUS register is wrongly mapped

2) "Not yet supported" check for omap4 needs to be removed

Verified on OMAP4 SDP board

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
---
 arch/arm/plat-omap/include/plat/omap44xx.h |    2 +-
 arch/arm/plat-omap/sram.c                  |    4 ----
 2 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap44xx.h b/arch/arm/plat-omap/include/plat/omap44xx.h
index 8b3f12f..2075856 100644
--- a/arch/arm/plat-omap/include/plat/omap44xx.h
+++ b/arch/arm/plat-omap/include/plat/omap44xx.h
@@ -33,7 +33,7 @@
 #define OMAP4430_PRCM_MPU_BASE		0x48243000
 #define OMAP44XX_GPMC_BASE		0x50000000
 #define OMAP443X_SCM_BASE		0x4a002000
-#define OMAP443X_CTRL_BASE		0x4a100000
+#define OMAP443X_CTRL_BASE		0x4a002000
 #define OMAP44XX_IC_BASE		0x48200000
 #define OMAP44XX_IVA_INTC_BASE		0x40000000
 #define IRQ_SIR_IRQ			0x0040
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 2eb5a27..112b807 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -93,10 +93,6 @@ extern unsigned long omapfb_reserve_sram(unsigned long sram_pstart,
  */
 static int is_sram_locked(void)
 {
-	if (cpu_is_omap44xx())
-		/* Not yet supported */
-		return 0;
-
 	if (OMAP2_DEVICE_TYPE_GP == omap_type()) {
 		/* RAMFW: R/W access to all initiators for all qualifier sets */
 		if (cpu_is_omap242x()) {
-- 
1.6.6.1

