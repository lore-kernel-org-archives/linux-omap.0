From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 6/8] ARM: OMAP4: hwmod data: add HDQ/1-wire hwmod
Date: Sat, 21 Jan 2012 16:59:34 -0700
Message-ID: <20120121235934.17619.74939.stgit@dusk>
References: <20120121235333.17619.56725.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120121235333.17619.56725.stgit@dusk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>
List-Id: linux-omap@vger.kernel.org

Add the hwmod data for the HDQ/1-wire hwmod ('hdq1w').  The scripts hav=
e been
updated.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   74 ++++++++++++++++++++=
++++++++
 1 files changed, 73 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach=
-omap2/omap_hwmod_44xx_data.c
index f9f1510..0f79ec8 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -1,7 +1,7 @@
 /*
  * Hardware modules present on the OMAP44xx chips
  *
- * Copyright (C) 2009-2011 Texas Instruments, Inc.
+ * Copyright (C) 2009-2012 Texas Instruments, Inc.
  * Copyright (C) 2009-2010 Nokia Corporation
  *
  * Paul Walmsley
@@ -31,6 +31,7 @@
 #include <plat/i2c.h>
 #include <plat/dmtimer.h>
 #include <plat/common.h>
+#include <plat/hdq1w.h>
=20
 #include "omap_hwmod_common_data.h"
=20
@@ -72,6 +73,7 @@ static struct omap_hwmod omap44xx_mpu_private_hwmod;
 static struct omap_hwmod omap44xx_usb_otg_hs_hwmod;
 static struct omap_hwmod omap44xx_usb_host_hs_hwmod;
 static struct omap_hwmod omap44xx_usb_tll_hs_hwmod;
+static struct omap_hwmod omap44xx_hdq1w_hwmod;
=20
 /*
  * Interconnects omap_hwmod structures
@@ -2157,6 +2159,73 @@ static struct omap_hwmod omap44xx_gpio6_hwmod =3D=
 {
 };
=20
 /*
+ * 'hdq1w' class
+ * hdq / 1-wire serial interface controller
+ */
+
+static struct omap_hwmod_class_sysconfig omap44xx_hdq1w_sysc =3D {
+	.rev_offs	=3D 0x0000,
+	.sysc_offs	=3D 0x0014,
+	.syss_offs	=3D 0x0018,
+	.sysc_flags	=3D (SYSC_HAS_AUTOIDLE | SYSC_HAS_SOFTRESET |
+			   SYSS_HAS_RESET_STATUS),
+	.sysc_fields	=3D &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap44xx_hdq1w_hwmod_class =3D {
+	.name	=3D "hdq1w",
+	.sysc	=3D &omap44xx_hdq1w_sysc,
+	.reset	=3D &omap_hdq1w_reset,
+};
+
+/* hdq1w */
+static struct omap_hwmod omap44xx_hdq1w_hwmod;
+static struct omap_hwmod_irq_info omap44xx_hdq1w_irqs[] =3D {
+	{ .irq =3D 58 + OMAP44XX_IRQ_GIC_START },
+	{ .irq =3D -1 }
+};
+
+static struct omap_hwmod_addr_space omap44xx_hdq1w_addrs[] =3D {
+	{
+		.pa_start	=3D 0x480b2000,
+		.pa_end		=3D 0x480b201f,
+		.flags		=3D ADDR_TYPE_RT
+	},
+	{ }
+};
+
+/* l4_per -> hdq1w */
+static struct omap_hwmod_ocp_if omap44xx_l4_per__hdq1w =3D {
+	.master		=3D &omap44xx_l4_per_hwmod,
+	.slave		=3D &omap44xx_hdq1w_hwmod,
+	.clk		=3D "l4_div_ck",
+	.addr		=3D omap44xx_hdq1w_addrs,
+	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* hdq1w slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_hdq1w_slaves[] =3D {
+	&omap44xx_l4_per__hdq1w,
+};
+
+static struct omap_hwmod omap44xx_hdq1w_hwmod =3D {
+	.name		=3D "hdq1w",
+	.class		=3D &omap44xx_hdq1w_hwmod_class,
+	.clkdm_name	=3D "l4_per_clkdm",
+	.mpu_irqs	=3D omap44xx_hdq1w_irqs,
+	.main_clk	=3D "func_12m_fclk",
+	.prcm =3D {
+		.omap4 =3D {
+			.clkctrl_offs =3D OMAP4_CM_L4PER_HDQ1W_CLKCTRL_OFFSET,
+			.context_offs =3D OMAP4_RM_L4PER_HDQ1W_CONTEXT_OFFSET,
+			.modulemode   =3D MODULEMODE_SWCTRL,
+		},
+	},
+	.slaves		=3D omap44xx_hdq1w_slaves,
+	.slaves_cnt	=3D ARRAY_SIZE(omap44xx_hdq1w_slaves),
+};
+
+/*
  * 'hsi' class
  * mipi high-speed synchronous serial interface (multichannel and full=
-duplex
  * serial if)
@@ -5539,6 +5608,9 @@ static __initdata struct omap_hwmod *omap44xx_hwm=
ods[] =3D {
 	&omap44xx_gpio5_hwmod,
 	&omap44xx_gpio6_hwmod,
=20
+	/* hdq1w class */
+	&omap44xx_hdq1w_hwmod,
+
 	/* hsi class */
 /*	&omap44xx_hsi_hwmod, */
=20
