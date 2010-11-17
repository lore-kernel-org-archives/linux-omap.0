From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH] OMAP3: add comments for erratas i540 and i478 workarounds
Date: Wed, 17 Nov 2010 18:52:11 +0100
Message-ID: <1290016331-9007-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:38114 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935165Ab0KQRw5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Nov 2010 12:52:57 -0500
Received: by gyh4 with SMTP id 4so1270284gyh.19
        for <linux-omap@vger.kernel.org>; Wed, 17 Nov 2010 09:52:56 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jean Pihet <jean.pihet@newoldbits.com>, Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <jean.pihet@newoldbits.com>

Add comments and IDs for the following erratas:
- i540: MPU cannot exit from Standby,
- i478: Unexpected Cold-Reset is generated when device is coming
   back from OFF mode

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/irq.c              |    5 ++++-
 arch/arm/mach-omap2/powerdomains34xx.h |    8 ++++++++
 2 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 32eeabe..85bf8ca 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -284,7 +284,10 @@ void omap3_intc_suspend(void)
 
 void omap3_intc_prepare_idle(void)
 {
-	/* Disable autoidle as it can stall interrupt controller */
+	/*
+	 * Disable autoidle as it can stall interrupt controller,
+	 * cf. errata ID i540 for 3430 (all revisions up to 3.1.x)
+	 */
 	intc_bank_write_reg(0, &irq_banks[0], INTC_SYSCONFIG);
 }
 
diff --git a/arch/arm/mach-omap2/powerdomains34xx.h b/arch/arm/mach-omap2/powerdomains34xx.h
index fa90486..ce5c15b 100644
--- a/arch/arm/mach-omap2/powerdomains34xx.h
+++ b/arch/arm/mach-omap2/powerdomains34xx.h
@@ -80,6 +80,10 @@ static struct powerdomain mpu_3xxx_pwrdm = {
  * 3430s upto ES3.0 and 3630ES1.0. Hence this feature
  * needs to be disabled on these chips.
  * Refer: 3430 errata ID i459 and 3630 errata ID i579
+ *
+ * Note: setting the SAR flag could help for errata ID i478
+ *  which applies to 3430 <= ES3.1, but since the SAR feature
+ *  is broken, do not use it.
  */
 static struct powerdomain core_3xxx_pre_es3_1_pwrdm = {
 	.name		  = "core_pwrdm",
@@ -108,6 +112,10 @@ static struct powerdomain core_3xxx_es3_1_pwrdm = {
 					  CHIP_GE_OMAP3630ES1_1),
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF_RET,
+	/*
+	 * Setting the SAR flag for errata ID i478 which applies
+	 *  to 3430 <= ES3.1
+	 */
 	.flags		  = PWRDM_HAS_HDWR_SAR, /* for USBTLL only */
 	.banks		  = 2,
 	.pwrsts_mem_ret	  = {
-- 
1.7.2.3

