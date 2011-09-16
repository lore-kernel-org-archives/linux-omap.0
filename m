From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH v2 1/6] OMAP4: Add missing clock divider for OCP_ABE_ICLK
Date: Fri, 16 Sep 2011 12:47:29 -0500
Message-ID: <1316195249-14914-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43073 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754804Ab1IPRrh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Sep 2011 13:47:37 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

From: Jon Hunter <jon-hunter@ti.com>

The parent clock of the OCP_ABE_ICLK is the AESS_FCLK and the
parent clock of the AESS_FCLK is the ABE_FCLK...

ABE_FCLK --> AESS_FCLK --> OCP_ABE_ICLK

The AESS_FCLK and OCP_ABE_ICLK clocks both have dividers which
determine their operational frequency. However, the dividers for
the AESS_FCLK and OCP_ABE_ICLK are controlled via a single bit,
which is the CM1_ABE_AESS_CLKCTRL[24] bit. When this bit is set to
0, the AESS_FCLK divider is 1 and the OCP_ABE_ICLK divider is 2.
Similarly, when this bit is set to 1, the AESS_FCLK divider is 2
and the OCP_ABE_ICLK is 1.

The above relationship between the AESS_FCLK and OCP_ABE_ICLK
dividers ensure that the OCP_ABE_ICLK clock is always half the
frequency of the ABE_CLK...

OCP_ABE_ICLK = ABE_FCLK/2

The divider for the OCP_ABE_ICLK is currently missing so add a
divider that will ensure the OCP_ABE_ICLK frequency is always half
the ABE_FCLK frequency.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index c0b6fbd..3e34dcd 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -1195,11 +1195,25 @@ static struct clk l4_wkup_clk_mux_ck = {
 	.recalc		= &omap2_clksel_recalc,
 };
 
+static const struct clksel_rate div2_2to1_rates[] = {
+	{ .div = 1, .val = 1, .flags = RATE_IN_4430 },
+	{ .div = 2, .val = 0, .flags = RATE_IN_4430 },
+	{ .div = 0 },
+};
+
+static const struct clksel ocp_abe_iclk_div[] = {
+	{ .parent = &aess_fclk, .rates = div2_2to1_rates },
+	{ .parent = NULL },
+};
+
 static struct clk ocp_abe_iclk = {
 	.name		= "ocp_abe_iclk",
 	.parent		= &aess_fclk,
+	.clksel		= ocp_abe_iclk_div,
+	.clksel_reg	= OMAP4430_CM1_ABE_AESS_CLKCTRL,
+	.clksel_mask	= OMAP4430_CLKSEL_AESS_FCLK_MASK,
 	.ops		= &clkops_null,
-	.recalc		= &followparent_recalc,
+	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk per_abe_24m_fclk = {
-- 
1.7.4.1

