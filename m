From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 10/11] OMAP3: clock: use autoidle clkops for all
	autoidle-controllable interface clocks
Date: Tue, 15 Feb 2011 23:52:55 -0700
Message-ID: <20110216065254.22089.54609.stgit@twilight.localdomain>
References: <20110216065030.22089.61217.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47525 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752142Ab1BPGyE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Feb 2011 01:54:04 -0500
In-Reply-To: <20110216065030.22089.61217.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Mark each interface clock with a corresponding CM_AUTOIDLE bit with
a clkops that has the allow_idle/deny_idle function pointers populated.
This allows the OMAP clock framework to enable and disable autoidle for
these clocks.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock34xx.c      |   29 ++++++-
 arch/arm/mach-omap2/clock34xx.h      |    5 +
 arch/arm/mach-omap2/clock3517.c      |    4 +
 arch/arm/mach-omap2/clock3xxx_data.c |  149 ++++++++++++++++++--------=
--------
 4 files changed, 112 insertions(+), 75 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/cloc=
k34xx.c
index 287abc4..1fc96b9 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -2,7 +2,7 @@
  * OMAP3-specific clock framework functions
  *
  * Copyright (C) 2007-2008 Texas Instruments, Inc.
- * Copyright (C) 2007-2010 Nokia Corporation
+ * Copyright (C) 2007-2011 Nokia Corporation
  *
  * Paul Walmsley
  * Jouni H=C3=B6gander
@@ -59,6 +59,15 @@ const struct clkops clkops_omap3430es2_ssi_wait =3D =
{
 	.find_companion =3D omap2_clk_dflt_find_companion,
 };
=20
+const struct clkops clkops_omap3430es2_iclk_ssi_wait =3D {
+	.enable		=3D omap2_dflt_clk_enable,
+	.disable	=3D omap2_dflt_clk_disable,
+	.find_idlest	=3D omap3430es2_clk_ssi_find_idlest,
+	.find_companion =3D omap2_clk_dflt_find_companion,
+	.allow_idle	=3D omap2_clkt_iclk_allow_idle,
+	.deny_idle	=3D omap2_clkt_iclk_deny_idle,
+};
+
 /**
  * omap3430es2_clk_dss_usbhost_find_idlest - CM_IDLEST info for DSS, U=
SBHOST
  * @clk: struct clk * being enabled
@@ -94,6 +103,15 @@ const struct clkops clkops_omap3430es2_dss_usbhost_=
wait =3D {
 	.find_companion =3D omap2_clk_dflt_find_companion,
 };
=20
+const struct clkops clkops_omap3430es2_iclk_dss_usbhost_wait =3D {
+	.enable		=3D omap2_dflt_clk_enable,
+	.disable	=3D omap2_dflt_clk_disable,
+	.find_idlest	=3D omap3430es2_clk_dss_usbhost_find_idlest,
+	.find_companion =3D omap2_clk_dflt_find_companion,
+	.allow_idle	=3D omap2_clkt_iclk_allow_idle,
+	.deny_idle	=3D omap2_clkt_iclk_deny_idle,
+};
+
 /**
  * omap3430es2_clk_hsotgusb_find_idlest - return CM_IDLEST info for HS=
OTGUSB
  * @clk: struct clk * being enabled
@@ -124,3 +142,12 @@ const struct clkops clkops_omap3430es2_hsotgusb_wa=
it =3D {
 	.find_idlest	=3D omap3430es2_clk_hsotgusb_find_idlest,
 	.find_companion =3D omap2_clk_dflt_find_companion,
 };
+
+const struct clkops clkops_omap3430es2_iclk_hsotgusb_wait =3D {
+	.enable		=3D omap2_dflt_clk_enable,
+	.disable	=3D omap2_dflt_clk_disable,
+	.find_idlest	=3D omap3430es2_clk_hsotgusb_find_idlest,
+	.find_companion =3D omap2_clk_dflt_find_companion,
+	.allow_idle	=3D omap2_clkt_iclk_allow_idle,
+	.deny_idle	=3D omap2_clkt_iclk_deny_idle,
+};
diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/cloc=
k34xx.h
index 628e8de..084ba71 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -2,14 +2,17 @@
  * OMAP34xx clock function prototypes and macros
  *
  * Copyright (C) 2007-2010 Texas Instruments, Inc.
- * Copyright (C) 2007-2010 Nokia Corporation
+ * Copyright (C) 2007-2011 Nokia Corporation
  */
=20
 #ifndef __ARCH_ARM_MACH_OMAP2_CLOCK34XX_H
 #define __ARCH_ARM_MACH_OMAP2_CLOCK34XX_H
=20
 extern const struct clkops clkops_omap3430es2_ssi_wait;
+extern const struct clkops clkops_omap3430es2_iclk_ssi_wait;
 extern const struct clkops clkops_omap3430es2_hsotgusb_wait;
+extern const struct clkops clkops_omap3430es2_iclk_hsotgusb_wait;
 extern const struct clkops clkops_omap3430es2_dss_usbhost_wait;
+extern const struct clkops clkops_omap3430es2_iclk_dss_usbhost_wait;
=20
 #endif
