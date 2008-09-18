From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 05/11] OMAP2/3 clock: add _omap2_clk_{read,write}_reg()
Date: Thu, 18 Sep 2008 11:47:06 -0600
Message-ID: <20080918174703.7146.84730.stgit@localhost.localdomain>
References: <20080918174432.7146.21366.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:55112 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755239AbYIRRsI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Sep 2008 13:48:08 -0400
In-Reply-To: <20080918174432.7146.21366.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

Create new static functions to read/write registers used in the struct
clk, _omap2_clk_{read,write}_reg().  A subsequent patch will use these
to ensure the correct register read/write instruction is used, which depends
on whether the clock registers are in the CM, PRM, or SCM.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock.c |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 56065aa..2bdd587 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -29,6 +29,7 @@
 #include <mach/sram.h>
 #include <mach/cpu.h>
 #include <mach/prcm.h>
+#include <mach/control.h>
 #include <asm/div64.h>
 
 #include <mach/sdrc.h>
@@ -70,6 +71,43 @@ u8 cpu_mask;
  * OMAP2/3 specific clock functions
  *-------------------------------------------------------------------------*/
 
+/*
+ * _omap2_clk_read_reg - read a clock register
+ * @clk: struct clk *
+ *
+ * Given a struct clk *, returns the value of the clock's register.
+ */
+static u32 _omap2_clk_read_reg(u16 reg_offset, struct clk *clk)
+{
+	if (clk->prcm_mod & CLK_REG_IN_SCM)
+		return omap_ctrl_readl(reg_offset);
+	else if (clk->prcm_mod & CLK_REG_IN_PRM)
+		return prm_read_mod_reg(clk->prcm_mod & PRCM_MOD_ADDR_MASK,
+					reg_offset);
+	else
+		return cm_read_mod_reg(clk->prcm_mod, reg_offset);
+}
+
+/*
+ * _omap2_clk_write_reg - write a clock's register
+ * @v: value to write to the clock's enable_reg
+ * @clk: struct clk *
+ *
+ * Given a register value @v and struct clk * @clk, writes the value of @v to
+ * the clock's enable register.  No return value.
+ */
+static void _omap2_clk_write_reg(u32 v, u16 reg_offset, struct clk *clk)
+{
+	if (clk->prcm_mod & CLK_REG_IN_SCM)
+		omap_ctrl_writel(v, reg_offset);
+	else if (clk->prcm_mod & CLK_REG_IN_PRM)
+		prm_write_mod_reg(v, clk->prcm_mod & PRCM_MOD_ADDR_MASK,
+				  reg_offset);
+	else
+		cm_write_mod_reg(v, clk->prcm_mod, reg_offset);
+}
+
+
 /**
  * omap2_init_clk_clkdm - look up a clockdomain name, store pointer in clk
  * @clk: OMAP clock struct ptr to use


