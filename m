From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v2 04/18] OMAP4: clock data: Add sddiv to USB DPLL
Date: Fri, 1 Jul 2011 22:41:27 +0200
Message-ID: <1309552901-8944-5-git-send-email-b-cousson@ti.com>
References: <1309552901-8944-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40164 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755146Ab1GAUl5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jul 2011 16:41:57 -0400
In-Reply-To: <1309552901-8944-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>

The USB DPLL is a J-Type DPLL with the sddiv extra parameter.
On the other hand, the UNIPRO is not a J-Type and thus does
not require this flag.

Add it in USB DPLL and remove it in UNIPRO DPLL.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 72a3976..bd2aa4b 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -949,7 +949,6 @@ static struct dpll_data dpll_unipro_dd = {
 	.enable_mask	= OMAP4430_DPLL_EN_MASK,
 	.autoidle_mask	= OMAP4430_AUTO_DPLL_MODE_MASK,
 	.idlest_mask	= OMAP4430_ST_DPLL_CLK_MASK,
-	.sddiv_mask	= OMAP4430_DPLL_SD_DIV_MASK,
 	.max_multiplier	= OMAP4430_MAX_DPLL_MULT,
 	.max_divider	= OMAP4430_MAX_DPLL_DIV,
 	.min_divider	= 1,
@@ -1015,6 +1014,7 @@ static struct dpll_data dpll_usb_dd = {
 	.enable_mask	= OMAP4430_DPLL_EN_MASK,
 	.autoidle_mask	= OMAP4430_AUTO_DPLL_MODE_MASK,
 	.idlest_mask	= OMAP4430_ST_DPLL_CLK_MASK,
+	.sddiv_mask	= OMAP4430_DPLL_SD_DIV_MASK,
 	.max_multiplier	= OMAP4430_MAX_DPLL_MULT,
 	.max_divider	= OMAP4430_MAX_DPLL_DIV,
 	.min_divider	= 1,
-- 
1.7.0.4

