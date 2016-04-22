From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [PATCH v6 6/7] ARM: AM335x/AM437x: hwmod: Remove eQEP, ePWM and eCAP hwmod entries
Date: Fri, 22 Apr 2016 11:40:37 -0500
Message-ID: <1461343238-29274-7-git-send-email-fcooper@ti.com>
References: <1461343238-29274-1-git-send-email-fcooper@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461343238-29274-1-git-send-email-fcooper@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, tony@atomide.com, paul@pwsan.com, t-kristo@ti.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org, vigneshr@ti.com, nsekhar@ti.com
Cc: Franklin S Cooper Jr <fcooper@ti.com>
List-Id: linux-omap@vger.kernel.org

Devices that utilize the OCP registers and/or PRCM registers and
register bit fields should be modeled using hwmod. Since eQEP, ePWM and
eCAP don't fall under this category, remove their hwmod entries.

Instead these clocks simply use the clock that is passed through by its
parent PWMSS. Therefore, PWMSS handles the clock for itself and its
subdevices.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
 .../mach-omap2/omap_hwmod_33xx_43xx_common_data.h  | 18 -----
 .../omap_hwmod_33xx_43xx_interconnect_data.c       | 64 -----------------
 .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c | 84 ----------------------
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |  9 ---
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c         | 54 --------------
 5 files changed, 229 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common_data.h b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common_data.h
index 7f73796..d3e61d1 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common_data.h
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common_data.h
@@ -36,17 +36,8 @@ extern struct omap_hwmod_ocp_if am33xx_l4_per__gpio3;
 extern struct omap_hwmod_ocp_if am33xx_cpgmac0__mdio;
 extern struct omap_hwmod_ocp_if am33xx_l4_ls__elm;
 extern struct omap_hwmod_ocp_if am33xx_l4_ls__epwmss0;
-extern struct omap_hwmod_ocp_if am33xx_epwmss0__ecap0;
-extern struct omap_hwmod_ocp_if am33xx_epwmss0__eqep0;
-extern struct omap_hwmod_ocp_if am33xx_epwmss0__ehrpwm0;
 extern struct omap_hwmod_ocp_if am33xx_l4_ls__epwmss1;
-extern struct omap_hwmod_ocp_if am33xx_epwmss1__ecap1;
-extern struct omap_hwmod_ocp_if am33xx_epwmss1__eqep1;
-extern struct omap_hwmod_ocp_if am33xx_epwmss1__ehrpwm1;
 extern struct omap_hwmod_ocp_if am33xx_l4_ls__epwmss2;
-extern struct omap_hwmod_ocp_if am33xx_epwmss2__ecap2;
-extern struct omap_hwmod_ocp_if am33xx_epwmss2__eqep2;
-extern struct omap_hwmod_ocp_if am33xx_epwmss2__ehrpwm2;
 extern struct omap_hwmod_ocp_if am33xx_l3_s__gpmc;
 extern struct omap_hwmod_ocp_if am33xx_l4_per__i2c2;
 extern struct omap_hwmod_ocp_if am33xx_l4_per__i2c3;
@@ -98,17 +89,8 @@ extern struct omap_hwmod am33xx_dcan0_hwmod;
 extern struct omap_hwmod am33xx_dcan1_hwmod;
 extern struct omap_hwmod am33xx_elm_hwmod;
 extern struct omap_hwmod am33xx_epwmss0_hwmod;
-extern struct omap_hwmod am33xx_ecap0_hwmod;
-extern struct omap_hwmod am33xx_eqep0_hwmod;
-extern struct omap_hwmod am33xx_ehrpwm0_hwmod;
 extern struct omap_hwmod am33xx_epwmss1_hwmod;
-extern struct omap_hwmod am33xx_ecap1_hwmod;
-extern struct omap_hwmod am33xx_eqep1_hwmod;
-extern struct omap_hwmod am33xx_ehrpwm1_hwmod;
 extern struct omap_hwmod am33xx_epwmss2_hwmod;
