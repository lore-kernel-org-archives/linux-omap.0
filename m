From: Vivien Chappelier <vivien.chappelier@free.fr>
Subject: [PATCH 4/12] Add OMAP730 clocks.
Date: Sat, 09 Jun 2007 19:24:08 +0200
Message-ID: <466AE238.7090806@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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
To: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Add missing clock definitions for the OMAP730/850 platform.

Signed-off-by: Vivien Chappelier <vivien.chappelier@free.fr>

---
 arch/arm/mach-omap1/clock.h |  115 
+++++++++++++++++++++++++++++++------------
 1 files changed, 83 insertions(+), 32 deletions(-)

diff --git a/arch/arm/mach-omap1/clock.h b/arch/arm/mach-omap1/clock.h
index 6eadf72..bdf4de2 100644
--- a/arch/arm/mach-omap1/clock.h
+++ b/arch/arm/mach-omap1/clock.h
@@ -154,7 +154,7 @@ static struct clk ck_ref = {
     .name        = "ck_ref",
     .rate        = 12000000,
     .flags        = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-              CLOCK_IN_OMAP310 | ALWAYS_ENABLED,
+              CLOCK_IN_OMAP730 | CLOCK_IN_OMAP310 | ALWAYS_ENABLED,
     .enable        = &omap1_clk_enable_generic,
     .disable    = &omap1_clk_disable_generic,
 };
@@ -163,7 +163,8 @@ static struct clk ck_dpll1 = {
     .name        = "ck_dpll1",
     .parent        = &ck_ref,
     .flags        = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-              CLOCK_IN_OMAP310 | RATE_PROPAGATES | ALWAYS_ENABLED,
+              CLOCK_IN_OMAP730 | CLOCK_IN_OMAP310 |
+              RATE_PROPAGATES | ALWAYS_ENABLED,
     .enable        = &omap1_clk_enable_generic,
     .disable    = &omap1_clk_disable_generic,
 };
