From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/7] OMAP2xxx clock: fix broken cpu_mask code
Date: Tue, 14 Apr 2009 12:23:28 -0600
Message-ID: <20090414182327.22344.64686.stgit@localhost.localdomain>
References: <20090414182039.22344.49790.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45705 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755986AbZDNS1M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Apr 2009 14:27:12 -0400
In-Reply-To: <20090414182039.22344.49790.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Paul Walmsley <paul@pwsan.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org

Commit 8ad8ff6548f1c0bcbeaa02f274b3927c5015a921 breaks the OMAP2xxx
cpu_mask code, which causes OMAP2xxx to panic on boot.  Fix by
removing the cpu_mask auto variable and by changing CK_242X
and CK_243X to use RATE_IN_242X/RATE_IN_243X.

Resolves

<1>Unable to handle kernel NULL pointer dereference at virtual address 0000000c
<1>pgd = c0004000
<1>[0000000c] *pgd=00000000
Internal error: Oops: 5 [#1]
Modules linked in:
CPU: 0    Not tainted  (2.6.29-omap1 #32)
PC is at omap2_clk_set_parent+0x104/0x120
LR is at omap2_clk_set_parent+0x28/0x120

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Tested-by: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/mach-omap2/clock24xx.c |   12 +++---------
 1 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/clock24xx.c b/arch/arm/mach-omap2/clock24xx.c
index 3b7ecc6..4306392 100644
--- a/arch/arm/mach-omap2/clock24xx.c
+++ b/arch/arm/mach-omap2/clock24xx.c
@@ -60,8 +60,8 @@ struct omap_clk {
 		},			\
 	}
 
-#define CK_243X	(1 << 0)
-#define CK_242X	(1 << 1)
+#define CK_243X			RATE_IN_243X
+#define CK_242X			RATE_IN_242X
 
 static struct omap_clk omap24xx_clks[] = {
 	/* external root sources */
@@ -711,7 +711,7 @@ int __init omap2_clk_init(void)
 {
 	struct prcm_config *prcm;
 	struct omap_clk *c;
-	u32 clkrate, cpu_mask;
+	u32 clkrate;
 
 	if (cpu_is_omap242x())
 		cpu_mask = RATE_IN_242X;
@@ -730,12 +730,6 @@ int __init omap2_clk_init(void)
 	for (c = omap24xx_clks; c < omap24xx_clks + ARRAY_SIZE(omap24xx_clks); c++)
 		clk_init_one(c->lk.clk);
 
-	cpu_mask = 0;
-	if (cpu_is_omap2420())
-		cpu_mask |= CK_242X;
-	if (cpu_is_omap2430())
-		cpu_mask |= CK_243X;
-
 	for (c = omap24xx_clks; c < omap24xx_clks + ARRAY_SIZE(omap24xx_clks); c++)
 		if (c->cpu & cpu_mask) {
 			clkdev_add(&c->lk);


