From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH RFC v3 02/12] ARM: OMAP2+: hwmod: AM335x/AM43x: move common ocpif
Date: Mon, 16 Sep 2013 19:17:31 +0530
Message-ID: <6cf2e6a8e7023fc389afdc51264610267368ed8d.1379337301.git.afzal@ti.com>
References: <cover.1379337301.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51660 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752515Ab3IPNsM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Sep 2013 09:48:12 -0400
In-Reply-To: <cover.1379337301.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

AM335x and AM43x have most of the interconnect's similar. Instead of
adding redundant hwmod data, move interconnects similar between AM335x
and AM43x to a common location. This helps in reuse on AM43x.

AM335x interconnects that has difference and not present in AM43x is
not moved. Ocp clock of those in l4_wkup is fed from a different source
for AM43x. Also pruss interconnect is different.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/Makefile                       |   1 +
 arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common.h  |  76 +++
 .../omap_hwmod_33xx_43xx_interconnect_data.c       | 656 +++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         | 625 +-------------------
 4 files changed, 734 insertions(+), 624 deletions(-)
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common.h
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index afb457c..4bd83da 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -210,6 +210,7 @@ obj-$(CONFIG_ARCH_OMAP3)		+= omap_hwmod_2xxx_3xxx_ipblock_data.o
 obj-$(CONFIG_ARCH_OMAP3)		+= omap_hwmod_2xxx_3xxx_interconnect_data.o
 obj-$(CONFIG_ARCH_OMAP3)		+= omap_hwmod_3xxx_data.o
 obj-$(CONFIG_SOC_AM33XX)		+= omap_hwmod_33xx_data.o