@@ -172,8 +173,9 @@ static struct arm_idlect1_clk ck_dpll1out = {
     .clk = {
         .name        = "ck_dpll1out",
         .parent        = &ck_dpll1,
-        .flags        = CLOCK_IN_OMAP16XX | CLOCK_IDLE_CONTROL |
-                  ENABLE_REG_32BIT | RATE_PROPAGATES,
+        .flags        = CLOCK_IN_OMAP730 | CLOCK_IN_OMAP16XX |
+                  CLOCK_IDLE_CONTROL | ENABLE_REG_32BIT |
+                  RATE_PROPAGATES,
         .enable_reg    = (void __iomem *)ARM_IDLECT2,
         .enable_bit    = EN_CKOUT_ARM,
         .recalc        = &followparent_recalc,
@@ -200,8 +202,8 @@ static struct clk arm_ck = {
     .name        = "arm_ck",
     .parent        = &ck_dpll1,
     .flags        = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-              CLOCK_IN_OMAP310 | RATE_CKCTL | RATE_PROPAGATES |
-              ALWAYS_ENABLED,
+              CLOCK_IN_OMAP730 | CLOCK_IN_OMAP310 | RATE_CKCTL |
+              RATE_PROPAGATES | ALWAYS_ENABLED,
     .rate_offset    = CKCTL_ARMDIV_OFFSET,
     .recalc        = &omap1_ckctl_recalc,
     .enable        = &omap1_clk_enable_generic,
@@ -213,8 +215,8 @@ static struct arm_idlect1_clk armper_ck = {
         .name        = "armper_ck",
         .parent        = &ck_dpll1,
         .flags        = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-                  CLOCK_IN_OMAP310 | RATE_CKCTL |
-                  CLOCK_IDLE_CONTROL,
+                  CLOCK_IN_OMAP730 | CLOCK_IN_OMAP310 |
+                  RATE_CKCTL | CLOCK_IDLE_CONTROL,
         .enable_reg    = (void __iomem *)ARM_IDLECT2,
         .enable_bit    = EN_PERCK,
         .rate_offset    = CKCTL_PERDIV_OFFSET,
@@ -241,7 +243,8 @@ static struct arm_idlect1_clk armxor_ck = {
         .name        = "armxor_ck",
         .parent        = &ck_ref,
         .flags        = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-                  CLOCK_IN_OMAP310 | CLOCK_IDLE_CONTROL,
+                  CLOCK_IN_OMAP730 | CLOCK_IN_OMAP310 |
+                  CLOCK_IDLE_CONTROL,
         .enable_reg    = (void __iomem *)ARM_IDLECT2,
         .enable_bit    = EN_XORPCK,
         .recalc        = &followparent_recalc,
@@ -256,7 +259,8 @@ static struct arm_idlect1_clk armtim_ck = {
         .name        = "armtim_ck",
         .parent        = &ck_ref,
         .flags        = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-                  CLOCK_IN_OMAP310 | CLOCK_IDLE_CONTROL,
+                  CLOCK_IN_OMAP730 | CLOCK_IN_OMAP310 |
+                  CLOCK_IDLE_CONTROL,
         .enable_reg    = (void __iomem *)ARM_IDLECT2,
         .enable_bit    = EN_TIMCK,
         .recalc        = &followparent_recalc,
@@ -271,7 +275,8 @@ static struct arm_idlect1_clk armwdt_ck = {
         .name        = "armwdt_ck",
         .parent        = &ck_ref,
         .flags        = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-                  CLOCK_IN_OMAP310 | CLOCK_IDLE_CONTROL,
+                  CLOCK_IN_OMAP730 | CLOCK_IN_OMAP310 |
+                  CLOCK_IDLE_CONTROL,
         .enable_reg    = (void __iomem *)ARM_IDLECT2,
         .enable_bit    = EN_WDTCK,
         .recalc        = &omap1_watchdog_recalc,
@@ -284,7 +289,8 @@ static struct arm_idlect1_clk armwdt_ck = {
 static struct clk arminth_ck16xx = {
     .name        = "arminth_ck",
     .parent        = &arm_ck,
-    .flags        = CLOCK_IN_OMAP16XX | ALWAYS_ENABLED,
+    .flags        = CLOCK_IN_OMAP730 | CLOCK_IN_OMAP16XX |
+              ALWAYS_ENABLED,
     .recalc        = &followparent_recalc,
     /* Note: On 16xx the frequency can be divided by 2 by programming
      * ARM_CKCTL:ARM_INTHCK_SEL(14) to 1
@@ -298,7 +304,8 @@ static struct clk arminth_ck16xx = {
 static struct clk dsp_ck = {
     .name        = "dsp_ck",
     .parent        = &ck_dpll1,
-    .flags        = CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | 
CLOCK_IN_OMAP16XX |
+    .flags        = CLOCK_IN_OMAP310 |
+              CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
               RATE_CKCTL,
     .enable_reg    = (void __iomem *)ARM_CKCTL,
     .enable_bit    = EN_DSPCK,
@@ -311,7 +318,8 @@ static struct clk dsp_ck = {
 static struct clk dspmmu_ck = {
     .name        = "dspmmu_ck",
     .parent        = &ck_dpll1,
-    .flags        = CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | 
CLOCK_IN_OMAP16XX |
+    .flags        = CLOCK_IN_OMAP310 | CLOCK_IN_OMAP730 |
+              CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
               RATE_CKCTL | ALWAYS_ENABLED,
     .rate_offset    = CKCTL_DSPMMUDIV_OFFSET,
     .recalc        = &omap1_ckctl_recalc,
@@ -322,7 +330,8 @@ static struct clk dspmmu_ck = {
 static struct clk dspper_ck = {
     .name        = "dspper_ck",
     .parent        = &ck_dpll1,
-    .flags        = CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | 
CLOCK_IN_OMAP16XX |
+    .flags        = CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 |
+              CLOCK_IN_OMAP730 | CLOCK_IN_OMAP16XX |
               RATE_CKCTL | VIRTUAL_IO_ADDRESS,
     .enable_reg    = (void __iomem *)DSP_IDLECT2,
     .enable_bit    = EN_PERCK,
@@ -336,7 +345,8 @@ static struct clk dspper_ck = {
 static struct clk dspxor_ck = {
     .name        = "dspxor_ck",
     .parent        = &ck_ref,
-    .flags        = CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | 
CLOCK_IN_OMAP16XX |
+    .flags        = CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 |
+              CLOCK_IN_OMAP730 | CLOCK_IN_OMAP16XX |
               VIRTUAL_IO_ADDRESS,
     .enable_reg    = (void __iomem *)DSP_IDLECT2,
     .enable_bit    = EN_XORPCK,
@@ -348,7 +358,8 @@ static struct clk dspxor_ck = {
 static struct clk dsptim_ck = {
     .name        = "dsptim_ck",
     .parent        = &ck_ref,
-    .flags        = CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | 
CLOCK_IN_OMAP16XX |
+    .flags        = CLOCK_IN_OMAP310 | CLOCK_IN_OMAP730 |
+              CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
               VIRTUAL_IO_ADDRESS,
     .enable_reg    = (void __iomem *)DSP_IDLECT2,
     .enable_bit    = EN_DSPTIMCK,
@@ -403,7 +414,7 @@ static struct clk l3_ocpi_ck = {
     /* No-idle controlled by "tc_ck" */
     .name        = "l3_ocpi_ck",
     .parent        = &tc_ck.clk,
-    .flags        = CLOCK_IN_OMAP16XX,
+    .flags        = CLOCK_IN_OMAP730 | CLOCK_IN_OMAP16XX,
     .enable_reg    = (void __iomem *)ARM_IDLECT3,
     .enable_bit    = EN_OCPI_CK,
     .recalc        = &followparent_recalc,
@@ -414,7 +425,7 @@ static struct clk l3_ocpi_ck = {
 static struct clk tc1_ck = {
     .name        = "tc1_ck",
     .parent        = &tc_ck.clk,
-    .flags        = CLOCK_IN_OMAP16XX,
+    .flags        = CLOCK_IN_OMAP730 | CLOCK_IN_OMAP16XX,
     .enable_reg    = (void __iomem *)ARM_IDLECT3,
     .enable_bit    = EN_TC1_CK,
     .recalc        = &followparent_recalc,
@@ -425,7 +436,7 @@ static struct clk tc1_ck = {
 static struct clk tc2_ck = {
     .name        = "tc2_ck",
     .parent        = &tc_ck.clk,
-    .flags        = CLOCK_IN_OMAP16XX,
+    .flags        = CLOCK_IN_OMAP730 | CLOCK_IN_OMAP16XX,
     .enable_reg    = (void __iomem *)ARM_IDLECT3,
     .enable_bit    = EN_TC2_CK,
     .recalc        = &followparent_recalc,
@@ -438,7 +449,7 @@ static struct clk dma_ck = {
     .name        = "dma_ck",
     .parent        = &tc_ck.clk,
     .flags        = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-              CLOCK_IN_OMAP310 | ALWAYS_ENABLED,
+              CLOCK_IN_OMAP730 | CLOCK_IN_OMAP310 | ALWAYS_ENABLED,
     .recalc        = &followparent_recalc,
     .enable        = &omap1_clk_enable_generic,
     .disable    = &omap1_clk_disable_generic,
@@ -447,7 +458,8 @@ static struct clk dma_ck = {
 static struct clk dma_lcdfree_ck = {
     .name        = "dma_lcdfree_ck",
     .parent        = &tc_ck.clk,
-    .flags        = CLOCK_IN_OMAP16XX | ALWAYS_ENABLED,
+    .flags        = CLOCK_IN_OMAP730 | CLOCK_IN_OMAP16XX |
+              ALWAYS_ENABLED,
     .recalc        = &followparent_recalc,
     .enable        = &omap1_clk_enable_generic,
     .disable    = &omap1_clk_disable_generic,
@@ -458,7 +470,8 @@ static struct arm_idlect1_clk api_ck = {
         .name        = "api_ck",
         .parent        = &tc_ck.clk,
         .flags        = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-                  CLOCK_IN_OMAP310 | CLOCK_IDLE_CONTROL,
+                  CLOCK_IN_OMAP730 | CLOCK_IN_OMAP310 |
+                  CLOCK_IDLE_CONTROL,
         .enable_reg    = (void __iomem *)ARM_IDLECT2,
         .enable_bit    = EN_APICK,
         .recalc        = &followparent_recalc,
@@ -486,7 +499,8 @@ static struct arm_idlect1_clk lb_ck = {
 static struct clk rhea1_ck = {
     .name        = "rhea1_ck",
     .parent        = &tc_ck.clk,
-    .flags        = CLOCK_IN_OMAP16XX | ALWAYS_ENABLED,
+    .flags        = CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP730 |
+              ALWAYS_ENABLED,
     .recalc        = &followparent_recalc,
     .enable        = &omap1_clk_enable_generic,
     .disable    = &omap1_clk_disable_generic,
@@ -495,7 +509,8 @@ static struct clk rhea1_ck = {
 static struct clk rhea2_ck = {
     .name        = "rhea2_ck",
     .parent        = &tc_ck.clk,
-    .flags        = CLOCK_IN_OMAP16XX | ALWAYS_ENABLED,
+    .flags        = CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP730 |
+              ALWAYS_ENABLED,
     .recalc        = &followparent_recalc,
     .enable        = &omap1_clk_enable_generic,
     .disable    = &omap1_clk_disable_generic,
@@ -529,6 +544,16 @@ static struct arm_idlect1_clk lcd_ck_1510 = {
     .idlect_shift    = 3,
 };
 
+static struct clk uart1_730 = {
+    .name        = "uart1_ck",
+    .flags        = CLOCK_IN_OMAP730 | ENABLE_REG_32BIT |
+              CLOCK_NO_IDLE_PARENT,
+    .enable_reg    = (void __iomem *)SOFT_REQ_REG,
+    .enable_bit    = 9,
+    .enable        = &omap1_clk_enable_generic,
+    .disable    = &omap1_clk_disable_generic,
+};
+
 static struct clk uart1_1510 = {
     .name        = "uart1_ck",
     /* Direct from ULPD, no real parent */
@@ -577,6 +602,16 @@ static struct clk uart2_ck = {
     .disable    = &omap1_clk_disable_generic,
 };
 
+static struct clk uart2_730 = {
+    .name        = "uart2_ck",
+    .flags        = CLOCK_IN_OMAP730 | ENABLE_REG_32BIT |
+              CLOCK_NO_IDLE_PARENT,
+    .enable_reg    = (void __iomem *)SOFT_REQ_REG,
+    .enable_bit    = 11,
+    .enable        = &omap1_clk_enable_generic,
+    .disable    = &omap1_clk_disable_generic,
+};
+
 static struct clk uart3_1510 = {
     .name        = "uart3_ck",
     /* Direct from ULPD, no real parent */
@@ -638,7 +673,7 @@ static struct clk usb_hhc_ck16xx = {
     /* Direct from ULPD, no parent */
     .rate        = 48000000,
     /* OTG_SYSCON_2.OTG_PADEN == 0 (not 1510-compatible) */
-    .flags        = CLOCK_IN_OMAP16XX |
+    .flags        = CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP730 |
               RATE_FIXED | ENABLE_REG_32BIT,
     .enable_reg    = (void __iomem *)OTG_BASE + 0x08 /* OTG_SYSCON_2 */,
     .enable_bit    = 8 /* UHOST_EN */,
@@ -650,7 +685,7 @@ static struct clk usb_dc_ck = {
     .name        = "usb_dc_ck",
     /* Direct from ULPD, no parent */
     .rate        = 48000000,
-    .flags        = CLOCK_IN_OMAP16XX | RATE_FIXED,
+    .flags        = CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP730 | RATE_FIXED,
     .enable_reg    = (void __iomem *)SOFT_REQ_REG,
     .enable_bit    = 4,
     .enable        = &omap1_clk_enable_generic,
@@ -671,7 +706,7 @@ static struct clk mclk_1510 = {
 static struct clk mclk_16xx = {
     .name        = "mclk",
     /* Direct from ULPD, no parent. May be enabled by ext hardware. */
-    .flags        = CLOCK_IN_OMAP16XX,
+    .flags        = CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP730,
     .enable_reg    = (void __iomem *)COM_CLK_DIV_CTRL_SEL,
     .enable_bit    = COM_ULPD_PLL_CLK_REQ,
     .set_rate    = &omap1_set_ext_clk_rate,
@@ -693,7 +728,7 @@ static struct clk bclk_1510 = {
 static struct clk bclk_16xx = {
     .name        = "bclk",
     /* Direct from ULPD, no parent. May be enabled by ext hardware. */
-    .flags        = CLOCK_IN_OMAP16XX,
+    .flags        = CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP730,
     .enable_reg    = (void __iomem *)SWD_CLK_DIV_CTRL_SEL,
     .enable_bit    = SWD_ULPD_PLL_CLK_REQ,
     .set_rate    = &omap1_set_ext_clk_rate,
@@ -732,10 +767,22 @@ static struct clk mmc2_ck = {
     .disable    = &omap1_clk_disable_generic,
 };
 
+static struct clk mmc1_730 = {
+    .name        = "mmc_ck",
+    .id        = 1,
+    .flags        = CLOCK_IN_OMAP730 | ENABLE_REG_32BIT |
+              CLOCK_NO_IDLE_PARENT,
+    .enable_reg    = (void __iomem *)SOFT_REQ_REG,
+    .enable_bit    = 12,
+    .enable        = &omap1_clk_enable_generic,
+    .disable    = &omap1_clk_disable_generic,
+};
+
 static struct clk virtual_ck_mpu = {
     .name        = "mpu",
     .flags        = CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-              CLOCK_IN_OMAP310 | VIRTUAL_CLOCK | ALWAYS_ENABLED,
+              CLOCK_IN_OMAP310 | CLOCK_IN_OMAP730 |
+              VIRTUAL_CLOCK | ALWAYS_ENABLED,
     .parent        = &arm_ck, /* Is smarter alias for */
     .recalc        = &followparent_recalc,
     .set_rate    = &omap1_select_table_rate,
@@ -749,7 +796,8 @@ remains active during MPU idle whenever this is 
enabled */
 static struct clk i2c_fck = {
     .name        = "i2c_fck",
     .id        = 1,
-    .flags        = CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | 
CLOCK_IN_OMAP16XX |
+    .flags        = CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 |
+              CLOCK_IN_OMAP730 | CLOCK_IN_OMAP16XX |
               VIRTUAL_CLOCK | CLOCK_NO_IDLE_PARENT |
               ALWAYS_ENABLED,
     .parent        = &armxor_ck.clk,
@@ -761,7 +809,7 @@ static struct clk i2c_fck = {
 static struct clk i2c_ick = {
     .name        = "i2c_ick",
     .id        = 1,
-    .flags        = CLOCK_IN_OMAP16XX |
+    .flags        = CLOCK_IN_OMAP730 | CLOCK_IN_OMAP16XX |
               VIRTUAL_CLOCK | CLOCK_NO_IDLE_PARENT |
               ALWAYS_ENABLED,
     .parent        = &armper_ck.clk,
@@ -805,8 +853,10 @@ static struct clk * onchip_clks[] = {
     &lcd_ck_16xx,
     &lcd_ck_1510.clk,
     /* ULPD clocks */
+    &uart1_730,
     &uart1_1510,
     &uart1_16xx.clk,
+    &uart2_730,
     &uart2_ck,
     &uart3_1510,
     &uart3_16xx.clk,
@@ -817,6 +867,7 @@ static struct clk * onchip_clks[] = {
     &bclk_1510,  &bclk_16xx,
     &mmc1_ck,
     &mmc2_ck,
+    &mmc1_730,
     /* Virtual clocks */
     &virtual_ck_mpu,
     &i2c_fck,
-- 
1.5.1.3
