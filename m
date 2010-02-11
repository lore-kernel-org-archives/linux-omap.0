From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 10/13] OMAP2430 clock: make func_96m_ck parent-selectable
Date: Thu, 11 Feb 2010 11:18:06 -0700
Message-ID: <20100211181757.795.72534.stgit@localhost.localdomain>
References: <20100211181236.795.56094.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35540 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756795Ab0BKSUz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Feb 2010 13:20:55 -0500
In-Reply-To: <20100211181236.795.56094.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

func_96m_ck was incorrectly marked as being rate-selectable, when in
fact it is only parent-selectable.  Remove the .set_rate and .round_rate
function pointers for this clk.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock2430_data.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/clock2430_data.c b/arch/arm/mach-omap2/clock2430_data.c
index 9b9470e..daf6439 100644
--- a/arch/arm/mach-omap2/clock2430_data.c
+++ b/arch/arm/mach-omap2/clock2430_data.c
@@ -210,7 +210,6 @@ static const struct clksel func_96m_clksel[] = {
 	{ .parent = NULL }
 };
 
-/* The parent of this clock is not selectable on 2420. */
 static struct clk func_96m_ck = {
 	.name		= "func_96m_ck",
 	.ops		= &clkops_null,
@@ -221,8 +220,6 @@ static struct clk func_96m_ck = {
 	.clksel_mask	= OMAP2430_96M_SOURCE,
 	.clksel		= func_96m_clksel,
 	.recalc		= &omap2_clksel_recalc,
-	.round_rate	= &omap2_clksel_round_rate,
-	.set_rate	= &omap2_clksel_set_rate
 };
 
 /* func_48m_ck */


