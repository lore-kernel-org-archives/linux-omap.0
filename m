From: Jean Pihet <jpihet@mvista.com>
Subject: [PATCH 1/2] OMAP3: add support for 2 SDRAM chip selects
Date: Tue, 16 Jun 2009 10:13:47 +0200
Message-ID: <200906161013.48013.jpihet@mvista.com>
References: <200906161011.33725.jpihet@mvista.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_8Q1NKUzc40gI0YS"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:13111 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751708AbZFPINs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Jun 2009 04:13:48 -0400
In-Reply-To: <200906161011.33725.jpihet@mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>

--Boundary-00=_8Q1NKUzc40gI0YS
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Some OMAP3 boards (Beagle Cx, Overo, RX51, Pandora) have 2
SDRAM parts connected to the SDRC.

This patch adds the following:
- add a new argument of type omap_sdrc_params struct*
to omap2_init_common_hw and omap2_sdrc_init for the 2nd CS params
- adapted the OMAP boards files to the new prototype of
omap2_init_common_hw
- add the SDRC 2nd CS registers offsets defines
- adapt the sram sleep code to configure the SDRC for the 2nd CS

Note: If the 2nd param to omap2_init_common_hw is NULL, then the
parameters are not programmed into the SDRC CS1 registers

Tested on 3430 SDP and Beagleboard rev C2 and B5, with
suspend/resume and frequency changes (cpufreq).

Signed-off-by: Jean Pihet <jpihet@mvista.com>
---
 arch/arm/mach-omap2/board-2430sdp.c      |    2 +-
 arch/arm/mach-omap2/board-3430sdp.c      |    2 +-
 arch/arm/mach-omap2/board-4430sdp.c      |    2 +-
 arch/arm/mach-omap2/board-apollon.c      |    2 +-
 arch/arm/mach-omap2/board-generic.c      |    2 +-
 arch/arm/mach-omap2/board-h4.c           |    2 +-
 arch/arm/mach-omap2/board-ldp.c          |    2 +-
 arch/arm/mach-omap2/board-n800.c         |    2 +-
 arch/arm/mach-omap2/board-omap3beagle.c  |    3 +-
 arch/arm/mach-omap2/board-omap3evm.c     |    2 +-
 arch/arm/mach-omap2/board-omap3pandora.c |    3 +-
 arch/arm/mach-omap2/board-overo.c        |    3 +-
 arch/arm/mach-omap2/board-rx51.c         |    2 +-
 arch/arm/mach-omap2/board-zoom2.c        |    2 +-
 arch/arm/mach-omap2/clock34xx.c          |   37 ++++++--
 arch/arm/mach-omap2/io.c                 |    5 +-
 arch/arm/mach-omap2/sdrc.c               |   63 +++++++++-----
 arch/arm/mach-omap2/sram34xx.S           |  137 
+++++++++++++++++++++++-------
 arch/arm/plat-omap/include/mach/io.h     |    3 +-
 arch/arm/plat-omap/include/mach/sdrc.h   |   11 ++-
 arch/arm/plat-omap/include/mach/sram.h   |   23 +++---
 arch/arm/plat-omap/sram.c                |   30 ++++---
 22 files changed, 237 insertions(+), 103 deletions(-)


--Boundary-00=_8Q1NKUzc40gI0YS
Content-Type: text/x-diff;
  charset="iso 8859-15";
  name="0001-OMAP3-add-support-for-2-SDRAM-chip-selects.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-OMAP3-add-support-for-2-SDRAM-chip-selects.patch"

=46rom 037d377794543a46112a7e797a27b5101f1509f0 Mon Sep 17 00:00:00 2001
=46rom: Jean Pihet <jpihet@mvista.com>
Date: Mon, 15 Jun 2009 21:22:00 +0200
Subject: [PATCH 1/2] OMAP3: add support for 2 SDRAM chip selects

Some OMAP3 boards (Beagle Cx, Overo, RX51, Pandora) have 2
SDRAM parts connected to the SDRC.

This patch adds the following:
=2D add a new argument of type omap_sdrc_params struct*
to omap2_init_common_hw and omap2_sdrc_init for the 2nd CS params
=2D adapted the OMAP boards files to the new prototype of
omap2_init_common_hw
=2D add the SDRC 2nd CS registers offsets defines
=2D adapt the sram sleep code to configure the SDRC for the 2nd CS

Note: If the 2nd param to omap2_init_common_hw is NULL, then the
parameters are not programmed into the SDRC CS1 registers

Tested on 3430 SDP and Beagleboard rev C2 and B5, with
suspend/resume and frequency changes (cpufreq).

