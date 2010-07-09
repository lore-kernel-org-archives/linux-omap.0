From: Anand Gadiyar <gadiyar@ti.com>
Subject: [PATCH resend] omap: 3630: disable TLL SAR on 3630 ES1
Date: Sat, 10 Jul 2010 05:04:29 +0530
Message-ID: <1278718469-7940-1-git-send-email-gadiyar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40402 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750987Ab0GIXeg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Jul 2010 19:34:36 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Anand Gadiyar <gadiyar@ti.com>, Paul Walmsley <paul@pwsan.com>

USBTLL Save-and-Restore is broken in 3630 ES1.0. Having it
enabled could result in incorrect register restores as
the OMAP exits off-mode. This could potentially result in
unexpected wakeup events.

This is fixed in ES1.1. So disable it for ES1.0s.

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
This is a fix for buggy hardware, and it would be nice
to see this in the next merge window too.

Depends on the patch I just posted which adds the
CHIP_GE_OMAP3630ES1_1 macro
<https://patchwork.kernel.org/patch/111147/>

 arch/arm/mach-omap2/powerdomains34xx.h |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Index: linux-omap-2.6/arch/arm/mach-omap2/powerdomains34xx.h
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/powerdomains34xx.h
+++ linux-omap-2.6/arch/arm/mach-omap2/powerdomains34xx.h
@@ -80,7 +80,8 @@ static struct powerdomain core_3xxx_pre_
 	.prcm_offs	  = CORE_MOD,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES1 |
 					   CHIP_IS_OMAP3430ES2 |
-					   CHIP_IS_OMAP3430ES3_0),
+					   CHIP_IS_OMAP3430ES3_0 |
+					   CHIP_IS_OMAP3630ES1),
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.banks		  = 2,
@@ -97,7 +98,8 @@ static struct powerdomain core_3xxx_pre_
 static struct powerdomain core_3xxx_es3_1_pwrdm = {
 	.name		  = "core_pwrdm",
 	.prcm_offs	  = CORE_MOD,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES3_1),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES3_1 |
+					  CHIP_GE_OMAP3630ES1_1),
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.flags		  = PWRDM_HAS_HDWR_SAR, /* for USBTLL only */
