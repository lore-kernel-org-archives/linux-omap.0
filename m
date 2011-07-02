From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/7] omap_hwmod: share identical omap_hwmod_addr_space arrays
Date: Sat, 02 Jul 2011 02:44:50 -0600
Message-ID: <20110702084446.582.70442.stgit@dusk>
References: <20110702084348.582.65635.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44627 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870Ab1GBIp5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 2 Jul 2011 04:45:57 -0400
In-Reply-To: <20110702084348.582.65635.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

To reduce kernel source file data duplication, share struct
omap_hwmod_addr_space arrays across OMAP2xxx and 3xxx hwmod data
files.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/Makefile                       |   11 +
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |  291 ++----------=
------
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |  319 ++----------=
--------
 .../omap_hwmod_2xxx_3xxx_interconnect_data.c       |  173 +++++++++++
 .../mach-omap2/omap_hwmod_2xxx_interconnect_data.c |  130 ++++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |  151 +--------
 arch/arm/mach-omap2/omap_hwmod_common_data.h       |   38 ++
 7 files changed, 414 insertions(+), 699 deletions(-)
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_interconne=
ct_data.c
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_da=
ta.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefil=
e
index b148077..cafee7b 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -145,9 +145,14 @@ obj-$(CONFIG_SOC_OMAP2420)		+=3D opp2420_data.o
 obj-$(CONFIG_SOC_OMAP2430)		+=3D opp2430_data.o
=20
 # hwmod data
-obj-$(CONFIG_SOC_OMAP2420)		+=3D omap_hwmod_2420_data.o
-obj-$(CONFIG_SOC_OMAP2430)		+=3D omap_hwmod_2430_data.o
-obj-$(CONFIG_ARCH_OMAP3)		+=3D omap_hwmod_3xxx_data.o
+obj-$(CONFIG_SOC_OMAP2420)		+=3D omap_hwmod_2xxx_interconnect_data.o \
+					   omap_hwmod_2xxx_3xxx_interconnect_data.o \
+					   omap_hwmod_2420_data.o
+obj-$(CONFIG_SOC_OMAP2430)		+=3D omap_hwmod_2xxx_interconnect_data.o \
+					   omap_hwmod_2xxx_3xxx_interconnect_data.o \
+					   omap_hwmod_2430_data.o
+obj-$(CONFIG_ARCH_OMAP3)		+=3D omap_hwmod_2xxx_3xxx_interconnect_data.=
o \
+					   omap_hwmod_3xxx_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+=3D omap_hwmod_44xx_data.o
=20
 # EMU peripherals
diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach=
-omap2/omap_hwmod_2420_data.c
index 1a7ce3e..3ec625c 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -114,38 +114,20 @@ static struct omap_hwmod omap2420_mcbsp1_hwmod;
 static struct omap_hwmod omap2420_mcbsp2_hwmod;
=20
 /* l4 core -> mcspi1 interface */
