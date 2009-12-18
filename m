From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/8] ARM: OMAP3: PM: Fix the Invalid CM_CLKSTCTRL reg access.
Date: Thu, 17 Dec 2009 21:20:17 -0700
Message-ID: <20091218042015.27280.14688.stgit@localhost.localdomain>
References: <20091218041912.27280.92152.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40393 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751491AbZLREVt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Dec 2009 23:21:49 -0500
In-Reply-To: <20091218041912.27280.92152.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Rajendra Nayak <rnayak@ti.com>, Abhijit Pagare <abhijitpagare@ti.com>, Benoit Cousson <b-cousson@ti.com>

From: Abhijit Pagare <abhijitpagare@ti.com>

In OMAP2/3 some of the clock-domains which did not have control
facility were being falsely written to and read using the CM_CLKSTCTRL
register though it did not exist for them. One check is added to remove
this flaw.

Signed-off-by: Abhijit Pagare <abhijitpagare@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
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


