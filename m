From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH] ARM: OMAP: Fix PER_MOD ICLKs for 3430
Date: Tue, 20 Nov 2007 11:30:02 -0800
Message-ID: <1195587002-22871-1-git-send-email-khilman@mvista.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap@vger.kernel.org
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Several of the ICLKs which are in OMAP3430_PER_MOD were mistakenly
declared as being in WKUP_MOD.  Put them in to PER_MOD.

Signed-off-by: Kevin Hilman <khilman@mvista.com>
---
 arch/arm/mach-omap2/clock34xx.h |   36 ++++++++++++++++++------------------
 1 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index c081213..b8132a1 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -1820,7 +1820,7 @@ static struct clk per_l4_ick = {
 static struct clk gpio6_ick = {
 	.name		= "gpio6_ick",
 	.parent		= &per_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO6_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
 	.recalc		= &followparent_recalc,
@@ -1829,7 +1829,7 @@ static struct clk gpio6_ick = {
 static struct clk gpio5_ick = {
 	.name		= "gpio5_ick",
 	.parent		= &per_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO5_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
 	.recalc		= &followparent_recalc,
@@ -1838,7 +1838,7 @@ static struct clk gpio5_ick = {
 static struct clk gpio4_ick = {
 	.name		= "gpio4_ick",
 	.parent		= &per_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO4_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
 	.recalc		= &followparent_recalc,
@@ -1847,7 +1847,7 @@ static struct clk gpio4_ick = {
 static struct clk gpio3_ick = {
 	.name		= "gpio3_ick",
 	.parent		= &per_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO3_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
 	.recalc		= &followparent_recalc,
@@ -1856,7 +1856,7 @@ static struct clk gpio3_ick = {
 static struct clk gpio2_ick = {
 	.name		= "gpio2_ick",
 	.parent		= &per_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO2_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
 	.recalc		= &followparent_recalc,
@@ -1865,7 +1865,7 @@ static struct clk gpio2_ick = {
 static struct clk wdt3_ick = {
 	.name		= "wdt3_ick",
 	.parent		= &per_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_WDT3_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
 	.recalc		= &followparent_recalc,
@@ -1874,7 +1874,7 @@ static struct clk wdt3_ick = {
 static struct clk uart3_ick = {
 	.name		= "uart3_ick",
 	.parent		= &per_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_UART3_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
 	.recalc		= &followparent_recalc,
@@ -1883,7 +1883,7 @@ static struct clk uart3_ick = {
 static struct clk gpt9_ick = {
 	.name		= "gpt9_ick",
 	.parent		= &per_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPT9_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
 	.recalc		= &followparent_recalc,
@@ -1892,7 +1892,7 @@ static struct clk gpt9_ick = {
 static struct clk gpt8_ick = {
 	.name		= "gpt8_ick",
 	.parent		= &per_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPT8_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
 	.recalc		= &followparent_recalc,
@@ -1901,7 +1901,7 @@ static struct clk gpt8_ick = {
 static struct clk gpt7_ick = {
 	.name		= "gpt7_ick",
 	.parent		= &per_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPT7_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
 	.recalc		= &followparent_recalc,
@@ -1910,7 +1910,7 @@ static struct clk gpt7_ick = {
 static struct clk gpt6_ick = {
 	.name		= "gpt6_ick",
 	.parent		= &per_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPT6_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
 	.recalc		= &followparent_recalc,
@@ -1919,7 +1919,7 @@ static struct clk gpt6_ick = {
 static struct clk gpt5_ick = {
 	.name		= "gpt5_ick",
 	.parent		= &per_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPT5_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
 	.recalc		= &followparent_recalc,
@@ -1928,7 +1928,7 @@ static struct clk gpt5_ick = {
 static struct clk gpt4_ick = {
 	.name		= "gpt4_ick",
 	.parent		= &per_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPT4_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
 	.recalc		= &followparent_recalc,
@@ -1937,7 +1937,7 @@ static struct clk gpt4_ick = {
 static struct clk gpt3_ick = {
 	.name		= "gpt3_ick",
 	.parent		= &per_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPT3_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
 	.recalc		= &followparent_recalc,
@@ -1946,7 +1946,7 @@ static struct clk gpt3_ick = {
 static struct clk gpt2_ick = {
 	.name		= "gpt2_ick",
 	.parent		= &per_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPT2_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
 	.recalc		= &followparent_recalc,
@@ -1955,7 +1955,7 @@ static struct clk gpt2_ick = {
 static struct clk mcbsp2_ick = {
 	.name		= "mcbsp2_ick",
 	.parent		= &per_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_MCBSP2_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
 	.recalc		= &followparent_recalc,
@@ -1964,7 +1964,7 @@ static struct clk mcbsp2_ick = {
 static struct clk mcbsp3_ick = {
 	.name		= "mcbsp3_ick",
 	.parent		= &per_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_MCBSP3_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
 	.recalc		= &followparent_recalc,
@@ -1973,7 +1973,7 @@ static struct clk mcbsp3_ick = {
 static struct clk mcbsp4_ick = {
 	.name		= "mcbsp4_ick",
 	.parent		= &per_l4_ick,
-	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_MCBSP4_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
 	.recalc		= &followparent_recalc,
-- 
1.5.3.5
