From: Thara Gopinath <thara@ti.com>
Subject: [PATCH V2] OMAP3: PM: Fix for MPU power domain MEM BANK position
Date: Thu, 26 Nov 2009 16:44:47 +0530
Message-ID: <1259234087-10030-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59627 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753953AbZKZLOs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Nov 2009 06:14:48 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thara Gopinath <thara@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

MPU power domain bank 0 bits are displayed in position of bank 1
in PWRSTS and PREPWRSTS registers. So read them from correct
position

Signed-off-by: Thara Gopinath <thara@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/powerdomain.c             |    6 ++++++
 arch/arm/mach-omap2/powerdomains34xx.h        |    1 +
 arch/arm/plat-omap/include/plat/powerdomain.h |    5 ++++-
 3 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index b6990e3..1af447e 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -985,6 +985,9 @@ int pwrdm_read_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
 	if (pwrdm->banks < (bank + 1))
 		return -EEXIST;
 
+	if (pwrdm->flags & PWRDM_HAS_MPU_QUIRK)
+		bank = 1;
+
 	/*
 	 * The register bit names below may not correspond to the
 	 * actual names of the bits in each powerdomain's register,
@@ -1032,6 +1035,9 @@ int pwrdm_read_prev_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
 	if (pwrdm->banks < (bank + 1))
 		return -EEXIST;
 
+	if (pwrdm->flags & PWRDM_HAS_MPU_QUIRK)
+		bank = 1;
+
 	/*
 	 * The register bit names below may not correspond to the
 	 * actual names of the bits in each powerdomain's register,
diff --git a/arch/arm/mach-omap2/powerdomains34xx.h b/arch/arm/mach-omap2/powerdomains34xx.h
index fd09b08..588f7e0 100644
--- a/arch/arm/mach-omap2/powerdomains34xx.h
+++ b/arch/arm/mach-omap2/powerdomains34xx.h
@@ -190,6 +190,7 @@ static struct powerdomain mpu_34xx_pwrdm = {
 	.wkdep_srcs	  = mpu_34xx_wkdeps,
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF_RET,
+	.flags		  = PWRDM_HAS_MPU_QUIRK,
 	.banks		  = 1,
 	.pwrsts_mem_ret	  = {
 		[0] = PWRSTS_OFF_RET,
diff --git a/arch/arm/plat-omap/include/plat/powerdomain.h b/arch/arm/plat-omap/include/plat/powerdomain.h
index 3d45ee1..ad070a6 100644
--- a/arch/arm/plat-omap/include/plat/powerdomain.h
+++ b/arch/arm/plat-omap/include/plat/powerdomain.h
@@ -40,7 +40,10 @@
 
 /* Powerdomain flags */
 #define PWRDM_HAS_HDWR_SAR	(1 << 0) /* hardware save-and-restore support */
-
+#define PWRDM_HAS_MPU_QUIRK	(1 << 1) /* MPU pwr domain has MEM bank 0 bits
+					  * in MEM bank 1 position. This is
+					  * true for OMAP3430
+					  */
 
 /*
  * Number of memory banks that are power-controllable.	On OMAP3430, the
-- 
1.5.4.7

