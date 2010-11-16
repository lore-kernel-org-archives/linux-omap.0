From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/3] OMAP2+: wd_timer: disable on boot via hwmod postsetup
	mechanism
Date: Tue, 16 Nov 2010 03:25:18 -0700
Message-ID: <20101116102515.27991.78678.stgit@twilight.localdomain>
References: <20101116102205.27991.37909.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40970 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934147Ab0KPK1m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Nov 2010 05:27:42 -0500
In-Reply-To: <20101116102205.27991.37909.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>, Charulatha Varadarajan <charu@ti.com>

The OMAP watchdog timer IP blocks require a specific set of register
writes to occur before they will be disabled[1], even if the device
clocks appear to be disabled in the CM_*CLKEN registers.  In the MPU
watchdog case, failure to execute this reset sequence will eventually
cause the watchdog to reset the OMAP unexpectedly.

Previously, the code to disable this watchdog was manually called from
mach-omap2/devices.c during device initialization.  This causes the
watchdog to be unconditionally disabled for a portion of kernel
initialization.  This should be controllable by the board-*.c files,
since some system integrators will want full watchdog coverage of
kernel initialization.  Also, the watchdog disable code was not
connected to the hwmod shutdown code.  This means that calling
omap_hwmod_shutdown() will not, in fact, disable the watchdog, and the
goal of omap_hwmod_shutdown() is to be able to shutdown any on-chip
OMAP device.

To resolve the latter problem, populate the pre_shutdown pointer in
the watchdog timer hwmod classes with a function that executes the
watchdog shutdown sequence.  This allows the hwmod code to fully
disable the watchdog.

Then, to allow some board files to support watchdog coverage
throughout kernel initialization, add common code to mach-omap2/io.c
to cause the MPU watchdog to be disabled on boot unless a board file
specifically requests it to remain enabled.  Board files can do this
by changing the watchdog timer hwmod's postsetup state between the
omap2_init_common_infrastructure() and omap2_init_common_devices()
function calls.

1. OMAP34xx Multimedia Device Silicon Revision 3.1.x Rev. ZH
   [SWPU222H], Section 16.4.3.6, "Start/Stop Sequence for WDTs (Using
   WDTi.WSPR Register)"

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Charulatha Varadarajan <charu@ti.com>
---
 arch/arm/mach-omap2/devices.c              |   15 ---------------
 arch/arm/mach-omap2/io.c                   |   18 ++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |    6 ++++--
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |    6 ++++--
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    6 ++++--
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    6 ++++--
 arch/arm/mach-omap2/wd_timer.c             |   16 +---------------
 7 files changed, 35 insertions(+), 38 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/device=
s.c
index cd6a46a..b5cafd3 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -33,7 +33,6 @@
=20
 #include "mux.h"
 #include "control.h"
-#include "wd_timer.h"
=20
 #if defined(CONFIG_VIDEO_OMAP2) || defined(CONFIG_VIDEO_OMAP2_MODULE)
