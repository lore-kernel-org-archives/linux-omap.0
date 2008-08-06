From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 1/4] 34XX: PM: Workaround to check wether any fck is active
     before entering sleep
Date: Wed, 6 Aug 2008 18:31:07 +0530 (IST)
Message-ID: <57986.192.168.10.89.1218027667.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57876 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753110AbYHFNBQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 6 Aug 2008 09:01:16 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: jouni.hogander@nokia.com

This workaround shouldn't be needed when all drivers are configuring
their sysconfig registers properly and using their clocks properly.

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+)

Index: linux-omap-2.6/arch/arm/mach-omap2/pm34xx.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/pm34xx.c	2008-08-06
18:07:31.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/pm34xx.c	2008-08-06 18:07:34.000000000
+0530
@@ -174,10 +174,41 @@ static void omap_sram_idle(void)
 	omap2_gpio_resume_after_retention();
 }

+static int omap3_fclks_active(void)
+{
+	u32 fck_core1 = 0, fck_core3 = 0, fck_sgx = 0, fck_dss = 0,
+		fck_cam = 0, fck_per = 0, fck_usbhost = 0;
+
+	fck_core1 = cm_read_mod_reg(CORE_MOD,
+				    CM_FCLKEN1);
+	if (is_sil_rev_greater_than(OMAP3430_REV_ES1_0)) {
+		fck_core3 = cm_read_mod_reg(CORE_MOD,
+					    OMAP3430ES2_CM_FCLKEN3);
+		fck_sgx = cm_read_mod_reg(OMAP3430ES2_SGX_MOD,
+					  CM_FCLKEN);
+		fck_usbhost = cm_read_mod_reg(OMAP3430ES2_USBHOST_MOD,
+					      CM_FCLKEN);
+	} else
+		fck_sgx = cm_read_mod_reg(GFX_MOD,
+					  OMAP3430ES2_CM_FCLKEN3);
+	fck_dss = cm_read_mod_reg(OMAP3430_DSS_MOD,
+				  CM_FCLKEN);
+	fck_cam = cm_read_mod_reg(OMAP3430_CAM_MOD,
+				  CM_FCLKEN);
+	fck_per = cm_read_mod_reg(OMAP3430_PER_MOD,
+				  CM_FCLKEN);
+	if (fck_core1 | fck_core3 | fck_sgx | fck_dss |
+	    fck_cam | fck_per | fck_usbhost)
+		return 1;
+	return 0;
+}
+
 static int omap3_can_sleep(void)
 {
 	if (!enable_dyn_sleep)
 		return 0;
+	if (omap3_fclks_active())
+		return 0;
 	if (atomic_read(&sleep_block) > 0)
 		return 0;
 	return 1;