-static struct omap_hwmod_addr_space omap2420_mcspi1_addr_space[] =3D {
-	{
-		.pa_start	=3D 0x48098000,
-		.pa_end		=3D 0x480980ff,
-		.flags		=3D ADDR_TYPE_RT,
-	},
-	{ }
-};
-
 static struct omap_hwmod_ocp_if omap2420_l4_core__mcspi1 =3D {
 	.master		=3D &omap2420_l4_core_hwmod,
 	.slave		=3D &omap2420_mcspi1_hwmod,
 	.clk		=3D "mcspi1_ick",
-	.addr		=3D omap2420_mcspi1_addr_space,
+	.addr		=3D omap2_mcspi1_addr_space,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
 /* l4 core -> mcspi2 interface */
-static struct omap_hwmod_addr_space omap2420_mcspi2_addr_space[] =3D {
-	{
-		.pa_start	=3D 0x4809a000,
-		.pa_end		=3D 0x4809a0ff,
-		.flags		=3D ADDR_TYPE_RT,
-	},
-	{ }
-};
-
 static struct omap_hwmod_ocp_if omap2420_l4_core__mcspi2 =3D {
 	.master		=3D &omap2420_l4_core_hwmod,
 	.slave		=3D &omap2420_mcspi2_hwmod,
 	.clk		=3D "mcspi2_ick",
-	.addr		=3D omap2420_mcspi2_addr_space,
+	.addr		=3D omap2_mcspi2_addr_space,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
@@ -157,95 +139,47 @@ static struct omap_hwmod_ocp_if omap2420_l4_core_=
_l4_wkup =3D {
 };
=20
 /* L4 CORE -> UART1 interface */
-static struct omap_hwmod_addr_space omap2420_uart1_addr_space[] =3D {
-	{
-		.pa_start	=3D OMAP2_UART1_BASE,
-		.pa_end		=3D OMAP2_UART1_BASE + SZ_8K - 1,
-		.flags		=3D ADDR_MAP_ON_INIT | ADDR_TYPE_RT,
-	},
-	{ }
-};
-
 static struct omap_hwmod_ocp_if omap2_l4_core__uart1 =3D {
 	.master		=3D &omap2420_l4_core_hwmod,
 	.slave		=3D &omap2420_uart1_hwmod,
 	.clk		=3D "uart1_ick",
-	.addr		=3D omap2420_uart1_addr_space,
+	.addr		=3D omap2xxx_uart1_addr_space,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
 /* L4 CORE -> UART2 interface */
-static struct omap_hwmod_addr_space omap2420_uart2_addr_space[] =3D {
-	{
-		.pa_start	=3D OMAP2_UART2_BASE,
-		.pa_end		=3D OMAP2_UART2_BASE + SZ_1K - 1,
-		.flags		=3D ADDR_MAP_ON_INIT | ADDR_TYPE_RT,
-	},
-	{ }
-};
-
 static struct omap_hwmod_ocp_if omap2_l4_core__uart2 =3D {
 	.master		=3D &omap2420_l4_core_hwmod,
 	.slave		=3D &omap2420_uart2_hwmod,
 	.clk		=3D "uart2_ick",
-	.addr		=3D omap2420_uart2_addr_space,
+	.addr		=3D omap2xxx_uart2_addr_space,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
 /* L4 PER -> UART3 interface */
-static struct omap_hwmod_addr_space omap2420_uart3_addr_space[] =3D {
-	{
-		.pa_start	=3D OMAP2_UART3_BASE,
-		.pa_end		=3D OMAP2_UART3_BASE + SZ_1K - 1,
-		.flags		=3D ADDR_MAP_ON_INIT | ADDR_TYPE_RT,
-	},
-	{ }
-};
-
 static struct omap_hwmod_ocp_if omap2_l4_core__uart3 =3D {
 	.master		=3D &omap2420_l4_core_hwmod,
 	.slave		=3D &omap2420_uart3_hwmod,
 	.clk		=3D "uart3_ick",
-	.addr		=3D omap2420_uart3_addr_space,
+	.addr		=3D omap2xxx_uart3_addr_space,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-/* I2C IP block address space length (in bytes) */
-#define OMAP2_I2C_AS_LEN		128
-
 /* L4 CORE -> I2C1 interface */
-static struct omap_hwmod_addr_space omap2420_i2c1_addr_space[] =3D {
-	{
-		.pa_start	=3D 0x48070000,
-		.pa_end		=3D 0x48070000 + OMAP2_I2C_AS_LEN - 1,
-		.flags		=3D ADDR_TYPE_RT,
-	},
-	{ }
-};
-
 static struct omap_hwmod_ocp_if omap2420_l4_core__i2c1 =3D {
 	.master		=3D &omap2420_l4_core_hwmod,
 	.slave		=3D &omap2420_i2c1_hwmod,
 	.clk		=3D "i2c1_ick",
-	.addr		=3D omap2420_i2c1_addr_space,
+	.addr		=3D omap2_i2c1_addr_space,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
 /* L4 CORE -> I2C2 interface */
-static struct omap_hwmod_addr_space omap2420_i2c2_addr_space[] =3D {
-	{
-		.pa_start	=3D 0x48072000,
-		.pa_end		=3D 0x48072000 + OMAP2_I2C_AS_LEN - 1,
-		.flags		=3D ADDR_TYPE_RT,
-	},
-	{ }
-};
-
 static struct omap_hwmod_ocp_if omap2420_l4_core__i2c2 =3D {
 	.master		=3D &omap2420_l4_core_hwmod,
 	.slave		=3D &omap2420_i2c2_hwmod,
 	.clk		=3D "i2c2_ick",
-	.addr		=3D omap2420_i2c2_addr_space,
+	.addr		=3D omap2_i2c2_addr_space,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
@@ -414,21 +348,13 @@ static struct omap_hwmod_irq_info omap2420_timer2=
_mpu_irqs[] =3D {
 	{ .irq =3D 38, },
 };
=20
-static struct omap_hwmod_addr_space omap2420_timer2_addrs[] =3D {
-	{
-		.pa_start	=3D 0x4802a000,
-		.pa_end		=3D 0x4802a000 + SZ_1K - 1,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
=20
 /* l4_core -> timer2 */
 static struct omap_hwmod_ocp_if omap2420_l4_core__timer2 =3D {
 	.master		=3D &omap2420_l4_core_hwmod,
 	.slave		=3D &omap2420_timer2_hwmod,
 	.clk		=3D "gpt2_ick",
-	.addr		=3D omap2420_timer2_addrs,
+	.addr		=3D omap2xxx_timer2_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
@@ -464,21 +390,12 @@ static struct omap_hwmod_irq_info omap2420_timer3=
_mpu_irqs[] =3D {
 	{ .irq =3D 39, },
 };
=20
-static struct omap_hwmod_addr_space omap2420_timer3_addrs[] =3D {
-	{
-		.pa_start	=3D 0x48078000,
-		.pa_end		=3D 0x48078000 + SZ_1K - 1,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_core -> timer3 */
 static struct omap_hwmod_ocp_if omap2420_l4_core__timer3 =3D {
 	.master		=3D &omap2420_l4_core_hwmod,
 	.slave		=3D &omap2420_timer3_hwmod,
 	.clk		=3D "gpt3_ick",
-	.addr		=3D omap2420_timer3_addrs,
+	.addr		=3D omap2xxx_timer3_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
@@ -514,21 +431,12 @@ static struct omap_hwmod_irq_info omap2420_timer4=
_mpu_irqs[] =3D {
 	{ .irq =3D 40, },
 };
=20
-static struct omap_hwmod_addr_space omap2420_timer4_addrs[] =3D {
-	{
-		.pa_start	=3D 0x4807a000,
-		.pa_end		=3D 0x4807a000 + SZ_1K - 1,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_core -> timer4 */
 static struct omap_hwmod_ocp_if omap2420_l4_core__timer4 =3D {
 	.master		=3D &omap2420_l4_core_hwmod,
 	.slave		=3D &omap2420_timer4_hwmod,
 	.clk		=3D "gpt4_ick",
-	.addr		=3D omap2420_timer4_addrs,
+	.addr		=3D omap2xxx_timer4_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
@@ -564,21 +472,12 @@ static struct omap_hwmod_irq_info omap2420_timer5=
_mpu_irqs[] =3D {
 	{ .irq =3D 41, },
 };
=20
-static struct omap_hwmod_addr_space omap2420_timer5_addrs[] =3D {
-	{
-		.pa_start	=3D 0x4807c000,
-		.pa_end		=3D 0x4807c000 + SZ_1K - 1,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_core -> timer5 */
 static struct omap_hwmod_ocp_if omap2420_l4_core__timer5 =3D {
 	.master		=3D &omap2420_l4_core_hwmod,
 	.slave		=3D &omap2420_timer5_hwmod,
 	.clk		=3D "gpt5_ick",
-	.addr		=3D omap2420_timer5_addrs,
+	.addr		=3D omap2xxx_timer5_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
@@ -615,21 +514,12 @@ static struct omap_hwmod_irq_info omap2420_timer6=
_mpu_irqs[] =3D {
 	{ .irq =3D 42, },
 };
=20
-static struct omap_hwmod_addr_space omap2420_timer6_addrs[] =3D {
-	{
-		.pa_start	=3D 0x4807e000,
-		.pa_end		=3D 0x4807e000 + SZ_1K - 1,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_core -> timer6 */
 static struct omap_hwmod_ocp_if omap2420_l4_core__timer6 =3D {
 	.master		=3D &omap2420_l4_core_hwmod,
 	.slave		=3D &omap2420_timer6_hwmod,
 	.clk		=3D "gpt6_ick",
-	.addr		=3D omap2420_timer6_addrs,
+	.addr		=3D omap2xxx_timer6_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
@@ -665,21 +555,12 @@ static struct omap_hwmod_irq_info omap2420_timer7=
_mpu_irqs[] =3D {
 	{ .irq =3D 43, },
 };
=20
-static struct omap_hwmod_addr_space omap2420_timer7_addrs[] =3D {
-	{
-		.pa_start	=3D 0x48080000,
-		.pa_end		=3D 0x48080000 + SZ_1K - 1,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_core -> timer7 */
 static struct omap_hwmod_ocp_if omap2420_l4_core__timer7 =3D {
 	.master		=3D &omap2420_l4_core_hwmod,
 	.slave		=3D &omap2420_timer7_hwmod,
 	.clk		=3D "gpt7_ick",
-	.addr		=3D omap2420_timer7_addrs,
+	.addr		=3D omap2xxx_timer7_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
@@ -715,21 +596,12 @@ static struct omap_hwmod_irq_info omap2420_timer8=
_mpu_irqs[] =3D {
 	{ .irq =3D 44, },
 };
=20
-static struct omap_hwmod_addr_space omap2420_timer8_addrs[] =3D {
-	{
-		.pa_start	=3D 0x48082000,
-		.pa_end		=3D 0x48082000 + SZ_1K - 1,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_core -> timer8 */
 static struct omap_hwmod_ocp_if omap2420_l4_core__timer8 =3D {
 	.master		=3D &omap2420_l4_core_hwmod,
 	.slave		=3D &omap2420_timer8_hwmod,
 	.clk		=3D "gpt8_ick",
-	.addr		=3D omap2420_timer8_addrs,
+	.addr		=3D omap2xxx_timer8_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
@@ -765,21 +637,12 @@ static struct omap_hwmod_irq_info omap2420_timer9=
_mpu_irqs[] =3D {
 	{ .irq =3D 45, },
 };
=20
-static struct omap_hwmod_addr_space omap2420_timer9_addrs[] =3D {
-	{
-		.pa_start	=3D 0x48084000,
-		.pa_end		=3D 0x48084000 + SZ_1K - 1,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_core -> timer9 */
 static struct omap_hwmod_ocp_if omap2420_l4_core__timer9 =3D {
 	.master		=3D &omap2420_l4_core_hwmod,
 	.slave		=3D &omap2420_timer9_hwmod,
 	.clk		=3D "gpt9_ick",
-	.addr		=3D omap2420_timer9_addrs,
+	.addr		=3D omap2xxx_timer9_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
@@ -815,21 +678,12 @@ static struct omap_hwmod_irq_info omap2420_timer1=
0_mpu_irqs[] =3D {
 	{ .irq =3D 46, },
 };
=20
-static struct omap_hwmod_addr_space omap2420_timer10_addrs[] =3D {
-	{
-		.pa_start	=3D 0x48086000,
-		.pa_end		=3D 0x48086000 + SZ_1K - 1,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_core -> timer10 */
 static struct omap_hwmod_ocp_if omap2420_l4_core__timer10 =3D {
 	.master		=3D &omap2420_l4_core_hwmod,
 	.slave		=3D &omap2420_timer10_hwmod,
 	.clk		=3D "gpt10_ick",
-	.addr		=3D omap2420_timer10_addrs,
+	.addr		=3D omap2_timer10_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
@@ -865,21 +719,12 @@ static struct omap_hwmod_irq_info omap2420_timer1=
1_mpu_irqs[] =3D {
 	{ .irq =3D 47, },
 };
=20
-static struct omap_hwmod_addr_space omap2420_timer11_addrs[] =3D {
-	{
-		.pa_start	=3D 0x48088000,
-		.pa_end		=3D 0x48088000 + SZ_1K - 1,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_core -> timer11 */
 static struct omap_hwmod_ocp_if omap2420_l4_core__timer11 =3D {
 	.master		=3D &omap2420_l4_core_hwmod,
 	.slave		=3D &omap2420_timer11_hwmod,
 	.clk		=3D "gpt11_ick",
-	.addr		=3D omap2420_timer11_addrs,
+	.addr		=3D omap2_timer11_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
@@ -915,21 +760,12 @@ static struct omap_hwmod_irq_info omap2420_timer1=
2_mpu_irqs[] =3D {
 	{ .irq =3D 48, },
 };
=20
-static struct omap_hwmod_addr_space omap2420_timer12_addrs[] =3D {
-	{
-		.pa_start	=3D 0x4808a000,
-		.pa_end		=3D 0x4808a000 + SZ_1K - 1,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_core -> timer12 */
 static struct omap_hwmod_ocp_if omap2420_l4_core__timer12 =3D {
 	.master		=3D &omap2420_l4_core_hwmod,
 	.slave		=3D &omap2420_timer12_hwmod,
 	.clk		=3D "gpt12_ick",
-	.addr		=3D omap2420_timer12_addrs,
+	.addr		=3D omap2xxx_timer12_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
@@ -1178,21 +1014,12 @@ static struct omap_hwmod_ocp_if *omap2420_dss_m=
asters[] =3D {
 	&omap2420_dss__l3,
 };
=20
-static struct omap_hwmod_addr_space omap2420_dss_addrs[] =3D {
-	{
-		.pa_start	=3D 0x48050000,
-		.pa_end		=3D 0x480503FF,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_core -> dss */
 static struct omap_hwmod_ocp_if omap2420_l4_core__dss =3D {
 	.master		=3D &omap2420_l4_core_hwmod,
 	.slave		=3D &omap2420_dss_core_hwmod,
 	.clk		=3D "dss_ick",
-	.addr		=3D omap2420_dss_addrs,
+	.addr		=3D omap2_dss_addrs,
 	.fw =3D {
 		.omap2 =3D {
 			.l4_fw_region  =3D OMAP2420_L4_CORE_FW_DSS_CORE_REGION,
@@ -1262,21 +1089,12 @@ static struct omap_hwmod_irq_info omap2420_disp=
c_irqs[] =3D {
 	{ .irq =3D 25 },
 };
=20
-static struct omap_hwmod_addr_space omap2420_dss_dispc_addrs[] =3D {
-	{
-		.pa_start	=3D 0x48050400,
-		.pa_end		=3D 0x480507FF,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_core -> dss_dispc */
 static struct omap_hwmod_ocp_if omap2420_l4_core__dss_dispc =3D {
 	.master		=3D &omap2420_l4_core_hwmod,
 	.slave		=3D &omap2420_dss_dispc_hwmod,
 	.clk		=3D "dss_ick",
-	.addr		=3D omap2420_dss_dispc_addrs,
+	.addr		=3D omap2_dss_dispc_addrs,
 	.fw =3D {
 		.omap2 =3D {
 			.l4_fw_region  =3D OMAP2420_L4_CORE_FW_DSS_DISPC_REGION,
@@ -1332,21 +1150,12 @@ static struct omap_hwmod_class omap2420_rfbi_hw=
mod_class =3D {
 	.sysc =3D &omap2420_rfbi_sysc,
 };
=20
-static struct omap_hwmod_addr_space omap2420_dss_rfbi_addrs[] =3D {
-	{
-		.pa_start	=3D 0x48050800,
-		.pa_end		=3D 0x48050BFF,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_core -> dss_rfbi */
 static struct omap_hwmod_ocp_if omap2420_l4_core__dss_rfbi =3D {
 	.master		=3D &omap2420_l4_core_hwmod,
 	.slave		=3D &omap2420_dss_rfbi_hwmod,
 	.clk		=3D "dss_ick",
-	.addr		=3D omap2420_dss_rfbi_addrs,
+	.addr		=3D omap2_dss_rfbi_addrs,
 	.fw =3D {
 		.omap2 =3D {
 			.l4_fw_region  =3D OMAP2420_L4_CORE_FW_DSS_CORE_REGION,
@@ -1387,22 +1196,12 @@ static struct omap_hwmod_class omap2420_venc_hw=
mod_class =3D {
 	.name =3D "venc",
 };
=20
-/* dss_venc */
-static struct omap_hwmod_addr_space omap2420_dss_venc_addrs[] =3D {
-	{
-		.pa_start	=3D 0x48050C00,
-		.pa_end		=3D 0x48050FFF,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_core -> dss_venc */
 static struct omap_hwmod_ocp_if omap2420_l4_core__dss_venc =3D {
 	.master		=3D &omap2420_l4_core_hwmod,
 	.slave		=3D &omap2420_dss_venc_hwmod,
 	.clk		=3D "dss_54m_fck",
-	.addr		=3D omap2420_dss_venc_addrs,
+	.addr		=3D omap2_dss_venc_addrs,
 	.fw =3D {
 		.omap2 =3D {
 			.l4_fw_region  =3D OMAP2420_L4_CORE_FW_DSS_VENC_REGION,
@@ -1783,15 +1582,6 @@ static struct omap_hwmod_irq_info omap2420_dma_s=
ystem_irqs[] =3D {
 	{ .name =3D "3", .irq =3D 15 }, /* INT_24XX_SDMA_IRQ3 */
 };
=20
-static struct omap_hwmod_addr_space omap2420_dma_system_addrs[] =3D {
-	{
-		.pa_start	=3D 0x48056000,
-		.pa_end		=3D 0x48056fff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* dma_system -> L3 */
 static struct omap_hwmod_ocp_if omap2420_dma_system__l3 =3D {
 	.master		=3D &omap2420_dma_system_hwmod,
@@ -1810,7 +1600,7 @@ static struct omap_hwmod_ocp_if omap2420_l4_core_=
_dma_system =3D {
 	.master		=3D &omap2420_l4_core_hwmod,
 	.slave		=3D &omap2420_dma_system_hwmod,
 	.clk		=3D "sdma_ick",
-	.addr		=3D omap2420_dma_system_addrs,
+	.addr		=3D omap2_dma_system_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
@@ -1862,20 +1652,11 @@ static struct omap_hwmod_irq_info omap2420_mail=
box_irqs[] =3D {
 	{ .name =3D "iva", .irq =3D 34 },
 };
=20
-static struct omap_hwmod_addr_space omap2420_mailbox_addrs[] =3D {
-	{
-		.pa_start	=3D 0x48094000,
-		.pa_end		=3D 0x480941ff,
-		.flags		=3D ADDR_TYPE_RT,
-	},
-	{ }
-};
-
 /* l4_core -> mailbox */
 static struct omap_hwmod_ocp_if omap2420_l4_core__mailbox =3D {
 	.master		=3D &omap2420_l4_core_hwmod,
 	.slave		=3D &omap2420_mailbox_hwmod,
-	.addr		=3D omap2420_mailbox_addrs,
+	.addr		=3D omap2_mailbox_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
@@ -2037,22 +1818,12 @@ static struct omap_hwmod_dma_info omap2420_mcbs=
p1_sdma_chs[] =3D {
 	{ .name =3D "tx", .dma_req =3D 31 },
 };
=20
-static struct omap_hwmod_addr_space omap2420_mcbsp1_addrs[] =3D {
-	{
-		.name		=3D "mpu",
-		.pa_start	=3D 0x48074000,
-		.pa_end		=3D 0x480740ff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_core -> mcbsp1 */
 static struct omap_hwmod_ocp_if omap2420_l4_core__mcbsp1 =3D {
 	.master		=3D &omap2420_l4_core_hwmod,
 	.slave		=3D &omap2420_mcbsp1_hwmod,
 	.clk		=3D "mcbsp1_ick",
-	.addr		=3D omap2420_mcbsp1_addrs,
+	.addr		=3D omap2_mcbsp1_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
@@ -2094,22 +1865,12 @@ static struct omap_hwmod_dma_info omap2420_mcbs=
p2_sdma_chs[] =3D {
 	{ .name =3D "tx", .dma_req =3D 33 },
 };
=20
-static struct omap_hwmod_addr_space omap2420_mcbsp2_addrs[] =3D {
-	{
-		.name		=3D "mpu",
-		.pa_start	=3D 0x48076000,
-		.pa_end		=3D 0x480760ff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_core -> mcbsp2 */
 static struct omap_hwmod_ocp_if omap2420_l4_core__mcbsp2 =3D {
 	.master		=3D &omap2420_l4_core_hwmod,
 	.slave		=3D &omap2420_mcbsp2_hwmod,
 	.clk		=3D "mcbsp2_ick",
-	.addr		=3D omap2420_mcbsp2_addrs,
+	.addr		=3D omap2xxx_mcbsp2_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach=
-omap2/omap_hwmod_2430_data.c
index da28794..9531ef2 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -131,42 +131,21 @@ static struct omap_hwmod_ocp_if omap2430_usbhsotg=
__l3 =3D {
 	.user		=3D OCP_USER_MPU,
 };
=20
-/* I2C IP block address space length (in bytes) */
-#define OMAP2_I2C_AS_LEN		128
-
 /* L4 CORE -> I2C1 interface */
-static struct omap_hwmod_addr_space omap2430_i2c1_addr_space[] =3D {
-	{
-		.pa_start	=3D 0x48070000,
-		.pa_end		=3D 0x48070000 + OMAP2_I2C_AS_LEN - 1,
-		.flags		=3D ADDR_TYPE_RT,
-	},
-	{ }
-};
-
 static struct omap_hwmod_ocp_if omap2430_l4_core__i2c1 =3D {
 	.master		=3D &omap2430_l4_core_hwmod,
 	.slave		=3D &omap2430_i2c1_hwmod,
 	.clk		=3D "i2c1_ick",
-	.addr		=3D omap2430_i2c1_addr_space,
+	.addr		=3D omap2_i2c1_addr_space,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
 /* L4 CORE -> I2C2 interface */
-static struct omap_hwmod_addr_space omap2430_i2c2_addr_space[] =3D {
-	{
-		.pa_start	=3D 0x48072000,
-		.pa_end		=3D 0x48072000 + OMAP2_I2C_AS_LEN - 1,
-		.flags		=3D ADDR_TYPE_RT,
-	},
-	{ }
-};
-
 static struct omap_hwmod_ocp_if omap2430_l4_core__i2c2 =3D {
 	.master		=3D &omap2430_l4_core_hwmod,
 	.slave		=3D &omap2430_i2c2_hwmod,
 	.clk		=3D "i2c2_ick",
-	.addr		=3D omap2430_i2c2_addr_space,
+	.addr		=3D omap2_i2c2_addr_space,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
@@ -178,56 +157,29 @@ static struct omap_hwmod_ocp_if omap2430_l4_core_=
_l4_wkup =3D {
 };
=20
 /* L4 CORE -> UART1 interface */
-static struct omap_hwmod_addr_space omap2430_uart1_addr_space[] =3D {
-	{
-		.pa_start	=3D OMAP2_UART1_BASE,
-		.pa_end		=3D OMAP2_UART1_BASE + SZ_8K - 1,
-		.flags		=3D ADDR_MAP_ON_INIT | ADDR_TYPE_RT,
-	},
-	{ }
-};
-
 static struct omap_hwmod_ocp_if omap2_l4_core__uart1 =3D {
 	.master		=3D &omap2430_l4_core_hwmod,
 	.slave		=3D &omap2430_uart1_hwmod,
 	.clk		=3D "uart1_ick",
-	.addr		=3D omap2430_uart1_addr_space,
+	.addr		=3D omap2xxx_uart1_addr_space,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
 /* L4 CORE -> UART2 interface */
-static struct omap_hwmod_addr_space omap2430_uart2_addr_space[] =3D {
-	{
-		.pa_start	=3D OMAP2_UART2_BASE,
-		.pa_end		=3D OMAP2_UART2_BASE + SZ_1K - 1,
-		.flags		=3D ADDR_MAP_ON_INIT | ADDR_TYPE_RT,
-	},
-	{ }
-};
-
 static struct omap_hwmod_ocp_if omap2_l4_core__uart2 =3D {
 	.master		=3D &omap2430_l4_core_hwmod,
 	.slave		=3D &omap2430_uart2_hwmod,
 	.clk		=3D "uart2_ick",
-	.addr		=3D omap2430_uart2_addr_space,
+	.addr		=3D omap2xxx_uart2_addr_space,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
 /* L4 PER -> UART3 interface */
-static struct omap_hwmod_addr_space omap2430_uart3_addr_space[] =3D {
-	{
-		.pa_start	=3D OMAP2_UART3_BASE,
-		.pa_end		=3D OMAP2_UART3_BASE + SZ_1K - 1,
-		.flags		=3D ADDR_MAP_ON_INIT | ADDR_TYPE_RT,
-	},
-	{ }
-};
-
 static struct omap_hwmod_ocp_if omap2_l4_core__uart3 =3D {
 	.master		=3D &omap2430_l4_core_hwmod,
 	.slave		=3D &omap2430_uart3_hwmod,
 	.clk		=3D "uart3_ick",
-	.addr		=3D omap2430_uart3_addr_space,
+	.addr		=3D omap2xxx_uart3_addr_space,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
@@ -260,15 +212,6 @@ static struct omap_hwmod_ocp_if *omap2430_usbhsotg=
_slaves[] =3D {
 };
=20
 /* L4 CORE -> MMC1 interface */
-static struct omap_hwmod_addr_space omap2430_mmc1_addr_space[] =3D {
-	{
-		.pa_start	=3D 0x4809c000,
-		.pa_end		=3D 0x4809c1ff,
-		.flags		=3D ADDR_TYPE_RT,
-	},
-	{ }
-};
-
 static struct omap_hwmod_ocp_if omap2430_l4_core__mmc1 =3D {
 	.master		=3D &omap2430_l4_core_hwmod,
 	.slave		=3D &omap2430_mmc1_hwmod,
@@ -278,15 +221,6 @@ static struct omap_hwmod_ocp_if omap2430_l4_core__=
mmc1 =3D {
 };
=20
 /* L4 CORE -> MMC2 interface */
-static struct omap_hwmod_addr_space omap2430_mmc2_addr_space[] =3D {
-	{
-		.pa_start	=3D 0x480b4000,
-		.pa_end		=3D 0x480b41ff,
-		.flags		=3D ADDR_TYPE_RT,
-	},
-	{ }
-};
-
 static struct omap_hwmod_ocp_if omap2430_l4_core__mmc2 =3D {
 	.master		=3D &omap2430_l4_core_hwmod,
 	.slave		=3D &omap2430_mmc2_hwmod,
@@ -332,51 +266,24 @@ static struct omap_hwmod_ocp_if *omap2430_l4_wkup=
_masters[] =3D {
 };
=20
 /* l4 core -> mcspi1 interface */
-static struct omap_hwmod_addr_space omap2430_mcspi1_addr_space[] =3D {
-	{
-		.pa_start	=3D 0x48098000,
-		.pa_end		=3D 0x480980ff,
-		.flags		=3D ADDR_TYPE_RT,
-	},
-	{ }
-};
-
 static struct omap_hwmod_ocp_if omap2430_l4_core__mcspi1 =3D {
 	.master		=3D &omap2430_l4_core_hwmod,
 	.slave		=3D &omap2430_mcspi1_hwmod,
 	.clk		=3D "mcspi1_ick",
-	.addr		=3D omap2430_mcspi1_addr_space,
+	.addr		=3D omap2_mcspi1_addr_space,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
 /* l4 core -> mcspi2 interface */
-static struct omap_hwmod_addr_space omap2430_mcspi2_addr_space[] =3D {
-	{
-		.pa_start	=3D 0x4809a000,
-		.pa_end		=3D 0x4809a0ff,
-		.flags		=3D ADDR_TYPE_RT,
-	},
-	{ }
-};
-
 static struct omap_hwmod_ocp_if omap2430_l4_core__mcspi2 =3D {
 	.master		=3D &omap2430_l4_core_hwmod,
 	.slave		=3D &omap2430_mcspi2_hwmod,
 	.clk		=3D "mcspi2_ick",
-	.addr		=3D omap2430_mcspi2_addr_space,
+	.addr		=3D omap2_mcspi2_addr_space,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
 /* l4 core -> mcspi3 interface */
-static struct omap_hwmod_addr_space omap2430_mcspi3_addr_space[] =3D {
-	{
-		.pa_start	=3D 0x480b8000,
-		.pa_end		=3D 0x480b80ff,
-		.flags		=3D ADDR_TYPE_RT,
-	},
-	{ }
-};
-
 static struct omap_hwmod_ocp_if omap2430_l4_core__mcspi3 =3D {
 	.master		=3D &omap2430_l4_core_hwmod,
 	.slave		=3D &omap2430_mcspi3_hwmod,
@@ -514,21 +421,12 @@ static struct omap_hwmod_irq_info omap2430_timer2=
_mpu_irqs[] =3D {
 	{ .irq =3D 38, },
 };
=20
-static struct omap_hwmod_addr_space omap2430_timer2_addrs[] =3D {
-	{
-		.pa_start	=3D 0x4802a000,
-		.pa_end		=3D 0x4802a000 + SZ_1K - 1,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_core -> timer2 */
 static struct omap_hwmod_ocp_if omap2430_l4_core__timer2 =3D {
 	.master		=3D &omap2430_l4_core_hwmod,
 	.slave		=3D &omap2430_timer2_hwmod,
 	.clk		=3D "gpt2_ick",
-	.addr		=3D omap2430_timer2_addrs,
+	.addr		=3D omap2xxx_timer2_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
@@ -564,21 +462,12 @@ static struct omap_hwmod_irq_info omap2430_timer3=
_mpu_irqs[] =3D {
 	{ .irq =3D 39, },
 };
=20
-static struct omap_hwmod_addr_space omap2430_timer3_addrs[] =3D {
-	{
-		.pa_start	=3D 0x48078000,
-		.pa_end		=3D 0x48078000 + SZ_1K - 1,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_core -> timer3 */
 static struct omap_hwmod_ocp_if omap2430_l4_core__timer3 =3D {
 	.master		=3D &omap2430_l4_core_hwmod,
 	.slave		=3D &omap2430_timer3_hwmod,
 	.clk		=3D "gpt3_ick",
-	.addr		=3D omap2430_timer3_addrs,
+	.addr		=3D omap2xxx_timer3_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
@@ -614,21 +503,12 @@ static struct omap_hwmod_irq_info omap2430_timer4=
_mpu_irqs[] =3D {
 	{ .irq =3D 40, },
 };
=20
-static struct omap_hwmod_addr_space omap2430_timer4_addrs[] =3D {
-	{
-		.pa_start	=3D 0x4807a000,
-		.pa_end		=3D 0x4807a000 + SZ_1K - 1,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_core -> timer4 */
 static struct omap_hwmod_ocp_if omap2430_l4_core__timer4 =3D {
 	.master		=3D &omap2430_l4_core_hwmod,
 	.slave		=3D &omap2430_timer4_hwmod,
 	.clk		=3D "gpt4_ick",
-	.addr		=3D omap2430_timer4_addrs,
+	.addr		=3D omap2xxx_timer4_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
@@ -664,21 +544,12 @@ static struct omap_hwmod_irq_info omap2430_timer5=
_mpu_irqs[] =3D {
 	{ .irq =3D 41, },
 };
=20
-static struct omap_hwmod_addr_space omap2430_timer5_addrs[] =3D {
-	{
-		.pa_start	=3D 0x4807c000,
-		.pa_end		=3D 0x4807c000 + SZ_1K - 1,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_core -> timer5 */
 static struct omap_hwmod_ocp_if omap2430_l4_core__timer5 =3D {
 	.master		=3D &omap2430_l4_core_hwmod,
 	.slave		=3D &omap2430_timer5_hwmod,
 	.clk		=3D "gpt5_ick",
-	.addr		=3D omap2430_timer5_addrs,
+	.addr		=3D omap2xxx_timer5_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
@@ -714,21 +585,12 @@ static struct omap_hwmod_irq_info omap2430_timer6=
_mpu_irqs[] =3D {
 	{ .irq =3D 42, },
 };
=20
-static struct omap_hwmod_addr_space omap2430_timer6_addrs[] =3D {
-	{
-		.pa_start	=3D 0x4807e000,
-		.pa_end		=3D 0x4807e000 + SZ_1K - 1,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_core -> timer6 */
 static struct omap_hwmod_ocp_if omap2430_l4_core__timer6 =3D {
 	.master		=3D &omap2430_l4_core_hwmod,
 	.slave		=3D &omap2430_timer6_hwmod,
 	.clk		=3D "gpt6_ick",
-	.addr		=3D omap2430_timer6_addrs,
+	.addr		=3D omap2xxx_timer6_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
@@ -764,21 +626,12 @@ static struct omap_hwmod_irq_info omap2430_timer7=
_mpu_irqs[] =3D {
 	{ .irq =3D 43, },
 };
=20
-static struct omap_hwmod_addr_space omap2430_timer7_addrs[] =3D {
-	{
-		.pa_start	=3D 0x48080000,
-		.pa_end		=3D 0x48080000 + SZ_1K - 1,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_core -> timer7 */
 static struct omap_hwmod_ocp_if omap2430_l4_core__timer7 =3D {
 	.master		=3D &omap2430_l4_core_hwmod,
 	.slave		=3D &omap2430_timer7_hwmod,
 	.clk		=3D "gpt7_ick",
-	.addr		=3D omap2430_timer7_addrs,
+	.addr		=3D omap2xxx_timer7_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
@@ -814,21 +667,12 @@ static struct omap_hwmod_irq_info omap2430_timer8=
_mpu_irqs[] =3D {
 	{ .irq =3D 44, },
 };
=20
-static struct omap_hwmod_addr_space omap2430_timer8_addrs[] =3D {
-	{
-		.pa_start	=3D 0x48082000,
-		.pa_end		=3D 0x48082000 + SZ_1K - 1,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_core -> timer8 */
 static struct omap_hwmod_ocp_if omap2430_l4_core__timer8 =3D {
 	.master		=3D &omap2430_l4_core_hwmod,
 	.slave		=3D &omap2430_timer8_hwmod,
 	.clk		=3D "gpt8_ick",
-	.addr		=3D omap2430_timer8_addrs,
+	.addr		=3D omap2xxx_timer8_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
@@ -864,21 +708,12 @@ static struct omap_hwmod_irq_info omap2430_timer9=
_mpu_irqs[] =3D {
 	{ .irq =3D 45, },
 };
=20
-static struct omap_hwmod_addr_space omap2430_timer9_addrs[] =3D {
-	{
-		.pa_start	=3D 0x48084000,
-		.pa_end		=3D 0x48084000 + SZ_1K - 1,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_core -> timer9 */
 static struct omap_hwmod_ocp_if omap2430_l4_core__timer9 =3D {
 	.master		=3D &omap2430_l4_core_hwmod,
 	.slave		=3D &omap2430_timer9_hwmod,
 	.clk		=3D "gpt9_ick",
-	.addr		=3D omap2430_timer9_addrs,
+	.addr		=3D omap2xxx_timer9_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
@@ -914,21 +749,12 @@ static struct omap_hwmod_irq_info omap2430_timer1=
0_mpu_irqs[] =3D {
 	{ .irq =3D 46, },
 };
=20
-static struct omap_hwmod_addr_space omap2430_timer10_addrs[] =3D {
-	{
-		.pa_start	=3D 0x48086000,
-		.pa_end		=3D 0x48086000 + SZ_1K - 1,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_core -> timer10 */
 static struct omap_hwmod_ocp_if omap2430_l4_core__timer10 =3D {
 	.master		=3D &omap2430_l4_core_hwmod,
 	.slave		=3D &omap2430_timer10_hwmod,
 	.clk		=3D "gpt10_ick",
-	.addr		=3D omap2430_timer10_addrs,
+	.addr		=3D omap2_timer10_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
@@ -964,21 +790,12 @@ static struct omap_hwmod_irq_info omap2430_timer1=
1_mpu_irqs[] =3D {
 	{ .irq =3D 47, },
 };
=20
-static struct omap_hwmod_addr_space omap2430_timer11_addrs[] =3D {
-	{
-		.pa_start	=3D 0x48088000,
-		.pa_end		=3D 0x48088000 + SZ_1K - 1,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_core -> timer11 */
 static struct omap_hwmod_ocp_if omap2430_l4_core__timer11 =3D {
 	.master		=3D &omap2430_l4_core_hwmod,
 	.slave		=3D &omap2430_timer11_hwmod,
 	.clk		=3D "gpt11_ick",
-	.addr		=3D omap2430_timer11_addrs,
+	.addr		=3D omap2_timer11_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
@@ -1014,21 +831,12 @@ static struct omap_hwmod_irq_info omap2430_timer=
12_mpu_irqs[] =3D {
 	{ .irq =3D 48, },
 };
=20
-static struct omap_hwmod_addr_space omap2430_timer12_addrs[] =3D {
-	{
-		.pa_start	=3D 0x4808a000,
-		.pa_end		=3D 0x4808a000 + SZ_1K - 1,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_core -> timer12 */
 static struct omap_hwmod_ocp_if omap2430_l4_core__timer12 =3D {
 	.master		=3D &omap2430_l4_core_hwmod,
 	.slave		=3D &omap2430_timer12_hwmod,
 	.clk		=3D "gpt12_ick",
-	.addr		=3D omap2430_timer12_addrs,
+	.addr		=3D omap2xxx_timer12_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
@@ -1277,21 +1085,12 @@ static struct omap_hwmod_ocp_if *omap2430_dss_m=
asters[] =3D {
 	&omap2430_dss__l3,
 };
=20
-static struct omap_hwmod_addr_space omap2430_dss_addrs[] =3D {
-	{
-		.pa_start	=3D 0x48050000,
-		.pa_end		=3D 0x480503FF,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_core -> dss */
 static struct omap_hwmod_ocp_if omap2430_l4_core__dss =3D {
 	.master		=3D &omap2430_l4_core_hwmod,
 	.slave		=3D &omap2430_dss_core_hwmod,
 	.clk		=3D "dss_ick",
-	.addr		=3D omap2430_dss_addrs,
+	.addr		=3D omap2_dss_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
@@ -1355,21 +1154,12 @@ static struct omap_hwmod_irq_info omap2430_disp=
c_irqs[] =3D {
 	{ .irq =3D 25 },
 };
=20
-static struct omap_hwmod_addr_space omap2430_dss_dispc_addrs[] =3D {
-	{
-		.pa_start	=3D 0x48050400,
-		.pa_end		=3D 0x480507FF,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_core -> dss_dispc */
 static struct omap_hwmod_ocp_if omap2430_l4_core__dss_dispc =3D {
 	.master		=3D &omap2430_l4_core_hwmod,
 	.slave		=3D &omap2430_dss_dispc_hwmod,
 	.clk		=3D "dss_ick",
-	.addr		=3D omap2430_dss_dispc_addrs,
+	.addr		=3D omap2_dss_dispc_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
@@ -1419,21 +1209,12 @@ static struct omap_hwmod_class omap2430_rfbi_hw=
mod_class =3D {
 	.sysc =3D &omap2430_rfbi_sysc,
 };
=20
-static struct omap_hwmod_addr_space omap2430_dss_rfbi_addrs[] =3D {
-	{
-		.pa_start	=3D 0x48050800,
-		.pa_end		=3D 0x48050BFF,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_core -> dss_rfbi */
 static struct omap_hwmod_ocp_if omap2430_l4_core__dss_rfbi =3D {
 	.master		=3D &omap2430_l4_core_hwmod,
 	.slave		=3D &omap2430_dss_rfbi_hwmod,
 	.clk		=3D "dss_ick",
-	.addr		=3D omap2430_dss_rfbi_addrs,
+	.addr		=3D omap2_dss_rfbi_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
@@ -1468,22 +1249,12 @@ static struct omap_hwmod_class omap2430_venc_hw=
mod_class =3D {
 	.name =3D "venc",
 };
=20
-/* dss_venc */
-static struct omap_hwmod_addr_space omap2430_dss_venc_addrs[] =3D {
-	{
-		.pa_start	=3D 0x48050C00,
-		.pa_end		=3D 0x48050FFF,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_core -> dss_venc */
 static struct omap_hwmod_ocp_if omap2430_l4_core__dss_venc =3D {
 	.master		=3D &omap2430_l4_core_hwmod,
 	.slave		=3D &omap2430_dss_venc_hwmod,
 	.clk		=3D "dss_54m_fck",
-	.addr		=3D omap2430_dss_venc_addrs,
+	.addr		=3D omap2_dss_venc_addrs,
 	.flags		=3D OCPIF_SWSUP_IDLE,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
@@ -1916,15 +1687,6 @@ static struct omap_hwmod_irq_info omap2430_dma_s=
ystem_irqs[] =3D {
 	{ .name =3D "3", .irq =3D 15 }, /* INT_24XX_SDMA_IRQ3 */
 };
=20
-static struct omap_hwmod_addr_space omap2430_dma_system_addrs[] =3D {
-	{
-		.pa_start	=3D 0x48056000,
-		.pa_end		=3D 0x48056fff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* dma_system -> L3 */
 static struct omap_hwmod_ocp_if omap2430_dma_system__l3 =3D {
 	.master		=3D &omap2430_dma_system_hwmod,
@@ -1943,7 +1705,7 @@ static struct omap_hwmod_ocp_if omap2430_l4_core_=
_dma_system =3D {
 	.master		=3D &omap2430_l4_core_hwmod,
 	.slave		=3D &omap2430_dma_system_hwmod,
 	.clk		=3D "sdma_ick",
-	.addr		=3D omap2430_dma_system_addrs,
+	.addr		=3D omap2_dma_system_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
@@ -1994,20 +1756,11 @@ static struct omap_hwmod_irq_info omap2430_mail=
box_irqs[] =3D {
 	{ .irq =3D 26 },
 };
=20
-static struct omap_hwmod_addr_space omap2430_mailbox_addrs[] =3D {
-	{
-		.pa_start	=3D 0x48094000,
-		.pa_end		=3D 0x480941ff,
-		.flags		=3D ADDR_TYPE_RT,
-	},
-	{ }
-};
-
 /* l4_core -> mailbox */
 static struct omap_hwmod_ocp_if omap2430_l4_core__mailbox =3D {
 	.master		=3D &omap2430_l4_core_hwmod,
 	.slave		=3D &omap2430_mailbox_hwmod,
-	.addr		=3D omap2430_mailbox_addrs,
+	.addr		=3D omap2_mailbox_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
@@ -2279,22 +2032,12 @@ static struct omap_hwmod_dma_info omap2430_mcbs=
p1_sdma_chs[] =3D {
 	{ .name =3D "tx", .dma_req =3D 31 },
 };
=20
-static struct omap_hwmod_addr_space omap2430_mcbsp1_addrs[] =3D {
-	{
-		.name		=3D "mpu",
-		.pa_start	=3D 0x48074000,
-		.pa_end		=3D 0x480740ff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_core -> mcbsp1 */
 static struct omap_hwmod_ocp_if omap2430_l4_core__mcbsp1 =3D {
 	.master		=3D &omap2430_l4_core_hwmod,
 	.slave		=3D &omap2430_mcbsp1_hwmod,
 	.clk		=3D "mcbsp1_ick",
-	.addr		=3D omap2430_mcbsp1_addrs,
+	.addr		=3D omap2_mcbsp1_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
@@ -2337,22 +2080,12 @@ static struct omap_hwmod_dma_info omap2430_mcbs=
p2_sdma_chs[] =3D {
 	{ .name =3D "tx", .dma_req =3D 33 },
 };
=20
-static struct omap_hwmod_addr_space omap2430_mcbsp2_addrs[] =3D {
-	{
-		.name		=3D "mpu",
-		.pa_start	=3D 0x48076000,
-		.pa_end		=3D 0x480760ff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_core -> mcbsp2 */
 static struct omap_hwmod_ocp_if omap2430_l4_core__mcbsp2 =3D {
 	.master		=3D &omap2430_l4_core_hwmod,
 	.slave		=3D &omap2430_mcbsp2_hwmod,
 	.clk		=3D "mcbsp2_ick",
-	.addr		=3D omap2430_mcbsp2_addrs,
+	.addr		=3D omap2xxx_mcbsp2_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_interconnect_data=
=2Ec b/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_interconnect_data.c
new file mode 100644
index 0000000..04637fa
--- /dev/null
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_interconnect_data.c
@@ -0,0 +1,173 @@
+/*
+ * omap_hwmod_2xxx_3xxx_interconnect_data.c - common interconnect data=
, OMAP2/3
+ *
+ * Copyright (C) 2009-2011 Nokia Corporation
+ * Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * XXX handle crossbar/shared link difference for L3?
+ * XXX these should be marked initdata for multi-OMAP kernels
+ */
+#include <asm/sizes.h>
+
+#include <plat/omap_hwmod.h>
+#include <plat/serial.h>
+
+#include "omap_hwmod_common_data.h"
+
+struct omap_hwmod_addr_space omap2430_mmc1_addr_space[] =3D {
+	{
+		.pa_start	=3D 0x4809c000,
+		.pa_end		=3D 0x4809c1ff,
+		.flags		=3D ADDR_TYPE_RT,
+	},
+	{ }
+};
+
+struct omap_hwmod_addr_space omap2430_mmc2_addr_space[] =3D {
+	{
+		.pa_start	=3D 0x480b4000,
+		.pa_end		=3D 0x480b41ff,
+		.flags		=3D ADDR_TYPE_RT,
+	},
+	{ }
+};
+
+struct omap_hwmod_addr_space omap2_i2c1_addr_space[] =3D {
+	{
+		.pa_start	=3D 0x48070000,
+		.pa_end		=3D 0x48070000 + SZ_128 - 1,
+		.flags		=3D ADDR_TYPE_RT,
+	},
+	{ }
+};
+
+struct omap_hwmod_addr_space omap2_i2c2_addr_space[] =3D {
+	{
+		.pa_start	=3D 0x48072000,
+		.pa_end		=3D 0x48072000 + SZ_128 - 1,
+		.flags		=3D ADDR_TYPE_RT,
+	},
+	{ }
+};
+
+struct omap_hwmod_addr_space omap2_dss_addrs[] =3D {
+	{
+		.pa_start	=3D 0x48050000,
+		.pa_end		=3D 0x48050000 + SZ_1K - 1,
+		.flags		=3D ADDR_TYPE_RT
+	},
+	{ }
+};
+
+struct omap_hwmod_addr_space omap2_dss_dispc_addrs[] =3D {
+	{
+		.pa_start	=3D 0x48050400,
+		.pa_end		=3D 0x48050400 + SZ_1K - 1,
+		.flags		=3D ADDR_TYPE_RT
+	},
+	{ }
+};
+
+struct omap_hwmod_addr_space omap2_dss_rfbi_addrs[] =3D {
+	{
+		.pa_start	=3D 0x48050800,
+		.pa_end		=3D 0x48050800 + SZ_1K - 1,
+		.flags		=3D ADDR_TYPE_RT
+	},
+	{ }
+};
+
+struct omap_hwmod_addr_space omap2_dss_venc_addrs[] =3D {
+	{
+		.pa_start	=3D 0x48050C00,
+		.pa_end		=3D 0x48050C00 + SZ_1K - 1,
+		.flags		=3D ADDR_TYPE_RT
+	},
+	{ }
+};
+
+struct omap_hwmod_addr_space omap2_timer10_addrs[] =3D {
+	{
+		.pa_start	=3D 0x48086000,
+		.pa_end		=3D 0x48086000 + SZ_1K - 1,
+		.flags		=3D ADDR_TYPE_RT
+	},
+	{ }
+};
+
+struct omap_hwmod_addr_space omap2_timer11_addrs[] =3D {
+	{
+		.pa_start	=3D 0x48088000,
+		.pa_end		=3D 0x48088000 + SZ_1K - 1,
+		.flags		=3D ADDR_TYPE_RT
+	},
+	{ }
+};
+
+struct omap_hwmod_addr_space omap2xxx_timer12_addrs[] =3D {
+	{
+		.pa_start	=3D 0x4808a000,
+		.pa_end		=3D 0x4808a000 + SZ_1K - 1,
+		.flags		=3D ADDR_TYPE_RT
+	},
+	{ }
+};
+
+struct omap_hwmod_addr_space omap2_mcspi1_addr_space[] =3D {
+	{
+		.pa_start	=3D 0x48098000,
+		.pa_end		=3D 0x48098000 + SZ_256 - 1,
+		.flags		=3D ADDR_TYPE_RT,
+	},
+	{ }
+};
+
+struct omap_hwmod_addr_space omap2_mcspi2_addr_space[] =3D {
+	{
+		.pa_start	=3D 0x4809a000,
+		.pa_end		=3D 0x4809a000 + SZ_256 - 1,
+		.flags		=3D ADDR_TYPE_RT,
+	},
+	{ }
+};
+
+struct omap_hwmod_addr_space omap2430_mcspi3_addr_space[] =3D {
+	{
+		.pa_start	=3D 0x480b8000,
+		.pa_end		=3D 0x480b8000 + SZ_256 - 1,
+		.flags		=3D ADDR_TYPE_RT,
+	},
+	{ }
+};
+
+struct omap_hwmod_addr_space omap2_dma_system_addrs[] =3D {
+	{
+		.pa_start	=3D 0x48056000,
+		.pa_end		=3D 0x48056000 + SZ_4K - 1,
+		.flags		=3D ADDR_TYPE_RT
+	},
+	{ }
+};
+
+struct omap_hwmod_addr_space omap2_mailbox_addrs[] =3D {
+	{
+		.pa_start	=3D 0x48094000,
+		.pa_end		=3D 0x48094000 + SZ_512 - 1,
+		.flags		=3D ADDR_TYPE_RT,
+	},
+	{ }
+};
+
+struct omap_hwmod_addr_space omap2_mcbsp1_addrs[] =3D {
+	{
+		.name		=3D "mpu",
+		.pa_start	=3D 0x48074000,
+		.pa_end		=3D 0x480740ff,
+		.flags		=3D ADDR_TYPE_RT
+	},
+	{ }
+};
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c b/=
arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c
new file mode 100644
index 0000000..4f3547c
--- /dev/null
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c
@@ -0,0 +1,130 @@
+/*
+ * omap_hwmod_2xxx_interconnect_data.c - common interconnect data for =
OMAP2xxx
+ *
+ * Copyright (C) 2009-2011 Nokia Corporation
+ * Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * XXX handle crossbar/shared link difference for L3?
+ * XXX these should be marked initdata for multi-OMAP kernels
+ */
+#include <asm/sizes.h>
+
+#include <plat/omap_hwmod.h>
+#include <plat/serial.h>
+
+#include "omap_hwmod_common_data.h"
+
+struct omap_hwmod_addr_space omap2xxx_uart1_addr_space[] =3D {
+	{
+		.pa_start	=3D OMAP2_UART1_BASE,
+		.pa_end		=3D OMAP2_UART1_BASE + SZ_8K - 1,
+		.flags		=3D ADDR_MAP_ON_INIT | ADDR_TYPE_RT,
+	},
+	{ }
+};
+
+struct omap_hwmod_addr_space omap2xxx_uart2_addr_space[] =3D {
+	{
+		.pa_start	=3D OMAP2_UART2_BASE,
+		.pa_end		=3D OMAP2_UART2_BASE + SZ_1K - 1,
+		.flags		=3D ADDR_MAP_ON_INIT | ADDR_TYPE_RT,
+	},
+	{ }
+};
+
+struct omap_hwmod_addr_space omap2xxx_uart3_addr_space[] =3D {
+	{
+		.pa_start	=3D OMAP2_UART3_BASE,
+		.pa_end		=3D OMAP2_UART3_BASE + SZ_1K - 1,
+		.flags		=3D ADDR_MAP_ON_INIT | ADDR_TYPE_RT,
+	},
+	{ }
+};
+
+struct omap_hwmod_addr_space omap2xxx_timer2_addrs[] =3D {
+	{
+		.pa_start	=3D 0x4802a000,
+		.pa_end		=3D 0x4802a000 + SZ_1K - 1,
+		.flags		=3D ADDR_TYPE_RT
+	},
+	{ }
+};
+
+struct omap_hwmod_addr_space omap2xxx_timer3_addrs[] =3D {
+	{
+		.pa_start	=3D 0x48078000,
+		.pa_end		=3D 0x48078000 + SZ_1K - 1,
+		.flags		=3D ADDR_TYPE_RT
+	},
+	{ }
+};
+
+struct omap_hwmod_addr_space omap2xxx_timer4_addrs[] =3D {
+	{
+		.pa_start	=3D 0x4807a000,
+		.pa_end		=3D 0x4807a000 + SZ_1K - 1,
+		.flags		=3D ADDR_TYPE_RT
+	},
+	{ }
+};
+
+struct omap_hwmod_addr_space omap2xxx_timer5_addrs[] =3D {
+	{
+		.pa_start	=3D 0x4807c000,
+		.pa_end		=3D 0x4807c000 + SZ_1K - 1,
+		.flags		=3D ADDR_TYPE_RT
+	},
+	{ }
+};
+
+struct omap_hwmod_addr_space omap2xxx_timer6_addrs[] =3D {
+	{
+		.pa_start	=3D 0x4807e000,
+		.pa_end		=3D 0x4807e000 + SZ_1K - 1,
+		.flags		=3D ADDR_TYPE_RT
+	},
+	{ }
+};
+
+struct omap_hwmod_addr_space omap2xxx_timer7_addrs[] =3D {
+	{
+		.pa_start	=3D 0x48080000,
+		.pa_end		=3D 0x48080000 + SZ_1K - 1,
+		.flags		=3D ADDR_TYPE_RT
+	},
+	{ }
+};
+
+struct omap_hwmod_addr_space omap2xxx_timer8_addrs[] =3D {
+	{
+		.pa_start	=3D 0x48082000,
+		.pa_end		=3D 0x48082000 + SZ_1K - 1,
+		.flags		=3D ADDR_TYPE_RT
+	},
+	{ }
+};
+
+struct omap_hwmod_addr_space omap2xxx_timer9_addrs[] =3D {
+	{
+		.pa_start	=3D 0x48084000,
+		.pa_end		=3D 0x48084000 + SZ_1K - 1,
+		.flags		=3D ADDR_TYPE_RT
+	},
+	{ }
+};
+
+struct omap_hwmod_addr_space omap2xxx_mcbsp2_addrs[] =3D {
+	{
+		.name		=3D "mpu",
+		.pa_start	=3D 0x48076000,
+		.pa_end		=3D 0x480760ff,
+		.flags		=3D ADDR_TYPE_RT
+	},
+	{ }
+};
+
+
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach=
-omap2/omap_hwmod_3xxx_data.c
index 6410779..791f9b2 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -190,39 +190,21 @@ static struct omap_hwmod_ocp_if omap3xxx_l4_core_=
_l4_wkup =3D {
 };
=20
 /* L4 CORE -> MMC1 interface */
-static struct omap_hwmod_addr_space omap3xxx_mmc1_addr_space[] =3D {
-	{
-		.pa_start	=3D 0x4809c000,
-		.pa_end		=3D 0x4809c1ff,
-		.flags		=3D ADDR_TYPE_RT,
-	},
-	{ }
-};
-
 static struct omap_hwmod_ocp_if omap3xxx_l4_core__mmc1 =3D {
 	.master		=3D &omap3xxx_l4_core_hwmod,
 	.slave		=3D &omap3xxx_mmc1_hwmod,
 	.clk		=3D "mmchs1_ick",
-	.addr		=3D omap3xxx_mmc1_addr_space,
+	.addr		=3D omap2430_mmc1_addr_space,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 	.flags		=3D OMAP_FIREWALL_L4
 };
=20
 /* L4 CORE -> MMC2 interface */
-static struct omap_hwmod_addr_space omap3xxx_mmc2_addr_space[] =3D {
-	{
-		.pa_start	=3D 0x480b4000,
-		.pa_end		=3D 0x480b41ff,
-		.flags		=3D ADDR_TYPE_RT,
-	},
-	{ }
-};
-
 static struct omap_hwmod_ocp_if omap3xxx_l4_core__mmc2 =3D {
 	.master		=3D &omap3xxx_l4_core_hwmod,
 	.slave		=3D &omap3xxx_mmc2_hwmod,
 	.clk		=3D "mmchs2_ick",
-	.addr		=3D omap3xxx_mmc2_addr_space,
+	.addr		=3D omap2430_mmc2_addr_space,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 	.flags		=3D OMAP_FIREWALL_L4
 };
@@ -318,24 +300,12 @@ static struct omap_hwmod_ocp_if omap3_l4_per__uar=
t4 =3D {
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-/* I2C IP block address space length (in bytes) */
-#define OMAP2_I2C_AS_LEN		128
-
 /* L4 CORE -> I2C1 interface */
-static struct omap_hwmod_addr_space omap3xxx_i2c1_addr_space[] =3D {
-	{
-		.pa_start	=3D 0x48070000,
-		.pa_end		=3D 0x48070000 + OMAP2_I2C_AS_LEN - 1,
-		.flags		=3D ADDR_TYPE_RT,
-	},
-	{ }
-};
-
 static struct omap_hwmod_ocp_if omap3_l4_core__i2c1 =3D {
 	.master		=3D &omap3xxx_l4_core_hwmod,
 	.slave		=3D &omap3xxx_i2c1_hwmod,
 	.clk		=3D "i2c1_ick",
-	.addr		=3D omap3xxx_i2c1_addr_space,
+	.addr		=3D omap2_i2c1_addr_space,
 	.fw =3D {
 		.omap2 =3D {
 			.l4_fw_region  =3D OMAP3_L4_CORE_FW_I2C1_REGION,
@@ -347,20 +317,11 @@ static struct omap_hwmod_ocp_if omap3_l4_core__i2=
c1 =3D {
 };
=20
 /* L4 CORE -> I2C2 interface */
-static struct omap_hwmod_addr_space omap3xxx_i2c2_addr_space[] =3D {
-	{
-		.pa_start	=3D 0x48072000,
-		.pa_end		=3D 0x48072000 + OMAP2_I2C_AS_LEN - 1,
-		.flags		=3D ADDR_TYPE_RT,
-	},
-	{ }
-};
-
 static struct omap_hwmod_ocp_if omap3_l4_core__i2c2 =3D {
 	.master		=3D &omap3xxx_l4_core_hwmod,
 	.slave		=3D &omap3xxx_i2c2_hwmod,
 	.clk		=3D "i2c2_ick",
-	.addr		=3D omap3xxx_i2c2_addr_space,
+	.addr		=3D omap2_i2c2_addr_space,
 	.fw =3D {
 		.omap2 =3D {
 			.l4_fw_region  =3D OMAP3_L4_CORE_FW_I2C2_REGION,
@@ -375,7 +336,7 @@ static struct omap_hwmod_ocp_if omap3_l4_core__i2c2=
 =3D {
 static struct omap_hwmod_addr_space omap3xxx_i2c3_addr_space[] =3D {
 	{
 		.pa_start	=3D 0x48060000,
-		.pa_end		=3D 0x48060000 + OMAP2_I2C_AS_LEN - 1,
+		.pa_end		=3D 0x48060000 + SZ_128 - 1,
 		.flags		=3D ADDR_TYPE_RT,
 	},
 	{ }
@@ -1065,21 +1026,12 @@ static struct omap_hwmod_irq_info omap3xxx_time=
r10_mpu_irqs[] =3D {
 	{ .irq =3D 46, },
 };
=20
-static struct omap_hwmod_addr_space omap3xxx_timer10_addrs[] =3D {
-	{
-		.pa_start	=3D 0x48086000,
-		.pa_end		=3D 0x48086000 + SZ_1K - 1,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_core -> timer10 */
 static struct omap_hwmod_ocp_if omap3xxx_l4_core__timer10 =3D {
 	.master		=3D &omap3xxx_l4_core_hwmod,
 	.slave		=3D &omap3xxx_timer10_hwmod,
 	.clk		=3D "gpt10_ick",
-	.addr		=3D omap3xxx_timer10_addrs,
+	.addr		=3D omap2_timer10_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
@@ -1115,21 +1067,12 @@ static struct omap_hwmod_irq_info omap3xxx_time=
r11_mpu_irqs[] =3D {
 	{ .irq =3D 47, },
 };
=20
-static struct omap_hwmod_addr_space omap3xxx_timer11_addrs[] =3D {
-	{
-		.pa_start	=3D 0x48088000,
-		.pa_end		=3D 0x48088000 + SZ_1K - 1,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_core -> timer11 */
 static struct omap_hwmod_ocp_if omap3xxx_l4_core__timer11 =3D {
 	.master		=3D &omap3xxx_l4_core_hwmod,
 	.slave		=3D &omap3xxx_timer11_hwmod,
 	.clk		=3D "gpt11_ick",
-	.addr		=3D omap3xxx_timer11_addrs,
+	.addr		=3D omap2_timer11_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
@@ -1491,21 +1434,12 @@ static struct omap_hwmod_ocp_if *omap3xxx_dss_m=
asters[] =3D {
 	&omap3xxx_dss__l3,
 };
=20
-static struct omap_hwmod_addr_space omap3xxx_dss_addrs[] =3D {
-	{
-		.pa_start	=3D 0x48050000,
-		.pa_end		=3D 0x480503FF,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_core -> dss */
 static struct omap_hwmod_ocp_if omap3430es1_l4_core__dss =3D {
 	.master		=3D &omap3xxx_l4_core_hwmod,
 	.slave		=3D &omap3430es1_dss_core_hwmod,
 	.clk		=3D "dss_ick",
-	.addr		=3D omap3xxx_dss_addrs,
+	.addr		=3D omap2_dss_addrs,
 	.fw =3D {
 		.omap2 =3D {
 			.l4_fw_region  =3D OMAP3ES1_L4_CORE_FW_DSS_CORE_REGION,
@@ -1520,7 +1454,7 @@ static struct omap_hwmod_ocp_if omap3xxx_l4_core_=
_dss =3D {
 	.master		=3D &omap3xxx_l4_core_hwmod,
 	.slave		=3D &omap3xxx_dss_core_hwmod,
 	.clk		=3D "dss_ick",
-	.addr		=3D omap3xxx_dss_addrs,
+	.addr		=3D omap2_dss_addrs,
 	.fw =3D {
 		.omap2 =3D {
 			.l4_fw_region  =3D OMAP3_L4_CORE_FW_DSS_CORE_REGION,
@@ -1625,21 +1559,12 @@ static struct omap_hwmod_irq_info omap3xxx_disp=
c_irqs[] =3D {
 	{ .irq =3D 25 },
 };
=20
-static struct omap_hwmod_addr_space omap3xxx_dss_dispc_addrs[] =3D {
-	{
-		.pa_start	=3D 0x48050400,
-		.pa_end		=3D 0x480507FF,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_core -> dss_dispc */
 static struct omap_hwmod_ocp_if omap3xxx_l4_core__dss_dispc =3D {
 	.master		=3D &omap3xxx_l4_core_hwmod,
 	.slave		=3D &omap3xxx_dss_dispc_hwmod,
 	.clk		=3D "dss_ick",
-	.addr		=3D omap3xxx_dss_dispc_addrs,
+	.addr		=3D omap2_dss_dispc_addrs,
 	.fw =3D {
 		.omap2 =3D {
 			.l4_fw_region  =3D OMAP3_L4_CORE_FW_DSS_DISPC_REGION,
@@ -1760,21 +1685,12 @@ static struct omap_hwmod_class omap3xxx_rfbi_hw=
mod_class =3D {
 	.sysc =3D &omap3xxx_rfbi_sysc,
 };
=20
-static struct omap_hwmod_addr_space omap3xxx_dss_rfbi_addrs[] =3D {
-	{
-		.pa_start	=3D 0x48050800,
-		.pa_end		=3D 0x48050BFF,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_core -> dss_rfbi */
 static struct omap_hwmod_ocp_if omap3xxx_l4_core__dss_rfbi =3D {
 	.master		=3D &omap3xxx_l4_core_hwmod,
 	.slave		=3D &omap3xxx_dss_rfbi_hwmod,
 	.clk		=3D "dss_ick",
-	.addr		=3D omap3xxx_dss_rfbi_addrs,
+	.addr		=3D omap2_dss_rfbi_addrs,
 	.fw =3D {
 		.omap2 =3D {
 			.l4_fw_region  =3D OMAP3_L4_CORE_FW_DSS_RFBI_REGION,
@@ -1818,22 +1734,12 @@ static struct omap_hwmod_class omap3xxx_venc_hw=
mod_class =3D {
 	.name =3D "venc",
 };
=20
-/* dss_venc */
-static struct omap_hwmod_addr_space omap3xxx_dss_venc_addrs[] =3D {
-	{
-		.pa_start	=3D 0x48050C00,
-		.pa_end		=3D 0x48050FFF,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_core -> dss_venc */
 static struct omap_hwmod_ocp_if omap3xxx_l4_core__dss_venc =3D {
 	.master		=3D &omap3xxx_l4_core_hwmod,
 	.slave		=3D &omap3xxx_dss_venc_hwmod,
 	.clk		=3D "dss_tv_fck",
-	.addr		=3D omap3xxx_dss_venc_addrs,
+	.addr		=3D omap2_dss_venc_addrs,
 	.fw =3D {
 		.omap2 =3D {
 			.l4_fw_region  =3D OMAP3_L4_CORE_FW_DSS_VENC_REGION,
@@ -3070,56 +2976,29 @@ static struct omap_hwmod omap3xxx_mailbox_hwmod=
 =3D {
 };
=20
 /* l4 core -> mcspi1 interface */
-static struct omap_hwmod_addr_space omap34xx_mcspi1_addr_space[] =3D {
-	{
-		.pa_start	=3D 0x48098000,
-		.pa_end		=3D 0x480980ff,
-		.flags		=3D ADDR_TYPE_RT,
-	},
-	{ }
-};
-
 static struct omap_hwmod_ocp_if omap34xx_l4_core__mcspi1 =3D {
 	.master		=3D &omap3xxx_l4_core_hwmod,
 	.slave		=3D &omap34xx_mcspi1,
 	.clk		=3D "mcspi1_ick",
-	.addr		=3D omap34xx_mcspi1_addr_space,
+	.addr		=3D omap2_mcspi1_addr_space,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
 /* l4 core -> mcspi2 interface */
-static struct omap_hwmod_addr_space omap34xx_mcspi2_addr_space[] =3D {
-	{
-		.pa_start	=3D 0x4809a000,
-		.pa_end		=3D 0x4809a0ff,
-		.flags		=3D ADDR_TYPE_RT,
-	},
-	{ }
-};
-
 static struct omap_hwmod_ocp_if omap34xx_l4_core__mcspi2 =3D {
 	.master		=3D &omap3xxx_l4_core_hwmod,
 	.slave		=3D &omap34xx_mcspi2,
 	.clk		=3D "mcspi2_ick",
-	.addr		=3D omap34xx_mcspi2_addr_space,
+	.addr		=3D omap2_mcspi2_addr_space,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
 /* l4 core -> mcspi3 interface */
-static struct omap_hwmod_addr_space omap34xx_mcspi3_addr_space[] =3D {
-	{
-		.pa_start	=3D 0x480b8000,
-		.pa_end		=3D 0x480b80ff,
-		.flags		=3D ADDR_TYPE_RT,
-	},
-	{ }
-};
-
 static struct omap_hwmod_ocp_if omap34xx_l4_core__mcspi3 =3D {
 	.master		=3D &omap3xxx_l4_core_hwmod,
 	.slave		=3D &omap34xx_mcspi3,
 	.clk		=3D "mcspi3_ick",
-	.addr		=3D omap34xx_mcspi3_addr_space,
+	.addr		=3D omap2430_mcspi3_addr_space,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
diff --git a/arch/arm/mach-omap2/omap_hwmod_common_data.h b/arch/arm/ma=
ch-omap2/omap_hwmod_common_data.h
index c34e98b..76a2f11 100644
--- a/arch/arm/mach-omap2/omap_hwmod_common_data.h
+++ b/arch/arm/mach-omap2/omap_hwmod_common_data.h
@@ -1,10 +1,10 @@
 /*
  * omap_hwmod_common_data.h - OMAP hwmod common macros and declaration=
s
  *
- * Copyright (C) 2010 Nokia Corporation
+ * Copyright (C) 2010-2011 Nokia Corporation
  * Paul Walmsley
  *
- * Copyright (C) 2010 Texas Instruments, Inc.
+ * Copyright (C) 2010-2011 Texas Instruments, Inc.
  * Beno=C3=AEt Cousson
  *
  * This program is free software; you can redistribute it and/or modif=
y
@@ -16,10 +16,44 @@
=20
 #include <plat/omap_hwmod.h>
=20
+/* Common address space across OMAP2xxx */
+extern struct omap_hwmod_addr_space omap2xxx_uart1_addr_space[];
+extern struct omap_hwmod_addr_space omap2xxx_uart2_addr_space[];
+extern struct omap_hwmod_addr_space omap2xxx_uart3_addr_space[];
+extern struct omap_hwmod_addr_space omap2xxx_timer2_addrs[];
+extern struct omap_hwmod_addr_space omap2xxx_timer3_addrs[];
+extern struct omap_hwmod_addr_space omap2xxx_timer4_addrs[];
+extern struct omap_hwmod_addr_space omap2xxx_timer5_addrs[];
+extern struct omap_hwmod_addr_space omap2xxx_timer6_addrs[];
+extern struct omap_hwmod_addr_space omap2xxx_timer7_addrs[];
+extern struct omap_hwmod_addr_space omap2xxx_timer8_addrs[];
+extern struct omap_hwmod_addr_space omap2xxx_timer9_addrs[];
+extern struct omap_hwmod_addr_space omap2xxx_timer12_addrs[];
+extern struct omap_hwmod_addr_space omap2xxx_mcbsp2_addrs[];
+
+/* Common address space across OMAP2xxx/3xxx */
+extern struct omap_hwmod_addr_space omap2_i2c1_addr_space[];
+extern struct omap_hwmod_addr_space omap2_i2c2_addr_space[];
+extern struct omap_hwmod_addr_space omap2_dss_addrs[];
+extern struct omap_hwmod_addr_space omap2_dss_dispc_addrs[];
+extern struct omap_hwmod_addr_space omap2_dss_rfbi_addrs[];
+extern struct omap_hwmod_addr_space omap2_dss_venc_addrs[];
+extern struct omap_hwmod_addr_space omap2_timer10_addrs[];
+extern struct omap_hwmod_addr_space omap2_timer11_addrs[];
+extern struct omap_hwmod_addr_space omap2430_mmc1_addr_space[];
+extern struct omap_hwmod_addr_space omap2430_mmc2_addr_space[];
+extern struct omap_hwmod_addr_space omap2_mcspi1_addr_space[];
+extern struct omap_hwmod_addr_space omap2_mcspi2_addr_space[];
+extern struct omap_hwmod_addr_space omap2430_mcspi3_addr_space[];
+extern struct omap_hwmod_addr_space omap2_dma_system_addrs[];
+extern struct omap_hwmod_addr_space omap2_mailbox_addrs[];
+extern struct omap_hwmod_addr_space omap2_mcbsp1_addrs[];
+
 /* OMAP hwmod classes - forward declarations */
 extern struct omap_hwmod_class l3_hwmod_class;
 extern struct omap_hwmod_class l4_hwmod_class;
 extern struct omap_hwmod_class mpu_hwmod_class;
 extern struct omap_hwmod_class iva_hwmod_class;
=20
+
 #endif


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