diff --git a/arch/arm/mach-omap2/clock3517.c b/arch/arm/mach-omap2/cloc=
k3517.c
index 74116a3..2e97d08 100644
--- a/arch/arm/mach-omap2/clock3517.c
+++ b/arch/arm/mach-omap2/clock3517.c
@@ -2,7 +2,7 @@
  * OMAP3517/3505-specific clock framework functions
  *
  * Copyright (C) 2010 Texas Instruments, Inc.
- * Copyright (C) 2010 Nokia Corporation
+ * Copyright (C) 2011 Nokia Corporation
  *
  * Ranjith Lohithakshan
  * Paul Walmsley
@@ -119,6 +119,8 @@ const struct clkops clkops_am35xx_ipss_wait =3D {
 	.disable	=3D omap2_dflt_clk_disable,
 	.find_idlest	=3D am35xx_clk_ipss_find_idlest,
 	.find_companion	=3D omap2_clk_dflt_find_companion,
+	.allow_idle	=3D omap2_clkt_iclk_allow_idle,
+	.deny_idle	=3D omap2_clkt_iclk_deny_idle,
 };
=20
=20
diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2=
/clock3xxx_data.c
index 0021559..58db368 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -2,7 +2,7 @@
  * OMAP3 clock data
  *
  * Copyright (C) 2007-2010 Texas Instruments, Inc.
- * Copyright (C) 2007-2010 Nokia Corporation
+ * Copyright (C) 2007-2011 Nokia Corporation
  *
  * Written by Paul Walmsley
  * With many device clock fixes by Kevin Hilman and Jouni H=C3=B6gande=
r
@@ -1205,7 +1205,10 @@ static const struct clksel gfx_l3_clksel[] =3D {
 	{ .parent =3D NULL }
 };
