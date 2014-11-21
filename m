From: Vivek Gautam <gautam.vivek-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 08/11] clk: exynos7: Add required clock tree for USB
Date: Fri, 21 Nov 2014 19:05:51 +0530
Message-ID: <1416576954-11997-9-git-send-email-gautam.vivek@samsung.com>
References: <1416576954-11997-1-git-send-email-gautam.vivek@samsung.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1416576954-11997-1-git-send-email-gautam.vivek-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Vivek Gautam <gautam.vivek-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Adding required gate clocks for USB3.0 DRD controller
present on Exynos7.

Signed-off-by: Vivek Gautam <gautam.vivek-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/clk/samsung/clk-exynos7.c       |   64 +++++++++++++++++++++++++++++++
 include/dt-bindings/clock/exynos7-clk.h |    9 ++++-
 2 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-exynos7.c b/drivers/clk/samsung/clk-exynos7.c
index ea4483b..3128593 100644
--- a/drivers/clk/samsung/clk-exynos7.c
+++ b/drivers/clk/samsung/clk-exynos7.c
@@ -343,6 +343,8 @@ static struct samsung_mux_clock top1_mux_clks[] __initdata = {
 	MUX(0, "mout_aclk_fsys0_200", mout_top1_group1, MUX_SEL_TOP13, 28, 2),
 
 	MUX(0, "mout_sclk_mmc2", mout_top1_group1, MUX_SEL_TOP1_FSYS0, 24, 2),
+	MUX(0, "mout_sclk_usbdrd300", mout_top1_group1,
+		MUX_SEL_TOP1_FSYS0, 28, 2),
 
 	MUX(0, "mout_sclk_mmc1", mout_top1_group1, MUX_SEL_TOP1_FSYS1, 24, 2),
 	MUX(0, "mout_sclk_mmc0", mout_top1_group1, MUX_SEL_TOP1_FSYS1, 28, 2),
@@ -356,6 +358,8 @@ static struct samsung_div_clock top1_div_clks[] __initdata = {
 
 	DIV(DOUT_SCLK_MMC2, "dout_sclk_mmc2", "mout_sclk_mmc2",
 		DIV_TOP1_FSYS0, 24, 4),
+	DIV(0, "dout_sclk_usbdrd300", "mout_sclk_usbdrd300",
+		DIV_TOP1_FSYS0, 28, 4),
 
 	DIV(DOUT_SCLK_MMC1, "dout_sclk_mmc1", "mout_sclk_mmc1",
 		DIV_TOP1_FSYS1, 24, 4),
@@ -366,6 +370,8 @@ static struct samsung_div_clock top1_div_clks[] __initdata = {
 static struct samsung_gate_clock top1_gate_clks[] __initdata = {
 	GATE(CLK_SCLK_MMC2, "sclk_mmc2", "dout_sclk_mmc2",
 		ENABLE_SCLK_TOP1_FSYS0, 24, CLK_SET_RATE_PARENT, 0),
+	GATE(0, "sclk_usbdrd300", "dout_sclk_usbdrd300",
+		ENABLE_SCLK_TOP1_FSYS0, 28, 0, 0),
 
 	GATE(CLK_SCLK_MMC1, "sclk_mmc1", "dout_sclk_mmc1",
 		ENABLE_SCLK_TOP1_FSYS1, 24, CLK_SET_RATE_PARENT, 0),
@@ -647,7 +653,12 @@ CLK_OF_DECLARE(exynos7_clk_peris, "samsung,exynos7-clock-peris",
 /* Register Offset definitions for CMU_FSYS0 (0x10E90000) */
 #define MUX_SEL_FSYS00			0x0200
 #define MUX_SEL_FSYS01			0x0204
+#define MUX_SEL_FSYS02			0x0208
+#define ENABLE_ACLK_FSYS00		0x0800
 #define ENABLE_ACLK_FSYS01		0x0804
+#define ENABLE_SCLK_FSYS01		0x0A04
+#define ENABLE_SCLK_FSYS02		0x0A08
+#define ENABLE_SCLK_FSYS04		0x0A10
 
 /*
  * List of parent clocks for Muxes in CMU_FSYS0
@@ -655,10 +666,29 @@ CLK_OF_DECLARE(exynos7_clk_peris, "samsung,exynos7-clock-peris",
 PNAME(mout_aclk_fsys0_200_p)	= { "fin_pll", "dout_aclk_fsys0_200" };
 PNAME(mout_sclk_mmc2_p)		= { "fin_pll", "sclk_mmc2" };
 
+PNAME(mout_sclk_usbdrd300_p)	= { "fin_pll", "sclk_usbdrd300" };
+PNAME(mout_phyclk_usbdrd300_udrd30_phyclk_p)	= { "fin_pll",
+				"phyclk_usbdrd300_udrd30_phyclock" };
+PNAME(mout_phyclk_usbdrd300_udrd30_pipe_pclk_p)	= { "fin_pll",
+				"phyclk_usbdrd300_udrd30_pipe_pclk" };
+
+/* fixed rate clocks used in the FSYS0 block */
+struct samsung_fixed_rate_clock fixed_rate_clks_fsys0[] __initdata = {
+	FRATE(0, "phyclk_usbdrd300_udrd30_phyclock", NULL,
+		CLK_IS_ROOT, 60000000),
+	FRATE(0, "phyclk_usbdrd300_udrd30_pipe_pclk", NULL,
+		CLK_IS_ROOT, 125000000),
+};
+
 static unsigned long fsys0_clk_regs[] __initdata = {
 	MUX_SEL_FSYS00,
 	MUX_SEL_FSYS01,
+	MUX_SEL_FSYS02,
+	ENABLE_ACLK_FSYS00,
 	ENABLE_ACLK_FSYS01,
+	ENABLE_SCLK_FSYS01,
+	ENABLE_SCLK_FSYS02,
+	ENABLE_SCLK_FSYS04,
 };
 
 static struct samsung_mux_clock fsys0_mux_clks[] __initdata = {
@@ -666,11 +696,45 @@ static struct samsung_mux_clock fsys0_mux_clks[] __initdata = {
 		MUX_SEL_FSYS00, 24, 1),
 
 	MUX(0, "mout_sclk_mmc2_user", mout_sclk_mmc2_p, MUX_SEL_FSYS01, 24, 1),
+	MUX(0, "mout_sclk_usbdrd300_user", mout_sclk_usbdrd300_p,
+		MUX_SEL_FSYS01, 28, 1),
+
+	MUX(0, "mout_phyclk_usbdrd300_udrd30_pipe_pclk_user",
+		mout_phyclk_usbdrd300_udrd30_pipe_pclk_p,
+		MUX_SEL_FSYS02, 24, 1),
+	MUX(0, "mout_phyclk_usbdrd300_udrd30_phyclk_user",
+		mout_phyclk_usbdrd300_udrd30_phyclk_p,
+		MUX_SEL_FSYS02, 28, 1),
 };
 
 static struct samsung_gate_clock fsys0_gate_clks[] __initdata = {
+	GATE(ACLK_AXIUS_USBDRD30X_FSYS0X, "aclk_axius_usbdrd30x_fsys0x",
+		"mout_aclk_fsys0_200_user",
+		ENABLE_ACLK_FSYS00, 19, 0, 0),
+
+	GATE(ACLK_USBDRD300, "aclk_usbdrd300", "mout_aclk_fsys0_200_user",
+		ENABLE_ACLK_FSYS01, 29, 0, 0),
 	GATE(ACLK_MMC2, "aclk_mmc2", "mout_aclk_fsys0_200_user",
 		ENABLE_ACLK_FSYS01, 31, 0, 0),
+
+	GATE(SCLK_USBDRD300_SUSPENDCLK, "sclk_usbdrd300_suspendclk",
+		"mout_sclk_usbdrd300_user",
+		ENABLE_SCLK_FSYS01, 4, 0, 0),
+	GATE(SCLK_USBDRD300_REFCLK, "sclk_usbdrd300_refclk", "fin_pll",
+		ENABLE_SCLK_FSYS01, 8, 0, 0),
+
+	GATE(PHYCLK_USBDRD300_UDRD30_PIPE_PCLK_USER,
+		"phyclk_usbdrd300_udrd30_pipe_pclk_user",
+		"mout_phyclk_usbdrd300_udrd30_pipe_pclk_user",
+		ENABLE_SCLK_FSYS02, 24, 0, 0),
+	GATE(PHYCLK_USBDRD300_UDRD30_PHYCLK_USER,
+		"phyclk_usbdrd300_udrd30_phyclk_user",
+		"mout_phyclk_usbdrd300_udrd30_phyclk_user",
+		ENABLE_SCLK_FSYS02, 28, 0, 0),
+
+	GATE(OSCCLK_PHY_CLKOUT_USB30_PHY, "oscclk_phy_clkout_usb30_phy",
+		"fin_pll",
+		ENABLE_SCLK_FSYS04, 28, 0, 0),
 };
 
 static struct samsung_cmu_info fsys0_cmu_info __initdata = {
diff --git a/include/dt-bindings/clock/exynos7-clk.h b/include/dt-bindings/clock/exynos7-clk.h
index 8e4681b..eef2116 100644
--- a/include/dt-bindings/clock/exynos7-clk.h
+++ b/include/dt-bindings/clock/exynos7-clk.h
@@ -82,7 +82,14 @@
 
 /* FSYS0 */
 #define ACLK_MMC2			1
-#define FSYS0_NR_CLK			2
+#define ACLK_AXIUS_USBDRD30X_FSYS0X	2
+#define ACLK_USBDRD300			3
+#define SCLK_USBDRD300_SUSPENDCLK	4
+#define SCLK_USBDRD300_REFCLK		5
+#define PHYCLK_USBDRD300_UDRD30_PIPE_PCLK_USER		6
+#define PHYCLK_USBDRD300_UDRD30_PHYCLK_USER		7
+#define OSCCLK_PHY_CLKOUT_USB30_PHY		8
+#define FSYS0_NR_CLK			9
 
 /* FSYS1 */
 #define ACLK_MMC1			1
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
