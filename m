From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v2 4/5] OMAP4: clock data: Keep GPMC clocks always enabled and hardware managed
Date: Fri, 1 Jul 2011 22:27:39 +0200
Message-ID: <1309552060-4547-5-git-send-email-b-cousson@ti.com>
References: <1309552060-4547-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57091 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755480Ab1GAU15 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Jul 2011 16:27:57 -0400
In-Reply-To: <1309552060-4547-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, rnayak@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>

From: Santosh Shilimkar <santosh.shilimkar@ti.com>

On OMAP4, CPU accesses on unmapped addresses are redirected to GPMC by
L3 interconnect. Because of CPU speculative nature, such accesses are
possible which can lead to indirect access to GPMC and if it's clock is
not running, it can result in hang/abort on the platform.

Above makes access to GPMC unpredictable during the execution, so it's
module mode needs to be kept under hardware control instead of software
control.
Since the auto gating is supported for GPMC, there isn't any power impact
because of this change.

The issue was un-covered with security middleware running along with HLOS.
In this case GPMC had a valid MMU descriptor on secure side where as HLOS
didn't map the GMPC because it isn't being used.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
[b-cousson@ti.com: Update subject and fix typos in the changelog]
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 8c96567..72a3976 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -1694,6 +1694,7 @@ static struct clk gpmc_ick = {
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L3_2_GPMC_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
+	.flags		= ENABLE_ON_INIT,
 	.clkdm_name	= "l3_2_clkdm",
 	.parent		= &l3_div_ck,
 	.recalc		= &followparent_recalc,
-- 
1.7.0.4

