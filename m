From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 9/9] omap4: clockdomain: Fix the CPUx domain name
Date: Fri,  4 Feb 2011 15:29:04 +0530
Message-ID: <1296813544-25170-10-git-send-email-santosh.shilimkar@ti.com>
References: <1296813544-25170-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50478 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754836Ab1BDJ7U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Feb 2011 04:59:20 -0500
In-Reply-To: <1296813544-25170-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, paul@pwsan.com, b-cousson@ti.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: Benoit Cousson <b-cousson@ti.com>

The register naming convention for clock domain control inside
power domain instance is:
OMAPXXXX_<partition>_<power_domain>_<clock_domain>_CDOFFS

Both CPU0 and CPU1 use MPU as clock domain name instead of CPU0
and CPU1.

Change the name to stick to the convention.
The autogen scripts are updated accordingly.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clockdomains44xx_data.c |    4 ++--
 arch/arm/mach-omap2/prcm_mpu44xx.h          |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomains44xx_data.c b/arch/arm/mach-omap2/clockdomains44xx_data.c
index 51920fc..db1f442 100644
--- a/arch/arm/mach-omap2/clockdomains44xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains44xx_data.c
@@ -152,7 +152,7 @@ static struct clockdomain mpu0_44xx_clkdm = {
 	.pwrdm		  = { .name = "cpu0_pwrdm" },
 	.prcm_partition	  = OMAP4430_PRCM_MPU_PARTITION,
 	.cm_inst	  = OMAP4430_PRCM_MPU_CPU0_INST,
-	.clkdm_offs	  = OMAP4430_PRCM_MPU_CPU0_MPU_CDOFFS,
+	.clkdm_offs	  = OMAP4430_PRCM_MPU_CPU0_CPU0_CDOFFS,
 	.flags		  = CLKDM_CAN_FORCE_WAKEUP | CLKDM_CAN_HWSUP,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
@@ -162,7 +162,7 @@ static struct clockdomain mpu1_44xx_clkdm = {
 	.pwrdm		  = { .name = "cpu1_pwrdm" },
 	.prcm_partition	  = OMAP4430_PRCM_MPU_PARTITION,
 	.cm_inst	  = OMAP4430_PRCM_MPU_CPU1_INST,
-	.clkdm_offs	  = OMAP4430_PRCM_MPU_CPU1_MPU_CDOFFS,
+	.clkdm_offs	  = OMAP4430_PRCM_MPU_CPU1_CPU1_CDOFFS,
 	.flags		  = CLKDM_CAN_FORCE_WAKEUP | CLKDM_CAN_HWSUP,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
diff --git a/arch/arm/mach-omap2/prcm_mpu44xx.h b/arch/arm/mach-omap2/prcm_mpu44xx.h
index 3300ff6..d22d1b4 100644
--- a/arch/arm/mach-omap2/prcm_mpu44xx.h
+++ b/arch/arm/mach-omap2/prcm_mpu44xx.h
@@ -38,8 +38,8 @@
 #define OMAP4430_PRCM_MPU_CPU1_INST		0x0800
 
 /* PRCM_MPU clockdomain register offsets (from instance start) */
-#define OMAP4430_PRCM_MPU_CPU0_MPU_CDOFFS	0x0018
-#define OMAP4430_PRCM_MPU_CPU1_MPU_CDOFFS	0x0018
+#define OMAP4430_PRCM_MPU_CPU0_CPU0_CDOFFS	0x0018
+#define OMAP4430_PRCM_MPU_CPU1_CPU1_CDOFFS	0x0018
 
 
 /*
-- 
1.6.0.4

