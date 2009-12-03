From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 4/8] OMAP2xxx clock: remove implicit dependency between rate
	CPU flag and clkdev_omap CPU flag
Date: Thu, 03 Dec 2009 03:07:05 -0700
Message-ID: <20091203100704.1203.53963.stgit@localhost.localdomain>
References: <20091203095830.1203.76290.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35917 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755534AbZLCKLs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Dec 2009 05:11:48 -0500
In-Reply-To: <20091203095830.1203.76290.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

cpu_mask is reused in the OMAP2xxx clock code to match against both the
CPU-specific rate flags (e.g., RATE_IN_2420) and the OMAP clkdev integration
code CPU flags (e.g., CK_242X).  This means that any patch that renumbers the
CK_* macros, as the next patch does, will probably break.  This patch
separates the clkdev_omap and clksel_rate CPU type detection flags so
the CK_* macros can be renumbered freely.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock24xx.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clock24xx.c b/arch/arm/mach-omap2/clock24xx.c
index e60d1c0..5f201d2 100644
--- a/arch/arm/mach-omap2/clock24xx.c
+++ b/arch/arm/mach-omap2/clock24xx.c
@@ -751,13 +751,16 @@ int __init omap2_clk_init(void)
 	struct prcm_config *prcm;
 	struct omap_clk *c;
 	u32 clkrate;
+	u16 cpu_clkflg;
 
 	if (cpu_is_omap242x()) {
 		prcm_clksrc_ctrl = OMAP2420_PRCM_CLKSRC_CTRL;
 		cpu_mask = RATE_IN_242X;
+		cpu_clkflg = CK_242X;
 	} else if (cpu_is_omap2430()) {
 		prcm_clksrc_ctrl = OMAP2430_PRCM_CLKSRC_CTRL;
 		cpu_mask = RATE_IN_243X;
+		cpu_clkflg = CK_243X;
 	}
 
 	clk_init(&omap2_clk_functions);
@@ -771,7 +774,7 @@ int __init omap2_clk_init(void)
 	propagate_rate(&sys_ck);
 
 	for (c = omap24xx_clks; c < omap24xx_clks + ARRAY_SIZE(omap24xx_clks); c++)
-		if (c->cpu & cpu_mask) {
+		if (c->cpu & cpu_clkflg) {
 			clkdev_add(&c->lk);
 			clk_register(c->lk.clk);
 			omap2_init_clk_clkdm(c->lk.clk);


