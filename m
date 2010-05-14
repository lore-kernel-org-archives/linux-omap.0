From: Anand Gadiyar <gadiyar@ti.com>
Subject: [PATCH 2/2] omap: 3630: disable TLL SAR on 3630 ES1
Date: Fri, 14 May 2010 17:36:07 +0530
Message-ID: <1273838767-16638-2-git-send-email-gadiyar@ti.com>
References: <1273838767-16638-1-git-send-email-gadiyar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54574 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758766Ab0ENMGM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 May 2010 08:06:12 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o4EC69gI007586
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 14 May 2010 07:06:11 -0500
In-Reply-To: <1273838767-16638-1-git-send-email-gadiyar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Anand Gadiyar <gadiyar@ti.com>

USBTLL Save-and-Restore is broken in 3630 ES1.0. Having it
enabled could result in incorrect register restores as
the OMAP exits off-mode. This could potentially result in
unexpected wakeup events.

This is fixed in ES1.1. So disable it for ES1.0s.

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
---
Not using the errata framework for this - but if it does
get implemented, then this is a candidate to add to it.

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
