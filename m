From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 11/17] Make USBHOST powerdomain go to sleep after warm reset.
Date: Fri, 16 Oct 2009 13:49:04 +0300
Message-ID: <1255690150-16853-12-git-send-email-tero.kristo@nokia.com>
References: <>
 <1255690150-16853-1-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-2-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-3-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-4-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-5-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-6-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-7-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-8-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-9-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-10-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-11-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:19602 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758339AbZJPLEb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Oct 2009 07:04:31 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n9GB33U7009629
	for <linux-omap@vger.kernel.org>; Fri, 16 Oct 2009 06:03:04 -0500
In-Reply-To: <1255690150-16853-11-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter De-Schrijver <peter.de-schrijver@nokia.com>

From: Peter De-Schrijver <peter.de-schrijver@nokia.com>

This patch makes sure the USBHOST and SGX powerdomains can go to any sleep
state after a warm reset.

Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/cm-regbits-34xx.h |    1 +
 arch/arm/mach-omap2/pm34xx.c          |   18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/cm-regbits-34xx.h b/arch/arm/mach-omap2/cm-regbits-34xx.h
index 6923deb..3152553 100644
--- a/arch/arm/mach-omap2/cm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/cm-regbits-34xx.h
@@ -680,6 +680,7 @@
 #define OMAP3430_CLKSEL_GPT2_SHIFT			0
 
 /* CM_SLEEPDEP_PER specific bits */
+#define OMAP3430_CM_SLEEPDEP_PER_EN_MPU			(1 << 1)
 #define OMAP3430_CM_SLEEPDEP_PER_EN_IVA2		(1 << 2)
 
 /* CM_CLKSTCTRL_PER */
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 47f5738..1fa778f 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -26,6 +26,7 @@
 #include <linux/err.h>
 #include <linux/gpio.h>
 #include <linux/clk.h>
+#include <linux/delay.h>
 
 #include <mach/sram.h>
 #include <mach/prcm.h>
@@ -934,6 +935,24 @@ static void __init prcm_setup_regs(void)
 	prm_write_mod_reg(0, OMAP3430_CAM_MOD, PM_WKDEP);
 	prm_write_mod_reg(0, OMAP3430_PER_MOD, PM_WKDEP);
 	if (omap_rev() > OMAP3430_REV_ES1_0) {
+
+		/*
+		 * This workaround is needed to prevent SGX and USBHOST from
+		 * failing to transition to RET/OFF after a warm reset in OFF
+		 * mode. Workaround sets a sleepdep of each of these domains
+		 * with MPU, waits for a min 2 sysclk cycles and clears the
+		 * sleepdep.
+		 */
+		cm_write_mod_reg(OMAP3430_CM_SLEEPDEP_PER_EN_MPU,
+				OMAP3430ES2_USBHOST_MOD, OMAP3430_CM_SLEEPDEP);
+		cm_write_mod_reg(OMAP3430_CM_SLEEPDEP_PER_EN_MPU,
+				OMAP3430ES2_SGX_MOD, OMAP3430_CM_SLEEPDEP);
+		udelay(100);
+		cm_write_mod_reg(0, OMAP3430ES2_USBHOST_MOD,
+				OMAP3430_CM_SLEEPDEP);
+		cm_write_mod_reg(0, OMAP3430ES2_SGX_MOD,
+				OMAP3430_CM_SLEEPDEP);
+
 		prm_write_mod_reg(0, OMAP3430ES2_SGX_MOD, PM_WKDEP);
 		prm_write_mod_reg(0, OMAP3430ES2_USBHOST_MOD, PM_WKDEP);
 	} else
-- 
1.5.4.3

