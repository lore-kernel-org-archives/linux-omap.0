From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2] ARM: AM43xx: hwmod: add DSS hwmod data
Date: Tue, 22 Jul 2014 21:14:20 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1407222110260.25593@utopia.booyaka.com>
References: <1402994233-22599-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:55734 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932101AbaGVVOV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jul 2014 17:14:21 -0400
In-Reply-To: <1402994233-22599-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, Rajendra Nayak <rnayak@ti.com>, linux-arm-kernel@lists.infradead.org, Archit Taneja <archit@ti.com>, Sathya Prakash M R <sathyap@ti.com>

On Tue, 17 Jun 2014, Tomi Valkeinen wrote:

> From: Sathya Prakash M R <sathyap@ti.com>
> 
> Add DSS hwmod data for AM43xx.
> 
> Signed-off-by: Sathya Prakash M R <sathyap@ti.com>
> [tomi.valkeinen@ti.com: added missing dispc flags]
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Acked-by: Rajendra Nayak <rnayak@ti.com>

This one didn't compile on an AM43xx-only build:

----
arch/arm/mach-omap2/built-in.o:(.data+0x3f2c): undefined reference to `omap2_dss_hwmod_class'
arch/arm/mach-omap2/built-in.o:(.data+0x405c): undefined reference to `omap2_rfbi_hwmod_class'
make: *** [vmlinux] Error 1
test_build: Tue Jul 22 13:48:50 MDT 2014: FAILED on omap2plus_defconfig_am43xx_only hwmod-a-v3.17
----

Have queued the following patch instead.


- Paul

From: Sathya Prakash M R <sathyap@ti.com>
Date: Sat, 5 Jul 2014 17:44:57 -0600
Subject: [PATCH] ARM: AM43xx: hwmod: add DSS hwmod data

Add DSS hwmod data for AM43xx.

Signed-off-by: Sathya Prakash M R <sathyap@ti.com>
[tomi.valkeinen@ti.com: added missing dispc flags]
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Acked-by: Rajendra Nayak <rnayak@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
Tested-by: Felipe Balbi <balbi@ti.com> # on linux-next 5f295cdf5c5d
[paul@pwsan.com: fixed build break on AM43xx-only config]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/Makefile                       |   1 +
 .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |  40 ---------
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c         | 100 +++++++++++++++++++++
 .../mach-omap2/omap_hwmod_common_ipblock_data.c    |  55 ++++++++++++
 arch/arm/mach-omap2/prcm43xx.h                     |   1 +
 5 files changed, 157 insertions(+), 40 deletions(-)
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_common_ipblock_data.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 8421f38cf445..75c73f253604 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -200,6 +200,7 @@ obj-$(CONFIG_SOC_OMAP2420)		+= opp2420_data.o
 obj-$(CONFIG_SOC_OMAP2430)		+= opp2430_data.o
 
 # hwmod data
+obj-y					+= omap_hwmod_common_ipblock_data.o
 obj-$(CONFIG_SOC_OMAP2420)		+= omap_hwmod_2xxx_ipblock_data.o
 obj-$(CONFIG_SOC_OMAP2420)		+= omap_hwmod_2xxx_3xxx_ipblock_data.o
 obj-$(CONFIG_SOC_OMAP2420)		+= omap_hwmod_2xxx_interconnect_data.o
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
index 5da7a42a6d90..c6c6384de867 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c
@@ -37,46 +37,6 @@ struct omap_hwmod_class omap2_uart_class = {
 };
 
 /*
- * 'dss' class
- * display sub-system
- */
-
-static struct omap_hwmod_class_sysconfig omap2_dss_sysc = {
-	.rev_offs	= 0x0000,
-	.sysc_offs	= 0x0010,
-	.syss_offs	= 0x0014,
-	.sysc_flags	= (SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE |
-			   SYSS_HAS_RESET_STATUS),
-	.sysc_fields	= &omap_hwmod_sysc_type1,
-};
-
-struct omap_hwmod_class omap2_dss_hwmod_class = {
-	.name	= "dss",
-	.sysc	= &omap2_dss_sysc,
-	.reset	= omap_dss_reset,
-};
-
-/*
- * 'rfbi' class
- * remote frame buffer interface
- */
-
-static struct omap_hwmod_class_sysconfig omap2_rfbi_sysc = {
-	.rev_offs	= 0x0000,
-	.sysc_offs	= 0x0010,
-	.syss_offs	= 0x0014,
-	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET |
-			   SYSC_HAS_AUTOIDLE),
-	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
-	.sysc_fields	= &omap_hwmod_sysc_type1,
-};
-
-struct omap_hwmod_class omap2_rfbi_hwmod_class = {
-	.name	= "rfbi",
-	.sysc	= &omap2_rfbi_sysc,
-};
-
-/*
  * 'venc' class
  * video encoder
  */
