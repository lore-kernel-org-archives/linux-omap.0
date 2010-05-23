From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 2/5 v2] ARM: mach-shmobile: add LCDC and MIPI DSI-Tx clock
 definitions to sh7372
Date: Sun, 23 May 2010 15:55:34 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1005231551420.3571@axis700.grange>
References: <Pine.LNX.4.64.1005201829260.26000@axis700.grange>
 <Pine.LNX.4.64.1005211700420.8450@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1005211700420.8450@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, "linux-fbdev, @vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Syrjala Ville (Nokia-D/Helsinki)" <ville.syrjala@nokia.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, Paul Mundt <lethal@linux-sh.org>
List-Id: linux-omap@vger.kernel.org

Define clock objects for switching on and off clocks for LCDC0, LCDC1 and MIPI
DSI-Tx.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v1 -> v2:

1. reimplemented based on the arm-shmobile clocking scheme v2. Please, 
verify, that this is ok now, also that the naming choise is suitable.

2. adjusted the subject line

 arch/arm/mach-shmobile/clock-sh7372.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-sh7372.c b/arch/arm/mach-shmobile/clock-sh7372.c
index ac46b4b..d6414ad 100644
--- a/arch/arm/mach-shmobile/clock-sh7372.c
+++ b/arch/arm/mach-shmobile/clock-sh7372.c
@@ -241,7 +241,10 @@ struct clk div6_clks[DIV6_NR] = {
 };
 
 enum { MSTP001,
-       MSTP131, MSTP130, MSTP129, MSTP128, MSTP116, MSTP106, MSTP101,
+       MSTP131, MSTP130,
+       MSTP129, MSTP128,
+       MSTP118, MSTP117, MSTP116,
+       MSTP106, MSTP101, MSTP100,
        MSTP223,
        MSTP207, MSTP206, MSTP204, MSTP203, MSTP202, MSTP201, MSTP200,
        MSTP329, MSTP323, MSTP322, MSTP314, MSTP313,
@@ -257,9 +260,12 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP130] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 30, 0), /* VEU2 */
 	[MSTP129] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 29, 0), /* VEU1 */
 	[MSTP128] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 28, 0), /* VEU0 */
+	[MSTP118] = MSTP(&div6_clks[DIV4_B], SMSTPCR1, 18, 0), /* DSITX */
+	[MSTP117] = MSTP(&div6_clks[DIV4_B], SMSTPCR1, 17, 0), /* LCDC1 */
 	[MSTP116] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR1, 16, 0), /* IIC0 */
 	[MSTP106] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 6, 0), /* JPU */
 	[MSTP101] = MSTP(&div4_clks[DIV4_M1], SMSTPCR1, 1, 0), /* VPU */
+	[MSTP100] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 0, 0), /* LCDC0 */
 	[MSTP223] = MSTP(&div6_clks[DIV6_SPU], SMSTPCR2, 23, 0), /* SPU2 */
 	[MSTP207] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR2, 7, 0), /* SCIFA5 */
 	[MSTP206] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR2, 6, 0), /* SCIFB */
@@ -335,9 +341,12 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("uio_pdrv_genirq.2", &mstp_clks[MSTP130]), /* VEU2 */
 	CLKDEV_DEV_ID("uio_pdrv_genirq.1", &mstp_clks[MSTP129]), /* VEU1 */
 	CLKDEV_DEV_ID("uio_pdrv_genirq.0", &mstp_clks[MSTP128]), /* VEU0 */
+	CLKDEV_DEV_ID("sh-mipi-dsi.0", &mstp_clks[MSTP118]), /* DSITX */
+	CLKDEV_DEV_ID("sh_mobile_lcdc_fb.1", &mstp_clks[MSTP117]), /* LCDC1 */
 	CLKDEV_DEV_ID("i2c-sh_mobile.0", &mstp_clks[MSTP116]), /* IIC0 */
 	CLKDEV_DEV_ID("uio_pdrv_genirq.5", &mstp_clks[MSTP106]), /* JPU */
 	CLKDEV_DEV_ID("uio_pdrv_genirq.0", &mstp_clks[MSTP101]), /* VPU */
+	CLKDEV_DEV_ID("sh_mobile_lcdc_fb.0", &mstp_clks[MSTP100]), /* LCDC0 */
 	CLKDEV_DEV_ID("uio_pdrv_genirq.6", &mstp_clks[MSTP223]), /* SPU2DSP0 */
 	CLKDEV_DEV_ID("uio_pdrv_genirq.7", &mstp_clks[MSTP223]), /* SPU2DSP1 */
 	CLKDEV_DEV_ID("sh-sci.5", &mstp_clks[MSTP207]), /* SCIFA5 */
-- 
1.6.2.4