-extern struct omap_hwmod am33xx_ecap2_hwmod;
-extern struct omap_hwmod am33xx_eqep2_hwmod;
-extern struct omap_hwmod am33xx_ehrpwm2_hwmod;
 extern struct omap_hwmod am33xx_gpio1_hwmod;
 extern struct omap_hwmod am33xx_gpio2_hwmod;
 extern struct omap_hwmod am33xx_gpio3_hwmod;
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c
index 1c210cb..10dff2f 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c
@@ -176,28 +176,6 @@ struct omap_hwmod_ocp_if am33xx_l4_ls__epwmss0 = {
 	.user		= OCP_USER_MPU,
 };
 
-struct omap_hwmod_ocp_if am33xx_epwmss0__ecap0 = {
-	.master		= &am33xx_epwmss0_hwmod,
-	.slave		= &am33xx_ecap0_hwmod,
-	.clk		= "l4ls_gclk",
-	.user		= OCP_USER_MPU,
-};
-
-struct omap_hwmod_ocp_if am33xx_epwmss0__eqep0 = {
-	.master		= &am33xx_epwmss0_hwmod,
-	.slave		= &am33xx_eqep0_hwmod,
-	.clk		= "l4ls_gclk",
-	.user		= OCP_USER_MPU,
-};
-
-struct omap_hwmod_ocp_if am33xx_epwmss0__ehrpwm0 = {
-	.master		= &am33xx_epwmss0_hwmod,
-	.slave		= &am33xx_ehrpwm0_hwmod,
-	.clk		= "l4ls_gclk",
-	.user		= OCP_USER_MPU,
-};
-
-
 static struct omap_hwmod_addr_space am33xx_epwmss1_addr_space[] = {
 	{
 		.pa_start	= 0x48302000,
@@ -215,27 +193,6 @@ struct omap_hwmod_ocp_if am33xx_l4_ls__epwmss1 = {
 	.user		= OCP_USER_MPU,
 };
 
-struct omap_hwmod_ocp_if am33xx_epwmss1__ecap1 = {
-	.master		= &am33xx_epwmss1_hwmod,
-	.slave		= &am33xx_ecap1_hwmod,
-	.clk		= "l4ls_gclk",
-	.user		= OCP_USER_MPU,
-};
-
-struct omap_hwmod_ocp_if am33xx_epwmss1__eqep1 = {
-	.master		= &am33xx_epwmss1_hwmod,
-	.slave		= &am33xx_eqep1_hwmod,
-	.clk		= "l4ls_gclk",
-	.user		= OCP_USER_MPU,
-};
-
-struct omap_hwmod_ocp_if am33xx_epwmss1__ehrpwm1 = {
-	.master		= &am33xx_epwmss1_hwmod,
-	.slave		= &am33xx_ehrpwm1_hwmod,
-	.clk		= "l4ls_gclk",
-	.user		= OCP_USER_MPU,
-};
-
 static struct omap_hwmod_addr_space am33xx_epwmss2_addr_space[] = {
 	{
 		.pa_start	= 0x48304000,
@@ -253,27 +210,6 @@ struct omap_hwmod_ocp_if am33xx_l4_ls__epwmss2 = {
 	.user		= OCP_USER_MPU,
 };
 
-struct omap_hwmod_ocp_if am33xx_epwmss2__ecap2 = {
-	.master		= &am33xx_epwmss2_hwmod,
-	.slave		= &am33xx_ecap2_hwmod,
-	.clk		= "l4ls_gclk",
-	.user		= OCP_USER_MPU,
-};
-
-struct omap_hwmod_ocp_if am33xx_epwmss2__eqep2 = {
-	.master		= &am33xx_epwmss2_hwmod,
-	.slave		= &am33xx_eqep2_hwmod,
-	.clk		= "l4ls_gclk",
-	.user		= OCP_USER_MPU,
-};
-
-struct omap_hwmod_ocp_if am33xx_epwmss2__ehrpwm2 = {
-	.master		= &am33xx_epwmss2_hwmod,
-	.slave		= &am33xx_ehrpwm2_hwmod,
-	.clk		= "l4ls_gclk",
-	.user		= OCP_USER_MPU,
-};
-
 /* l3s cfg -> gpmc */
 struct omap_hwmod_ocp_if am33xx_l3_s__gpmc = {
 	.master		= &am33xx_l3_s_hwmod,
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
index aed3362..6a73b6c 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
@@ -449,18 +449,6 @@ struct omap_hwmod_class am33xx_epwmss_hwmod_class = {
 	.sysc		= &am33xx_epwmss_sysc,
 };
 
-static struct omap_hwmod_class am33xx_ecap_hwmod_class = {
-	.name		= "ecap",
-};
-
-static struct omap_hwmod_class am33xx_eqep_hwmod_class = {
-	.name		= "eqep",
-};
-
-struct omap_hwmod_class am33xx_ehrpwm_hwmod_class = {
-	.name		= "ehrpwm",
-};
-
 /* epwmss0 */
 struct omap_hwmod am33xx_epwmss0_hwmod = {
 	.name		= "epwmss0",
@@ -474,30 +462,6 @@ struct omap_hwmod am33xx_epwmss0_hwmod = {
 	},
 };
 
-/* ecap0 */
-struct omap_hwmod am33xx_ecap0_hwmod = {
-	.name		= "ecap0",
-	.class		= &am33xx_ecap_hwmod_class,
-	.clkdm_name	= "l4ls_clkdm",
-	.main_clk	= "l4ls_gclk",
-};
-
-/* eqep0 */
-struct omap_hwmod am33xx_eqep0_hwmod = {
-	.name		= "eqep0",
-	.class		= &am33xx_eqep_hwmod_class,
-	.clkdm_name	= "l4ls_clkdm",
-	.main_clk	= "l4ls_gclk",
-};
-
-/* ehrpwm0 */
-struct omap_hwmod am33xx_ehrpwm0_hwmod = {
-	.name		= "ehrpwm0",
-	.class		= &am33xx_ehrpwm_hwmod_class,
-	.clkdm_name	= "l4ls_clkdm",
-	.main_clk	= "l4ls_gclk",
-};
-
 /* epwmss1 */
 struct omap_hwmod am33xx_epwmss1_hwmod = {
 	.name		= "epwmss1",
@@ -511,30 +475,6 @@ struct omap_hwmod am33xx_epwmss1_hwmod = {
 	},
 };
 
-/* ecap1 */
-struct omap_hwmod am33xx_ecap1_hwmod = {
-	.name		= "ecap1",
-	.class		= &am33xx_ecap_hwmod_class,
-	.clkdm_name	= "l4ls_clkdm",
-	.main_clk	= "l4ls_gclk",
-};
-
-/* eqep1 */
-struct omap_hwmod am33xx_eqep1_hwmod = {
-	.name		= "eqep1",
-	.class		= &am33xx_eqep_hwmod_class,
-	.clkdm_name	= "l4ls_clkdm",
-	.main_clk	= "l4ls_gclk",
-};
-
-/* ehrpwm1 */
-struct omap_hwmod am33xx_ehrpwm1_hwmod = {
-	.name		= "ehrpwm1",
-	.class		= &am33xx_ehrpwm_hwmod_class,
-	.clkdm_name	= "l4ls_clkdm",
-	.main_clk	= "l4ls_gclk",
-};
-
 /* epwmss2 */
 struct omap_hwmod am33xx_epwmss2_hwmod = {
 	.name		= "epwmss2",
@@ -548,30 +488,6 @@ struct omap_hwmod am33xx_epwmss2_hwmod = {
 	},
 };
 
-/* ecap2 */
-struct omap_hwmod am33xx_ecap2_hwmod = {
-	.name		= "ecap2",
-	.class		= &am33xx_ecap_hwmod_class,
-	.clkdm_name	= "l4ls_clkdm",
-	.main_clk	= "l4ls_gclk",
-};
-
-/* eqep2 */
-struct omap_hwmod am33xx_eqep2_hwmod = {
-	.name		= "eqep2",
-	.class		= &am33xx_eqep_hwmod_class,
-	.clkdm_name	= "l4ls_clkdm",
-	.main_clk	= "l4ls_gclk",
-};
-
-/* ehrpwm2 */
-struct omap_hwmod am33xx_ehrpwm2_hwmod = {
-	.name		= "ehrpwm2",
-	.class		= &am33xx_ehrpwm_hwmod_class,
-	.clkdm_name	= "l4ls_clkdm",
-	.main_clk	= "l4ls_gclk",
-};
-
 /*
  * 'gpio' class: for gpio 0,1,2,3
  */
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
index cc0791d..e1c2025 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -593,17 +593,8 @@ static struct omap_hwmod_ocp_if *am33xx_hwmod_ocp_ifs[] __initdata = {
 	&am33xx_l4_ls__spinlock,
 	&am33xx_l4_ls__elm,
 	&am33xx_l4_ls__epwmss0,
-	&am33xx_epwmss0__ecap0,
-	&am33xx_epwmss0__eqep0,
-	&am33xx_epwmss0__ehrpwm0,
 	&am33xx_l4_ls__epwmss1,
-	&am33xx_epwmss1__ecap1,
-	&am33xx_epwmss1__eqep1,
-	&am33xx_epwmss1__ehrpwm1,
 	&am33xx_l4_ls__epwmss2,
-	&am33xx_epwmss2__ecap2,
-	&am33xx_epwmss2__eqep2,
-	&am33xx_epwmss2__ehrpwm2,
 	&am33xx_l3_s__gpmc,
 	&am33xx_l3_main__lcdc,
 	&am33xx_l4_ls__mcspi0,
diff --git a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
index 97fd399..61f2f30 100644
--- a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
@@ -202,13 +202,6 @@ static struct omap_hwmod am43xx_epwmss3_hwmod = {
 	},
 };
 
-static struct omap_hwmod am43xx_ehrpwm3_hwmod = {
-	.name		= "ehrpwm3",
-	.class		= &am33xx_ehrpwm_hwmod_class,
-	.clkdm_name	= "l4ls_clkdm",
-	.main_clk	= "l4ls_gclk",
-};
-
 static struct omap_hwmod am43xx_epwmss4_hwmod = {
 	.name		= "epwmss4",
 	.class		= &am33xx_epwmss_hwmod_class,
@@ -222,13 +215,6 @@ static struct omap_hwmod am43xx_epwmss4_hwmod = {
 	},
 };
 
-static struct omap_hwmod am43xx_ehrpwm4_hwmod = {
-	.name		= "ehrpwm4",
-	.class		= &am33xx_ehrpwm_hwmod_class,
-	.clkdm_name	= "l4ls_clkdm",
-	.main_clk	= "l4ls_gclk",
-};
-
 static struct omap_hwmod am43xx_epwmss5_hwmod = {
 	.name		= "epwmss5",
 	.class		= &am33xx_epwmss_hwmod_class,
@@ -242,13 +228,6 @@ static struct omap_hwmod am43xx_epwmss5_hwmod = {
 	},
 };
 
-static struct omap_hwmod am43xx_ehrpwm5_hwmod = {
-	.name		= "ehrpwm5",
-	.class		= &am33xx_ehrpwm_hwmod_class,
-	.clkdm_name	= "l4ls_clkdm",
-	.main_clk	= "l4ls_gclk",
-};
-
 static struct omap_hwmod am43xx_spi2_hwmod = {
 	.name		= "spi2",
 	.class		= &am33xx_spi_hwmod_class,
@@ -744,13 +723,6 @@ static struct omap_hwmod_ocp_if am43xx_l4_ls__epwmss3 = {
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_ocp_if am43xx_epwmss3__ehrpwm3 = {
-	.master		= &am43xx_epwmss3_hwmod,
-	.slave		= &am43xx_ehrpwm3_hwmod,
-	.clk		= "l4ls_gclk",
-	.user		= OCP_USER_MPU,
-};
-
 static struct omap_hwmod_ocp_if am43xx_l4_ls__epwmss4 = {
 	.master		= &am33xx_l4_ls_hwmod,
 	.slave		= &am43xx_epwmss4_hwmod,
@@ -758,13 +730,6 @@ static struct omap_hwmod_ocp_if am43xx_l4_ls__epwmss4 = {
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_ocp_if am43xx_epwmss4__ehrpwm4 = {
-	.master		= &am43xx_epwmss4_hwmod,
-	.slave		= &am43xx_ehrpwm4_hwmod,
-	.clk		= "l4ls_gclk",
-	.user		= OCP_USER_MPU,
-};
-
 static struct omap_hwmod_ocp_if am43xx_l4_ls__epwmss5 = {
 	.master		= &am33xx_l4_ls_hwmod,
 	.slave		= &am43xx_epwmss5_hwmod,
@@ -772,13 +737,6 @@ static struct omap_hwmod_ocp_if am43xx_l4_ls__epwmss5 = {
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_ocp_if am43xx_epwmss5__ehrpwm5 = {
-	.master		= &am43xx_epwmss5_hwmod,
-	.slave		= &am43xx_ehrpwm5_hwmod,
-	.clk		= "l4ls_gclk",
-	.user		= OCP_USER_MPU,
-};
-
 static struct omap_hwmod_ocp_if am43xx_l4_ls__mcspi2 = {
 	.master		= &am33xx_l4_ls_hwmod,
 	.slave		= &am43xx_spi2_hwmod,
@@ -919,11 +877,8 @@ static struct omap_hwmod_ocp_if *am43xx_hwmod_ocp_ifs[] __initdata = {
 	&am43xx_l4_ls__timer10,
 	&am43xx_l4_ls__timer11,
 	&am43xx_l4_ls__epwmss3,
-	&am43xx_epwmss3__ehrpwm3,
 	&am43xx_l4_ls__epwmss4,
-	&am43xx_epwmss4__ehrpwm4,
 	&am43xx_l4_ls__epwmss5,
-	&am43xx_epwmss5__ehrpwm5,
 	&am43xx_l4_ls__mcspi2,
 	&am43xx_l4_ls__mcspi3,
 	&am43xx_l4_ls__mcspi4,
@@ -982,17 +937,8 @@ static struct omap_hwmod_ocp_if *am43xx_hwmod_ocp_ifs[] __initdata = {
 	&am33xx_l4_ls__spinlock,
 	&am33xx_l4_ls__elm,
 	&am33xx_l4_ls__epwmss0,
-	&am33xx_epwmss0__ecap0,
-	&am33xx_epwmss0__eqep0,
-	&am33xx_epwmss0__ehrpwm0,
 	&am33xx_l4_ls__epwmss1,
-	&am33xx_epwmss1__ecap1,
-	&am33xx_epwmss1__eqep1,
-	&am33xx_epwmss1__ehrpwm1,
 	&am33xx_l4_ls__epwmss2,
-	&am33xx_epwmss2__ecap2,
-	&am33xx_epwmss2__eqep2,
-	&am33xx_epwmss2__ehrpwm2,
 	&am33xx_l3_s__gpmc,
 	&am33xx_l4_ls__mcspi0,
 	&am33xx_l4_ls__mcspi1,
-- 
2.7.0