=20
@@ -952,26 +951,12 @@ static inline void omap_init_vout(void) {}
=20
 /*--------------------------------------------------------------------=
-----*/
=20
-static int omap2_disable_wdt(struct omap_hwmod *oh, void *unused)
-{
-	return omap2_wd_timer_disable(oh);
-}
-
-static void __init omap_disable_wdt(void)
-{
-	if (cpu_class_is_omap2())
-		omap_hwmod_for_each_by_class("wd_timer",
-					     omap2_disable_wdt, NULL);
-	return;
-}
-
 static int __init omap2_init_devices(void)
 {
 	/*
 	 * please keep these calls, and their implementations above,
 	 * in alphabetical order so they're easier to sort through.
 	 */
-	omap_disable_wdt();
 	omap_hsmmc_reset();
 	omap_init_audio();
 	omap_init_camera();
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 39ab1ec..5b4f30e 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -341,6 +341,24 @@ void __init omap2_init_common_infrastructure(void)
 #endif
 	omap_hwmod_for_each(_set_hwmod_postsetup_state, &postsetup_state);
=20
+	/*
+	 * Set the default postsetup state for unusual modules (like
+	 * MPU WDT).
+	 *
+	 * The postsetup_state is not actually used until
+	 * omap_hwmod_late_init(), so boards that desire full watchdog
+	 * coverage of kernel initialization can reprogram the
+	 * postsetup_state between the calls to
+	 * omap2_init_common_infra() and omap2_init_common_devices().
+	 *
+	 * XXX ideally we could detect whether the MPU WDT was currently
+	 * enabled here and make this conditional
+	 */
+	postsetup_state =3D _HWMOD_STATE_DISABLED;
+	omap_hwmod_for_each_by_class("wd_timer",
+				     _set_hwmod_postsetup_state,
+				     &postsetup_state);
+
 	/* The OPP tables have to be registered before a clk init */
 	omap_pm_if_early_init(mpu_opps, dsp_opps, l3_opps);
=20
diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach=
-omap2/omap_hwmod_2420_data.c
index a1a3dd6..9a5f0d7 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -23,6 +23,7 @@
=20
 #include "cm-regbits-24xx.h"
 #include "prm-regbits-24xx.h"
+#include "wd_timer.h"
=20
 /*
  * OMAP2420 hardware module integration data
@@ -307,8 +308,9 @@ static struct omap_hwmod_class_sysconfig omap2420_w=
d_timer_sysc =3D {
 };
=20
 static struct omap_hwmod_class omap2420_wd_timer_hwmod_class =3D {
-	.name =3D "wd_timer",
-	.sysc =3D &omap2420_wd_timer_sysc,
+	.name		=3D "wd_timer",
+	.sysc		=3D &omap2420_wd_timer_sysc,
+	.pre_shutdown	=3D &omap2_wd_timer_disable
 };
=20
 /* wd_timer2 */
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach=
-omap2/omap_hwmod_2430_data.c
index e4b8d7d..0b89f54 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -23,6 +23,7 @@
=20
 #include "prm-regbits-24xx.h"
 #include "cm-regbits-24xx.h"
+#include "wd_timer.h"
=20
 /*
  * OMAP2430 hardware module integration data
@@ -305,8 +306,9 @@ static struct omap_hwmod_class_sysconfig omap2430_w=
d_timer_sysc =3D {
 };
=20
 static struct omap_hwmod_class omap2430_wd_timer_hwmod_class =3D {
-	.name =3D "wd_timer",
-	.sysc =3D &omap2430_wd_timer_sysc,
+	.name		=3D "wd_timer",
+	.sysc		=3D &omap2430_wd_timer_sysc,
+	.pre_shutdown	=3D &omap2_wd_timer_disable
 };
=20
 /* wd_timer2 */
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach=
-omap2/omap_hwmod_3xxx_data.c
index ed6bf4a..794ed33 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -26,6 +26,7 @@
=20
 #include "prm-regbits-34xx.h"
 #include "cm-regbits-34xx.h"
+#include "wd_timer.h"
=20
 /*
  * OMAP3xxx hardware module integration data
@@ -415,8 +416,9 @@ static struct omap_hwmod_class_sysconfig i2c_sysc =3D=
 {
 };
=20
 static struct omap_hwmod_class omap3xxx_wd_timer_hwmod_class =3D {
-	.name =3D "wd_timer",
-	.sysc =3D &omap3xxx_wd_timer_sysc,
+	.name		=3D "wd_timer",
+	.sysc		=3D &omap3xxx_wd_timer_sysc,
+	.pre_shutdown	=3D &omap2_wd_timer_disable
 };
=20
 /* wd_timer2 */
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach=
-omap2/omap_hwmod_44xx_data.c
index 0d5c6eb..2ab1749 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -27,6 +27,7 @@
=20
 #include "cm.h"
 #include "prm-regbits-44xx.h"
+#include "wd_timer.h"
=20
 /* Base offset for all OMAP4 interrupts external to MPUSS */
 #define OMAP44XX_IRQ_GIC_START	32
@@ -716,8 +717,9 @@ static struct omap_hwmod_class_sysconfig omap44xx_u=
art_sysc =3D {
 };
=20
 static struct omap_hwmod_class omap44xx_wd_timer_hwmod_class =3D {
-	.name =3D "wd_timer",
-	.sysc =3D &omap44xx_wd_timer_sysc,
+	.name		=3D "wd_timer",
+	.sysc		=3D &omap44xx_wd_timer_sysc,
+	.pre_shutdown	=3D &omap2_wd_timer_disable
 };
=20
 /* wd_timer2 */
diff --git a/arch/arm/mach-omap2/wd_timer.c b/arch/arm/mach-omap2/wd_ti=
mer.c
index 06c256d..b0c4907 100644
--- a/arch/arm/mach-omap2/wd_timer.c
+++ b/arch/arm/mach-omap2/wd_timer.c
@@ -27,7 +27,6 @@
 int omap2_wd_timer_disable(struct omap_hwmod *oh)
 {
 	void __iomem *base;
-	int ret;
=20
 	if (!oh) {
 		pr_err("%s: Could not look up wdtimer_hwmod\n", __func__);
@@ -41,14 +40,6 @@ int omap2_wd_timer_disable(struct omap_hwmod *oh)
 		return -EINVAL;
 	}
=20
-	/* Enable the clocks before accessing the WDT registers */
-	ret =3D omap_hwmod_enable(oh);
-	if (ret) {
-		pr_err("%s: Could not enable clocks for %s\n",
-				oh->name, __func__);
-		return ret;
-	}
-
 	/* sequence required to disable watchdog */
 	__raw_writel(0xAAAA, base + OMAP_WDT_SPR);
 	while (__raw_readl(base + OMAP_WDT_WPS) & 0x10)
@@ -58,11 +49,6 @@ int omap2_wd_timer_disable(struct omap_hwmod *oh)
 	while (__raw_readl(base + OMAP_WDT_WPS) & 0x10)
 		cpu_relax();
=20
-	ret =3D omap_hwmod_idle(oh);
-	if (ret)
-		pr_err("%s: Could not disable clocks for %s\n",
-				oh->name, __func__);
-
-	return ret;
+	return 0;
 }
=20


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
