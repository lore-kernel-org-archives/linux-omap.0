From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 3/9] omap4: powerdomain: Use intended PWRSTS_* flags instead of values
Date: Fri,  4 Feb 2011 15:28:58 +0530
Message-ID: <1296813544-25170-4-git-send-email-santosh.shilimkar@ti.com>
References: <1296813544-25170-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55018 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754478Ab1BDJ7T (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 Feb 2011 04:59:19 -0500
In-Reply-To: <1296813544-25170-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, paul@pwsan.com, b-cousson@ti.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

IVAHD and ABE power domain logic state is populated using directly
value instead of the capability flags.

Fix the same.

This was getting generated due to a bug 'gen_logicst' macro
in powerdomain autogen script bug which is fixed as well.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/powerdomains44xx_data.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomains44xx_data.c b/arch/arm/mach-omap2/powerdomains44xx_data.c
index 96cde98..daee255 100644
--- a/arch/arm/mach-omap2/powerdomains44xx_data.c
+++ b/arch/arm/mach-omap2/powerdomains44xx_data.c
@@ -80,7 +80,7 @@ static struct powerdomain abe_44xx_pwrdm = {
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 	.pwrsts		  = PWRSTS_OFF_RET_INA_ON,
-	.pwrsts_logic_ret = PWRDM_POWER_OFF,
+	.pwrsts_logic_ret = PWRSTS_OFF,
 	.banks		  = 2,
 	.pwrsts_mem_ret	= {
 		[0] = PWRDM_POWER_RET,	/* aessmem */
@@ -227,7 +227,7 @@ static struct powerdomain ivahd_44xx_pwrdm = {
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 	.pwrsts		  = PWRSTS_OFF_RET_INA_ON,
-	.pwrsts_logic_ret = PWRDM_POWER_OFF,
+	.pwrsts_logic_ret = PWRSTS_OFF,
 	.banks		  = 4,
 	.pwrsts_mem_ret	= {
 		[0] = PWRDM_POWER_OFF,	/* hwa_mem */
-- 
1.6.0.4

