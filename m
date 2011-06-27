From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 3/7] OMAP4: hwmod data: TEMP: Do not idle MMC1 & MMC2 after boot
Date: Mon, 27 Jun 2011 18:33:07 +0200
Message-ID: <1309192391-12410-4-git-send-email-b-cousson@ti.com>
References: <1309192391-12410-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:32801 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752211Ab1F0Qd4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Jun 2011 12:33:56 -0400
In-Reply-To: <1309192391-12410-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, rnayak@ti.com
Cc: santosh.shilimkar@ti.com, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

Since the MMC driver is not pm_runtime adapted, do not put
them in idle after boot.
It will allow the driver to work as expected until the migration
to pm_runtime.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 850ac39..e10d3f7 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -3658,6 +3658,7 @@ static struct omap_hwmod omap44xx_mmc1_hwmod = {
 	.name		= "mmc1",
 	.class		= &omap44xx_mmc_hwmod_class,
 	.clkdm_name	= "l3_init_clkdm",
+	.flags		= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
 	.mpu_irqs	= omap44xx_mmc1_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_mmc1_irqs),
 	.sdma_reqs	= omap44xx_mmc1_sdma_reqs,
@@ -3720,6 +3721,7 @@ static struct omap_hwmod omap44xx_mmc2_hwmod = {
 	.name		= "mmc2",
 	.class		= &omap44xx_mmc_hwmod_class,
 	.clkdm_name	= "l3_init_clkdm",
+	.flags		= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
 	.mpu_irqs	= omap44xx_mmc2_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_mmc2_irqs),
 	.sdma_reqs	= omap44xx_mmc2_sdma_reqs,
-- 
1.7.0.4

