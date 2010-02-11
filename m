From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 13/13] OMAP4 clock: drop the ALWAYS_ENABLED clock flag
Date: Thu, 11 Feb 2010 11:18:15 -0700
Message-ID: <20100211181810.795.68652.stgit@localhost.localdomain>
References: <20100211181236.795.56094.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35548 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756800Ab0BKSU4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Feb 2010 13:20:56 -0500
In-Reply-To: <20100211181236.795.56094.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Rajendra Nayak <rnayak@ti.com>, =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

Get rid of the ALWAYS_ENABLED clock flag - it doesn't actually do anyth=
ing.
(The OMAP4 clock autogeneration scripts have been updated accordingly.)

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/clock44xx_data.c    |   11 -----------
 arch/arm/plat-omap/include/plat/clock.h |    1 -
 2 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2=
/clock44xx_data.c
index 022f1a7..6deca1e 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -39,42 +39,36 @@ static struct clk extalt_clkin_ck =3D {
 	.name		=3D "extalt_clkin_ck",
 	.rate		=3D 59000000,
 	.ops		=3D &clkops_null,
-	.flags		=3D ALWAYS_ENABLED,
 };
=20
 static struct clk pad_clks_ck =3D {
 	.name		=3D "pad_clks_ck",
 	.rate		=3D 12000000,
 	.ops		=3D &clkops_null,
-	.flags		=3D ALWAYS_ENABLED,
 };
=20
 static struct clk pad_slimbus_core_clks_ck =3D {
 	.name		=3D "pad_slimbus_core_clks_ck",
 	.rate		=3D 12000000,
 	.ops		=3D &clkops_null,
-	.flags		=3D ALWAYS_ENABLED,
 };
=20
 static struct clk secure_32k_clk_src_ck =3D {
 	.name		=3D "secure_32k_clk_src_ck",
 	.rate		=3D 32768,
 	.ops		=3D &clkops_null,
-	.flags		=3D ALWAYS_ENABLED,
 };
=20
 static struct clk slimbus_clk =3D {
 	.name		=3D "slimbus_clk",
 	.rate		=3D 12000000,
 	.ops		=3D &clkops_null,
-	.flags		=3D ALWAYS_ENABLED,
 };
=20
 static struct clk sys_32k_ck =3D {
 	.name		=3D "sys_32k_ck",
 	.rate		=3D 32768,
 	.ops		=3D &clkops_null,
-	.flags		=3D ALWAYS_ENABLED,
 };
=20
 static struct clk virt_12000000_ck =3D {
@@ -179,35 +173,30 @@ static struct clk sys_clkin_ck =3D {
 	.clksel_mask	=3D OMAP4430_SYS_CLKSEL_MASK,
 	.ops		=3D &clkops_null,
 	.recalc		=3D &omap2_clksel_recalc,
-	.flags		=3D ALWAYS_ENABLED,
 };
=20
 static struct clk utmi_phy_clkout_ck =3D {
 	.name		=3D "utmi_phy_clkout_ck",
 	.rate		=3D 12000000,
 	.ops		=3D &clkops_null,
-	.flags		=3D ALWAYS_ENABLED,
 };
=20
 static struct clk xclk60mhsp1_ck =3D {
 	.name		=3D "xclk60mhsp1_ck",
 	.rate		=3D 12000000,
 	.ops		=3D &clkops_null,
-	.flags		=3D ALWAYS_ENABLED,
 };
=20
 static struct clk xclk60mhsp2_ck =3D {
 	.name		=3D "xclk60mhsp2_ck",
 	.rate		=3D 12000000,
 	.ops		=3D &clkops_null,
-	.flags		=3D ALWAYS_ENABLED,
 };
=20
 static struct clk xclk60motg_ck =3D {
 	.name		=3D "xclk60motg_ck",
 	.rate		=3D 60000000,
 	.ops		=3D &clkops_null,
-	.flags		=3D ALWAYS_ENABLED,
 };
=20
 /* Module clocks and DPLL outputs */
diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-om=
ap/include/plat/clock.h
index dcfdcd6..5e1c035 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -193,7 +193,6 @@ extern const struct clkops clkops_null;
 #define CLOCK_NO_IDLE_PARENT	(1 << 2)
 #define ENABLE_ON_INIT		(1 << 3)	/* Enable upon framework init */
 #define INVERT_ENABLE		(1 << 4)	/* 0 enables, 1 disables */
-#define ALWAYS_ENABLED		(1 << 5)
=20
 /* Clksel_rate flags */
 #define DEFAULT_RATE		(1 << 0)


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