Signed-off-by: Jean Pihet <jpihet@mvista.com>
=2D--
 arch/arm/mach-omap2/board-2430sdp.c      |    2 +-
 arch/arm/mach-omap2/board-3430sdp.c      |    2 +-
 arch/arm/mach-omap2/board-4430sdp.c      |    2 +-
 arch/arm/mach-omap2/board-apollon.c      |    2 +-
 arch/arm/mach-omap2/board-generic.c      |    2 +-
 arch/arm/mach-omap2/board-h4.c           |    2 +-
 arch/arm/mach-omap2/board-ldp.c          |    2 +-
 arch/arm/mach-omap2/board-n800.c         |    2 +-
 arch/arm/mach-omap2/board-omap3beagle.c  |    3 +-
 arch/arm/mach-omap2/board-omap3evm.c     |    2 +-
 arch/arm/mach-omap2/board-omap3pandora.c |    3 +-
 arch/arm/mach-omap2/board-overo.c        |    3 +-
 arch/arm/mach-omap2/board-rx51.c         |    2 +-
 arch/arm/mach-omap2/board-zoom2.c        |    2 +-
 arch/arm/mach-omap2/clock34xx.c          |   37 ++++++--
 arch/arm/mach-omap2/io.c                 |    5 +-
 arch/arm/mach-omap2/sdrc.c               |   63 +++++++++-----
 arch/arm/mach-omap2/sram34xx.S           |  137 +++++++++++++++++++++++---=
=2D---
 arch/arm/plat-omap/include/mach/io.h     |    3 +-
 arch/arm/plat-omap/include/mach/sdrc.h   |   11 ++-
 arch/arm/plat-omap/include/mach/sram.h   |   23 +++---
 arch/arm/plat-omap/sram.c                |   30 ++++---
 22 files changed, 237 insertions(+), 103 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/boar=
