From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/2] OMAP3 clock: move sys_clkout2 clk to core_clkdm
Date: Wed, 07 May 2008 19:19:07 -0600
Message-ID: <20080508011907.15057.41574.stgit@localhost.localdomain>
References: <20080508011650.15057.8127.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44818 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753992AbYEHB3b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 May 2008 21:29:31 -0400
In-Reply-To: <20080508011650.15057.8127.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

sys_clkout2 belongs in the core_clkdm (3430 TRM section 4.7.2.2).
It's not clear whether it actually is in the CORE clockdomain, or whether
it is technically in a different clockdomain; but this is closer to
reality than the present configuration.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---

 arch/arm/mach-omap2/clock34xx.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index 85afe1e..825bab4 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -978,6 +978,7 @@ static struct clk clkout2_src_ck = {
 	.clksel_mask	= OMAP3430_CLKOUT2SOURCE_MASK,
 	.clksel		= clkout2_src_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.clkdm_name	= "core_clkdm",
 	.recalc		= &omap2_clksel_recalc,
 };
 