+obj-$(CONFIG_SOC_AM33XX)		+= omap_hwmod_33xx_43xx_interconnect_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+= omap_hwmod_44xx_data.o
 obj-$(CONFIG_SOC_OMAP5)			+= omap_hwmod_54xx_data.o
 obj-$(CONFIG_SOC_DRA7XX)		+= omap_hwmod_7xx_data.o
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common.h b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common.h
new file mode 100644
index 0000000..c193d9c
--- /dev/null
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common.h
@@ -0,0 +1,76 @@
+/*
+ *
+ * Copyright (C) 2013 Texas Instruments Incorporated
+ *
+ * Data common for AM335x and AM43x
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+extern struct omap_hwmod_ocp_if am33xx_mpu__l3_main;
+extern struct omap_hwmod_ocp_if am33xx_l3_main__l3_s;
+extern struct omap_hwmod_ocp_if am33xx_l3_s__l4_ls;
+extern struct omap_hwmod_ocp_if am33xx_l3_s__l4_wkup;
+extern struct omap_hwmod_ocp_if am33xx_l3_main__l3_instr;
+extern struct omap_hwmod_ocp_if am33xx_mpu__prcm;
+extern struct omap_hwmod_ocp_if am33xx_l3_s__l3_main;
+extern struct omap_hwmod_ocp_if am33xx_pruss__l3_main;
+extern struct omap_hwmod_ocp_if am33xx_gfx__l3_main;
+extern struct omap_hwmod_ocp_if am33xx_l3_main__gfx;
+extern struct omap_hwmod_ocp_if am33xx_l4_wkup__rtc;
+extern struct omap_hwmod_ocp_if am33xx_l4_per__dcan0;
+extern struct omap_hwmod_ocp_if am33xx_l4_per__dcan1;
+extern struct omap_hwmod_ocp_if am33xx_l4_per__gpio1;
+extern struct omap_hwmod_ocp_if am33xx_l4_per__gpio2;
+extern struct omap_hwmod_ocp_if am33xx_l4_per__gpio3;
+extern struct omap_hwmod_ocp_if am33xx_cpgmac0__mdio;
+extern struct omap_hwmod_ocp_if am33xx_l4_ls__elm;
+extern struct omap_hwmod_ocp_if am33xx_l4_ls__epwmss0;
+extern struct omap_hwmod_ocp_if am33xx_epwmss0__ecap0;
+extern struct omap_hwmod_ocp_if am33xx_epwmss0__eqep0;
+extern struct omap_hwmod_ocp_if am33xx_epwmss0__ehrpwm0;
+extern struct omap_hwmod_ocp_if am33xx_l4_ls__epwmss1;
+extern struct omap_hwmod_ocp_if am33xx_epwmss1__ecap1;
+extern struct omap_hwmod_ocp_if am33xx_epwmss1__eqep1;
+extern struct omap_hwmod_ocp_if am33xx_epwmss1__ehrpwm1;
+extern struct omap_hwmod_ocp_if am33xx_l4_ls__epwmss2;
+extern struct omap_hwmod_ocp_if am33xx_epwmss2__ecap2;
+extern struct omap_hwmod_ocp_if am33xx_epwmss2__eqep2;
+extern struct omap_hwmod_ocp_if am33xx_epwmss2__ehrpwm2;
+extern struct omap_hwmod_ocp_if am33xx_l3_s__gpmc;
+extern struct omap_hwmod_ocp_if am33xx_l4_per__i2c2;
+extern struct omap_hwmod_ocp_if am33xx_l4_per__i2c3;
+extern struct omap_hwmod_ocp_if am33xx_l4_per__mailbox;
+extern struct omap_hwmod_ocp_if am33xx_l4_ls__spinlock;
+extern struct omap_hwmod_ocp_if am33xx_l4_ls__mcasp0;
+extern struct omap_hwmod_ocp_if am33xx_l4_ls__mcasp1;
+extern struct omap_hwmod_ocp_if am33xx_l4_ls__mmc0;
+extern struct omap_hwmod_ocp_if am33xx_l4_ls__mmc1;
+extern struct omap_hwmod_ocp_if am33xx_l3_s__mmc2;
+extern struct omap_hwmod_ocp_if am33xx_l4_ls__mcspi0;
+extern struct omap_hwmod_ocp_if am33xx_l4_ls__mcspi1;
+extern struct omap_hwmod_ocp_if am33xx_l4_ls__timer2;
+extern struct omap_hwmod_ocp_if am33xx_l4_ls__timer3;
+extern struct omap_hwmod_ocp_if am33xx_l4_ls__timer4;
+extern struct omap_hwmod_ocp_if am33xx_l4_ls__timer5;
+extern struct omap_hwmod_ocp_if am33xx_l4_ls__timer6;
+extern struct omap_hwmod_ocp_if am33xx_l4_ls__timer7;
+extern struct omap_hwmod_ocp_if am33xx_l3_main__tpcc;
+extern struct omap_hwmod_ocp_if am33xx_l3_main__tptc0;
+extern struct omap_hwmod_ocp_if am33xx_l3_main__tptc1;
+extern struct omap_hwmod_ocp_if am33xx_l3_main__tptc2;
+extern struct omap_hwmod_ocp_if am33xx_l4_ls__uart2;
+extern struct omap_hwmod_ocp_if am33xx_l4_ls__uart3;
+extern struct omap_hwmod_ocp_if am33xx_l4_ls__uart4;
+extern struct omap_hwmod_ocp_if am33xx_l4_ls__uart5;
+extern struct omap_hwmod_ocp_if am33xx_l4_ls__uart6;
+extern struct omap_hwmod_ocp_if am33xx_l3_main__ocmc;
+extern struct omap_hwmod_ocp_if am33xx_l3_main__sha0;
+extern struct omap_hwmod_ocp_if am33xx_l3_main__aes0;
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c
new file mode 100644
index 0000000..2adee39
--- /dev/null
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c
@@ -0,0 +1,656 @@
+/*
+ *
+ * Copyright (C) 2013 Texas Instruments Incorporated
+ *
+ * Interconnects common for AM335x and AM43x
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/i2c-omap.h>
+
+#include "omap_hwmod.h"
+#include <linux/platform_data/gpio-omap.h>
+#include <linux/platform_data/spi-omap2-mcspi.h>
+
+#include "omap_hwmod_common_data.h"
+
+#include "control.h"
+#include "cm33xx.h"
+#include "prm33xx.h"
+#include "prm-regbits-33xx.h"
+#include "i2c.h"
+#include "mmc.h"
+#include "wd_timer.h"
+#include "omap_hwmod_33xx_43xx_common.h"
+
+/* mpu -> l3 main */
+struct omap_hwmod_ocp_if am33xx_mpu__l3_main = {
+	.master		= &am33xx_mpu_hwmod,
+	.slave		= &am33xx_l3_main_hwmod,
+	.clk		= "dpll_mpu_m2_ck",
+	.user		= OCP_USER_MPU,
+};
+
+/* l3 main -> l3 s */
+struct omap_hwmod_ocp_if am33xx_l3_main__l3_s = {
+	.master		= &am33xx_l3_main_hwmod,
+	.slave		= &am33xx_l3_s_hwmod,
+	.clk		= "l3s_gclk",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* l3 s -> l4 per/ls */
+struct omap_hwmod_ocp_if am33xx_l3_s__l4_ls = {
+	.master		= &am33xx_l3_s_hwmod,
+	.slave		= &am33xx_l4_ls_hwmod,
+	.clk		= "l3s_gclk",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* l3 s -> l4 wkup */
+struct omap_hwmod_ocp_if am33xx_l3_s__l4_wkup = {
+	.master		= &am33xx_l3_s_hwmod,
+	.slave		= &am33xx_l4_wkup_hwmod,
+	.clk		= "l3s_gclk",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* l3 main -> l3 instr */
+struct omap_hwmod_ocp_if am33xx_l3_main__l3_instr = {
+	.master		= &am33xx_l3_main_hwmod,
+	.slave		= &am33xx_l3_instr_hwmod,
+	.clk		= "l3s_gclk",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* mpu -> prcm */
+struct omap_hwmod_ocp_if am33xx_mpu__prcm = {
+	.master		= &am33xx_mpu_hwmod,
+	.slave		= &am33xx_prcm_hwmod,
+	.clk		= "dpll_mpu_m2_ck",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* l3 s -> l3 main*/
+struct omap_hwmod_ocp_if am33xx_l3_s__l3_main = {
+	.master		= &am33xx_l3_s_hwmod,
+	.slave		= &am33xx_l3_main_hwmod,
+	.clk		= "l3s_gclk",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* pru-icss -> l3 main */
+struct omap_hwmod_ocp_if am33xx_pruss__l3_main = {
+	.master		= &am33xx_pruss_hwmod,
+	.slave		= &am33xx_l3_main_hwmod,
+	.clk		= "l3_gclk",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* gfx -> l3 main */
+struct omap_hwmod_ocp_if am33xx_gfx__l3_main = {
+	.master		= &am33xx_gfx_hwmod,
+	.slave		= &am33xx_l3_main_hwmod,
+	.clk		= "dpll_core_m4_ck",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* l3 main -> gfx */
+struct omap_hwmod_ocp_if am33xx_l3_main__gfx = {
+	.master		= &am33xx_l3_main_hwmod,
+	.slave		= &am33xx_gfx_hwmod,
+	.clk		= "dpll_core_m4_ck",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* l4 wkup -> rtc */
+struct omap_hwmod_ocp_if am33xx_l4_wkup__rtc = {
+	.master		= &am33xx_l4_wkup_hwmod,
+	.slave		= &am33xx_rtc_hwmod,
+	.clk		= "clkdiv32k_ick",
+	.user		= OCP_USER_MPU,
+};
+
+/* l4 per/ls -> DCAN0 */
+struct omap_hwmod_ocp_if am33xx_l4_per__dcan0 = {
+	.master		= &am33xx_l4_ls_hwmod,
+	.slave		= &am33xx_dcan0_hwmod,
+	.clk		= "l4ls_gclk",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* l4 per/ls -> DCAN1 */
+struct omap_hwmod_ocp_if am33xx_l4_per__dcan1 = {
+	.master		= &am33xx_l4_ls_hwmod,
+	.slave		= &am33xx_dcan1_hwmod,
+	.clk		= "l4ls_gclk",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* l4 per/ls -> GPIO2 */
+struct omap_hwmod_ocp_if am33xx_l4_per__gpio1 = {
+	.master		= &am33xx_l4_ls_hwmod,
+	.slave		= &am33xx_gpio1_hwmod,
+	.clk		= "l4ls_gclk",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* l4 per/ls -> gpio3 */
+struct omap_hwmod_ocp_if am33xx_l4_per__gpio2 = {
+	.master		= &am33xx_l4_ls_hwmod,
+	.slave		= &am33xx_gpio2_hwmod,
+	.clk		= "l4ls_gclk",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* l4 per/ls -> gpio4 */
+struct omap_hwmod_ocp_if am33xx_l4_per__gpio3 = {
+	.master		= &am33xx_l4_ls_hwmod,
+	.slave		= &am33xx_gpio3_hwmod,
+	.clk		= "l4ls_gclk",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+struct omap_hwmod_ocp_if am33xx_cpgmac0__mdio = {
+	.master		= &am33xx_cpgmac0_hwmod,
+	.slave		= &am33xx_mdio_hwmod,
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_addr_space am33xx_elm_addr_space[] = {
+	{
+		.pa_start	= 0x48080000,
+		.pa_end		= 0x48080000 + SZ_8K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+	{ }
+};
+
+struct omap_hwmod_ocp_if am33xx_l4_ls__elm = {
+	.master		= &am33xx_l4_ls_hwmod,
+	.slave		= &am33xx_elm_hwmod,
+	.clk		= "l4ls_gclk",
+	.addr		= am33xx_elm_addr_space,
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_addr_space am33xx_epwmss0_addr_space[] = {
+	{
+		.pa_start	= 0x48300000,
+		.pa_end		= 0x48300000 + SZ_16 - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+	{ }
+};
+
+struct omap_hwmod_ocp_if am33xx_l4_ls__epwmss0 = {
+	.master		= &am33xx_l4_ls_hwmod,
+	.slave		= &am33xx_epwmss0_hwmod,
+	.clk		= "l4ls_gclk",
+	.addr		= am33xx_epwmss0_addr_space,
+	.user		= OCP_USER_MPU,
+};
+
+struct omap_hwmod_ocp_if am33xx_epwmss0__ecap0 = {
+	.master		= &am33xx_epwmss0_hwmod,
+	.slave		= &am33xx_ecap0_hwmod,
+	.clk		= "l4ls_gclk",
+	.user		= OCP_USER_MPU,
+};
+
+struct omap_hwmod_ocp_if am33xx_epwmss0__eqep0 = {
+	.master		= &am33xx_epwmss0_hwmod,
+	.slave		= &am33xx_eqep0_hwmod,
+	.clk		= "l4ls_gclk",
+	.user		= OCP_USER_MPU,
+};
+
+struct omap_hwmod_ocp_if am33xx_epwmss0__ehrpwm0 = {
+	.master		= &am33xx_epwmss0_hwmod,
+	.slave		= &am33xx_ehrpwm0_hwmod,
+	.clk		= "l4ls_gclk",
+	.user		= OCP_USER_MPU,
+};
+
+
+static struct omap_hwmod_addr_space am33xx_epwmss1_addr_space[] = {
+	{
+		.pa_start	= 0x48302000,
+		.pa_end		= 0x48302000 + SZ_16 - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+	{ }
+};
+
+struct omap_hwmod_ocp_if am33xx_l4_ls__epwmss1 = {
+	.master		= &am33xx_l4_ls_hwmod,
+	.slave		= &am33xx_epwmss1_hwmod,
+	.clk		= "l4ls_gclk",
+	.addr		= am33xx_epwmss1_addr_space,
+	.user		= OCP_USER_MPU,
+};
+
+struct omap_hwmod_ocp_if am33xx_epwmss1__ecap1 = {
+	.master		= &am33xx_epwmss1_hwmod,
+	.slave		= &am33xx_ecap1_hwmod,
+	.clk		= "l4ls_gclk",
+	.user		= OCP_USER_MPU,
+};
+
+struct omap_hwmod_ocp_if am33xx_epwmss1__eqep1 = {
+	.master		= &am33xx_epwmss1_hwmod,
+	.slave		= &am33xx_eqep1_hwmod,
+	.clk		= "l4ls_gclk",
+	.user		= OCP_USER_MPU,
+};
+
+struct omap_hwmod_ocp_if am33xx_epwmss1__ehrpwm1 = {
+	.master		= &am33xx_epwmss1_hwmod,
+	.slave		= &am33xx_ehrpwm1_hwmod,
+	.clk		= "l4ls_gclk",
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_addr_space am33xx_epwmss2_addr_space[] = {
+	{
+		.pa_start	= 0x48304000,
+		.pa_end		= 0x48304000 + SZ_16 - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+	{ }
+};
+
+struct omap_hwmod_ocp_if am33xx_l4_ls__epwmss2 = {
+	.master		= &am33xx_l4_ls_hwmod,
+	.slave		= &am33xx_epwmss2_hwmod,
+	.clk		= "l4ls_gclk",
+	.addr		= am33xx_epwmss2_addr_space,
+	.user		= OCP_USER_MPU,
+};
+
+struct omap_hwmod_ocp_if am33xx_epwmss2__ecap2 = {
+	.master		= &am33xx_epwmss2_hwmod,
+	.slave		= &am33xx_ecap2_hwmod,
+	.clk		= "l4ls_gclk",
+	.user		= OCP_USER_MPU,
+};
+
+struct omap_hwmod_ocp_if am33xx_epwmss2__eqep2 = {
+	.master		= &am33xx_epwmss2_hwmod,
+	.slave		= &am33xx_eqep2_hwmod,
+	.clk		= "l4ls_gclk",
+	.user		= OCP_USER_MPU,
+};
+
+struct omap_hwmod_ocp_if am33xx_epwmss2__ehrpwm2 = {
+	.master		= &am33xx_epwmss2_hwmod,
+	.slave		= &am33xx_ehrpwm2_hwmod,
+	.clk		= "l4ls_gclk",
+	.user		= OCP_USER_MPU,
+};
+
+/* l3s cfg -> gpmc */
+static struct omap_hwmod_addr_space am33xx_gpmc_addr_space[] = {
+	{
+		.pa_start	= 0x50000000,
+		.pa_end		= 0x50000000 + SZ_8K - 1,
+		.flags		= ADDR_TYPE_RT,
+	},
+	{ }
+};
+
+struct omap_hwmod_ocp_if am33xx_l3_s__gpmc = {
+	.master		= &am33xx_l3_s_hwmod,
+	.slave		= &am33xx_gpmc_hwmod,
+	.clk		= "l3s_gclk",
+	.addr		= am33xx_gpmc_addr_space,
+	.user		= OCP_USER_MPU,
+};
+
+/* i2c2 */
+struct omap_hwmod_ocp_if am33xx_l4_per__i2c2 = {
+	.master		= &am33xx_l4_ls_hwmod,
+	.slave		= &am33xx_i2c2_hwmod,
+	.clk		= "l4ls_gclk",
+	.user		= OCP_USER_MPU,
+};
+
+struct omap_hwmod_ocp_if am33xx_l4_per__i2c3 = {
+	.master		= &am33xx_l4_ls_hwmod,
+	.slave		= &am33xx_i2c3_hwmod,
+	.clk		= "l4ls_gclk",
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_addr_space am33xx_mailbox_addrs[] = {
+	{
+		.pa_start	= 0x480C8000,
+		.pa_end		= 0x480C8000 + (SZ_4K - 1),
+		.flags		= ADDR_TYPE_RT
+	},
+	{ }
+};
+
+/* l4 ls -> mailbox */
+struct omap_hwmod_ocp_if am33xx_l4_per__mailbox = {
+	.master		= &am33xx_l4_ls_hwmod,
+	.slave		= &am33xx_mailbox_hwmod,
+	.clk		= "l4ls_gclk",
+	.addr		= am33xx_mailbox_addrs,
+	.user		= OCP_USER_MPU,
+};
+
+/* l4 ls -> spinlock */
+struct omap_hwmod_ocp_if am33xx_l4_ls__spinlock = {
+	.master		= &am33xx_l4_ls_hwmod,
+	.slave		= &am33xx_spinlock_hwmod,
+	.clk		= "l4ls_gclk",
+	.user		= OCP_USER_MPU,
+};
+
+/* l4 ls -> mcasp0 */
+static struct omap_hwmod_addr_space am33xx_mcasp0_addr_space[] = {
+	{
+		.pa_start	= 0x48038000,
+		.pa_end		= 0x48038000 + SZ_8K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+	{ }
+};
+
+struct omap_hwmod_ocp_if am33xx_l4_ls__mcasp0 = {
+	.master		= &am33xx_l4_ls_hwmod,
+	.slave		= &am33xx_mcasp0_hwmod,
+	.clk		= "l4ls_gclk",
+	.addr		= am33xx_mcasp0_addr_space,
+	.user		= OCP_USER_MPU,
+};
+
+/* l4 ls -> mcasp1 */
+static struct omap_hwmod_addr_space am33xx_mcasp1_addr_space[] = {
+	{
+		.pa_start	= 0x4803C000,
+		.pa_end		= 0x4803C000 + SZ_8K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+	{ }
+};
+
+struct omap_hwmod_ocp_if am33xx_l4_ls__mcasp1 = {
+	.master		= &am33xx_l4_ls_hwmod,
+	.slave		= &am33xx_mcasp1_hwmod,
+	.clk		= "l4ls_gclk",
+	.addr		= am33xx_mcasp1_addr_space,
+	.user		= OCP_USER_MPU,
+};
+
+/* l4 ls -> mmc0 */
+static struct omap_hwmod_addr_space am33xx_mmc0_addr_space[] = {
+	{
+		.pa_start	= 0x48060100,
+		.pa_end		= 0x48060100 + SZ_4K - 1,
+		.flags		= ADDR_TYPE_RT,
+	},
+	{ }
+};
+
+struct omap_hwmod_ocp_if am33xx_l4_ls__mmc0 = {
+	.master		= &am33xx_l4_ls_hwmod,
+	.slave		= &am33xx_mmc0_hwmod,
+	.clk		= "l4ls_gclk",
+	.addr		= am33xx_mmc0_addr_space,
+	.user		= OCP_USER_MPU,
+};
+
+/* l4 ls -> mmc1 */
+static struct omap_hwmod_addr_space am33xx_mmc1_addr_space[] = {
+	{
+		.pa_start	= 0x481d8100,
+		.pa_end		= 0x481d8100 + SZ_4K - 1,
+		.flags		= ADDR_TYPE_RT,
+	},
+	{ }
+};
+
+struct omap_hwmod_ocp_if am33xx_l4_ls__mmc1 = {
+	.master		= &am33xx_l4_ls_hwmod,
+	.slave		= &am33xx_mmc1_hwmod,
+	.clk		= "l4ls_gclk",
+	.addr		= am33xx_mmc1_addr_space,
+	.user		= OCP_USER_MPU,
+};
+
+/* l3 s -> mmc2 */
+static struct omap_hwmod_addr_space am33xx_mmc2_addr_space[] = {
+	{
+		.pa_start	= 0x47810100,
+		.pa_end		= 0x47810100 + SZ_64K - 1,
+		.flags		= ADDR_TYPE_RT,
+	},
+	{ }
+};
+
+struct omap_hwmod_ocp_if am33xx_l3_s__mmc2 = {
+	.master		= &am33xx_l3_s_hwmod,
+	.slave		= &am33xx_mmc2_hwmod,
+	.clk		= "l3s_gclk",
+	.addr		= am33xx_mmc2_addr_space,
+	.user		= OCP_USER_MPU,
+};
+
+/* l4 ls -> mcspi0 */
+struct omap_hwmod_ocp_if am33xx_l4_ls__mcspi0 = {
+	.master		= &am33xx_l4_ls_hwmod,
+	.slave		= &am33xx_spi0_hwmod,
+	.clk		= "l4ls_gclk",
+	.user		= OCP_USER_MPU,
+};
+
+/* l4 ls -> mcspi1 */
+struct omap_hwmod_ocp_if am33xx_l4_ls__mcspi1 = {
+	.master		= &am33xx_l4_ls_hwmod,
+	.slave		= &am33xx_spi1_hwmod,
+	.clk		= "l4ls_gclk",
+	.user		= OCP_USER_MPU,
+};
+
+/* l4 per -> timer2 */
+struct omap_hwmod_ocp_if am33xx_l4_ls__timer2 = {
+	.master		= &am33xx_l4_ls_hwmod,
+	.slave		= &am33xx_timer2_hwmod,
+	.clk		= "l4ls_gclk",
+	.user		= OCP_USER_MPU,
+};
+
+/* l4 per -> timer3 */
+struct omap_hwmod_ocp_if am33xx_l4_ls__timer3 = {
+	.master		= &am33xx_l4_ls_hwmod,
+	.slave		= &am33xx_timer3_hwmod,
+	.clk		= "l4ls_gclk",
+	.user		= OCP_USER_MPU,
+};
+
+/* l4 per -> timer4 */
+struct omap_hwmod_ocp_if am33xx_l4_ls__timer4 = {
+	.master		= &am33xx_l4_ls_hwmod,
+	.slave		= &am33xx_timer4_hwmod,
+	.clk		= "l4ls_gclk",
+	.user		= OCP_USER_MPU,
+};
+
+/* l4 per -> timer5 */
+struct omap_hwmod_ocp_if am33xx_l4_ls__timer5 = {
+	.master		= &am33xx_l4_ls_hwmod,
+	.slave		= &am33xx_timer5_hwmod,
+	.clk		= "l4ls_gclk",
+	.user		= OCP_USER_MPU,
+};
+
+/* l4 per -> timer6 */
+struct omap_hwmod_ocp_if am33xx_l4_ls__timer6 = {
+	.master		= &am33xx_l4_ls_hwmod,
+	.slave		= &am33xx_timer6_hwmod,
+	.clk		= "l4ls_gclk",
+	.user		= OCP_USER_MPU,
+};
+
+/* l4 per -> timer7 */
+struct omap_hwmod_ocp_if am33xx_l4_ls__timer7 = {
+	.master		= &am33xx_l4_ls_hwmod,
+	.slave		= &am33xx_timer7_hwmod,
+	.clk		= "l4ls_gclk",
+	.user		= OCP_USER_MPU,
+};
+
+/* l3 main -> tpcc */
+struct omap_hwmod_ocp_if am33xx_l3_main__tpcc = {
+	.master		= &am33xx_l3_main_hwmod,
+	.slave		= &am33xx_tpcc_hwmod,
+	.clk		= "l3_gclk",
+	.user		= OCP_USER_MPU,
+};
+
+/* l3 main -> tpcc0 */
+static struct omap_hwmod_addr_space am33xx_tptc0_addr_space[] = {
+	{
+		.pa_start	= 0x49800000,
+		.pa_end		= 0x49800000 + SZ_8K - 1,
+		.flags		= ADDR_TYPE_RT,
+	},
+	{ }
+};
+
+struct omap_hwmod_ocp_if am33xx_l3_main__tptc0 = {
+	.master		= &am33xx_l3_main_hwmod,
+	.slave		= &am33xx_tptc0_hwmod,
+	.clk		= "l3_gclk",
+	.addr		= am33xx_tptc0_addr_space,
+	.user		= OCP_USER_MPU,
+};
+
+/* l3 main -> tpcc1 */
+static struct omap_hwmod_addr_space am33xx_tptc1_addr_space[] = {
+	{
+		.pa_start	= 0x49900000,
+		.pa_end		= 0x49900000 + SZ_8K - 1,
+		.flags		= ADDR_TYPE_RT,
+	},
+	{ }
+};
+
+struct omap_hwmod_ocp_if am33xx_l3_main__tptc1 = {
+	.master		= &am33xx_l3_main_hwmod,
+	.slave		= &am33xx_tptc1_hwmod,
+	.clk		= "l3_gclk",
+	.addr		= am33xx_tptc1_addr_space,
+	.user		= OCP_USER_MPU,
+};
+
+/* l3 main -> tpcc2 */
+static struct omap_hwmod_addr_space am33xx_tptc2_addr_space[] = {
+	{
+		.pa_start	= 0x49a00000,
+		.pa_end		= 0x49a00000 + SZ_8K - 1,
+		.flags		= ADDR_TYPE_RT,
+	},
+	{ }
+};
+
+struct omap_hwmod_ocp_if am33xx_l3_main__tptc2 = {
+	.master		= &am33xx_l3_main_hwmod,
+	.slave		= &am33xx_tptc2_hwmod,
+	.clk		= "l3_gclk",
+	.addr		= am33xx_tptc2_addr_space,
+	.user		= OCP_USER_MPU,
+};
+
+/* l4 ls -> uart2 */
+struct omap_hwmod_ocp_if am33xx_l4_ls__uart2 = {
+	.master		= &am33xx_l4_ls_hwmod,
+	.slave		= &am33xx_uart2_hwmod,
+	.clk		= "l4ls_gclk",
+	.user		= OCP_USER_MPU,
+};
+
+/* l4 ls -> uart3 */
+struct omap_hwmod_ocp_if am33xx_l4_ls__uart3 = {
+	.master		= &am33xx_l4_ls_hwmod,
+	.slave		= &am33xx_uart3_hwmod,
+	.clk		= "l4ls_gclk",
+	.user		= OCP_USER_MPU,
+};
+
+/* l4 ls -> uart4 */
+struct omap_hwmod_ocp_if am33xx_l4_ls__uart4 = {
+	.master		= &am33xx_l4_ls_hwmod,
+	.slave		= &am33xx_uart4_hwmod,
+	.clk		= "l4ls_gclk",
+	.user		= OCP_USER_MPU,
+};
+
+/* l4 ls -> uart5 */
+struct omap_hwmod_ocp_if am33xx_l4_ls__uart5 = {
+	.master		= &am33xx_l4_ls_hwmod,
+	.slave		= &am33xx_uart5_hwmod,
+	.clk		= "l4ls_gclk",
+	.user		= OCP_USER_MPU,
+};
+
+/* l4 ls -> uart6 */
+struct omap_hwmod_ocp_if am33xx_l4_ls__uart6 = {
+	.master		= &am33xx_l4_ls_hwmod,
+	.slave		= &am33xx_uart6_hwmod,
+	.clk		= "l4ls_gclk",
+	.user		= OCP_USER_MPU,
+};
+
+/* l3 main -> ocmc */
+struct omap_hwmod_ocp_if am33xx_l3_main__ocmc = {
+	.master		= &am33xx_l3_main_hwmod,
+	.slave		= &am33xx_ocmcram_hwmod,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* l3 main -> sha0 HIB2 */
+static struct omap_hwmod_addr_space am33xx_sha0_addrs[] = {
+	{
+		.pa_start	= 0x53100000,
+		.pa_end		= 0x53100000 + SZ_512 - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+	{ }
+};
+
+struct omap_hwmod_ocp_if am33xx_l3_main__sha0 = {
+	.master		= &am33xx_l3_main_hwmod,
+	.slave		= &am33xx_sha0_hwmod,
+	.clk		= "sha0_fck",
+	.addr		= am33xx_sha0_addrs,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* l3 main -> AES0 HIB2 */
+static struct omap_hwmod_addr_space am33xx_aes0_addrs[] = {
+	{
+		.pa_start	= 0x53500000,
+		.pa_end		= 0x53500000 + SZ_1M - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+	{ }
+};
+
+struct omap_hwmod_ocp_if am33xx_l3_main__aes0 = {
+	.master		= &am33xx_l3_main_hwmod,
+	.slave		= &am33xx_aes0_hwmod,
+	.clk		= "aes0_fck",
+	.addr		= am33xx_aes0_addrs,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
index 215894f..ce58713 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -29,6 +29,7 @@
 #include "i2c.h"
 #include "mmc.h"
 #include "wd_timer.h"
+#include "omap_hwmod_33xx_43xx_common.h"
 
 /*
  * IP blocks
@@ -1690,14 +1691,6 @@ static struct omap_hwmod_ocp_if am33xx_l3_main__emif = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-/* mpu -> l3 main */
-static struct omap_hwmod_ocp_if am33xx_mpu__l3_main = {
-	.master		= &am33xx_mpu_hwmod,
-	.slave		= &am33xx_l3_main_hwmod,
-	.clk		= "dpll_mpu_m2_ck",
-	.user		= OCP_USER_MPU,
-};
-
 /* l3 main -> l4 hs */
 static struct omap_hwmod_ocp_if am33xx_l3_main__l4_hs = {
 	.master		= &am33xx_l3_main_hwmod,
@@ -1706,62 +1699,6 @@ static struct omap_hwmod_ocp_if am33xx_l3_main__l4_hs = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-/* l3 main -> l3 s */
-static struct omap_hwmod_ocp_if am33xx_l3_main__l3_s = {
-	.master		= &am33xx_l3_main_hwmod,
-	.slave		= &am33xx_l3_s_hwmod,
-	.clk		= "l3s_gclk",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l3 s -> l4 per/ls */
-static struct omap_hwmod_ocp_if am33xx_l3_s__l4_ls = {
-	.master		= &am33xx_l3_s_hwmod,
-	.slave		= &am33xx_l4_ls_hwmod,
-	.clk		= "l3s_gclk",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l3 s -> l4 wkup */
-static struct omap_hwmod_ocp_if am33xx_l3_s__l4_wkup = {
-	.master		= &am33xx_l3_s_hwmod,
-	.slave		= &am33xx_l4_wkup_hwmod,
-	.clk		= "l3s_gclk",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l3 main -> l3 instr */
-static struct omap_hwmod_ocp_if am33xx_l3_main__l3_instr = {
-	.master		= &am33xx_l3_main_hwmod,
-	.slave		= &am33xx_l3_instr_hwmod,
-	.clk		= "l3s_gclk",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* mpu -> prcm */
-static struct omap_hwmod_ocp_if am33xx_mpu__prcm = {
-	.master		= &am33xx_mpu_hwmod,
-	.slave		= &am33xx_prcm_hwmod,
-	.clk		= "dpll_mpu_m2_ck",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l3 s -> l3 main*/
-static struct omap_hwmod_ocp_if am33xx_l3_s__l3_main = {
-	.master		= &am33xx_l3_s_hwmod,
-	.slave		= &am33xx_l3_main_hwmod,
-	.clk		= "l3s_gclk",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* pru-icss -> l3 main */
-static struct omap_hwmod_ocp_if am33xx_pruss__l3_main = {
-	.master		= &am33xx_pruss_hwmod,
-	.slave		= &am33xx_l3_main_hwmod,
-	.clk		= "l3_gclk",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
 /* wkup m3 -> l4 wkup */
 static struct omap_hwmod_ocp_if am33xx_wkup_m3__l4_wkup = {
 	.master		= &am33xx_wkup_m3_hwmod,
@@ -1770,14 +1707,6 @@ static struct omap_hwmod_ocp_if am33xx_wkup_m3__l4_wkup = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-/* gfx -> l3 main */
-static struct omap_hwmod_ocp_if am33xx_gfx__l3_main = {
-	.master		= &am33xx_gfx_hwmod,
-	.slave		= &am33xx_l3_main_hwmod,
-	.clk		= "dpll_core_m4_ck",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
 /* l4 wkup -> wkup m3 */
 static struct omap_hwmod_ocp_if am33xx_l4_wkup__wkup_m3 = {
 	.master		= &am33xx_l4_wkup_hwmod,
@@ -1794,14 +1723,6 @@ static struct omap_hwmod_ocp_if am33xx_l4_hs__pruss = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-/* l3 main -> gfx */
-static struct omap_hwmod_ocp_if am33xx_l3_main__gfx = {
-	.master		= &am33xx_l3_main_hwmod,
-	.slave		= &am33xx_gfx_hwmod,
-	.clk		= "dpll_core_m4_ck",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
 /* l3_main -> debugss */
 static struct omap_hwmod_addr_space am33xx_debugss_addrs[] = {
 	{
@@ -1844,54 +1765,6 @@ static struct omap_hwmod_ocp_if am33xx_l4_wkup__control = {
 	.user		= OCP_USER_MPU,
 };
 
-/* l4 wkup -> rtc */
-static struct omap_hwmod_ocp_if am33xx_l4_wkup__rtc = {
-	.master		= &am33xx_l4_wkup_hwmod,
-	.slave		= &am33xx_rtc_hwmod,
-	.clk		= "clkdiv32k_ick",
-	.user		= OCP_USER_MPU,
-};
-
-/* l4 per/ls -> DCAN0 */
-static struct omap_hwmod_ocp_if am33xx_l4_per__dcan0 = {
-	.master		= &am33xx_l4_ls_hwmod,
-	.slave		= &am33xx_dcan0_hwmod,
-	.clk		= "l4ls_gclk",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4 per/ls -> DCAN1 */
-static struct omap_hwmod_ocp_if am33xx_l4_per__dcan1 = {
-	.master		= &am33xx_l4_ls_hwmod,
-	.slave		= &am33xx_dcan1_hwmod,
-	.clk		= "l4ls_gclk",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4 per/ls -> GPIO2 */
-static struct omap_hwmod_ocp_if am33xx_l4_per__gpio1 = {
-	.master		= &am33xx_l4_ls_hwmod,
-	.slave		= &am33xx_gpio1_hwmod,
-	.clk		= "l4ls_gclk",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4 per/ls -> gpio3 */
-static struct omap_hwmod_ocp_if am33xx_l4_per__gpio2 = {
-	.master		= &am33xx_l4_ls_hwmod,
-	.slave		= &am33xx_gpio2_hwmod,
-	.clk		= "l4ls_gclk",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4 per/ls -> gpio4 */
-static struct omap_hwmod_ocp_if am33xx_l4_per__gpio3 = {
-	.master		= &am33xx_l4_ls_hwmod,
-	.slave		= &am33xx_gpio3_hwmod,
-	.clk		= "l4ls_gclk",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
 /* L4 WKUP -> I2C1 */
 static struct omap_hwmod_ocp_if am33xx_l4_wkup__i2c1 = {
 	.master		= &am33xx_l4_wkup_hwmod,
@@ -1933,177 +1806,6 @@ static struct omap_hwmod_ocp_if am33xx_l4_hs__cpgmac0 = {
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_ocp_if am33xx_cpgmac0__mdio = {
-	.master		= &am33xx_cpgmac0_hwmod,
-	.slave		= &am33xx_mdio_hwmod,
-	.user		= OCP_USER_MPU,
-};
-
-static struct omap_hwmod_addr_space am33xx_elm_addr_space[] = {
-	{
-		.pa_start	= 0x48080000,
-		.pa_end		= 0x48080000 + SZ_8K - 1,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
-static struct omap_hwmod_ocp_if am33xx_l4_ls__elm = {
-	.master		= &am33xx_l4_ls_hwmod,
-	.slave		= &am33xx_elm_hwmod,
-	.clk		= "l4ls_gclk",
-	.addr		= am33xx_elm_addr_space,
-	.user		= OCP_USER_MPU,
-};
-
-static struct omap_hwmod_addr_space am33xx_epwmss0_addr_space[] = {
-	{
-		.pa_start	= 0x48300000,
-		.pa_end		= 0x48300000 + SZ_16 - 1,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
-static struct omap_hwmod_ocp_if am33xx_l4_ls__epwmss0 = {
-	.master		= &am33xx_l4_ls_hwmod,
-	.slave		= &am33xx_epwmss0_hwmod,
-	.clk		= "l4ls_gclk",
-	.addr		= am33xx_epwmss0_addr_space,
-	.user		= OCP_USER_MPU,
-};
-
-static struct omap_hwmod_ocp_if am33xx_epwmss0__ecap0 = {
-	.master		= &am33xx_epwmss0_hwmod,
-	.slave		= &am33xx_ecap0_hwmod,
-	.clk		= "l4ls_gclk",
-	.user		= OCP_USER_MPU,
-};
-
-static struct omap_hwmod_ocp_if am33xx_epwmss0__eqep0 = {
-	.master		= &am33xx_epwmss0_hwmod,
-	.slave		= &am33xx_eqep0_hwmod,
-	.clk		= "l4ls_gclk",
-	.user		= OCP_USER_MPU,
-};
-
-static struct omap_hwmod_ocp_if am33xx_epwmss0__ehrpwm0 = {
-	.master		= &am33xx_epwmss0_hwmod,
-	.slave		= &am33xx_ehrpwm0_hwmod,
-	.clk		= "l4ls_gclk",
-	.user		= OCP_USER_MPU,
-};
-
-
-static struct omap_hwmod_addr_space am33xx_epwmss1_addr_space[] = {
-	{
-		.pa_start	= 0x48302000,
-		.pa_end		= 0x48302000 + SZ_16 - 1,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
-static struct omap_hwmod_ocp_if am33xx_l4_ls__epwmss1 = {
-	.master		= &am33xx_l4_ls_hwmod,
-	.slave		= &am33xx_epwmss1_hwmod,
-	.clk		= "l4ls_gclk",
-	.addr		= am33xx_epwmss1_addr_space,
-	.user		= OCP_USER_MPU,
-};
-
-static struct omap_hwmod_ocp_if am33xx_epwmss1__ecap1 = {
-	.master		= &am33xx_epwmss1_hwmod,
-	.slave		= &am33xx_ecap1_hwmod,
-	.clk		= "l4ls_gclk",
-	.user		= OCP_USER_MPU,
-};
-
-static struct omap_hwmod_ocp_if am33xx_epwmss1__eqep1 = {
-	.master		= &am33xx_epwmss1_hwmod,
-	.slave		= &am33xx_eqep1_hwmod,
-	.clk		= "l4ls_gclk",
-	.user		= OCP_USER_MPU,
-};
-
-static struct omap_hwmod_ocp_if am33xx_epwmss1__ehrpwm1 = {
-	.master		= &am33xx_epwmss1_hwmod,
-	.slave		= &am33xx_ehrpwm1_hwmod,
-	.clk		= "l4ls_gclk",
-	.user		= OCP_USER_MPU,
-};
-
-static struct omap_hwmod_addr_space am33xx_epwmss2_addr_space[] = {
-	{
-		.pa_start	= 0x48304000,
-		.pa_end		= 0x48304000 + SZ_16 - 1,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
-static struct omap_hwmod_ocp_if am33xx_l4_ls__epwmss2 = {
-	.master		= &am33xx_l4_ls_hwmod,
-	.slave		= &am33xx_epwmss2_hwmod,
-	.clk		= "l4ls_gclk",
-	.addr		= am33xx_epwmss2_addr_space,
-	.user		= OCP_USER_MPU,
-};
-
-static struct omap_hwmod_ocp_if am33xx_epwmss2__ecap2 = {
-	.master		= &am33xx_epwmss2_hwmod,
-	.slave		= &am33xx_ecap2_hwmod,
-	.clk		= "l4ls_gclk",
-	.user		= OCP_USER_MPU,
-};
-
-static struct omap_hwmod_ocp_if am33xx_epwmss2__eqep2 = {
-	.master		= &am33xx_epwmss2_hwmod,
-	.slave		= &am33xx_eqep2_hwmod,
-	.clk		= "l4ls_gclk",
-	.user		= OCP_USER_MPU,
-};
-
-static struct omap_hwmod_ocp_if am33xx_epwmss2__ehrpwm2 = {
-	.master		= &am33xx_epwmss2_hwmod,
-	.slave		= &am33xx_ehrpwm2_hwmod,
-	.clk		= "l4ls_gclk",
-	.user		= OCP_USER_MPU,
-};
-
-/* l3s cfg -> gpmc */
-static struct omap_hwmod_addr_space am33xx_gpmc_addr_space[] = {
-	{
-		.pa_start	= 0x50000000,
-		.pa_end		= 0x50000000 + SZ_8K - 1,
-		.flags		= ADDR_TYPE_RT,
-	},
-	{ }
-};
-
-static struct omap_hwmod_ocp_if am33xx_l3_s__gpmc = {
-	.master		= &am33xx_l3_s_hwmod,
-	.slave		= &am33xx_gpmc_hwmod,
-	.clk		= "l3s_gclk",
-	.addr		= am33xx_gpmc_addr_space,
-	.user		= OCP_USER_MPU,
-};
-
-/* i2c2 */
-static struct omap_hwmod_ocp_if am33xx_l4_per__i2c2 = {
-	.master		= &am33xx_l4_ls_hwmod,
-	.slave		= &am33xx_i2c2_hwmod,
-	.clk		= "l4ls_gclk",
-	.user		= OCP_USER_MPU,
-};
-
-static struct omap_hwmod_ocp_if am33xx_l4_per__i2c3 = {
-	.master		= &am33xx_l4_ls_hwmod,
-	.slave		= &am33xx_i2c3_hwmod,
-	.clk		= "l4ls_gclk",
-	.user		= OCP_USER_MPU,
-};
-
 static struct omap_hwmod_addr_space am33xx_lcdc_addr_space[] = {
 	{
 		.pa_start	= 0x4830E000,
@@ -2121,138 +1823,6 @@ static struct omap_hwmod_ocp_if am33xx_l3_main__lcdc = {
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_addr_space am33xx_mailbox_addrs[] = {
-	{
-		.pa_start	= 0x480C8000,
-		.pa_end		= 0x480C8000 + (SZ_4K - 1),
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
-/* l4 ls -> mailbox */
-static struct omap_hwmod_ocp_if am33xx_l4_per__mailbox = {
-	.master		= &am33xx_l4_ls_hwmod,
-	.slave		= &am33xx_mailbox_hwmod,
-	.clk		= "l4ls_gclk",
-	.addr		= am33xx_mailbox_addrs,
-	.user		= OCP_USER_MPU,
-};
-
-/* l4 ls -> spinlock */
-static struct omap_hwmod_ocp_if am33xx_l4_ls__spinlock = {
-	.master		= &am33xx_l4_ls_hwmod,
-	.slave		= &am33xx_spinlock_hwmod,
-	.clk		= "l4ls_gclk",
-	.user		= OCP_USER_MPU,
-};
-
-/* l4 ls -> mcasp0 */
-static struct omap_hwmod_addr_space am33xx_mcasp0_addr_space[] = {
-	{
-		.pa_start	= 0x48038000,
-		.pa_end		= 0x48038000 + SZ_8K - 1,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
-static struct omap_hwmod_ocp_if am33xx_l4_ls__mcasp0 = {
-	.master		= &am33xx_l4_ls_hwmod,
-	.slave		= &am33xx_mcasp0_hwmod,
-	.clk		= "l4ls_gclk",
-	.addr		= am33xx_mcasp0_addr_space,
-	.user		= OCP_USER_MPU,
-};
-
-/* l4 ls -> mcasp1 */
-static struct omap_hwmod_addr_space am33xx_mcasp1_addr_space[] = {
-	{
-		.pa_start	= 0x4803C000,
-		.pa_end		= 0x4803C000 + SZ_8K - 1,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
-static struct omap_hwmod_ocp_if am33xx_l4_ls__mcasp1 = {
-	.master		= &am33xx_l4_ls_hwmod,
-	.slave		= &am33xx_mcasp1_hwmod,
-	.clk		= "l4ls_gclk",
-	.addr		= am33xx_mcasp1_addr_space,
-	.user		= OCP_USER_MPU,
-};
-
-/* l4 ls -> mmc0 */
-static struct omap_hwmod_addr_space am33xx_mmc0_addr_space[] = {
-	{
-		.pa_start	= 0x48060100,
-		.pa_end		= 0x48060100 + SZ_4K - 1,
-		.flags		= ADDR_TYPE_RT,
-	},
-	{ }
-};
-
-static struct omap_hwmod_ocp_if am33xx_l4_ls__mmc0 = {
-	.master		= &am33xx_l4_ls_hwmod,
-	.slave		= &am33xx_mmc0_hwmod,
-	.clk		= "l4ls_gclk",
-	.addr		= am33xx_mmc0_addr_space,
-	.user		= OCP_USER_MPU,
-};
-
-/* l4 ls -> mmc1 */
-static struct omap_hwmod_addr_space am33xx_mmc1_addr_space[] = {
-	{
-		.pa_start	= 0x481d8100,
-		.pa_end		= 0x481d8100 + SZ_4K - 1,
-		.flags		= ADDR_TYPE_RT,
-	},
-	{ }
-};
-
-static struct omap_hwmod_ocp_if am33xx_l4_ls__mmc1 = {
-	.master		= &am33xx_l4_ls_hwmod,
-	.slave		= &am33xx_mmc1_hwmod,
-	.clk		= "l4ls_gclk",
-	.addr		= am33xx_mmc1_addr_space,
-	.user		= OCP_USER_MPU,
-};
-
-/* l3 s -> mmc2 */
-static struct omap_hwmod_addr_space am33xx_mmc2_addr_space[] = {
-	{
-		.pa_start	= 0x47810100,
-		.pa_end		= 0x47810100 + SZ_64K - 1,
-		.flags		= ADDR_TYPE_RT,
-	},
-	{ }
-};
-
-static struct omap_hwmod_ocp_if am33xx_l3_s__mmc2 = {
-	.master		= &am33xx_l3_s_hwmod,
-	.slave		= &am33xx_mmc2_hwmod,
-	.clk		= "l3s_gclk",
-	.addr		= am33xx_mmc2_addr_space,
-	.user		= OCP_USER_MPU,
-};
-
-/* l4 ls -> mcspi0 */
-static struct omap_hwmod_ocp_if am33xx_l4_ls__mcspi0 = {
-	.master		= &am33xx_l4_ls_hwmod,
-	.slave		= &am33xx_spi0_hwmod,
-	.clk		= "l4ls_gclk",
-	.user		= OCP_USER_MPU,
-};
-
-/* l4 ls -> mcspi1 */
-static struct omap_hwmod_ocp_if am33xx_l4_ls__mcspi1 = {
-	.master		= &am33xx_l4_ls_hwmod,
-	.slave		= &am33xx_spi1_hwmod,
-	.clk		= "l4ls_gclk",
-	.user		= OCP_USER_MPU,
-};
-
 /* l4 wkup -> timer1 */
 static struct omap_hwmod_ocp_if am33xx_l4_wkup__timer1 = {
 	.master		= &am33xx_l4_wkup_hwmod,
@@ -2261,116 +1831,6 @@ static struct omap_hwmod_ocp_if am33xx_l4_wkup__timer1 = {
 	.user		= OCP_USER_MPU,
 };
 
-/* l4 per -> timer2 */
-static struct omap_hwmod_ocp_if am33xx_l4_ls__timer2 = {
-	.master		= &am33xx_l4_ls_hwmod,
-	.slave		= &am33xx_timer2_hwmod,
-	.clk		= "l4ls_gclk",
-	.user		= OCP_USER_MPU,
-};
-
-/* l4 per -> timer3 */
-static struct omap_hwmod_ocp_if am33xx_l4_ls__timer3 = {
-	.master		= &am33xx_l4_ls_hwmod,
-	.slave		= &am33xx_timer3_hwmod,
-	.clk		= "l4ls_gclk",
-	.user		= OCP_USER_MPU,
-};
-
-/* l4 per -> timer4 */
-static struct omap_hwmod_ocp_if am33xx_l4_ls__timer4 = {
-	.master		= &am33xx_l4_ls_hwmod,
-	.slave		= &am33xx_timer4_hwmod,
-	.clk		= "l4ls_gclk",
-	.user		= OCP_USER_MPU,
-};
-
-/* l4 per -> timer5 */
-static struct omap_hwmod_ocp_if am33xx_l4_ls__timer5 = {
-	.master		= &am33xx_l4_ls_hwmod,
-	.slave		= &am33xx_timer5_hwmod,
-	.clk		= "l4ls_gclk",
-	.user		= OCP_USER_MPU,
-};
-
-/* l4 per -> timer6 */
-static struct omap_hwmod_ocp_if am33xx_l4_ls__timer6 = {
-	.master		= &am33xx_l4_ls_hwmod,
-	.slave		= &am33xx_timer6_hwmod,
-	.clk		= "l4ls_gclk",
-	.user		= OCP_USER_MPU,
-};
-
-/* l4 per -> timer7 */
-static struct omap_hwmod_ocp_if am33xx_l4_ls__timer7 = {
-	.master		= &am33xx_l4_ls_hwmod,
-	.slave		= &am33xx_timer7_hwmod,
-	.clk		= "l4ls_gclk",
-	.user		= OCP_USER_MPU,
-};
-
-/* l3 main -> tpcc */
-static struct omap_hwmod_ocp_if am33xx_l3_main__tpcc = {
-	.master		= &am33xx_l3_main_hwmod,
-	.slave		= &am33xx_tpcc_hwmod,
-	.clk		= "l3_gclk",
-	.user		= OCP_USER_MPU,
-};
-
-/* l3 main -> tpcc0 */
-static struct omap_hwmod_addr_space am33xx_tptc0_addr_space[] = {
-	{
-		.pa_start	= 0x49800000,
-		.pa_end		= 0x49800000 + SZ_8K - 1,
-		.flags		= ADDR_TYPE_RT,
-	},
-	{ }
-};
-
-static struct omap_hwmod_ocp_if am33xx_l3_main__tptc0 = {
-	.master		= &am33xx_l3_main_hwmod,
-	.slave		= &am33xx_tptc0_hwmod,
-	.clk		= "l3_gclk",
-	.addr		= am33xx_tptc0_addr_space,
-	.user		= OCP_USER_MPU,
-};
-
-/* l3 main -> tpcc1 */
-static struct omap_hwmod_addr_space am33xx_tptc1_addr_space[] = {
-	{
-		.pa_start	= 0x49900000,
-		.pa_end		= 0x49900000 + SZ_8K - 1,
-		.flags		= ADDR_TYPE_RT,
-	},
-	{ }
-};
-
-static struct omap_hwmod_ocp_if am33xx_l3_main__tptc1 = {
-	.master		= &am33xx_l3_main_hwmod,
-	.slave		= &am33xx_tptc1_hwmod,
-	.clk		= "l3_gclk",
-	.addr		= am33xx_tptc1_addr_space,
-	.user		= OCP_USER_MPU,
-};
-
-/* l3 main -> tpcc2 */
-static struct omap_hwmod_addr_space am33xx_tptc2_addr_space[] = {
-	{
-		.pa_start	= 0x49a00000,
-		.pa_end		= 0x49a00000 + SZ_8K - 1,
-		.flags		= ADDR_TYPE_RT,
-	},
-	{ }
-};
-
-static struct omap_hwmod_ocp_if am33xx_l3_main__tptc2 = {
-	.master		= &am33xx_l3_main_hwmod,
-	.slave		= &am33xx_tptc2_hwmod,
-	.clk		= "l3_gclk",
-	.addr		= am33xx_tptc2_addr_space,
-	.user		= OCP_USER_MPU,
-};
-
 /* l4 wkup -> uart1 */
 static struct omap_hwmod_ocp_if am33xx_l4_wkup__uart1 = {
 	.master		= &am33xx_l4_wkup_hwmod,
@@ -2379,46 +1839,6 @@ static struct omap_hwmod_ocp_if am33xx_l4_wkup__uart1 = {
 	.user		= OCP_USER_MPU,
 };
 
-/* l4 ls -> uart2 */
-static struct omap_hwmod_ocp_if am33xx_l4_ls__uart2 = {
-	.master		= &am33xx_l4_ls_hwmod,
-	.slave		= &am33xx_uart2_hwmod,
-	.clk		= "l4ls_gclk",
-	.user		= OCP_USER_MPU,
-};
-
-/* l4 ls -> uart3 */
-static struct omap_hwmod_ocp_if am33xx_l4_ls__uart3 = {
-	.master		= &am33xx_l4_ls_hwmod,
-	.slave		= &am33xx_uart3_hwmod,
-	.clk		= "l4ls_gclk",
-	.user		= OCP_USER_MPU,
-};
-
-/* l4 ls -> uart4 */
-static struct omap_hwmod_ocp_if am33xx_l4_ls__uart4 = {
-	.master		= &am33xx_l4_ls_hwmod,
-	.slave		= &am33xx_uart4_hwmod,
-	.clk		= "l4ls_gclk",
-	.user		= OCP_USER_MPU,
-};
-
-/* l4 ls -> uart5 */
-static struct omap_hwmod_ocp_if am33xx_l4_ls__uart5 = {
-	.master		= &am33xx_l4_ls_hwmod,
-	.slave		= &am33xx_uart5_hwmod,
-	.clk		= "l4ls_gclk",
-	.user		= OCP_USER_MPU,
-};
-
-/* l4 ls -> uart6 */
-static struct omap_hwmod_ocp_if am33xx_l4_ls__uart6 = {
-	.master		= &am33xx_l4_ls_hwmod,
-	.slave		= &am33xx_uart6_hwmod,
-	.clk		= "l4ls_gclk",
-	.user		= OCP_USER_MPU,
-};
-
 /* l4 wkup -> wd_timer1 */
 static struct omap_hwmod_ocp_if am33xx_l4_wkup__wd_timer1 = {
 	.master		= &am33xx_l4_wkup_hwmod,
@@ -2437,49 +1857,6 @@ static struct omap_hwmod_ocp_if am33xx_l3_s__usbss = {
 	.flags		= OCPIF_SWSUP_IDLE,
 };
 
-/* l3 main -> ocmc */
-static struct omap_hwmod_ocp_if am33xx_l3_main__ocmc = {
-	.master		= &am33xx_l3_main_hwmod,
-	.slave		= &am33xx_ocmcram_hwmod,
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l3 main -> sha0 HIB2 */
-static struct omap_hwmod_addr_space am33xx_sha0_addrs[] = {
-	{
-		.pa_start	= 0x53100000,
-		.pa_end		= 0x53100000 + SZ_512 - 1,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
-static struct omap_hwmod_ocp_if am33xx_l3_main__sha0 = {
-	.master		= &am33xx_l3_main_hwmod,
-	.slave		= &am33xx_sha0_hwmod,
-	.clk		= "sha0_fck",
-	.addr		= am33xx_sha0_addrs,
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l3 main -> AES0 HIB2 */
-static struct omap_hwmod_addr_space am33xx_aes0_addrs[] = {
-	{
-		.pa_start	= 0x53500000,
-		.pa_end		= 0x53500000 + SZ_1M - 1,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
-static struct omap_hwmod_ocp_if am33xx_l3_main__aes0 = {
-	.master		= &am33xx_l3_main_hwmod,
-	.slave		= &am33xx_aes0_hwmod,
-	.clk		= "aes0_fck",
-	.addr		= am33xx_aes0_addrs,
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
 static struct omap_hwmod_ocp_if *am33xx_hwmod_ocp_ifs[] __initdata = {
 	&am33xx_l3_main__emif,
 	&am33xx_mpu__l3_main,
-- 
1.8.3.4

