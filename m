From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] OMAP2+: clock: allow per-SoC clock init code to prevent
 clockdomain calls from clock code
Date: Sat, 9 Jul 2011 15:26:00 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107091524390.15984@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-424436621-1310246760=:15984"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52766 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754782Ab1GIV0B (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 9 Jul 2011 17:26:01 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: =?ISO-8859-15?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-424436621-1310246760=:15984
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE


The OMAP2/3 clock code was written to notify the clockdomain code when
the first clock in a clockdomain is enabled and when the last enabled
clock in a clockdomain is disabled.  OMAP4 requires a different
approach: the hwmod code needs to signal the clockdomain code when to
force-enable and auto-idle a clockdomain during the IP block enable
process.  The current conjecture is that once that hwmod sequence is
implemented, it will no longer be necessary for the clock code to call
into the clockdomain code for "optional clocks" on OMAP4.

Add a static flag to the OMAP2+ clock code, clkdm_control, that by
default preserves the OMAP2/3 behavior.  Also add a function,
omap2_clk_disable_clkdm_control(), intended to be called from OMAP4
and beyond clock initcalls, that disables the old behavior.

Part of this patch was originally based on a patch by Rajendra Nayak
<rnayak@ti.com>.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno=EEt Cousson <b-cousson@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clock.c |   27 ++++++++++++++++++++++++---
 arch/arm/mach-omap2/clock.h |    3 +++
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 180299e..fc84576 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -38,6 +38,14 @@
 u8 cpu_mask;
=20
 /*
+ * clkdm_control: if true, then when a clock is enabled in the
+ * hardware, its clockdomain will first be enabled; and when a clock
+ * is disabled in the hardware, its clockdomain will be disabled
+ * afterwards.
+ */
+static bool clkdm_control =3D true;
+
+/*
  * OMAP2+ specific clock functions
  */
=20
@@ -100,6 +108,19 @@ void omap2_init_clk_clkdm(struct clk *clk)
 }
=20
 /**
+ * omap2_clk_disable_clkdm_control - disable clkdm control on clk enable/d=
isable
+ *
+ * Prevent the OMAP clock code from calling into the clockdomain code
+ * when a hardware clock in that clockdomain is enabled or disabled.
+ * Intended to be called at init time from omap*_clk_init().  No
+ * return value.
+ */
+void __init omap2_clk_disable_clkdm_control(void)
+{
+=09clkdm_control =3D false;
+}
+
+/**
  * omap2_clk_dflt_find_companion - find companion clock to @clk
  * @clk: struct clk * to find the companion clock of
  * @other_reg: void __iomem ** to return the companion clock CM_*CLKEN va =
in
@@ -268,7 +289,7 @@ void omap2_clk_disable(struct clk *clk)
 =09=09clk->ops->disable(clk);
 =09}
=20
-=09if (clk->clkdm)
+=09if (clkdm_control && clk->clkdm)
 =09=09clkdm_clk_disable(clk->clkdm, clk);
=20
 =09if (clk->parent)
@@ -308,7 +329,7 @@ int omap2_clk_enable(struct clk *clk)
 =09=09}
 =09}
=20
-=09if (clk->clkdm) {
+=09if (clkdm_control && clk->clkdm) {
 =09=09ret =3D clkdm_clk_enable(clk->clkdm, clk);
 =09=09if (ret) {
 =09=09=09WARN(1, "clock: %s: could not enable clockdomain %s: "
@@ -330,7 +351,7 @@ int omap2_clk_enable(struct clk *clk)
 =09return 0;
=20
 oce_err3:
-=09if (clk->clkdm)
+=09if (clkdm_control && clk->clkdm)
 =09=09clkdm_clk_disable(clk->clkdm, clk);
 oce_err2:
 =09if (clk->parent)
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index e10ff2b..48ac568 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -16,6 +16,8 @@
 #ifndef __ARCH_ARM_MACH_OMAP2_CLOCK_H
 #define __ARCH_ARM_MACH_OMAP2_CLOCK_H
=20
+#include <linux/kernel.h>
+
 #include <plat/clock.h>
=20
 /* CM_CLKSEL2_PLL.CORE_CLK_SRC bits (2XXX) */
@@ -72,6 +74,7 @@ void omap2_clk_disable_unused(struct clk *clk);
 #endif
=20
 void omap2_init_clk_clkdm(struct clk *clk);
+void __init omap2_clk_disable_clkdm_control(void);
=20
 /* clkt_clksel.c public functions */
 u32 omap2_clksel_round_rate_div(struct clk *clk, unsigned long target_rate=
,
--=20
1.7.5.4

--155748971-424436621-1310246760=:15984--
