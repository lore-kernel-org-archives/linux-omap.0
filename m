From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH] ARM: OMAP4: hwmod data: gpmc main clk
Date: Mon, 15 Oct 2012 11:17:43 +0530
Message-ID: <1350280063-27422-1-git-send-email-afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50506 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751993Ab2JOFsD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Oct 2012 01:48:03 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Afzal Mohammed <afzal@ti.com>

gpmc has been converted to a driver. It requests clock with
con-id "fck", if not available, probe fails. Clock for gpmc
device with con-id "fck" is created (aliased) along with
hwmod device, and for that to happen, main_clk needs to be
specified in hwmod entry, add it for OMAP4.

Note that the corresponding clock is dummy.

Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 652d028..ce04002 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -1363,6 +1363,7 @@ static struct omap_hwmod omap44xx_gpmc_hwmod = {
 	.flags		= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
 	.mpu_irqs	= omap44xx_gpmc_irqs,
 	.sdma_reqs	= omap44xx_gpmc_sdma_reqs,
+	.main_clk	= "gpmc_ck",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L3_2_GPMC_CLKCTRL_OFFSET,
-- 
1.7.12