diff --git a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
index 5c2cc8083fdd..fea01aa3ef42 100644
--- a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
@@ -19,6 +19,8 @@
 #include "omap_hwmod.h"
 #include "omap_hwmod_33xx_43xx_common_data.h"
 #include "prcm43xx.h"
+#include "omap_hwmod_common_data.h"
+
 
 /* IP blocks */
 static struct omap_hwmod am43xx_l4_hs_hwmod = {
@@ -415,6 +417,72 @@ static struct omap_hwmod am43xx_qspi_hwmod = {
 	},
 };
 
+/* dss */
+
+static struct omap_hwmod am43xx_dss_core_hwmod = {
+	.name		= "dss_core",
+	.class		= &omap2_dss_hwmod_class,
+	.clkdm_name	= "dss_clkdm",
+	.main_clk	= "disp_clk",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = AM43XX_CM_PER_DSS_CLKCTRL_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
+		},
+	},
+};
+
+/* dispc */
+
+struct omap_dss_dispc_dev_attr am43xx_dss_dispc_dev_attr = {
+	.manager_count		= 1,
+	.has_framedonetv_irq	= 0
+};
+
+static struct omap_hwmod_class_sysconfig am43xx_dispc_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.syss_offs	= 0x0014,
+	.sysc_flags	= (SYSC_HAS_AUTOIDLE | SYSC_HAS_SOFTRESET |
+			   SYSC_HAS_ENAWAKEUP | SYSC_HAS_SIDLEMODE |
+			   SYSC_HAS_CLOCKACTIVITY | SYSC_HAS_MIDLEMODE),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
+			   MSTANDBY_FORCE | MSTANDBY_NO | MSTANDBY_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class am43xx_dispc_hwmod_class = {
+	.name	= "dispc",
+	.sysc	= &am43xx_dispc_sysc,
+};
+
+static struct omap_hwmod am43xx_dss_dispc_hwmod = {
+	.name		= "dss_dispc",
+	.class		= &am43xx_dispc_hwmod_class,
+	.clkdm_name	= "dss_clkdm",
+	.main_clk	= "disp_clk",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = AM43XX_CM_PER_DSS_CLKCTRL_OFFSET,
+		},
+	},
+	.dev_attr	= &am43xx_dss_dispc_dev_attr,
+};
+
+/* rfbi */
+
+static struct omap_hwmod am43xx_dss_rfbi_hwmod = {
+	.name		= "dss_rfbi",
+	.class		= &omap2_rfbi_hwmod_class,
+	.clkdm_name	= "dss_clkdm",
+	.main_clk	= "disp_clk",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = AM43XX_CM_PER_DSS_CLKCTRL_OFFSET,
+		},
+	},
+};
+
 /* Interfaces */
 static struct omap_hwmod_ocp_if am43xx_l3_main__l4_hs = {
 	.master		= &am33xx_l3_main_hwmod,
@@ -654,6 +722,34 @@ static struct omap_hwmod_ocp_if am43xx_l3_s__qspi = {
 	.user           = OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+static struct omap_hwmod_ocp_if am43xx_dss__l3_main = {
+	.master		= &am43xx_dss_core_hwmod,
+	.slave		= &am33xx_l3_main_hwmod,
+	.clk		= "l3_gclk",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+static struct omap_hwmod_ocp_if am43xx_l4_ls__dss = {
+	.master		= &am33xx_l4_ls_hwmod,
+	.slave		= &am43xx_dss_core_hwmod,
+	.clk		= "l4ls_gclk",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+static struct omap_hwmod_ocp_if am43xx_l4_ls__dss_dispc = {
+	.master		= &am33xx_l4_ls_hwmod,
+	.slave		= &am43xx_dss_dispc_hwmod,
+	.clk		= "l4ls_gclk",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+static struct omap_hwmod_ocp_if am43xx_l4_ls__dss_rfbi = {
+	.master		= &am33xx_l4_ls_hwmod,
+	.slave		= &am43xx_dss_rfbi_hwmod,
+	.clk		= "l4ls_gclk",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 static struct omap_hwmod_ocp_if *am43xx_hwmod_ocp_ifs[] __initdata = {
 	&am33xx_l4_wkup__synctimer,
 	&am43xx_l4_ls__timer8,
@@ -748,6 +844,10 @@ static struct omap_hwmod_ocp_if *am43xx_hwmod_ocp_ifs[] __initdata = {
 	&am43xx_l4_ls__ocp2scp1,
 	&am43xx_l3_s__usbotgss0,
 	&am43xx_l3_s__usbotgss1,
+	&am43xx_dss__l3_main,
+	&am43xx_l4_ls__dss,
+	&am43xx_l4_ls__dss_dispc,
+	&am43xx_l4_ls__dss_rfbi,
 	NULL,
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_common_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_common_ipblock_data.c
new file mode 100644
index 000000000000..f21664da25a2
--- /dev/null
+++ b/arch/arm/mach-omap2/omap_hwmod_common_ipblock_data.c
@@ -0,0 +1,55 @@
+/*
+ * omap_hwmod_common_ipblock_data.c - common IP block data for OMAP2+
+ *
+ * Copyright (C) 2011 Nokia Corporation
+ * Copyright (C) 2012 Texas Instruments, Inc.
+ * Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "omap_hwmod.h"
+#include "omap_hwmod_common_data.h"
+
+/*
+ * 'dss' class
+ * display sub-system
+ */
+
+static struct omap_hwmod_class_sysconfig omap2_dss_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.syss_offs	= 0x0014,
+	.sysc_flags	= (SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE |
+			   SYSS_HAS_RESET_STATUS),
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+struct omap_hwmod_class omap2_dss_hwmod_class = {
+	.name	= "dss",
+	.sysc	= &omap2_dss_sysc,
+	.reset	= omap_dss_reset,
+};
+
+/*
+ * 'rfbi' class
+ * remote frame buffer interface
+ */
+
+static struct omap_hwmod_class_sysconfig omap2_rfbi_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.syss_offs	= 0x0014,
+	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET |
+			   SYSC_HAS_AUTOIDLE),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+struct omap_hwmod_class omap2_rfbi_hwmod_class = {
+	.name	= "rfbi",
+	.sysc	= &omap2_rfbi_sysc,
+};
+
diff --git a/arch/arm/mach-omap2/prcm43xx.h b/arch/arm/mach-omap2/prcm43xx.h
index 7785be984edd..ad7b3e9977f8 100644
--- a/arch/arm/mach-omap2/prcm43xx.h
+++ b/arch/arm/mach-omap2/prcm43xx.h
@@ -142,5 +142,6 @@
 #define AM43XX_CM_PER_USBPHYOCP2SCP0_CLKCTRL_OFFSET	0x05B8
 #define AM43XX_CM_PER_USB_OTG_SS1_CLKCTRL_OFFSET        0x0268
 #define AM43XX_CM_PER_USBPHYOCP2SCP1_CLKCTRL_OFFSET	0x05C0
+#define AM43XX_CM_PER_DSS_CLKCTRL_OFFSET		0x0a20
 
 #endif
-- 
2.0.1

