From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 6/8] OMAP3 clock: McBSP 2, 3,
	4 functional clock parent is PER_96M_FCLK, not CORE_96M_FCLK
Date: Thu, 17 Dec 2009 21:20:21 -0700
Message-ID: <20091218042020.27280.77746.stgit@localhost.localdomain>
References: <20091218041912.27280.92152.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40407 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752268AbZLREVu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Dec 2009 23:21:50 -0500
In-Reply-To: <20091218041912.27280.92152.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Nicole Chalhoub <n-chalhoub@ti.com>

The correct parent of the McBSP 2, 3, and 4 functional clocks is
PER_96M_FCLK, not CORE_96M_FCLK.  Fix this in the OMAP clock tree.
Reported by Nicole Chalhoub <n-chalhoub@ti.com>.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Nicole Chalhoub <n-chalhoub@ti.com>
---
 arch/arm/mach-omap2/clock34xx_data.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx_data.c b/arch/arm/mach-omap2/clock34xx_data.c
index c60b19a..7eea9fb 100644
--- a/arch/arm/mach-omap2/clock34xx_data.c
+++ b/arch/arm/mach-omap2/clock34xx_data.c
@@ -2747,7 +2747,7 @@ static struct clk mcbsp4_ick = {
 };
 
 static const struct clksel mcbsp_234_clksel[] = {
-	{ .parent = &core_96m_fck, .rates = common_mcbsp_96m_rates },
+	{ .parent = &per_96m_fck,  .rates = common_mcbsp_96m_rates },
 	{ .parent = &mcbsp_clks,   .rates = common_mcbsp_mcbsp_rates },
 	{ .parent = NULL }
 };


