From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 3/5] OMAP4 powerdomain: Fix pwrsts flags for ALWAYS ON domains
Date: Tue, 11 May 2010 12:57:08 +0530
Message-ID: <1273562830-9758-4-git-send-email-rnayak@ti.com>
References: <1273562830-9758-1-git-send-email-rnayak@ti.com>
 <1273562830-9758-2-git-send-email-rnayak@ti.com>
 <1273562830-9758-3-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59549 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754095Ab0EKH1Q (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 May 2010 03:27:16 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o4B7RDHj006837
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 11 May 2010 02:27:15 -0500
In-Reply-To: <1273562830-9758-3-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>

The pwrsts flag for ALWAYS ON domains like always_on_core_pwrdm
and wkup_pwrdm is wrongly populated with the define for a
powerdomain power state, instead of the allowable state
bitfields.
This causes a few api's to fail sensing invalid pwrst
requested.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/powerdomains44xx.h        |    4 ++--
 arch/arm/plat-omap/include/plat/powerdomain.h |    1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomains44xx.h b/arch/arm/mach-omap2/powerdomains44xx.h
index c101514..ad2fbd7 100644
--- a/arch/arm/mach-omap2/powerdomains44xx.h
+++ b/arch/arm/mach-omap2/powerdomains44xx.h
@@ -130,7 +130,7 @@ static struct powerdomain wkup_44xx_pwrdm = {
 	.name		  = "wkup_pwrdm",
 	.prcm_offs	  = OMAP4430_PRM_WKUP_MOD,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
-	.pwrsts		  = PWRDM_POWER_ON,
+	.pwrsts		  = PWRSTS_ON,
 	.banks		  = 1,
 	.pwrsts_mem_ret	= {
 		[0] = PWRDM_POWER_OFF,	/* wkup_bank */
@@ -286,7 +286,7 @@ static struct powerdomain always_on_core_44xx_pwrdm = {
 	.name		  = "always_on_core_pwrdm",
 	.prcm_offs	  = OMAP4430_PRM_ALWAYS_ON_MOD,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
-	.pwrsts		  = PWRDM_POWER_ON,
+	.pwrsts		  = PWRSTS_ON,
 };
 
 /* cefuse_44xx_pwrdm: Customer efuse controller power domain */
diff --git a/arch/arm/plat-omap/include/plat/powerdomain.h b/arch/arm/plat-omap/include/plat/powerdomain.h
index d82b2c0..e7cc7e6 100644
--- a/arch/arm/plat-omap/include/plat/powerdomain.h
+++ b/arch/arm/plat-omap/include/plat/powerdomain.h
@@ -31,6 +31,7 @@
 #define PWRDM_MAX_PWRSTS	4
 
 /* Powerdomain allowable state bitfields */
+#define PWRSTS_ON		(1 << PWRDM_POWER_ON)
 #define PWRSTS_OFF_ON		((1 << PWRDM_POWER_OFF) | \
 				 (1 << PWRDM_POWER_ON))
 
-- 
1.7.0.rc1.33.g07cf0f

