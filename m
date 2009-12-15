From: Abhijit Pagare <abhijitpagare@ti.com>
Subject: [PATCH 1/1] ARM: OMAP3: PM: Fix the Invalid CM_CLKSTCTRL reg access.
Date: Tue, 15 Dec 2009 19:01:12 +0530
Message-ID: <1260883872-22299-1-git-send-email-abhijitpagare@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42582 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760158AbZLONb2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Dec 2009 08:31:28 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Abhijit Pagare <abhijitpagare@ti.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>

In OMAP2/3 some of the clock-domains which did not have control
facility were being falsely written to and read using the CM_CLKSTCTRL
register though it did not exist for them. One check is added to remove
this flaw.

Signed-off-by: Abhijit Pagare <abhijitpagare@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clockdomain.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index 1a45ed1..dd285f0 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -559,7 +559,7 @@ int omap2_clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk)
 	 * downstream clocks for debugging purposes?
 	 */
 
-	if (!clkdm || !clk)
+	if (!clkdm || !clk || !clkdm->clktrctrl_mask)
 		return -EINVAL;
 
 	if (atomic_inc_return(&clkdm->usecount) > 1)
@@ -610,7 +610,7 @@ int omap2_clkdm_clk_disable(struct clockdomain *clkdm, struct clk *clk)
 	 * downstream clocks for debugging purposes?
 	 */
 
-	if (!clkdm || !clk)
+	if (!clkdm || !clk || !clkdm->clktrctrl_mask)
 		return -EINVAL;
 
 #ifdef DEBUG
-- 
1.5.4.7