d-2430sdp.c
index 9c3fdcd..8ec2a13 100644
=2D-- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -141,7 +141,7 @@ static inline void board_smc91x_init(void)
=20
 static void __init omap_2430sdp_init_irq(void)
 {
=2D	omap2_init_common_hw(NULL);
+	omap2_init_common_hw(NULL, NULL);
 	omap_init_irq();
 	omap_gpio_init();
 }
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/boar=
d-3430sdp.c
index 21b4a52..765cb76 100644
=2D-- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -169,7 +169,7 @@ static struct platform_device *sdp3430_devices[] __init=
data =3D {
=20
 static void __init omap_3430sdp_init_irq(void)
 {
=2D	omap2_init_common_hw(hyb18m512160af6_sdrc_params);
+	omap2_init_common_hw(hyb18m512160af6_sdrc_params, NULL);
 	omap_init_irq();
 	omap_gpio_init();
 }
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/boar=
d-4430sdp.c
index 57e477b..b0c7402 100644
=2D-- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -59,7 +59,7 @@ static void __init gic_init_irq(void)
=20
 static void __init omap_4430sdp_init_irq(void)
 {
=2D	omap2_init_common_hw(NULL);
+	omap2_init_common_hw(NULL, NULL);
 #ifdef CONFIG_OMAP_32K_TIMER
 	omap2_gp_clockevent_set_gptimer(1);
 #endif
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/boar=
d-apollon.c
index 06dfba8..dcfc20d 100644
=2D-- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -250,7 +250,7 @@ out:
=20
 static void __init omap_apollon_init_irq(void)
 {
=2D	omap2_init_common_hw(NULL);
+	omap2_init_common_hw(NULL, NULL);
 	omap_init_irq();
 	omap_gpio_init();
 	apollon_init_smc91x();
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/boar=
d-generic.c
index 3492162..fd00aa0 100644
=2D-- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -33,7 +33,7 @@
=20
 static void __init omap_generic_init_irq(void)
 {
=2D	omap2_init_common_hw(NULL);
+	omap2_init_common_hw(NULL, NULL);
 	omap_init_irq();
 }
=20
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index e7d017c..7b1d61d 100644
=2D-- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -270,7 +270,7 @@ static void __init h4_init_flash(void)
=20
 static void __init omap_h4_init_irq(void)
 {
=2D	omap2_init_common_hw(NULL);
+	omap2_init_common_hw(NULL, NULL);
 	omap_init_irq();
 	omap_gpio_init();
 	h4_init_flash();
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ld=
p.c
index d8bc0a7..ea383f8 100644
=2D-- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -270,7 +270,7 @@ static inline void __init ldp_init_smsc911x(void)
=20
 static void __init omap_ldp_init_irq(void)
 {
=2D	omap2_init_common_hw(NULL);
+	omap2_init_common_hw(NULL, NULL);
 	omap_init_irq();
 	omap_gpio_init();
 	ldp_init_smsc911x();
diff --git a/arch/arm/mach-omap2/board-n800.c b/arch/arm/mach-omap2/board-n=
800.c
index 3b6bd31..f1b96cd 100644
=2D-- a/arch/arm/mach-omap2/board-n800.c
+++ b/arch/arm/mach-omap2/board-n800.c
@@ -142,7 +142,7 @@ static struct lm8323_platform_data lm8323_pdata =3D {
=20
 void __init nokia_n800_init_irq(void)
 {
=2D	omap2_init_common_hw(NULL);
+	omap2_init_common_hw(NULL, NULL);
 	omap_init_irq();
 	omap_gpio_init();
=20
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/=
board-omap3beagle.c
index b6a68d5..37cd4b7 100644
=2D-- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -282,7 +282,8 @@ static int __init omap3_beagle_i2c_init(void)
=20
 static void __init omap3_beagle_init_irq(void)
 {
=2D	omap2_init_common_hw(mt46h32m32lf6_sdrc_params);
+	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
+			     mt46h32m32lf6_sdrc_params);
 	omap_init_irq();
 #ifdef CONFIG_OMAP_32K_TIMER
 	omap2_gp_clockevent_set_gptimer(12);
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/boa=
rd-omap3evm.c
index 1b7a797..3bf38d7 100644
=2D-- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -279,7 +279,7 @@ struct spi_board_info omap3evm_spi_board_info[] =3D {
=20
 static void __init omap3_evm_init_irq(void)
 {
=2D	omap2_init_common_hw(mt46h32m32lf6_sdrc_params);
+	omap2_init_common_hw(mt46h32m32lf6_sdrc_params, NULL);
 	omap_init_irq();
 	omap_gpio_init();
 	omap3evm_init_smc911x();
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2=
/board-omap3pandora.c
index 85cc2a7..b19cc7b 100644
=2D-- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -310,7 +310,8 @@ static int __init omap3pandora_i2c_init(void)
=20
 static void __init omap3pandora_init_irq(void)
 {
=2D	omap2_init_common_hw(mt46h32m32lf6_sdrc_params);
+	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
+			     mt46h32m32lf6_sdrc_params);
 	omap_init_irq();
 	omap_gpio_init();
 }
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-=
overo.c
index 501d020..5932ff1 100644
=2D-- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -360,7 +360,8 @@ static int __init overo_i2c_init(void)
=20
 static void __init overo_init_irq(void)
 {
=2D	omap2_init_common_hw(mt46h32m32lf6_sdrc_params);
+	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
+			     mt46h32m32lf6_sdrc_params);
 	omap_init_irq();
 	omap_gpio_init();
 }
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-r=
x51.c
index 374ff63..591ae8a 100644
=2D-- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -61,7 +61,7 @@ static struct omap_board_config_kernel rx51_config[] =3D {
=20
 static void __init rx51_init_irq(void)
 {
=2D	omap2_init_common_hw(NULL);
+	omap2_init_common_hw(NULL, NULL);
 	omap_init_irq();
 	omap_gpio_init();
 }
diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/board-=
zoom2.c
index bcc0f76..427b7b8 100644
=2D-- a/arch/arm/mach-omap2/board-zoom2.c
+++ b/arch/arm/mach-omap2/board-zoom2.c
@@ -25,7 +25,7 @@
=20
 static void __init omap_zoom2_init_irq(void)
 {
=2D	omap2_init_common_hw(NULL);
+	omap2_init_common_hw(NULL, NULL);
 	omap_init_irq();
 	omap_gpio_init();
 }
diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34x=
x.c
index 045da92..1c6480d 100644
=2D-- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -725,7 +725,9 @@ static int omap3_core_dpll_m2_set_rate(struct clk *clk,=
 unsigned long rate)
 	u32 unlock_dll =3D 0;
 	u32 c;
 	unsigned long validrate, sdrcrate, mpurate;
=2D	struct omap_sdrc_params *sp;
+	struct omap_sdrc_params *sdrc_cs0;
+	struct omap_sdrc_params *sdrc_cs1;
+	int ret;
=20
 	if (!clk || !rate)
 		return -EINVAL;
@@ -743,8 +745,8 @@ static int omap3_core_dpll_m2_set_rate(struct clk *clk,=
 unsigned long rate)
 	else
 		sdrcrate >>=3D ((clk->rate / rate) >> 1);
=20
=2D	sp =3D omap2_sdrc_get_params(sdrcrate);
=2D	if (!sp)
+	ret =3D omap2_sdrc_get_params(sdrcrate, &sdrc_cs0, &sdrc_cs1);
+	if (ret)
 		return -EINVAL;
=20
 	if (sdrcrate < MIN_SDRC_DLL_LOCK_FREQ) {
@@ -765,12 +767,29 @@ static int omap3_core_dpll_m2_set_rate(struct clk *cl=
k, unsigned long rate)
=20
 	pr_debug("clock: changing CORE DPLL rate from %lu to %lu\n", clk->rate,
 		 validrate);
=2D	pr_debug("clock: SDRC timing params used: %08x %08x %08x\n",
=2D		 sp->rfr_ctrl, sp->actim_ctrla, sp->actim_ctrlb);
=2D
=2D	omap3_configure_core_dpll(sp->rfr_ctrl, sp->actim_ctrla,
=2D				  sp->actim_ctrlb, new_div, unlock_dll, c,
=2D				  sp->mr, rate > clk->rate);
+	pr_debug("clock: SDRC CS0 timing params used:"
+		 " RFR %08x CTRLA %08x CTRLB %08x MR %08x\n",
+		 sdrc_cs0->rfr_ctrl, sdrc_cs0->actim_ctrla,
+		 sdrc_cs0->actim_ctrlb, sdrc_cs0->mr);
+	if (sdrc_cs1)
+		pr_debug("clock: SDRC CS1 timing params used: "
+		 " RFR %08x CTRLA %08x CTRLB %08x MR %08x\n",
+		 sdrc_cs1->rfr_ctrl, sdrc_cs1->actim_ctrla,
+		 sdrc_cs1->actim_ctrlb, sdrc_cs1->mr);
+
+	if (sdrc_cs1)
+		omap3_configure_core_dpll(
+				  new_div, unlock_dll, c, rate > clk->rate,
+				  sdrc_cs0->rfr_ctrl, sdrc_cs0->actim_ctrla,
+				  sdrc_cs0->actim_ctrlb, sdrc_cs0->mr,
+				  sdrc_cs1->rfr_ctrl, sdrc_cs1->actim_ctrla,
+				  sdrc_cs1->actim_ctrlb, sdrc_cs1->mr);
+	else
+		omap3_configure_core_dpll(
+				  new_div, unlock_dll, c, rate > clk->rate,
+				  sdrc_cs0->rfr_ctrl, sdrc_cs0->actim_ctrla,
+				  sdrc_cs0->actim_ctrlb, sdrc_cs0->mr,
+				  0, 0, 0, 0);
=20
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 3a86b0f..e9b9bcb 100644
=2D-- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -276,14 +276,15 @@ static int __init _omap2_init_reprogram_sdrc(void)
 	return v;
 }
=20
=2Dvoid __init omap2_init_common_hw(struct omap_sdrc_params *sp)
+void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
+				 struct omap_sdrc_params *sdrc_cs1)
 {
 	omap2_mux_init();
 #ifndef CONFIG_ARCH_OMAP4 /* FIXME: Remove this once the clkdev is ready */
 	pwrdm_init(powerdomains_omap);
 	clkdm_init(clockdomains_omap, clkdm_pwrdm_autodeps);
 	omap2_clk_init();
=2D	omap2_sdrc_init(sp);
+	omap2_sdrc_init(sdrc_cs0, sdrc_cs1);
 	_omap2_init_reprogram_sdrc();
 #endif
 	gpmc_init();
diff --git a/arch/arm/mach-omap2/sdrc.c b/arch/arm/mach-omap2/sdrc.c
index 2045441..2e9e38d 100644
=2D-- a/arch/arm/mach-omap2/sdrc.c
+++ b/arch/arm/mach-omap2/sdrc.c
@@ -32,7 +32,7 @@
 #include <mach/sdrc.h>
 #include "sdrc.h"
=20
=2Dstatic struct omap_sdrc_params *sdrc_init_params;
+static struct omap_sdrc_params *sdrc_init_params_cs0, *sdrc_init_params_cs=
1;
=20
 void __iomem *omap2_sdrc_base;
 void __iomem *omap2_sms_base;
@@ -45,33 +45,49 @@ void __iomem *omap2_sms_base;
 /**
  * omap2_sdrc_get_params - return SDRC register values for a given clock r=
ate
  * @r: SDRC clock rate (in Hz)
+ * @sdrc_cs0: chip select 0 ram timings **
+ * @sdrc_cs1: chip select 1 ram timings **
  *
  * Return pre-calculated values for the SDRC_ACTIM_CTRLA,
=2D * SDRC_ACTIM_CTRLB, SDRC_RFR_CTRL, and SDRC_MR registers, for a given
=2D * SDRC clock rate 'r'.  These parameters control various timing
=2D * delays in the SDRAM controller that are expressed in terms of the
=2D * number of SDRC clock cycles to wait; hence the clock rate
=2D * dependency. Note that sdrc_init_params must be sorted rate
=2D * descending.  Also assumes that both chip-selects use the same
=2D * timing parameters.  Returns a struct omap_sdrc_params * upon
=2D * success, or NULL upon failure.
+ *  SDRC_ACTIM_CTRLB, SDRC_RFR_CTRL and SDRC_MR registers in sdrc_cs[01]
+ *  structs,for a given SDRC clock rate 'r'.
+ * These parameters control various timing delays in the SDRAM controller
+ *  that are expressed in terms of the number of SDRC clock cycles to
+ *  wait; hence the clock rate dependency.
+ *
+ * Supports 2 different timing parameters for both chip selects.
+ *
+ * Note 1: the sdrc_init_params_cs[01] must be sorted rate descending.
+ * Note 2: If sdrc_init_params_cs_1 is not NULL it must be of same size
+ *  as sdrc_init_params_cs_0.
+ *
+ * Fills in the struct omap_sdrc_params * for each chip select.
+ * Returns 0 upon success or -1 upon failure.
  */
=2Dstruct omap_sdrc_params *omap2_sdrc_get_params(unsigned long r)
+int omap2_sdrc_get_params(unsigned long r,
+			  struct omap_sdrc_params **sdrc_cs0,
+			  struct omap_sdrc_params **sdrc_cs1)
 {
=2D	struct omap_sdrc_params *sp;
+	struct omap_sdrc_params *sp0, *sp1;
=20
=2D	if (!sdrc_init_params)
=2D		return NULL;
+	if (!sdrc_init_params_cs0)
+		return -1;
=20
=2D	sp =3D sdrc_init_params;
+	sp0 =3D sdrc_init_params_cs0;
+	sp1 =3D sdrc_init_params_cs1;
=20
=2D	while (sp->rate && sp->rate !=3D r)
=2D		sp++;
+	while (sp0->rate && sp0->rate !=3D r) {
+		sp0++;
+		if (sdrc_init_params_cs1)
+			sp1++;
+	}
=20
=2D	if (!sp->rate)
=2D		return NULL;
+	if (!sp0->rate)
+		return -1;
=20
=2D	return sp;
+	*sdrc_cs0 =3D sp0;
+	*sdrc_cs1 =3D sp1;
+	return 0;
 }
=20
=20
@@ -83,13 +99,15 @@ void __init omap2_set_globals_sdrc(struct omap_globals =
*omap2_globals)
=20
 /**
  * omap2_sdrc_init - initialize SMS, SDRC devices on boot
=2D * @sp: pointer to a null-terminated list of struct omap_sdrc_params
+ * @sdrc_cs[01]: pointers to a null-terminated list of struct omap_sdrc_pa=
rams
+ *  Support for 2 chip selects timings
  *
  * Turn on smart idle modes for SDRAM scheduler and controller.
  * Program a known-good configuration for the SDRC to deal with buggy
  * bootloaders.
  */
=2Dvoid __init omap2_sdrc_init(struct omap_sdrc_params *sp)
+void __init omap2_sdrc_init(struct omap_sdrc_params *sdrc_cs0,
+			    struct omap_sdrc_params *sdrc_cs1)
 {
 	u32 l;
=20
@@ -103,7 +121,8 @@ void __init omap2_sdrc_init(struct omap_sdrc_params *sp)
 	l |=3D (0x2 << 3);
 	sdrc_write_reg(l, SDRC_SYSCONFIG);
=20
=2D	sdrc_init_params =3D sp;
+	sdrc_init_params_cs0 =3D sdrc_cs0;
+	sdrc_init_params_cs1 =3D sdrc_cs1;
=20
 	/* XXX Enable SRFRONIDLEREQ here also? */
 	l =3D (1 << SDRC_POWER_EXTCLKDIS_SHIFT) |
diff --git a/arch/arm/mach-omap2/sram34xx.S b/arch/arm/mach-omap2/sram34xx.S
index f41f8d9..3aef744 100644
=2D-- a/arch/arm/mach-omap2/sram34xx.S
+++ b/arch/arm/mach-omap2/sram34xx.S
@@ -36,7 +36,7 @@
=20
 	.text
=20
=2D/* r4 parameters */
+/* r1 parameters */
 #define SDRC_NO_UNLOCK_DLL		0x0
 #define SDRC_UNLOCK_DLL			0x1
=20
@@ -71,40 +71,71 @@
=20
 /*
  * omap3_sram_configure_core_dpll - change DPLL3 M2 divider
=2D * r0 =3D new SDRC_RFR_CTRL register contents
=2D * r1 =3D new SDRC_ACTIM_CTRLA register contents
=2D * r2 =3D new SDRC_ACTIM_CTRLB register contents
=2D * r3 =3D new M2 divider setting (only 1 and 2 supported right now)
=2D * r4 =3D unlock SDRC DLL? (1 =3D yes, 0 =3D no).  Only unlock DLL for
+ *
+ * Params passed in registers:
+ *  r0 =3D new M2 divider setting (only 1 and 2 supported right now)
+ *  r1 =3D unlock SDRC DLL? (1 =3D yes, 0 =3D no).  Only unlock DLL for
  *      SDRC rates < 83MHz
=2D * r5 =3D number of MPU cycles to wait for SDRC to stabilize after
+ *  r2 =3D number of MPU cycles to wait for SDRC to stabilize after
  *      reprogramming the SDRC when switching to a slower MPU speed
=2D * r6 =3D new SDRC_MR_0 register value
=2D * r7 =3D increasing SDRC rate? (1 =3D yes, 0 =3D no)
+ *  r3 =3D increasing SDRC rate? (1 =3D yes, 0 =3D no)
+ *
+ * Params passed via the stack. The needed params will be copied in SRAM
+ *  before use by the code in SRAM (SDRAM is not accessible during SDRC
+ *  reconfiguration):
+ *  new SDRC_RFR_CTRL_0 register contents
+ *  new SDRC_ACTIM_CTRL_A_0 register contents
+ *  new SDRC_ACTIM_CTRL_B_0 register contents
+ *  new SDRC_MR_0 register value
+ *  new SDRC_RFR_CTRL_1 register contents
+ *  new SDRC_ACTIM_CTRL_A_1 register contents
+ *  new SDRC_ACTIM_CTRL_B_1 register contents
+ *  new SDRC_MR_1 register value
  *
+ * If the param SDRC_RFR_CTRL_1 is 0, the parameters
+ *  are not programmed into the SDRC CS1 registers
  */
 ENTRY(omap3_sram_configure_core_dpll)
 	stmfd	sp!, {r1-r12, lr}	@ store regs to stack
=2D	ldr	r4, [sp, #52]		@ pull extra args off the stack
=2D	ldr	r5, [sp, #56]		@ load extra args from the stack
=2D	ldr	r6, [sp, #60]		@ load extra args from the stack
=2D	ldr	r7, [sp, #64]		@ load extra args from the stack
+
+					@ pull the extra args off the stack
+					@  and store them in SRAM
+	ldr	r4, [sp, #52]
+	str     r4, omap_sdrc_rfr_ctrl_0_val
+	ldr	r4, [sp, #56]
+	str     r4, omap_sdrc_actim_ctrl_a_0_val
+	ldr	r4, [sp, #60]
+	str     r4, omap_sdrc_actim_ctrl_b_0_val
+	ldr	r4, [sp, #64]
+	str     r4, omap_sdrc_mr_0_val
+	ldr	r4, [sp, #68]
+	str     r4, omap_sdrc_rfr_ctrl_1_val
+	cmp	r4, #0			@ if SDRC_RFR_CTRL_1 is 0,
+	beq	skip_cs1_params		@  do not use cs1 params
+	ldr	r4, [sp, #72]
+	str     r4, omap_sdrc_actim_ctrl_a_1_val
+	ldr	r4, [sp, #76]
+	str     r4, omap_sdrc_actim_ctrl_b_1_val
+	ldr	r4, [sp, #80]
+	str     r4, omap_sdrc_mr_1_val
+skip_cs1_params:
 	dsb				@ flush buffered writes to interconnect
=2D	cmp	r7, #1			@ if increasing SDRC clk rate,
+
+	cmp	r3, #1			@ if increasing SDRC clk rate,
 	bleq	configure_sdrc		@ program the SDRC regs early (for RFR)
=2D	cmp	r4, #SDRC_UNLOCK_DLL	@ set the intended DLL state
+	cmp	r1, #SDRC_UNLOCK_DLL	@ set the intended DLL state
 	bleq	unlock_dll
 	blne	lock_dll
 	bl	sdram_in_selfrefresh	@ put SDRAM in self refresh, idle SDRC
 	bl 	configure_core_dpll	@ change the DPLL3 M2 divider
 	bl	enable_sdrc		@ take SDRC out of idle
=2D	cmp	r4, #SDRC_UNLOCK_DLL	@ wait for DLL status to change
+	cmp	r1, #SDRC_UNLOCK_DLL	@ wait for DLL status to change
 	bleq	wait_dll_unlock
 	blne	wait_dll_lock
=2D	cmp	r7, #1			@ if increasing SDRC clk rate,
+	cmp	r3, #1			@ if increasing SDRC clk rate,
 	beq	return_to_sdram		@ return to SDRAM code, otherwise,
 	bl	configure_sdrc		@ reprogram SDRC regs now
=2D	mov	r12, r5
+	mov	r12, r2
 	bl	wait_clk_stable		@ wait for SDRC to stabilize
 return_to_sdram:
 	isb				@ prevent speculative exec past here
@@ -149,7 +180,7 @@ configure_core_dpll:
 	ldr	r12, [r11]
 	ldr	r10, core_m2_mask_val	@ modify m2 for core dpll
 	and	r12, r12, r10
=2D	orr	r12, r12, r3, lsl #CORE_DPLL_CLKOUT_DIV_SHIFT
+	orr	r12, r12, r0, lsl #CORE_DPLL_CLKOUT_DIV_SHIFT
 	str	r12, [r11]
 	ldr	r12, [r11]		@ posted-write barrier for CM
 	bx	lr
@@ -187,15 +218,34 @@ wait_dll_unlock:
 	bne	wait_dll_unlock
 	bx	lr
 configure_sdrc:
=2D	ldr	r11, omap3_sdrc_rfr_ctrl
=2D	str	r0, [r11]
=2D	ldr	r11, omap3_sdrc_actim_ctrla
=2D	str	r1, [r11]
=2D	ldr	r11, omap3_sdrc_actim_ctrlb
=2D	str	r2, [r11]
+	ldr	r12, omap_sdrc_rfr_ctrl_0_val	@ fetch value from SRAM
+	ldr	r11, omap3_sdrc_rfr_ctrl_0	@ fetch addr from SRAM
+	str	r12, [r11]			@ store
+	ldr	r12, omap_sdrc_actim_ctrl_a_0_val
+	ldr	r11, omap3_sdrc_actim_ctrl_a_0
+	str	r12, [r11]
+	ldr	r12, omap_sdrc_actim_ctrl_b_0_val
+	ldr	r11, omap3_sdrc_actim_ctrl_b_0
+	str	r12, [r11]
+	ldr	r12, omap_sdrc_mr_0_val
 	ldr	r11, omap3_sdrc_mr_0
=2D	str	r6, [r11]
=2D	ldr	r6, [r11]		@ posted-write barrier for SDRC
+	str	r12, [r11]
+	ldr	r12, omap_sdrc_rfr_ctrl_1_val
+	cmp	r12, #0			@ if SDRC_RFR_CTRL_1 is 0,
+	beq	skip_cs1_prog		@  do not program cs1 params
+	ldr	r11, omap3_sdrc_rfr_ctrl_1
+	str	r12, [r11]
+	ldr	r12, omap_sdrc_actim_ctrl_a_1_val
+	ldr	r11, omap3_sdrc_actim_ctrl_a_1
+	str	r12, [r11]
+	ldr	r12, omap_sdrc_actim_ctrl_b_1_val
+	ldr	r11, omap3_sdrc_actim_ctrl_b_1
+	str	r12, [r11]
+	ldr	r12, omap_sdrc_mr_1_val
+	ldr	r11, omap3_sdrc_mr_1
+	str	r12, [r11]
+skip_cs1_prog:
+	ldr	r12, [r11]		@ posted-write barrier for SDRC
 	bx	lr
=20
 omap3_sdrc_power:
@@ -206,14 +256,40 @@ omap3_cm_idlest1_core:
 	.word OMAP34XX_CM_REGADDR(CORE_MOD, CM_IDLEST)
 omap3_cm_iclken1_core:
 	.word OMAP34XX_CM_REGADDR(CORE_MOD, CM_ICLKEN1)
=2Domap3_sdrc_rfr_ctrl:
+
+omap3_sdrc_rfr_ctrl_0:
 	.word OMAP34XX_SDRC_REGADDR(SDRC_RFR_CTRL_0)
=2Domap3_sdrc_actim_ctrla:
+omap3_sdrc_rfr_ctrl_1:
+	.word OMAP34XX_SDRC_REGADDR(SDRC_RFR_CTRL_1)
+omap3_sdrc_actim_ctrl_a_0:
 	.word OMAP34XX_SDRC_REGADDR(SDRC_ACTIM_CTRL_A_0)
=2Domap3_sdrc_actim_ctrlb:
+omap3_sdrc_actim_ctrl_a_1:
+	.word OMAP34XX_SDRC_REGADDR(SDRC_ACTIM_CTRL_A_1)
+omap3_sdrc_actim_ctrl_b_0:
 	.word OMAP34XX_SDRC_REGADDR(SDRC_ACTIM_CTRL_B_0)
+omap3_sdrc_actim_ctrl_b_1:
+	.word OMAP34XX_SDRC_REGADDR(SDRC_ACTIM_CTRL_B_1)
 omap3_sdrc_mr_0:
 	.word OMAP34XX_SDRC_REGADDR(SDRC_MR_0)
+omap3_sdrc_mr_1:
+	.word OMAP34XX_SDRC_REGADDR(SDRC_MR_1)
+omap_sdrc_rfr_ctrl_0_val:
+	.word 0xDEADBEEF
+omap_sdrc_rfr_ctrl_1_val:
+	.word 0xDEADBEEF
+omap_sdrc_actim_ctrl_a_0_val:
+	.word 0xDEADBEEF
+omap_sdrc_actim_ctrl_a_1_val:
+	.word 0xDEADBEEF
+omap_sdrc_actim_ctrl_b_0_val:
+	.word 0xDEADBEEF
+omap_sdrc_actim_ctrl_b_1_val:
+	.word 0xDEADBEEF
+omap_sdrc_mr_0_val:
+	.word 0xDEADBEEF
+omap_sdrc_mr_1_val:
+	.word 0xDEADBEEF
+
 omap3_sdrc_dlla_status:
 	.word OMAP34XX_SDRC_REGADDR(SDRC_DLLA_STATUS)
 omap3_sdrc_dlla_ctrl:
@@ -223,3 +299,4 @@ core_m2_mask_val:
=20
 ENTRY(omap3_sram_configure_core_dpll_sz)
 	.word	. - omap3_sram_configure_core_dpll
+
diff --git a/arch/arm/plat-omap/include/mach/io.h b/arch/arm/plat-omap/incl=
ude/mach/io.h
index 3b28147..d8eadae 100644
=2D-- a/arch/arm/plat-omap/include/mach/io.h
+++ b/arch/arm/plat-omap/include/mach/io.h
@@ -228,7 +228,8 @@ extern void omap1_map_common_io(void);
 extern void omap1_init_common_hw(void);
=20
 extern void omap2_map_common_io(void);
=2Dextern void omap2_init_common_hw(struct omap_sdrc_params *sp);
+extern void omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
+				 struct omap_sdrc_params *sdrc_cs1);
=20
 #define __arch_ioremap(p,s,t)	omap_ioremap(p,s,t)
 #define __arch_iounmap(v)	omap_iounmap(v)
diff --git a/arch/arm/plat-omap/include/mach/sdrc.h b/arch/arm/plat-omap/in=
clude/mach/sdrc.h
index adc7352..0be18e4 100644
=2D-- a/arch/arm/plat-omap/include/mach/sdrc.h
+++ b/arch/arm/plat-omap/include/mach/sdrc.h
@@ -30,6 +30,10 @@
 #define SDRC_ACTIM_CTRL_A_0	0x09c
 #define SDRC_ACTIM_CTRL_B_0	0x0a0
 #define SDRC_RFR_CTRL_0		0x0a4
+#define SDRC_MR_1		0x0B4
+#define SDRC_ACTIM_CTRL_A_1	0x0C4
+#define SDRC_ACTIM_CTRL_B_1	0x0C8
+#define SDRC_RFR_CTRL_1		0x0D4
=20
 /*
  * These values represent the number of memory clock cycles between
@@ -102,8 +106,11 @@ struct omap_sdrc_params {
 	u32 mr;
 };
=20
=2Dvoid __init omap2_sdrc_init(struct omap_sdrc_params *sp);
=2Dstruct omap_sdrc_params *omap2_sdrc_get_params(unsigned long r);
+void __init omap2_sdrc_init(struct omap_sdrc_params *sdrc_cs0,
+			    struct omap_sdrc_params *sdrc_cs1);
+int omap2_sdrc_get_params(unsigned long r,
+			  struct omap_sdrc_params **sdrc_cs0,
+			  struct omap_sdrc_params **sdrc_cs1);
=20
 #ifdef CONFIG_ARCH_OMAP2
=20
diff --git a/arch/arm/plat-omap/include/mach/sram.h b/arch/arm/plat-omap/in=
clude/mach/sram.h
index 4d53cc5..8974e3f 100644
=2D-- a/arch/arm/plat-omap/include/mach/sram.h
+++ b/arch/arm/plat-omap/include/mach/sram.h
@@ -21,11 +21,12 @@ extern void omap2_sram_reprogram_sdrc(u32 perf_level, u=
32 dll_val,
 				      u32 mem_type);
 extern u32 omap2_set_prcm(u32 dpll_ctrl_val, u32 sdrc_rfr_val, int bypass);
=20
=2Dextern u32 omap3_configure_core_dpll(u32 sdrc_rfr_ctrl,
=2D				     u32 sdrc_actim_ctrla,
=2D				     u32 sdrc_actim_ctrlb, u32 m2,
=2D				     u32 unlock_dll, u32 f, u32 sdrc_mr,
=2D				     u32 inc);
+extern u32 omap3_configure_core_dpll(
+			u32 m2, u32 unlock_dll, u32 f, u32 inc,
+			u32 sdrc_rfr_ctrl_0, u32 sdrc_actim_ctrl_a_0,
+			u32 sdrc_actim_ctrl_b_0, u32 sdrc_mr_0,
+			u32 sdrc_rfr_ctrl_1, u32 sdrc_actim_ctrl_a_1,
+			u32 sdrc_actim_ctrl_b_1, u32 sdrc_mr_1);
=20
 /* Do not use these */
 extern void omap1_sram_reprogram_clock(u32 ckctl, u32 dpllctl);
@@ -59,12 +60,12 @@ extern void omap243x_sram_reprogram_sdrc(u32 perf_level=
, u32 dll_val,
 						u32 mem_type);
 extern unsigned long omap243x_sram_reprogram_sdrc_sz;
=20
=2D
=2Dextern u32 omap3_sram_configure_core_dpll(u32 sdrc_rfr_ctrl,
=2D					  u32 sdrc_actim_ctrla,
=2D					  u32 sdrc_actim_ctrlb, u32 m2,
=2D					  u32 unlock_dll, u32 f, u32 sdrc_mr,
=2D					  u32 inc);
+extern u32 omap3_sram_configure_core_dpll(
+			u32 m2, u32 unlock_dll, u32 f, u32 inc,
+			u32 sdrc_rfr_ctrl_0, u32 sdrc_actim_ctrl_a_0,
+			u32 sdrc_actim_ctrl_b_0, u32 sdrc_mr_0,
+			u32 sdrc_rfr_ctrl_1, u32 sdrc_actim_ctrl_a_1,
+			u32 sdrc_actim_ctrl_b_1, u32 sdrc_mr_1);
 extern unsigned long omap3_sram_configure_core_dpll_sz;
=20
 #endif
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 65006df..473125e 100644
=2D-- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -368,20 +368,26 @@ static inline int omap243x_sram_init(void)
=20
 #ifdef CONFIG_ARCH_OMAP3
=20
=2Dstatic u32 (*_omap3_sram_configure_core_dpll)(u32 sdrc_rfr_ctrl,
=2D					      u32 sdrc_actim_ctrla,
=2D					      u32 sdrc_actim_ctrlb,
=2D					      u32 m2, u32 unlock_dll,
=2D					      u32 f, u32 sdrc_mr, u32 inc);
=2Du32 omap3_configure_core_dpll(u32 sdrc_rfr_ctrl, u32 sdrc_actim_ctrla,
=2D			      u32 sdrc_actim_ctrlb, u32 m2, u32 unlock_dll,
=2D			      u32 f, u32 sdrc_mr, u32 inc)
+static u32 (*_omap3_sram_configure_core_dpll)(
+			u32 m2, u32 unlock_dll, u32 f, u32 inc,
+			u32 sdrc_rfr_ctrl_0, u32 sdrc_actim_ctrl_a_0,
+			u32 sdrc_actim_ctrl_b_0, u32 sdrc_mr_0,
+			u32 sdrc_rfr_ctrl_1, u32 sdrc_actim_ctrl_a_1,
+			u32 sdrc_actim_ctrl_b_1, u32 sdrc_mr_1);
+
+u32 omap3_configure_core_dpll(u32 m2, u32 unlock_dll, u32 f, u32 inc,
+			u32 sdrc_rfr_ctrl_0, u32 sdrc_actim_ctrl_a_0,
+			u32 sdrc_actim_ctrl_b_0, u32 sdrc_mr_0,
+			u32 sdrc_rfr_ctrl_1, u32 sdrc_actim_ctrl_a_1,
+			u32 sdrc_actim_ctrl_b_1, u32 sdrc_mr_1)
 {
 	BUG_ON(!_omap3_sram_configure_core_dpll);
=2D	return _omap3_sram_configure_core_dpll(sdrc_rfr_ctrl,
=2D					       sdrc_actim_ctrla,
=2D					       sdrc_actim_ctrlb, m2,
=2D					       unlock_dll, f, sdrc_mr, inc);
+	return _omap3_sram_configure_core_dpll(
+			m2, unlock_dll, f, inc,
+			sdrc_rfr_ctrl_0, sdrc_actim_ctrl_a_0,
+			sdrc_actim_ctrl_b_0, sdrc_mr_0,
+			sdrc_rfr_ctrl_1, sdrc_actim_ctrl_a_1,
+			sdrc_actim_ctrl_b_1, sdrc_mr_1);
 }
=20
 /* REVISIT: Should this be same as omap34xx_sram_init() after off-idle? */
=2D-=20
1.6.2.5.168.g3823


--Boundary-00=_8Q1NKUzc40gI0YS--
