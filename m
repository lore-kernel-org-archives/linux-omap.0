From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/5] ARM: OMAP2/3: hwmod: add RNG integration data
Date: Mon, 27 Aug 2012 17:36:09 -0600
Message-ID: <20120827233606.15045.59388.stgit@dusk.lan>
References: <20120827232922.15045.56522.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:37114 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755016Ab2H0Xis (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Aug 2012 19:38:48 -0400
In-Reply-To: <20120827232922.15045.56522.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Add integration data for the hardware random number generator IP block
on some OMAP SoCs.  This appears to be present on OMAP2xxx and OMAP3xxx
SoCs, although it is not so easy to tell.  It may also be present on
other OMAP2+ SoCs.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |    1 +
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |    1 +
 .../mach-omap2/omap_hwmod_2xxx_interconnect_data.c |   17 +++++++++
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |   37 ++++++++++++=
++++++++
 arch/arm/mach-omap2/omap_hwmod_common_data.h       |    5 ++-
 5 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach=
-omap2/omap_hwmod_2420_data.c
index 50cfab6..5a53287 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -587,6 +587,7 @@ static struct omap_hwmod_ocp_if *omap2420_hwmod_ocp=
_ifs[] __initdata =3D {
 	&omap2420_l4_core__mcbsp1,
 	&omap2420_l4_core__mcbsp2,
 	&omap2420_l4_core__msdi1,
+	&omap2xxx_l4_core__rng,
 	&omap2420_l4_core__hdq1w,
 	&omap2420_l4_wkup__counter_32k,
 	NULL,
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach=
-omap2/omap_hwmod_2430_data.c
index 58b5bc1..256d8f6 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -947,6 +947,7 @@ static struct omap_hwmod_ocp_if *omap2430_hwmod_ocp=
_ifs[] __initdata =3D {
 	&omap2430_l4_core__mcbsp4,
 	&omap2430_l4_core__mcbsp5,
 	&omap2430_l4_core__hdq1w,
+	&omap2xxx_l4_core__rng,
 	&omap2430_l4_wkup__counter_32k,
 	NULL,
 };
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c b/=
arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c
index 5178e40..14dc5ca 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c
@@ -129,6 +129,15 @@ struct omap_hwmod_addr_space omap2xxx_mcbsp2_addrs=
[] =3D {
 	{ }
 };
=20
+static struct omap_hwmod_addr_space omap2_rng_addr_space[] =3D {
+	{
+		.pa_start	=3D 0x480a0000,
+		.pa_end		=3D 0x480a004f,
+		.flags		=3D ADDR_TYPE_RT
+	},
+	{ }
+};
+
 /*
  * Common interconnect data
  */
@@ -372,3 +381,11 @@ struct omap_hwmod_ocp_if omap2xxx_l4_core__dss_ven=
c =3D {
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
+/* l4_core -> rng */
+struct omap_hwmod_ocp_if omap2xxx_l4_core__rng =3D {
+	.master		=3D &omap2xxx_l4_core_hwmod,
+	.slave		=3D &omap2xxx_rng_hwmod,
+	.clk		=3D "l4_ck",
+	.addr		=3D omap2_rng_addr_space,
+	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
+};
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c b/arch/=
arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
index afad69c..06a37db 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
@@ -745,3 +745,40 @@ struct omap_hwmod omap2xxx_counter_32k_hwmod =3D {
 	},
 	.class		=3D &omap2xxx_counter_hwmod_class,
 };
+
+/* RNG */
+
+static struct omap_hwmod_class_sysconfig omap2_rng_sysc =3D {
+	.rev_offs	=3D 0x3c,
+	.sysc_offs	=3D 0x40,
+	.syss_offs	=3D 0x44,
+	.sysc_flags	=3D (SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE |
+			   SYSS_HAS_RESET_STATUS),
+	.sysc_fields	=3D &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap2_rng_hwmod_class =3D {
+	.name		=3D "rng",
+	.sysc		=3D &omap2_rng_sysc,
+};
+
+static struct omap_hwmod_irq_info omap2_rng_mpu_irqs[] =3D {
+	{ .irq =3D 52 },
+	{ .irq =3D -1 }
+};
+
+struct omap_hwmod omap2xxx_rng_hwmod =3D {
+	.name		=3D "rng",
+	.mpu_irqs	=3D omap2_rng_mpu_irqs,
+	.main_clk	=3D "l4_ck",
+	.prcm		=3D {
+		.omap2 =3D {
+			.module_offs =3D CORE_MOD,
+			.prcm_reg_id =3D 4,
+			.module_bit =3D OMAP24XX_EN_RNG_SHIFT,
+			.idlest_reg_id =3D 4,
+			.idlest_idle_bit =3D OMAP24XX_ST_RNG_SHIFT,
+		},
+	},
+	.class		=3D &omap2_rng_hwmod_class,
+};
diff --git a/arch/arm/mach-omap2/omap_hwmod_common_data.h b/arch/arm/ma=
ch-omap2/omap_hwmod_common_data.h
index e7e8eea..4363610 100644
--- a/arch/arm/mach-omap2/omap_hwmod_common_data.h
+++ b/arch/arm/mach-omap2/omap_hwmod_common_data.h
@@ -2,9 +2,8 @@
  * omap_hwmod_common_data.h - OMAP hwmod common macros and declaration=
s
  *
  * Copyright (C) 2010-2011 Nokia Corporation
+ * Copyright (C) 2010-2012 Texas Instruments, Inc.
  * Paul Walmsley
- *
- * Copyright (C) 2010-2011 Texas Instruments, Inc.
  * Beno=C3=AEt Cousson
  *
  * This program is free software; you can redistribute it and/or modif=
y
@@ -76,6 +75,7 @@ extern struct omap_hwmod omap2xxx_gpio4_hwmod;
 extern struct omap_hwmod omap2xxx_mcspi1_hwmod;
 extern struct omap_hwmod omap2xxx_mcspi2_hwmod;
 extern struct omap_hwmod omap2xxx_counter_32k_hwmod;
+extern struct omap_hwmod omap2xxx_rng_hwmod;
=20
 /* Common interface data across OMAP2xxx */
 extern struct omap_hwmod_ocp_if omap2xxx_l3_main__l4_core;
@@ -102,6 +102,7 @@ extern struct omap_hwmod_ocp_if omap2xxx_l4_core__d=
ss;
 extern struct omap_hwmod_ocp_if omap2xxx_l4_core__dss_dispc;
 extern struct omap_hwmod_ocp_if omap2xxx_l4_core__dss_rfbi;
 extern struct omap_hwmod_ocp_if omap2xxx_l4_core__dss_venc;
+extern struct omap_hwmod_ocp_if omap2xxx_l4_core__rng;
=20
 /* Common IP block data */
 extern struct omap_hwmod_dma_info omap2_uart1_sdma_reqs[];


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
