From: Thara Gopinath <thara@ti.com>
Subject: [PATCH 2/3] OMAP3 PM: Defining .pwrsts_logic_ret field for core power domain structure
Date: Thu,  4 Feb 2010 22:17:50 +0530
Message-ID: <1265302071-7624-3-git-send-email-thara@ti.com>
References: <1265302071-7624-1-git-send-email-thara@ti.com>
 <1265302071-7624-2-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43612 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758483Ab0BDQr6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Feb 2010 11:47:58 -0500
In-Reply-To: <1265302071-7624-2-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thara Gopinath <thara@ti.com>, Paul Walmsley <paul@pwsan.com>

This patch adds the flag .pwrsts_logic_ret info for the core power domain
in the associated powerdomain structure. This flag specifies the states
core domain logic can hit in event of the domain entering retention.

Signed-off-by: Thara Gopinath <thara@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/powerdomains34xx.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomains34xx.h b/arch/arm/mach-omap2/powerdomains34xx.h
index 186c013..bd87112 100644
--- a/arch/arm/mach-omap2/powerdomains34xx.h
+++ b/arch/arm/mach-omap2/powerdomains34xx.h
@@ -82,6 +82,7 @@ static struct powerdomain core_3xxx_pre_es3_1_pwrdm = {
 					   CHIP_IS_OMAP3430ES2 |
 					   CHIP_IS_OMAP3430ES3_0),
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
+	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.banks		  = 2,
 	.pwrsts_mem_ret	  = {
 		[0] = PWRSTS_OFF_RET,	 /* MEM1RETSTATE */
@@ -98,6 +99,7 @@ static struct powerdomain core_3xxx_es3_1_pwrdm = {
 	.prcm_offs	  = CORE_MOD,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES3_1),
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
+	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.flags		  = PWRDM_HAS_HDWR_SAR, /* for USBTLL only */
 	.banks		  = 2,
 	.pwrsts_mem_ret	  = {
-- 
1.7.0.rc1.33.g07cf0f

