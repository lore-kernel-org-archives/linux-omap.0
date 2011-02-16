From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 06/11] OMAP2420: clock: add sdrc_ick
Date: Tue, 15 Feb 2011 23:52:50 -0700
Message-ID: <20110216065248.22089.45836.stgit@twilight.localdomain>
References: <20110216065030.22089.61217.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47517 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751974Ab1BPGyD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Feb 2011 01:54:03 -0500
In-Reply-To: <20110216065030.22089.61217.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Add sdrc_ick to the OMAP2420 clock data so the clock code can control
the CM_AUTOIDLE bit associated with this clock.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock2420_data.c  |   16 ++++++++++++++++
 arch/arm/mach-omap2/cm-regbits-24xx.h |    1 +
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock2420_data.c b/arch/arm/mach-omap2/clock2420_data.c
index 30fbcbd..63ed481 100644
--- a/arch/arm/mach-omap2/clock2420_data.c
+++ b/arch/arm/mach-omap2/clock2420_data.c
@@ -1608,6 +1608,21 @@ static struct clk sdma_ick = {
 	.recalc		= &followparent_recalc,
 };
 
+/*
+ * The enable_reg/enable_bit in this clock is only used for CM_AUTOIDLE
+ * accesses derived from this data.
+ */
+static struct clk sdrc_ick = {
+	.name		= "sdrc_ick",
+	.ops		= &clkops_omap2_iclk_idle_only,
+	.parent		= &core_l3_ck,
+	.flags		= ENABLE_ON_INIT,
+	.clkdm_name	= "core_l3_clkdm",
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN3),
+	.enable_bit	= OMAP24XX_AUTO_SDRC_SHIFT,
+	.recalc		= &followparent_recalc,
+};
+
 static struct clk vlynq_ick = {
 	.name		= "vlynq_ick",
 	.ops		= &clkops_omap2_dflt_wait,
@@ -1869,6 +1884,7 @@ static struct omap_clk omap2420_clks[] = {
 	CLK(NULL,	"gpmc_fck",	&gpmc_fck,	CK_242X),
 	CLK(NULL,	"sdma_fck",	&sdma_fck,	CK_242X),
 	CLK(NULL,	"sdma_ick",	&sdma_ick,	CK_242X),
+	CLK(NULL,	"sdrc_ick",	&sdrc_ick,	CK_242X),
 	CLK(NULL,	"vlynq_ick",	&vlynq_ick,	CK_242X),
 	CLK(NULL,	"vlynq_fck",	&vlynq_fck,	CK_242X),
 	CLK(NULL,	"des_ick",	&des_ick,	CK_242X),
diff --git a/arch/arm/mach-omap2/cm-regbits-24xx.h b/arch/arm/mach-omap2/cm-regbits-24xx.h
index d70660e..409c813 100644
--- a/arch/arm/mach-omap2/cm-regbits-24xx.h
+++ b/arch/arm/mach-omap2/cm-regbits-24xx.h
@@ -210,6 +210,7 @@
 #define OMAP24XX_AUTO_USB_MASK				(1 << 0)
 
 /* CM_AUTOIDLE3_CORE */
+#define OMAP24XX_AUTO_SDRC_SHIFT			2
 #define OMAP24XX_AUTO_SDRC_MASK				(1 << 2)
 #define OMAP24XX_AUTO_GPMC_MASK				(1 << 1)
 #define OMAP24XX_AUTO_SDMA_MASK				(1 << 0)