=20
-/* Virtual parent clock for gfx_l3_ick and gfx_l3_fck */
+/*
+ * Virtual parent clock for gfx_l3_ick and gfx_l3_fck
+ * This interface clock does not have a CM_AUTOIDLE bit
+ */
 static struct clk gfx_l3_ck =3D {
 	.name		=3D "gfx_l3_ck",
 	.ops		=3D &clkops_omap2_dflt_wait,
@@ -1304,6 +1307,7 @@ static struct clk sgx_fck =3D {
 	.round_rate	=3D &omap2_clksel_round_rate
 };
=20
+/* This interface clock does not have a CM_AUTOIDLE bit */
 static struct clk sgx_ick =3D {
 	.name		=3D "sgx_ick",
 	.ops		=3D &clkops_omap2_dflt_wait,
@@ -1328,7 +1332,7 @@ static struct clk d2d_26m_fck =3D {
=20
 static struct clk modem_fck =3D {
 	.name		=3D "modem_fck",
-	.ops		=3D &clkops_omap2_dflt_wait,
+	.ops		=3D &clkops_omap2_mdmclk_dflt_wait,
 	.parent		=3D &sys_ck,
 	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	=3D OMAP3430_EN_MODEM_SHIFT,
@@ -1338,7 +1342,7 @@ static struct clk modem_fck =3D {
=20
 static struct clk sad2d_ick =3D {
 	.name		=3D "sad2d_ick",
-	.ops		=3D &clkops_omap2_dflt_wait,
+	.ops		=3D &clkops_omap2_iclk_dflt_wait,
 	.parent		=3D &l3_ick,
 	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	=3D OMAP3430_EN_SAD2D_SHIFT,
@@ -1348,7 +1352,7 @@ static struct clk sad2d_ick =3D {
=20
 static struct clk mad2d_ick =3D {
 	.name		=3D "mad2d_ick",
-	.ops		=3D &clkops_omap2_dflt_wait,
+	.ops		=3D &clkops_omap2_iclk_dflt_wait,
 	.parent		=3D &l3_ick,
 	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN3),
 	.enable_bit	=3D OMAP3430_EN_MAD2D_SHIFT,
@@ -1718,7 +1722,7 @@ static struct clk core_l3_ick =3D {
=20
 static struct clk hsotgusb_ick_3430es1 =3D {
 	.name		=3D "hsotgusb_ick",
-	.ops		=3D &clkops_omap2_dflt,
+	.ops		=3D &clkops_omap2_iclk_dflt,
 	.parent		=3D &core_l3_ick,
 	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	=3D OMAP3430_EN_HSOTGUSB_SHIFT,
@@ -1728,7 +1732,7 @@ static struct clk hsotgusb_ick_3430es1 =3D {
=20
 static struct clk hsotgusb_ick_3430es2 =3D {
 	.name		=3D "hsotgusb_ick",
-	.ops		=3D &clkops_omap3430es2_hsotgusb_wait,
+	.ops		=3D &clkops_omap3430es2_iclk_hsotgusb_wait,
 	.parent		=3D &core_l3_ick,
 	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	=3D OMAP3430_EN_HSOTGUSB_SHIFT,
@@ -1736,6 +1740,7 @@ static struct clk hsotgusb_ick_3430es2 =3D {
 	.recalc		=3D &followparent_recalc,
 };
=20
+/* This interface clock does not have a CM_AUTOIDLE bit */
 static struct clk sdrc_ick =3D {
 	.name		=3D "sdrc_ick",
 	.ops		=3D &clkops_omap2_dflt_wait,
@@ -1767,7 +1772,7 @@ static struct clk security_l3_ick =3D {
=20
 static struct clk pka_ick =3D {
 	.name		=3D "pka_ick",
-	.ops		=3D &clkops_omap2_dflt_wait,
+	.ops		=3D &clkops_omap2_iclk_dflt_wait,
 	.parent		=3D &security_l3_ick,
 	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	=3D OMAP3430_EN_PKA_SHIFT,
@@ -1786,7 +1791,7 @@ static struct clk core_l4_ick =3D {
=20
 static struct clk usbtll_ick =3D {
 	.name		=3D "usbtll_ick",
-	.ops		=3D &clkops_omap2_dflt_wait,
+	.ops		=3D &clkops_omap2_iclk_dflt_wait,
 	.parent		=3D &core_l4_ick,
 	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN3),
 	.enable_bit	=3D OMAP3430ES2_EN_USBTLL_SHIFT,
@@ -1796,7 +1801,7 @@ static struct clk usbtll_ick =3D {
=20
 static struct clk mmchs3_ick =3D {
 	.name		=3D "mmchs3_ick",
-	.ops		=3D &clkops_omap2_dflt_wait,
+	.ops		=3D &clkops_omap2_iclk_dflt_wait,
 	.parent		=3D &core_l4_ick,
 	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	=3D OMAP3430ES2_EN_MMC3_SHIFT,
@@ -1807,7 +1812,7 @@ static struct clk mmchs3_ick =3D {
 /* Intersystem Communication Registers - chassis mode only */
 static struct clk icr_ick =3D {
 	.name		=3D "icr_ick",
-	.ops		=3D &clkops_omap2_dflt_wait,
+	.ops		=3D &clkops_omap2_iclk_dflt_wait,
 	.parent		=3D &core_l4_ick,
 	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	=3D OMAP3430_EN_ICR_SHIFT,
@@ -1817,7 +1822,7 @@ static struct clk icr_ick =3D {
=20
 static struct clk aes2_ick =3D {
 	.name		=3D "aes2_ick",
-	.ops		=3D &clkops_omap2_dflt_wait,
+	.ops		=3D &clkops_omap2_iclk_dflt_wait,
 	.parent		=3D &core_l4_ick,
 	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	=3D OMAP3430_EN_AES2_SHIFT,
@@ -1827,7 +1832,7 @@ static struct clk aes2_ick =3D {
=20
 static struct clk sha12_ick =3D {
 	.name		=3D "sha12_ick",
-	.ops		=3D &clkops_omap2_dflt_wait,
+	.ops		=3D &clkops_omap2_iclk_dflt_wait,
 	.parent		=3D &core_l4_ick,
 	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	=3D OMAP3430_EN_SHA12_SHIFT,
@@ -1837,7 +1842,7 @@ static struct clk sha12_ick =3D {
=20
 static struct clk des2_ick =3D {
 	.name		=3D "des2_ick",
-	.ops		=3D &clkops_omap2_dflt_wait,
+	.ops		=3D &clkops_omap2_iclk_dflt_wait,
 	.parent		=3D &core_l4_ick,
 	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	=3D OMAP3430_EN_DES2_SHIFT,
@@ -1847,7 +1852,7 @@ static struct clk des2_ick =3D {
=20
 static struct clk mmchs2_ick =3D {
 	.name		=3D "mmchs2_ick",
-	.ops		=3D &clkops_omap2_dflt_wait,
+	.ops		=3D &clkops_omap2_iclk_dflt_wait,
 	.parent		=3D &core_l4_ick,
 	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	=3D OMAP3430_EN_MMC2_SHIFT,
@@ -1857,7 +1862,7 @@ static struct clk mmchs2_ick =3D {
=20
 static struct clk mmchs1_ick =3D {
 	.name		=3D "mmchs1_ick",
-	.ops		=3D &clkops_omap2_dflt_wait,
+	.ops		=3D &clkops_omap2_iclk_dflt_wait,
 	.parent		=3D &core_l4_ick,
 	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	=3D OMAP3430_EN_MMC1_SHIFT,
@@ -1867,7 +1872,7 @@ static struct clk mmchs1_ick =3D {
=20
 static struct clk mspro_ick =3D {
 	.name		=3D "mspro_ick",
-	.ops		=3D &clkops_omap2_dflt_wait,
+	.ops		=3D &clkops_omap2_iclk_dflt_wait,
 	.parent		=3D &core_l4_ick,
 	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	=3D OMAP3430_EN_MSPRO_SHIFT,
@@ -1877,7 +1882,7 @@ static struct clk mspro_ick =3D {
=20
 static struct clk hdq_ick =3D {
 	.name		=3D "hdq_ick",
-	.ops		=3D &clkops_omap2_dflt_wait,
+	.ops		=3D &clkops_omap2_iclk_dflt_wait,
 	.parent		=3D &core_l4_ick,
 	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	=3D OMAP3430_EN_HDQ_SHIFT,
@@ -1887,7 +1892,7 @@ static struct clk hdq_ick =3D {
=20
 static struct clk mcspi4_ick =3D {
 	.name		=3D "mcspi4_ick",
-	.ops		=3D &clkops_omap2_dflt_wait,
+	.ops		=3D &clkops_omap2_iclk_dflt_wait,
 	.parent		=3D &core_l4_ick,
 	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	=3D OMAP3430_EN_MCSPI4_SHIFT,
@@ -1897,7 +1902,7 @@ static struct clk mcspi4_ick =3D {
=20
 static struct clk mcspi3_ick =3D {
 	.name		=3D "mcspi3_ick",
-	.ops		=3D &clkops_omap2_dflt_wait,
+	.ops		=3D &clkops_omap2_iclk_dflt_wait,
 	.parent		=3D &core_l4_ick,
 	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	=3D OMAP3430_EN_MCSPI3_SHIFT,
@@ -1907,7 +1912,7 @@ static struct clk mcspi3_ick =3D {
=20
 static struct clk mcspi2_ick =3D {
 	.name		=3D "mcspi2_ick",
-	.ops		=3D &clkops_omap2_dflt_wait,
+	.ops		=3D &clkops_omap2_iclk_dflt_wait,
 	.parent		=3D &core_l4_ick,
 	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	=3D OMAP3430_EN_MCSPI2_SHIFT,
@@ -1917,7 +1922,7 @@ static struct clk mcspi2_ick =3D {
=20
 static struct clk mcspi1_ick =3D {
 	.name		=3D "mcspi1_ick",
-	.ops		=3D &clkops_omap2_dflt_wait,
+	.ops		=3D &clkops_omap2_iclk_dflt_wait,
 	.parent		=3D &core_l4_ick,
 	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	=3D OMAP3430_EN_MCSPI1_SHIFT,
@@ -1927,7 +1932,7 @@ static struct clk mcspi1_ick =3D {
=20
 static struct clk i2c3_ick =3D {
 	.name		=3D "i2c3_ick",
-	.ops		=3D &clkops_omap2_dflt_wait,
+	.ops		=3D &clkops_omap2_iclk_dflt_wait,
 	.parent		=3D &core_l4_ick,
 	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	=3D OMAP3430_EN_I2C3_SHIFT,
@@ -1937,7 +1942,7 @@ static struct clk i2c3_ick =3D {
=20
 static struct clk i2c2_ick =3D {
 	.name		=3D "i2c2_ick",
-	.ops		=3D &clkops_omap2_dflt_wait,
+	.ops		=3D &clkops_omap2_iclk_dflt_wait,
 	.parent		=3D &core_l4_ick,
 	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	=3D OMAP3430_EN_I2C2_SHIFT,
@@ -1947,7 +1952,7 @@ static struct clk i2c2_ick =3D {
=20
 static struct clk i2c1_ick =3D {
 	.name		=3D "i2c1_ick",
-	.ops		=3D &clkops_omap2_dflt_wait,
+	.ops		=3D &clkops_omap2_iclk_dflt_wait,
 	.parent		=3D &core_l4_ick,
 	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	=3D OMAP3430_EN_I2C1_SHIFT,
@@ -1957,7 +1962,7 @@ static struct clk i2c1_ick =3D {
=20
 static struct clk uart2_ick =3D {
 	.name		=3D "uart2_ick",
-	.ops		=3D &clkops_omap2_dflt_wait,
+	.ops		=3D &clkops_omap2_iclk_dflt_wait,
 	.parent		=3D &core_l4_ick,
 	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	=3D OMAP3430_EN_UART2_SHIFT,
@@ -1967,7 +1972,7 @@ static struct clk uart2_ick =3D {
=20
 static struct clk uart1_ick =3D {
 	.name		=3D "uart1_ick",
-	.ops		=3D &clkops_omap2_dflt_wait,
+	.ops		=3D &clkops_omap2_iclk_dflt_wait,
 	.parent		=3D &core_l4_ick,
 	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	=3D OMAP3430_EN_UART1_SHIFT,
@@ -1977,7 +1982,7 @@ static struct clk uart1_ick =3D {
=20
 static struct clk gpt11_ick =3D {
 	.name		=3D "gpt11_ick",
-	.ops		=3D &clkops_omap2_dflt_wait,
+	.ops		=3D &clkops_omap2_iclk_dflt_wait,
 	.parent		=3D &core_l4_ick,
 	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	=3D OMAP3430_EN_GPT11_SHIFT,
@@ -1987,7 +1992,7 @@ static struct clk gpt11_ick =3D {
=20
 static struct clk gpt10_ick =3D {
 	.name		=3D "gpt10_ick",
-	.ops		=3D &clkops_omap2_dflt_wait,
+	.ops		=3D &clkops_omap2_iclk_dflt_wait,
 	.parent		=3D &core_l4_ick,
 	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	=3D OMAP3430_EN_GPT10_SHIFT,
@@ -1997,7 +2002,7 @@ static struct clk gpt10_ick =3D {
=20
 static struct clk mcbsp5_ick =3D {
 	.name		=3D "mcbsp5_ick",
-	.ops		=3D &clkops_omap2_dflt_wait,
+	.ops		=3D &clkops_omap2_iclk_dflt_wait,
 	.parent		=3D &core_l4_ick,
 	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	=3D OMAP3430_EN_MCBSP5_SHIFT,
@@ -2007,7 +2012,7 @@ static struct clk mcbsp5_ick =3D {
=20
 static struct clk mcbsp1_ick =3D {
 	.name		=3D "mcbsp1_ick",
-	.ops		=3D &clkops_omap2_dflt_wait,
+	.ops		=3D &clkops_omap2_iclk_dflt_wait,
 	.parent		=3D &core_l4_ick,
 	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	=3D OMAP3430_EN_MCBSP1_SHIFT,
@@ -2017,7 +2022,7 @@ static struct clk mcbsp1_ick =3D {
=20
 static struct clk fac_ick =3D {
 	.name		=3D "fac_ick",
-	.ops		=3D &clkops_omap2_dflt_wait,
+	.ops		=3D &clkops_omap2_iclk_dflt_wait,
 	.parent		=3D &core_l4_ick,
 	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	=3D OMAP3430ES1_EN_FAC_SHIFT,
@@ -2027,7 +2032,7 @@ static struct clk fac_ick =3D {
=20
 static struct clk mailboxes_ick =3D {
 	.name		=3D "mailboxes_ick",
-	.ops		=3D &clkops_omap2_dflt_wait,
+	.ops		=3D &clkops_omap2_iclk_dflt_wait,
 	.parent		=3D &core_l4_ick,
 	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	=3D OMAP3430_EN_MAILBOXES_SHIFT,
@@ -2037,7 +2042,7 @@ static struct clk mailboxes_ick =3D {
=20
 static struct clk omapctrl_ick =3D {
 	.name		=3D "omapctrl_ick",
-	.ops		=3D &clkops_omap2_dflt_wait,
+	.ops		=3D &clkops_omap2_iclk_dflt_wait,
 	.parent		=3D &core_l4_ick,
 	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	=3D OMAP3430_EN_OMAPCTRL_SHIFT,
@@ -2057,7 +2062,7 @@ static struct clk ssi_l4_ick =3D {
=20
 static struct clk ssi_ick_3430es1 =3D {
 	.name		=3D "ssi_ick",
-	.ops		=3D &clkops_omap2_dflt,
+	.ops		=3D &clkops_omap2_iclk_dflt,
 	.parent		=3D &ssi_l4_ick,
 	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	=3D OMAP3430_EN_SSI_SHIFT,
@@ -2067,7 +2072,7 @@ static struct clk ssi_ick_3430es1 =3D {
=20
 static struct clk ssi_ick_3430es2 =3D {
 	.name		=3D "ssi_ick",
-	.ops		=3D &clkops_omap3430es2_ssi_wait,
+	.ops		=3D &clkops_omap3430es2_iclk_ssi_wait,
 	.parent		=3D &ssi_l4_ick,
 	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	=3D OMAP3430_EN_SSI_SHIFT,
@@ -2085,7 +2090,7 @@ static const struct clksel usb_l4_clksel[] =3D {
=20
 static struct clk usb_l4_ick =3D {
 	.name		=3D "usb_l4_ick",
-	.ops		=3D &clkops_omap2_dflt_wait,
+	.ops		=3D &clkops_omap2_iclk_dflt_wait,
 	.parent		=3D &l4_ick,
 	.init		=3D &omap2_init_clksel_parent,
 	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
@@ -2107,7 +2112,7 @@ static struct clk security_l4_ick2 =3D {
=20
 static struct clk aes1_ick =3D {
 	.name		=3D "aes1_ick",
-	.ops		=3D &clkops_omap2_dflt_wait,
+	.ops		=3D &clkops_omap2_iclk_dflt_wait,
 	.parent		=3D &security_l4_ick2,
 	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	=3D OMAP3430_EN_AES1_SHIFT,
@@ -2116,7 +2121,7 @@ static struct clk aes1_ick =3D {
=20
 static struct clk rng_ick =3D {
 	.name		=3D "rng_ick",
-	.ops		=3D &clkops_omap2_dflt_wait,
+	.ops		=3D &clkops_omap2_iclk_dflt_wait,
 	.parent		=3D &security_l4_ick2,
 	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	=3D OMAP3430_EN_RNG_SHIFT,
@@ -2125,7 +2130,7 @@ static struct clk rng_ick =3D {
=20
 static struct clk sha11_ick =3D {
 	.name		=3D "sha11_ick",
-	.ops		=3D &clkops_omap2_dflt_wait,
+	.ops		=3D &clkops_omap2_iclk_dflt_wait,
 	.parent		=3D &security_l4_ick2,
 	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	=3D OMAP3430_EN_SHA11_SHIFT,
@@ -2134,7 +2139,7 @@ static struct clk sha11_ick =3D {
=20
 static struct clk des1_ick =3D {
 	.name		=3D "des1_ick",
-	.ops		=3D &clkops_omap2_dflt_wait,
+	.ops		=3D &clkops_omap2_iclk_dflt_wait,
 	.parent		=3D &security_l4_ick2,
 	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	=3D OMAP3430_EN_DES1_SHIFT,
@@ -2195,7 +2200,7 @@ static struct clk dss2_alwon_fck =3D {
 static struct clk dss_ick_3430es1 =3D {
 	/* Handles both L3 and L4 clocks */
 	.name		=3D "dss_ick",
-	.ops		=3D &clkops_omap2_dflt,
+	.ops		=3D &clkops_omap2_iclk_dflt,
 	.parent		=3D &l4_ick,
 	.enable_reg	=3D OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_ICLKEN),
 	.enable_bit	=3D OMAP3430_CM_ICLKEN_DSS_EN_DSS_SHIFT,
@@ -2206,7 +2211,7 @@ static struct clk dss_ick_3430es1 =3D {
 static struct clk dss_ick_3430es2 =3D {
 	/* Handles both L3 and L4 clocks */
 	.name		=3D "dss_ick",
-	.ops		=3D &clkops_omap3430es2_dss_usbhost_wait,
+	.ops		=3D &clkops_omap3430es2_iclk_dss_usbhost_wait,
 	.parent		=3D &l4_ick,
 	.enable_reg	=3D OMAP_CM_REGADDR(OMAP3430_DSS_MOD, CM_ICLKEN),
 	.enable_bit	=3D OMAP3430_CM_ICLKEN_DSS_EN_DSS_SHIFT,
@@ -2229,7 +2234,7 @@ static struct clk cam_mclk =3D {
 static struct clk cam_ick =3D {
 	/* Handles both L3 and L4 clocks */
 	.name		=3D "cam_ick",
-	.ops		=3D &clkops_omap2_dflt,
+	.ops		=3D &clkops_omap2_iclk_dflt,
 	.parent		=3D &l4_ick,
 	.enable_reg	=3D OMAP_CM_REGADDR(OMAP3430_CAM_MOD, CM_ICLKEN),
 	.enable_bit	=3D OMAP3430_EN_CAM_SHIFT,
@@ -2272,7 +2277,7 @@ static struct clk usbhost_48m_fck =3D {
 static struct clk usbhost_ick =3D {
 	/* Handles both L3 and L4 clocks */
 	.name		=3D "usbhost_ick",
-	.ops		=3D &clkops_omap3430es2_dss_usbhost_wait,
+	.ops		=3D &clkops_omap3430es2_iclk_dss_usbhost_wait,
 	.parent		=3D &l4_ick,
 	.enable_reg	=3D OMAP_CM_REGADDR(OMAP3430ES2_USBHOST_MOD, CM_ICLKEN),
 	.enable_bit	=3D OMAP3430ES2_EN_USBHOST_SHIFT,
@@ -2372,7 +2377,7 @@ static struct clk wkup_l4_ick =3D {
 /* Never specifically named in the TRM, so we have to infer a likely n=
ame */
 static struct clk usim_ick =3D {
 	.name		=3D "usim_ick",
-	.ops		=3D &clkops_omap2_dflt_wait,
+	.ops		=3D &clkops_omap2_iclk_dflt_wait,
 	.parent		=3D &wkup_l4_ick,
 	.enable_reg	=3D OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	=3D OMAP3430ES2_EN_USIMOCP_SHIFT,
@@ -2382,7 +2387,7 @@ static struct clk usim_ick =3D {
=20
 static struct clk wdt2_ick =3D {
 	.name		=3D "wdt2_ick",
-	.ops		=3D &clkops_omap2_dflt_wait,
+	.ops		=3D &clkops_omap2_iclk_dflt_wait,
 	.parent		=3D &wkup_l4_ick,
 	.enable_reg	=3D OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	=3D OMAP3430_EN_WDT2_SHIFT,
@@ -2392,7 +2397,7 @@ static struct clk wdt2_ick =3D {
=20
 static struct clk wdt1_ick =3D {
 	.name		=3D "wdt1_ick",
-	.ops		=3D &clkops_omap2_dflt_wait,
+	.ops		=3D &clkops_omap2_iclk_dflt_wait,
 	.parent		=3D &wkup_l4_ick,
 	.enable_reg	=3D OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	=3D OMAP3430_EN_WDT1_SHIFT,
@@ -2402,7 +2407,7 @@ static struct clk wdt1_ick =3D {
=20
 static struct clk gpio1_ick =3D {
 	.name		=3D "gpio1_ick",
-	.ops		=3D &clkops_omap2_dflt_wait,
+	.ops		=3D &clkops_omap2_iclk_dflt_wait,
 	.parent		=3D &wkup_l4_ick,
 	.enable_reg	=3D OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	=3D OMAP3430_EN_GPIO1_SHIFT,
@@ -2412,7 +2417,7 @@ static struct clk gpio1_ick =3D {
=20
 static struct clk omap_32ksync_ick =3D {
 	.name		=3D "omap_32ksync_ick",
-	.ops		=3D &clkops_omap2_dflt_wait,
+	.ops		=3D &clkops_omap2_iclk_dflt_wait,
 	.parent		=3D &wkup_l4_ick,
 	.enable_reg	=3D OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	=3D OMAP3430_EN_32KSYNC_SHIFT,
@@ -2423,7 +2428,7 @@ static struct clk omap_32ksync_ick =3D {
 /* XXX This clock no longer exists in 3430 TRM rev F */
 static struct clk gpt12_ick =3D {
 	.name		=3D "gpt12_ick",
-	.ops		=3D &clkops_omap2_dflt_wait,
+	.ops		=3D &clkops_omap2_iclk_dflt_wait,
 	.parent		=3D &wkup_l4_ick,
 	.enable_reg	=3D OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	=3D OMAP3430_EN_GPT12_SHIFT,
@@ -2433,7 +2438,7 @@ static struct clk gpt12_ick =3D {
=20
 static struct clk gpt1_ick =3D {
 	.name		=3D "gpt1_ick",
-	.ops		=3D &clkops_omap2_dflt_wait,
+	.ops		=3D &clkops_omap2_iclk_dflt_wait,
 	.parent		=3D &wkup_l4_ick,
 	.enable_reg	=3D OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	=3D OMAP3430_EN_GPT1_SHIFT,
@@ -2663,7 +2668,7 @@ static struct clk per_l4_ick =3D {
=20
 static struct clk gpio6_ick =3D {
 	.name		=3D "gpio6_ick",
-	.ops		=3D &clkops_omap2_dflt_wait,
+	.ops		=3D &clkops_omap2_iclk_dflt_wait,
 	.parent		=3D &per_l4_ick,
 	.enable_reg	=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	=3D OMAP3430_EN_GPIO6_SHIFT,
@@ -2673,7 +2678,7 @@ static struct clk gpio6_ick =3D {
=20
 static struct clk gpio5_ick =3D {
 	.name		=3D "gpio5_ick",
-	.ops		=3D &clkops_omap2_dflt_wait,
+	.ops		=3D &clkops_omap2_iclk_dflt_wait,
 	.parent		=3D &per_l4_ick,
 	.enable_reg	=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	=3D OMAP3430_EN_GPIO5_SHIFT,
@@ -2683,7 +2688,7 @@ static struct clk gpio5_ick =3D {
=20
 static struct clk gpio4_ick =3D {
 	.name		=3D "gpio4_ick",
-	.ops		=3D &clkops_omap2_dflt_wait,
+	.ops		=3D &clkops_omap2_iclk_dflt_wait,
 	.parent		=3D &per_l4_ick,
 	.enable_reg	=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	=3D OMAP3430_EN_GPIO4_SHIFT,
@@ -2693,7 +2698,7 @@ static struct clk gpio4_ick =3D {
=20
 static struct clk gpio3_ick =3D {
 	.name		=3D "gpio3_ick",
-	.ops		=3D &clkops_omap2_dflt_wait,
+	.ops		=3D &clkops_omap2_iclk_dflt_wait,
 	.parent		=3D &per_l4_ick,
 	.enable_reg	=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	=3D OMAP3430_EN_GPIO3_SHIFT,
@@ -2703,7 +2708,7 @@ static struct clk gpio3_ick =3D {
=20
 static struct clk gpio2_ick =3D {
 	.name		=3D "gpio2_ick",
-	.ops		=3D &clkops_omap2_dflt_wait,
+	.ops		=3D &clkops_omap2_iclk_dflt_wait,
 	.parent		=3D &per_l4_ick,
 	.enable_reg	=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	=3D OMAP3430_EN_GPIO2_SHIFT,
@@ -2713,7 +2718,7 @@ static struct clk gpio2_ick =3D {
=20
 static struct clk wdt3_ick =3D {
 	.name		=3D "wdt3_ick",
-	.ops		=3D &clkops_omap2_dflt_wait,
+	.ops		=3D &clkops_omap2_iclk_dflt_wait,
 	.parent		=3D &per_l4_ick,
 	.enable_reg	=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	=3D OMAP3430_EN_WDT3_SHIFT,
@@ -2723,7 +2728,7 @@ static struct clk wdt3_ick =3D {
=20
 static struct clk uart3_ick =3D {
 	.name		=3D "uart3_ick",
-	.ops		=3D &clkops_omap2_dflt_wait,
+	.ops		=3D &clkops_omap2_iclk_dflt_wait,
 	.parent		=3D &per_l4_ick,
 	.enable_reg	=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	=3D OMAP3430_EN_UART3_SHIFT,
@@ -2733,7 +2738,7 @@ static struct clk uart3_ick =3D {
=20
 static struct clk uart4_ick =3D {
 	.name		=3D "uart4_ick",
-	.ops		=3D &clkops_omap2_dflt_wait,
+	.ops		=3D &clkops_omap2_iclk_dflt_wait,
 	.parent		=3D &per_l4_ick,
 	.enable_reg	=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	=3D OMAP3630_EN_UART4_SHIFT,
@@ -2743,7 +2748,7 @@ static struct clk uart4_ick =3D {
=20
 static struct clk gpt9_ick =3D {
 	.name		=3D "gpt9_ick",
-	.ops		=3D &clkops_omap2_dflt_wait,
+	.ops		=3D &clkops_omap2_iclk_dflt_wait,
 	.parent		=3D &per_l4_ick,
 	.enable_reg	=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	=3D OMAP3430_EN_GPT9_SHIFT,
@@ -2753,7 +2758,7 @@ static struct clk gpt9_ick =3D {
=20
 static struct clk gpt8_ick =3D {
 	.name		=3D "gpt8_ick",
-	.ops		=3D &clkops_omap2_dflt_wait,
+	.ops		=3D &clkops_omap2_iclk_dflt_wait,
 	.parent		=3D &per_l4_ick,
 	.enable_reg	=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	=3D OMAP3430_EN_GPT8_SHIFT,
@@ -2763,7 +2768,7 @@ static struct clk gpt8_ick =3D {
=20
 static struct clk gpt7_ick =3D {
 	.name		=3D "gpt7_ick",
-	.ops		=3D &clkops_omap2_dflt_wait,
+	.ops		=3D &clkops_omap2_iclk_dflt_wait,
 	.parent		=3D &per_l4_ick,
 	.enable_reg	=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	=3D OMAP3430_EN_GPT7_SHIFT,
@@ -2773,7 +2778,7 @@ static struct clk gpt7_ick =3D {
=20
 static struct clk gpt6_ick =3D {
 	.name		=3D "gpt6_ick",
-	.ops		=3D &clkops_omap2_dflt_wait,
+	.ops		=3D &clkops_omap2_iclk_dflt_wait,
 	.parent		=3D &per_l4_ick,
 	.enable_reg	=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	=3D OMAP3430_EN_GPT6_SHIFT,
@@ -2783,7 +2788,7 @@ static struct clk gpt6_ick =3D {
=20
 static struct clk gpt5_ick =3D {
 	.name		=3D "gpt5_ick",
-	.ops		=3D &clkops_omap2_dflt_wait,
+	.ops		=3D &clkops_omap2_iclk_dflt_wait,
 	.parent		=3D &per_l4_ick,
 	.enable_reg	=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	=3D OMAP3430_EN_GPT5_SHIFT,
@@ -2793,7 +2798,7 @@ static struct clk gpt5_ick =3D {
=20
 static struct clk gpt4_ick =3D {
 	.name		=3D "gpt4_ick",
-	.ops		=3D &clkops_omap2_dflt_wait,
+	.ops		=3D &clkops_omap2_iclk_dflt_wait,
 	.parent		=3D &per_l4_ick,
 	.enable_reg	=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	=3D OMAP3430_EN_GPT4_SHIFT,
@@ -2803,7 +2808,7 @@ static struct clk gpt4_ick =3D {
=20
 static struct clk gpt3_ick =3D {
 	.name		=3D "gpt3_ick",
-	.ops		=3D &clkops_omap2_dflt_wait,
+	.ops		=3D &clkops_omap2_iclk_dflt_wait,
 	.parent		=3D &per_l4_ick,
 	.enable_reg	=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	=3D OMAP3430_EN_GPT3_SHIFT,
@@ -2813,7 +2818,7 @@ static struct clk gpt3_ick =3D {
=20
 static struct clk gpt2_ick =3D {
 	.name		=3D "gpt2_ick",
-	.ops		=3D &clkops_omap2_dflt_wait,
+	.ops		=3D &clkops_omap2_iclk_dflt_wait,
 	.parent		=3D &per_l4_ick,
 	.enable_reg	=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	=3D OMAP3430_EN_GPT2_SHIFT,
@@ -2823,7 +2828,7 @@ static struct clk gpt2_ick =3D {
=20
 static struct clk mcbsp2_ick =3D {
 	.name		=3D "mcbsp2_ick",
-	.ops		=3D &clkops_omap2_dflt_wait,
+	.ops		=3D &clkops_omap2_iclk_dflt_wait,
 	.parent		=3D &per_l4_ick,
 	.enable_reg	=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	=3D OMAP3430_EN_MCBSP2_SHIFT,
@@ -2833,7 +2838,7 @@ static struct clk mcbsp2_ick =3D {
=20
 static struct clk mcbsp3_ick =3D {
 	.name		=3D "mcbsp3_ick",
-	.ops		=3D &clkops_omap2_dflt_wait,
+	.ops		=3D &clkops_omap2_iclk_dflt_wait,
 	.parent		=3D &per_l4_ick,
 	.enable_reg	=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	=3D OMAP3430_EN_MCBSP3_SHIFT,
@@ -2843,7 +2848,7 @@ static struct clk mcbsp3_ick =3D {
=20
 static struct clk mcbsp4_ick =3D {
 	.name		=3D "mcbsp4_ick",
-	.ops		=3D &clkops_omap2_dflt_wait,
+	.ops		=3D &clkops_omap2_iclk_dflt_wait,
 	.parent		=3D &per_l4_ick,
 	.enable_reg	=3D OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	=3D OMAP3430_EN_MCBSP4_SHIFT,
@@ -3186,7 +3191,7 @@ static struct clk vpfe_fck =3D {
  */
 static struct clk uart4_ick_am35xx =3D {
 	.name		=3D "uart4_ick",
-	.ops		=3D &clkops_omap2_dflt_wait,
+	.ops		=3D &clkops_omap2_iclk_dflt_wait,
 	.parent		=3D &core_l4_ick,
 	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	=3D AM35XX_EN_UART4_SHIFT,


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
