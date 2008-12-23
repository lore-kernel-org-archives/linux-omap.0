From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 13/22] OMAP2xxx clock: consolidate DELAYED_APP clock commits;
	fix barrier
Date: Mon, 22 Dec 2008 23:38:38 -0700
Message-ID: <20081223063838.8542.66053.stgit@localhost.localdomain>
References: <20081223063709.8542.82882.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52898 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752523AbYLWGjt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Dec 2008 01:39:49 -0500
In-Reply-To: <20081223063709.8542.82882.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

Consolidate the commit code for DELAYED_APP clocks into a subroutine,
_omap2xxx_clk_commit().  Also convert the MPU barrier wmb() into an
OCP barrier, since with an MPU barrier, we have no guarantee that the
write actually reached the endpoint device.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock.c |   34 ++++++++++++++++++++++++----------
 1 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index d0caeef..78e14bf 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -120,6 +120,28 @@ static void _omap2_clk_write_reg(u32 v, u16 reg_offset, struct clk *clk)
 		cm_write_mod_reg(v, clk->prcm_mod, reg_offset);
 }
 
+/**
+ * _omap2xxx_clk_commit - commit clock parent/rate changes in hardware
+ * @clk: struct clk *
+ *
+ * If @clk has the DELAYED_APP flag set, meaning that parent/rate changes
+ * don't take effect until the VALID_CONFIG bit is written, write the
+ * VALID_CONFIG bit and wait for the write to complete.  No return value.
+ */
+static void _omap2xxx_clk_commit(struct clk *clk)
+{
+	if (!cpu_is_omap24xx())
+		return;
+
+	if (!(clk->flags & DELAYED_APP))
+		return;
+
+	prm_write_mod_reg(OMAP24XX_VALID_CONFIG, OMAP24XX_GR_MOD,
+			  OMAP24XX_PRCM_CLKCFG_CTRL_OFFSET);
+	/* OCP barrier */
+	prm_read_mod_reg(OMAP24XX_GR_MOD, OMAP24XX_PRCM_CLKCFG_CTRL_OFFSET);
+}
+
 /*
  * _dpll_test_fint - test whether an Fint value is valid for the DPLL
  * @clk: DPLL struct clk to test
@@ -757,11 +779,7 @@ int omap2_clksel_set_rate(struct clk *clk, unsigned long rate)
 
 	clk->rate = clk->parent->rate / new_div;
 
-	if (clk->flags & DELAYED_APP && cpu_is_omap24xx()) {
-		prm_write_mod_reg(OMAP24XX_VALID_CONFIG,
-			OMAP24XX_GR_MOD, OMAP24XX_PRCM_CLKCFG_CTRL_OFFSET);
-		wmb();
-	}
+	_omap2xxx_clk_commit(clk);
 
 	return 0;
 }
@@ -835,11 +853,7 @@ int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent)
 	_omap2_clk_write_reg(v, clk->clksel_reg, clk);
 	wmb();
 
-	if (clk->flags & DELAYED_APP && cpu_is_omap24xx()) {
-		prm_write_mod_reg(OMAP24XX_VALID_CONFIG,
-			OMAP24XX_GR_MOD, OMAP24XX_PRCM_CLKCFG_CTRL_OFFSET);
-		wmb();
-	}
+	_omap2xxx_clk_commit(clk);
 
 	if (clk->usecount > 0)
 		_omap2_clk_enable(clk);


