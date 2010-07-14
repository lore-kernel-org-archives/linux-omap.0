From: Anand Gadiyar <gadiyar@ti.com>
Subject: [PATCH resend v2] omap: 3630: disable TLL SAR on 3630 ES1
Date: Wed, 14 Jul 2010 19:08:49 +0530
Message-ID: <1279114729-8815-1-git-send-email-gadiyar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34931 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752786Ab0GNNiy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Jul 2010 09:38:54 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o6EDcpTH018469
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 14 Jul 2010 08:38:53 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Anand Gadiyar <gadiyar@ti.com>

USBTLL Save-and-Restore is broken in 3630 ES1.0. Having it
enabled could result in incorrect register restores as
the OMAP exits off-mode. This could potentially result in
unexpected wakeup events.

(Refer 3630 errata ID i579)

This is fixed in ES1.1. So disable it for ES1.0s.

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Acked-by: Paul Walmsley <paul@pwsan.com>
---
(v2: Added a comment to the code with a reference to the errata IDs
for 3430 and 3630. Also added Paul's ack).

This is a fix for buggy hardware, and it would be nice
to see this in the next merge window too.

Depends on the patch I just posted which adds the
CHIP_GE_OMAP3630ES1_1 macro
<https://patchwork.kernel.org/patch/111147/>

 arch/arm/mach-omap2/powerdomains34xx.h |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

Index: linux-omap-2.6/arch/arm/mach-omap2/powerdomains34xx.h
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/powerdomains34xx.h
+++ linux-omap-2.6/arch/arm/mach-omap2/powerdomains34xx.h
@@ -75,12 +75,19 @@ static struct powerdomain mpu_3xxx_pwrdm
 	},
 };
 
+/*
+ * The USBTLL Save-and-Restore mechanism is broken on
+ * 3430s upto ES3.0 and 3630ES1.0. Hence this feature
+ * needs to be disabled on these chips.
+ * Refer: 3430 errata ID i459 and 3630 errata ID i579
+ */
 static struct powerdomain core_3xxx_pre_es3_1_pwrdm = {
 	.name		  = "core_pwrdm",
 	.prcm_offs	  = CORE_MOD,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES1 |
 					   CHIP_IS_OMAP3430ES2 |
-					   CHIP_IS_OMAP3430ES3_0),
+					   CHIP_IS_OMAP3430ES3_0 |
+					   CHIP_IS_OMAP3630ES1),
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.banks		  = 2,
@@ -97,7 +104,8 @@ static struct powerdomain core_3xxx_pre_
 static struct powerdomain core_3xxx_es3_1_pwrdm = {
 	.name		  = "core_pwrdm",
 	.prcm_offs	  = CORE_MOD,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES3_1),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES3_1 |
+					  CHIP_GE_OMAP3630ES1_1),
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.flags		  = PWRDM_HAS_HDWR_SAR, /* for USBTLL only */
