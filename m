From: Ameya Palande <ameya.palande@ti.com>
Subject: [PATCH] ARM: OMAP4: clock: fix mult and div mask for USB_DPLL
Date: Wed, 18 Jan 2012 15:39:14 -0800
Message-ID: <1326929954-3912-1-git-send-email-ameya.palande@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34312 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753130Ab2ARXjR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Jan 2012 18:39:17 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, ameya.palande@ti.com

Signed-off-by: Ameya Palande <ameya.palande@ti.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 08e86d7..053cc15 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -953,8 +953,8 @@ static struct dpll_data dpll_usb_dd = {
 	.modes		= (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
 	.autoidle_reg	= OMAP4430_CM_AUTOIDLE_DPLL_USB,
 	.idlest_reg	= OMAP4430_CM_IDLEST_DPLL_USB,
-	.mult_mask	= OMAP4430_DPLL_MULT_MASK,
-	.div1_mask	= OMAP4430_DPLL_DIV_MASK,
+	.mult_mask	= OMAP4430_DPLL_MULT_USB_MASK,
+	.div1_mask	= OMAP4430_DPLL_DIV_0_7_MASK,
 	.enable_mask	= OMAP4430_DPLL_EN_MASK,
 	.autoidle_mask	= OMAP4430_AUTO_DPLL_MODE_MASK,
 	.idlest_mask	= OMAP4430_ST_DPLL_CLK_MASK,
-- 
1.7.4.1

