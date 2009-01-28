From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH D 07/11] OMAP2/3 clock: add _omap2_clk_{read,write}_reg()
Date: Wed, 28 Jan 2009 12:18:36 -0700
Message-ID: <20090128191833.16688.37564.stgit@localhost.localdomain>
References: <20090128191638.16688.33452.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60959 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751727AbZA1U1d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Jan 2009 15:27:33 -0500
In-Reply-To: <20090128191638.16688.33452.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

Create new static functions to read/write registers used in the struct
clk, _omap2_clk_{read,write}_reg().  A subsequent patch will use these
to ensure the correct register read/write instruction is used, which depends
on whether the clock registers are in the CM, PRM, or SCM.

linux-omap source commit is 2d8ea5c30f091efa6258f5c9dac292835cd36412.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/clock.c |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 185e1b7..1662d85 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -28,6 +28,7 @@
 #include <mach/clockdomain.h>
 #include <mach/cpu.h>
 #include <mach/prcm.h>
+#include <mach/control.h>
 #include <asm/div64.h>
 
 #include "memory.h"
@@ -76,6 +77,42 @@ u8 cpu_mask;
  *-------------------------------------------------------------------------*/
 
 /*
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
+/*
  * _dpll_test_fint - test whether an Fint value is valid for the DPLL
  * @clk: DPLL struct clk to test
  * @n: divider value (N) to test


