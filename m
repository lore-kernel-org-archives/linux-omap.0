From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/2] OMAP3 clock: remove omap3_noncore_dpll_set_rate fn from
	CORE DPLL definition
Date: Wed, 07 May 2008 19:19:07 -0600
Message-ID: <20080508011907.15057.3110.stgit@localhost.localdomain>
References: <20080508011650.15057.8127.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44819 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755085AbYEHB3b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 May 2008 21:29:31 -0400
In-Reply-To: <20080508011650.15057.8127.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

DPLL3 is the CORE DPLL and cannot use the non-CORE set_rate function since
SDRC is downstream.

Signed-off-by: Paul Walmslsy <paul@pwsan.com>
---

 arch/arm/mach-omap2/clock34xx.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index 825bab4..284c796 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -411,7 +411,6 @@ static struct clk dpll3_ck = {
 	.dpll_data	= &dpll3_dd,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
 	.round_rate	= &omap2_dpll_round_rate,
-	.set_rate	= &omap3_noncore_dpll_set_rate,
 	.recalc		= &omap3_dpll_recalc,
 };
 


