From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/3] OMAP3 clock: Fix the DPLL freqsel computations
Date: Mon, 16 Nov 2009 06:36:53 -0700
Message-ID: <20091116133649.14128.89383.stgit@localhost.localdomain>
References: <20091116133237.14128.39687.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49335 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752561AbZKPNh4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Nov 2009 08:37:56 -0500
In-Reply-To: <20091116133237.14128.39687.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Nishanth Menon <nm@ti.com>, Hayati Bayrakdar <h-bayrakdar@ti.com>, linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

Fix the freqsel value computation. Use n instead of (n+1)

The formula in the TRM uses a zero-based N, hence the (n+1); however
at this point in the clock34xx.c code, N is one-based.

Hayati Bayrakdar <h-bayrakdar@ti.com> and Nishanth Menon <nm@ti.com> helped
track down this bug.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
[paul@pwsan.com: modified commit message]
Cc: Hayati Bayrakdar <h-bayrakdar@ti.com>
Cc: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/clock34xx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index c258f87..225c1a7 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -473,7 +473,7 @@ static u16 _omap3_dpll_compute_freqsel(struct clk *clk, u8 n)
 	unsigned long fint;
 	u16 f = 0;
 
-	fint = clk->dpll_data->clk_ref->rate / (n + 1);
+	fint = clk->dpll_data->clk_ref->rate / n;
 
 	pr_debug("clock: fint is %lu\n", fint);
 


