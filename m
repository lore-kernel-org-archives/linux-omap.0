From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: [PATCH] OMAP1: Add clock for the SOSSI
Date: Sun, 04 Mar 2007 12:35:42 +0100
Message-ID: <85irdhi6lt.fsf@orfeo.duckcorp.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--=-=-=


Due to the n800fb changes, the sossi video driver needs a new clock
called ck_sossi. This patch adds the sossi clock definitions made in
the n800 kernel from maemo.org.

Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>

--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline; filename=add_sossi_clk.patch

---
 arch/arm/mach-omap1/clock.c |   36 	35 +	1 -	0 !
 arch/arm/mach-omap1/clock.h |   18 	17 +	1 -	0 !
 2 files changed, 52 insertions(+), 2 deletions(-)

Index: linux-omap-2.6/arch/arm/mach-omap1/clock.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap1/clock.c	2007-03-02 21:55:31.000000000 +0100
+++ linux-omap-2.6/arch/arm/mach-omap1/clock.c	2007-03-03 17:27:50.000000000 +0100
@@ -49,6 +49,16 @@ static void omap1_uart_recalc(struct clk
 		clk->rate = 12000000;
 }
 
+static void omap1_sossi_recalc(struct clk *clk)
+{
+	u32 div = omap_readl(MOD_CONF_CTRL_1);
+
+	div = (div >> 17) & 0x7;
+	div++;
+	clk->rate = clk->parent->rate / div;
+}
+
+
 static int omap1_clk_enable_dsp_domain(struct clk *clk)
 {
 	int retval;
@@ -396,6 +406,31 @@ static int omap1_set_ext_clk_rate(struct
 	return 0;
 }
 
+static int omap1_set_sossi_rate(struct clk *clk, unsigned long rate)
+{
+	u32 l;
+	int div;
+	unsigned long p_rate;
+
+	p_rate = clk->parent->rate;
+	/* Round towards slower frequency */
+	div = (p_rate + rate - 1) / rate;
+	div--;
+	if (div < 0 || div > 7)
+		return -EINVAL;
+
+	l = omap_readl(MOD_CONF_CTRL_1);
+	l &= ~(7 << 17);
+	l |= div << 17;
+	omap_writel(l, MOD_CONF_CTRL_1);
+
+	clk->rate = p_rate / (div + 1);
+	if (unlikely(clk->flags & RATE_PROPAGATES))
+		propagate_rate(clk);
+
+	return 0;
+}
+
 static long omap1_round_ext_clk_rate(struct clk * clk, unsigned long rate)
 {
 	return 96000000 / calc_ext_dsor(rate);
@@ -617,7 +652,6 @@ static void __init omap1_clk_disable_unu
 	/* FIXME: This clock seems to be necessary but no-one
 	 * has asked for its activation. */
 	if (clk == &tc2_ck		// FIX: pm.c (SRAM), CCP, Camera
-	    || clk == &ck_dpll1out.clk	// FIX: SoSSI, SSR
 	    || clk == &arm_gpio_ck	// FIX: GPIO code for 1510
 		) {
 		printk(KERN_INFO "FIXME: Clock \"%s\" seems unused\n",
Index: linux-omap-2.6/arch/arm/mach-omap1/clock.h
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap1/clock.h	2007-03-02 21:55:31.000000000 +0100
+++ linux-omap-2.6/arch/arm/mach-omap1/clock.h	2007-03-03 17:27:50.000000000 +0100
@@ -23,6 +23,8 @@ static int omap1_clk_set_rate_dsp_domain
 static void omap1_clk_disable_dsp_domain(struct clk * clk);
 static int omap1_set_uart_rate(struct clk * clk, unsigned long rate);
 static void omap1_uart_recalc(struct clk * clk);
+static int omap1_set_sossi_rate(struct clk *clk, unsigned long rate);
+static void omap1_sossi_recalc(struct clk *clk);
 static int omap1_clk_enable_uart_functional(struct clk * clk);
 static void omap1_clk_disable_uart_functional(struct clk * clk);
 static int omap1_set_ext_clk_rate(struct clk * clk, unsigned long rate);
@@ -170,7 +172,8 @@ static struct arm_idlect1_clk ck_dpll1ou
 	.clk = {
 	       	.name		= "ck_dpll1out",
 		.parent		= &ck_dpll1,
-		.flags		= CLOCK_IN_OMAP16XX | CLOCK_IDLE_CONTROL,
+		.flags		= CLOCK_IN_OMAP16XX | CLOCK_IDLE_CONTROL |
+				  ENABLE_REG_32BIT | RATE_PROPAGATES,
 		.enable_reg	= (void __iomem *)ARM_IDLECT2,
 		.enable_bit	= EN_CKOUT_ARM,
 		.recalc		= &followparent_recalc,
@@ -179,6 +182,18 @@ static struct arm_idlect1_clk ck_dpll1ou
 	},
 	.idlect_shift	= 12,
 };
+static struct clk sossi_ck = {
+	.name           = "ck_sossi",
+	.parent         = &ck_dpll1out.clk,
+	.flags          = CLOCK_IN_OMAP16XX | CLOCK_NO_IDLE_PARENT |
+			  ENABLE_REG_32BIT,
+	.enable_reg     = (void __iomem *)MOD_CONF_CTRL_1,
+	.enable_bit     = 16,
+	.recalc         = &omap1_sossi_recalc,
+	.set_rate       = &omap1_set_sossi_rate,
+	.enable         = &omap1_clk_enable_generic,
+	.disable        = &omap1_clk_disable_generic,
+};
 
 static struct clk arm_ck = {
 	.name		= "arm_ck",
@@ -760,6 +775,7 @@ static struct clk * onchip_clks[] = {
 	&ck_dpll1,
 	/* CK_GEN1 clocks */
 	&ck_dpll1out.clk,
+	&sossi_ck,
 	&arm_ck,
 	&armper_ck.clk,
 	&arm_gpio_ck,

--=-=-=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--=-=-=--
