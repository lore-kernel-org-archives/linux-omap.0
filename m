From: Thara Gopinath <thara@ti.com>
Subject: [PATCH 4/8] OMAP3 PM: Defining .pwrsts_logic_ret field for core power domain structure
Date: Wed, 20 Jan 2010 21:00:38 +0530
Message-ID: <1264001442-20078-5-git-send-email-thara@ti.com>
References: <1264001442-20078-1-git-send-email-thara@ti.com>
 <1264001442-20078-2-git-send-email-thara@ti.com>
 <1264001442-20078-3-git-send-email-thara@ti.com>
 <1264001442-20078-4-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53796 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753357Ab0ATPas (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Jan 2010 10:30:48 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o0KFUj9T002045
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 20 Jan 2010 09:30:47 -0600
In-Reply-To: <1264001442-20078-4-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thara Gopinath <thara@ti.com>

This patch adds the flag .pwrsts_logic_ret info for the core power domain
in the associated powerdomain structure. This flag specifies the states
core domain logic can hit in event of the domain entering retention.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/powerdomains34xx.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomains34xx.h b/arch/arm/mach-omap2/powerdomains34xx.h
index 588f7e0..6a058c7 100644
--- a/arch/arm/mach-omap2/powerdomains34xx.h
+++ b/arch/arm/mach-omap2/powerdomains34xx.h
@@ -208,6 +208,7 @@ static struct powerdomain core_34xx_pre_es3_1_pwrdm = {
 					   CHIP_IS_OMAP3430ES2 |
 					   CHIP_IS_OMAP3430ES3_0),
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
+	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.dep_bit	  = OMAP3430_EN_CORE_SHIFT,
 	.banks		  = 2,
 	.pwrsts_mem_ret	  = {
@@ -226,6 +227,7 @@ static struct powerdomain core_34xx_es3_1_pwrdm = {
 	.prcm_offs	  = CORE_MOD,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES3_1),
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
+	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.dep_bit	  = OMAP3430_EN_CORE_SHIFT,
 	.flags		  = PWRDM_HAS_HDWR_SAR, /* for USBTLL only */
 	.banks		  = 2,
-- 
1.5.6.3

