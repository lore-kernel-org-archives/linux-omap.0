From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 10/28] omap2 clock: convert omap2_get_clksel to use new
	clksel struct
Date: Mon, 20 Aug 2007 03:53:57 -0600
Message-ID: <20070820095530.950860859@pwsan.com>
References: <20070820095347.933473149@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=convert_get_clksel.patch
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Convert omap2_get_clksel to use new struct clksel and struct
clksel_rate data.  Also fix its parameter order to conform with the
rest of the clock framework functions (i.e., struct clk first).

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/clock.c |   92 ++++++--------------------------------------
 1 file changed, 13 insertions(+), 79 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/clock.c
Index: linux-omap/arch/arm/mach-omap2/clock.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock.c
+++ linux-omap/arch/arm/mach-omap2/clock.c
@@ -787,89 +787,23 @@ static u32 omap2_divisor_to_clksel(struc
 	return clkr->val;
 }
 
-/*
- * Returns the CLKSEL divider register value
+/**
+ * omap2_get_clksel - find clksel register addr & field mask for a clk
+ * @clk: struct clk to use
+ * @field_mask: ptr to u32 to store the register field mask
+ *
+ * Returns the address of the clksel register upon success or NULL on error.
  */
-static void __iomem *omap2_get_clksel(u32 *field_mask, struct clk *clk)
+static void __iomem *omap2_get_clksel(struct clk *clk, u32 *field_mask)
 {
-	u32 div_off, mask = ~0;
-	void __iomem *div_addr = 0;
+	if (unlikely((clk->clksel_reg == 0) || (clk->clksel_mask == 0)))
+		return NULL;
 
-	div_off = clk->rate_offset;
+	*field_mask = clk->clksel_mask;
 
-	switch (clk->flags & SRC_RATE_SEL_MASK) {
-	case CM_MPU_SEL1:
-		div_addr = OMAP_CM_REGADDR(MPU_MOD, CM_CLKSEL);
-		mask = OMAP24XX_CLKSEL_MPU_MASK;
-		break;
-	case CM_DSP_SEL1:
-		div_addr = OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_CLKSEL);
-		if (cpu_is_omap2420()) {
-			if (div_off == OMAP24XX_CLKSEL_DSP_SHIFT)
-				mask = OMAP24XX_CLKSEL_DSP_MASK;
-			else if (div_off == OMAP2420_CLKSEL_IVA_SHIFT)
-				mask = OMAP2420_CLKSEL_IVA_MASK;
-			else if (div_off == OMAP24XX_CLKSEL_DSP_IF_SHIFT)
-				mask = OMAP24XX_CLKSEL_DSP_IF_MASK;
-		} else if (cpu_is_omap2430()) {
-			if (div_off == OMAP24XX_CLKSEL_DSP_SHIFT)
-				mask = OMAP24XX_CLKSEL_DSP_MASK;
-			else if (div_off == OMAP24XX_CLKSEL_DSP_IF_SHIFT)
-				mask = OMAP24XX_CLKSEL_DSP_IF_MASK;
-		}
-	case CM_GFX_SEL1:
-		div_addr = OMAP_CM_REGADDR(GFX_MOD, CM_CLKSEL);
-		if (div_off == OMAP_CLKSEL_GFX_SHIFT)
-			mask = OMAP_CLKSEL_GFX_MASK;
-		break;
-	case CM_MODEM_SEL1:
-		div_addr = OMAP_CM_REGADDR(OMAP2430_MDM_MOD, CM_CLKSEL);
-		if (div_off == OMAP2430_CLKSEL_MDM_SHIFT)
-			mask = OMAP2430_CLKSEL_MDM_MASK;
-		break;
-	case CM_SYSCLKOUT_SEL1:
-		div_addr = OMAP24XX_PRCM_CLKOUT_CTRL;
-		if (div_off == OMAP24XX_CLKOUT_DIV_SHIFT)
-			mask = OMAP24XX_CLKOUT_DIV_MASK;
-		else if (div_off == OMAP2420_CLKOUT2_DIV_SHIFT)
-			mask = OMAP2420_CLKOUT2_DIV_MASK;
-		break;
-	case CM_CORE_SEL1:
-		div_addr = OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1);
-		switch (div_off) {
-		case OMAP24XX_CLKSEL_L3_SHIFT:
-			mask = OMAP24XX_CLKSEL_L3_MASK;
-			break;
-		case OMAP24XX_CLKSEL_L4_SHIFT:
-			mask = OMAP24XX_CLKSEL_L4_MASK;
-			break;
-		case OMAP24XX_CLKSEL_DSS1_SHIFT:
-			mask = OMAP24XX_CLKSEL_DSS1_MASK;
-			break;
-		case OMAP24XX_CLKSEL_DSS2_SHIFT:
-			mask = OMAP24XX_CLKSEL_DSS2_MASK;
-			break;
-		case OMAP2420_CLKSEL_VLYNQ_SHIFT:
-			mask = OMAP2420_CLKSEL_VLYNQ_MASK;
-			break;
-		case OMAP24XX_CLKSEL_SSI_SHIFT:
-			mask = OMAP24XX_CLKSEL_SSI_MASK;
-			break;
-		case OMAP24XX_CLKSEL_USB_SHIFT:
-			mask = OMAP24XX_CLKSEL_USB_MASK;
-			break;
-		}
-	}
-
-	if (unlikely((mask == ~0) || (div_addr == 0)))
-		return 0;
-
-	*field_mask = mask;
-
-	return div_addr;
+	return clk->clksel_reg;
 }
 
-
 /**
  * omap2_clksel_get_divisor - get current divider applied to parent clock.
  * @clk: OMAP struct clk to use.
@@ -881,7 +815,7 @@ static u32 omap2_clksel_get_divisor(stru
 	u32 field_mask, field_val;
 	void __iomem *div_addr;
 
-	div_addr = omap2_get_clksel(&field_mask, clk);
+	div_addr = omap2_get_clksel(clk, &field_mask);
 	if (div_addr == 0)
 		return 0;
 
@@ -910,7 +844,7 @@ static int omap2_clk_set_rate(struct clk
 		if (validrate != rate)
 			return ret;
 
-		div_addr = omap2_get_clksel(&field_mask, clk);
+		div_addr = omap2_get_clksel(clk, &field_mask);
 		if (div_addr == 0)
 			return ret;
 

-- 
