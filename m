From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 08/10] OMAP: split plat-omap/common.c
Date: Mon, 4 Oct 2010 13:26:29 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1010041324200.13816@utopia.booyaka.com>
References: <20101001213119.1408.65395.stgit@twilight.localdomain> <20101001213532.1408.55832.stgit@twilight.localdomain> <4CA999AA.4030608@ti.com> <alpine.DEB.2.00.1010041314170.13816@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1436174072-1286220389=:13816"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37668 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932477Ab0JDT0a (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 15:26:30 -0400
In-Reply-To: <alpine.DEB.2.00.1010041314170.13816@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1436174072-1286220389=:13816
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 4 Oct 2010, Paul Walmsley wrote:

> On Mon, 4 Oct 2010, Cousson, Benoit wrote:
>=20
> > > --- /dev/null
> > > +++ b/arch/arm/plat-omap/32ksynctimer.c
> > > @@ -0,0 +1,184 @@
> > > +/*
> > > + * linux/arch/arm/plat-omap/clocksource.c
> >=20
> > What name do you want to use? 32ksynctimer.c or clocksource.c?
>=20
> Thanks, that's a bug.
>=20
> > If this file is dedicated for the 32k sync timer, maybe we should now u=
se the
> > new OMAP4 name: "counter_32k".
> >=20
> > Noboby knows what the sync stand for, and at the end this is just a 32k
> > counter. Hence the new name :-)
>=20
> Yep, let's use counter_32k.c.

Here's the updated patch:


- Paul

From=2038a26f5b30116df2f0f82acdae3b0a5f8aa25ac7 Mon Sep 17 00:00:00 2001
From: Paul Walmsley <paul@pwsan.com>
Date: Fri, 1 Oct 2010 15:46:44 -0600
Subject: [PATCH] OMAP: split plat-omap/common.c
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

Split plat-omap/common.c into three pieces:

1. the 32KiHz sync timer and clocksource code, which now lives in
   plat-omap/counter_32k.c;

2. the OMAP2+ common code, which has been moved to mach-omap2/common.c;

3. and the remainder of the OMAP-wide common code, which includes the
   deprecated ATAGs code and a deprecated video RAM reservation function.

The primary motivation for doing this is to move the OMAP2+-specific parts
into an OMAP2+-specific file, so that build breakage related to the
System Control Module code can be resolved.

Beno=EEt Cousson <b-cousson@ti.com> suggested a new filename and found
some bugs in the counter_32k.c comments - thanks Beno=EEt.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno=EEt Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/Makefile     |    3 +-
 arch/arm/mach-omap2/common.c     |  137 ++++++++++++++++++
 arch/arm/plat-omap/Makefile      |    2 +-
 arch/arm/plat-omap/common.c      |  291 ----------------------------------=
----
 arch/arm/plat-omap/counter_32k.c |  183 ++++++++++++++++++++++++
 arch/arm/plat-omap/devices.c     |    1 -
 arch/arm/plat-omap/sram.c        |    3 -
 7 files changed, 323 insertions(+), 297 deletions(-)
 create mode 100644 arch/arm/mach-omap2/common.c
 create mode 100644 arch/arm/plat-omap/counter_32k.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 9edacb0..d543533 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -3,7 +3,8 @@
 #
=20
 # Common support
-obj-y :=3D id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-gp.o =
pm.o
+obj-y :=3D id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-gp.o =
pm.o \
+=09 common.o
=20
 omap-2-3-common=09=09=09=09=3D irq.o sdrc.o prm2xxx_3xxx.o
 hwmod-common=09=09=09=09=3D omap_hwmod.o \
diff --git a/arch/arm/mach-omap2/common.c b/arch/arm/mach-omap2/common.c
new file mode 100644
index 0000000..d613738
--- /dev/null
+++ b/arch/arm/mach-omap2/common.c
@@ -0,0 +1,137 @@
+/*
+ * linux/arch/arm/mach-omap2/common.c
+ *
+ * Code common to all OMAP2+ machines.
+ *
+ * Copyright (C) 2009 Texas Instruments
+ * Copyright (C) 2010 Nokia Corporation
+ * Tony Lindgren <tony@atomide.com>
+ * Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+
+#include <plat/common.h>
+#include <plat/board.h>
+#include <plat/control.h>
+#include <plat/mux.h>
+
+#include <plat/clock.h>
+
+#include "sdrc.h"
+
+/* Global address base setup code */
+
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
+
+static void __init __omap2_set_globals(struct omap_globals *omap2_globals)
+{
+=09omap2_set_globals_tap(omap2_globals);
+=09omap2_set_globals_sdrc(omap2_globals);
+=09omap2_set_globals_control(omap2_globals);
+=09omap2_set_globals_prcm(omap2_globals);
+=09omap2_set_globals_uart(omap2_globals);
+}
+
+#endif
+
+#if defined(CONFIG_ARCH_OMAP2420)
+
+static struct omap_globals omap242x_globals =3D {
+=09.class=09=3D OMAP242X_CLASS,
+=09.tap=09=3D OMAP2_L4_IO_ADDRESS(0x48014000),
+=09.sdrc=09=3D OMAP2420_SDRC_BASE,
+=09.sms=09=3D OMAP2420_SMS_BASE,
+=09.ctrl=09=3D OMAP242X_CTRL_BASE,
+=09.prm=09=3D OMAP2420_PRM_BASE,
+=09.cm=09=3D OMAP2420_CM_BASE,
+=09.uart1_phys=09=3D OMAP2_UART1_BASE,
+=09.uart2_phys=09=3D OMAP2_UART2_BASE,
+=09.uart3_phys=09=3D OMAP2_UART3_BASE,
+};
+
+void __init omap2_set_globals_242x(void)
+{
+=09__omap2_set_globals(&omap242x_globals);
+}
+#endif
+
+#if defined(CONFIG_ARCH_OMAP2430)
+
+static struct omap_globals omap243x_globals =3D {
+=09.class=09=3D OMAP243X_CLASS,
+=09.tap=09=3D OMAP2_L4_IO_ADDRESS(0x4900a000),
+=09.sdrc=09=3D OMAP243X_SDRC_BASE,
+=09.sms=09=3D OMAP243X_SMS_BASE,
+=09.ctrl=09=3D OMAP243X_CTRL_BASE,
+=09.prm=09=3D OMAP2430_PRM_BASE,
+=09.cm=09=3D OMAP2430_CM_BASE,
+=09.uart1_phys=09=3D OMAP2_UART1_BASE,
+=09.uart2_phys=09=3D OMAP2_UART2_BASE,
+=09.uart3_phys=09=3D OMAP2_UART3_BASE,
+};
+
+void __init omap2_set_globals_243x(void)
+{
+=09__omap2_set_globals(&omap243x_globals);
+}
+#endif
+
+#if defined(CONFIG_ARCH_OMAP3)
+
+static struct omap_globals omap3_globals =3D {
+=09.class=09=3D OMAP343X_CLASS,
+=09.tap=09=3D OMAP2_L4_IO_ADDRESS(0x4830A000),
+=09.sdrc=09=3D OMAP343X_SDRC_BASE,
+=09.sms=09=3D OMAP343X_SMS_BASE,
+=09.ctrl=09=3D OMAP343X_CTRL_BASE,
+=09.prm=09=3D OMAP3430_PRM_BASE,
+=09.cm=09=3D OMAP3430_CM_BASE,
+=09.uart1_phys=09=3D OMAP3_UART1_BASE,
+=09.uart2_phys=09=3D OMAP3_UART2_BASE,
+=09.uart3_phys=09=3D OMAP3_UART3_BASE,
+=09.uart4_phys=09=3D OMAP3_UART4_BASE,=09/* Only on 3630 */
+};
+
+void __init omap2_set_globals_3xxx(void)
+{
+=09__omap2_set_globals(&omap3_globals);
+}
+
+void __init omap3_map_io(void)
+{
+=09omap2_set_globals_3xxx();
+=09omap34xx_map_common_io();
+}
+#endif
+
+#if defined(CONFIG_ARCH_OMAP4)
+static struct omap_globals omap4_globals =3D {
+=09.class=09=3D OMAP443X_CLASS,
+=09.tap=09=3D OMAP2_L4_IO_ADDRESS(OMAP443X_SCM_BASE),
+=09.ctrl=09=3D OMAP443X_SCM_BASE,
+=09.ctrl_pad=09=3D OMAP443X_CTRL_BASE,
+=09.prm=09=3D OMAP4430_PRM_BASE,
+=09.cm=09=3D OMAP4430_CM_BASE,
+=09.cm2=09=3D OMAP4430_CM2_BASE,
+=09.uart1_phys=09=3D OMAP4_UART1_BASE,
+=09.uart2_phys=09=3D OMAP4_UART2_BASE,
+=09.uart3_phys=09=3D OMAP4_UART3_BASE,
+=09.uart4_phys=09=3D OMAP4_UART4_BASE,
+};
+
+void __init omap2_set_globals_443x(void)
+{
+=09omap2_set_globals_tap(&omap4_globals);
+=09omap2_set_globals_control(&omap4_globals);
+=09omap2_set_globals_prcm(&omap4_globals);
+=09omap2_set_globals_uart(&omap4_globals);
+}
+#endif
+
diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index 2a15191..a4a1285 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -4,7 +4,7 @@
=20
 # Common support
 obj-y :=3D common.o sram.o clock.o devices.o dma.o mux.o gpio.o \
-=09 usb.o fb.o io.o
+=09 usb.o fb.o io.o counter_32k.o
 obj-m :=3D
 obj-n :=3D
 obj-  :=3D
diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index 9200ea7..221a675 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -11,38 +11,15 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-#include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/delay.h>
-#include <linux/console.h>
-#include <linux/serial.h>
-#include <linux/tty.h>
-#include <linux/serial_8250.h>
-#include <linux/serial_reg.h>
-#include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/omapfb.h>
=20
-#include <mach/hardware.h>
-#include <asm/system.h>
-#include <asm/pgtable.h>
-#include <asm/mach/map.h>
-#include <asm/setup.h>
-
 #include <plat/common.h>
 #include <plat/board.h>
-#include <plat/control.h>
-#include <plat/mux.h>
-#include <plat/fpga.h>
-#include <plat/serial.h>
 #include <plat/vram.h>
=20
-#include <plat/clock.h>
-
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
-# include "../mach-omap2/sdrc.h"
-#endif
=20
 #define NO_LENGTH_CHECK 0xffffffff
=20
@@ -88,271 +65,3 @@ void __init omap_reserve(void)
 =09omapfb_reserve_sdram_memblock();
 =09omap_vram_reserve_sdram_memblock();
 }
-
-/*
- * 32KHz clocksource ... always available, on pretty most chips except
- * OMAP 730 and 1510.  Other timers could be used as clocksources, with
- * higher resolution in free-running counter modes (e.g. 12 MHz xtal),
- * but systems won't necessarily want to spend resources that way.
- */
-
-#define OMAP16XX_TIMER_32K_SYNCHRONIZED=09=090xfffbc410
-
-#if !(defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP15XX))
-
-#include <linux/clocksource.h>
-
-/*
- * offset_32k holds the init time counter value. It is then subtracted
- * from every counter read to achieve a counter that counts time from the
- * kernel boot (needed for sched_clock()).
- */
-static u32 offset_32k __read_mostly;
-
-#ifdef CONFIG_ARCH_OMAP16XX
-static cycle_t omap16xx_32k_read(struct clocksource *cs)
-{
-=09return omap_readl(OMAP16XX_TIMER_32K_SYNCHRONIZED) - offset_32k;
-}
-#else
-#define omap16xx_32k_read=09NULL
-#endif
-
-#ifdef CONFIG_ARCH_OMAP2420
-static cycle_t omap2420_32k_read(struct clocksource *cs)
-{
-=09return omap_readl(OMAP2420_32KSYNCT_BASE + 0x10) - offset_32k;
-}
-#else
-#define omap2420_32k_read=09NULL
-#endif
-
-#ifdef CONFIG_ARCH_OMAP2430
-static cycle_t omap2430_32k_read(struct clocksource *cs)
-{
-=09return omap_readl(OMAP2430_32KSYNCT_BASE + 0x10) - offset_32k;
-}
-#else
-#define omap2430_32k_read=09NULL
-#endif
-
-#ifdef CONFIG_ARCH_OMAP3
-static cycle_t omap34xx_32k_read(struct clocksource *cs)
-{
-=09return omap_readl(OMAP3430_32KSYNCT_BASE + 0x10) - offset_32k;
-}
-#else
-#define omap34xx_32k_read=09NULL
-#endif
-
-#ifdef CONFIG_ARCH_OMAP4
-static cycle_t omap44xx_32k_read(struct clocksource *cs)
-{
-=09return omap_readl(OMAP4430_32KSYNCT_BASE + 0x10) - offset_32k;
-}
-#else
-#define omap44xx_32k_read=09NULL
-#endif
-
-/*
- * Kernel assumes that sched_clock can be called early but may not have
- * things ready yet.
- */
-static cycle_t omap_32k_read_dummy(struct clocksource *cs)
-{
-=09return 0;
-}
-
-static struct clocksource clocksource_32k =3D {
-=09.name=09=09=3D "32k_counter",
-=09.rating=09=09=3D 250,
-=09.read=09=09=3D omap_32k_read_dummy,
-=09.mask=09=09=3D CLOCKSOURCE_MASK(32),
-=09.shift=09=09=3D 10,
-=09.flags=09=09=3D CLOCK_SOURCE_IS_CONTINUOUS,
-};
-
-/*
- * Returns current time from boot in nsecs. It's OK for this to wrap
- * around for now, as it's just a relative time stamp.
- */
-unsigned long long sched_clock(void)
-{
-=09return clocksource_cyc2ns(clocksource_32k.read(&clocksource_32k),
-=09=09=09=09  clocksource_32k.mult, clocksource_32k.shift);
-}
-
-/**
- * read_persistent_clock -  Return time from a persistent clock.
- *
- * Reads the time from a source which isn't disabled during PM, the
- * 32k sync timer.  Convert the cycles elapsed since last read into
- * nsecs and adds to a monotonically increasing timespec.
- */
-static struct timespec persistent_ts;
-static cycles_t cycles, last_cycles;
-void read_persistent_clock(struct timespec *ts)
-{
-=09unsigned long long nsecs;
-=09cycles_t delta;
-=09struct timespec *tsp =3D &persistent_ts;
-
-=09last_cycles =3D cycles;
-=09cycles =3D clocksource_32k.read(&clocksource_32k);
-=09delta =3D cycles - last_cycles;
-
-=09nsecs =3D clocksource_cyc2ns(delta,
-=09=09=09=09   clocksource_32k.mult, clocksource_32k.shift);
-
-=09timespec_add_ns(tsp, nsecs);
-=09*ts =3D *tsp;
-}
-
-static int __init omap_init_clocksource_32k(void)
-{
-=09static char err[] __initdata =3D KERN_ERR
-=09=09=09"%s: can't register clocksource!\n";
-
-=09if (cpu_is_omap16xx() || cpu_class_is_omap2()) {
-=09=09struct clk *sync_32k_ick;
-
-=09=09if (cpu_is_omap16xx())
-=09=09=09clocksource_32k.read =3D omap16xx_32k_read;
-=09=09else if (cpu_is_omap2420())
-=09=09=09clocksource_32k.read =3D omap2420_32k_read;
-=09=09else if (cpu_is_omap2430())
-=09=09=09clocksource_32k.read =3D omap2430_32k_read;
-=09=09else if (cpu_is_omap34xx())
-=09=09=09clocksource_32k.read =3D omap34xx_32k_read;
-=09=09else if (cpu_is_omap44xx())
-=09=09=09clocksource_32k.read =3D omap44xx_32k_read;
-=09=09else
-=09=09=09return -ENODEV;
-
-=09=09sync_32k_ick =3D clk_get(NULL, "omap_32ksync_ick");
-=09=09if (sync_32k_ick)
-=09=09=09clk_enable(sync_32k_ick);
-
-=09=09clocksource_32k.mult =3D clocksource_hz2mult(32768,
-=09=09=09=09=09    clocksource_32k.shift);
-
-=09=09offset_32k =3D clocksource_32k.read(&clocksource_32k);
-
-=09=09if (clocksource_register(&clocksource_32k))
-=09=09=09printk(err, clocksource_32k.name);
-=09}
-=09return 0;
-}
-arch_initcall(omap_init_clocksource_32k);
-
-#endif=09/* !(defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP15XX=
)) */
-
-/* Global address base setup code */
-
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
-
-static void __init __omap2_set_globals(struct omap_globals *omap2_globals)
-{
-=09omap2_set_globals_tap(omap2_globals);
-=09omap2_set_globals_sdrc(omap2_globals);
-=09omap2_set_globals_control(omap2_globals);
-=09omap2_set_globals_prcm(omap2_globals);
-=09omap2_set_globals_uart(omap2_globals);
-}
-
-#endif
-
-#if defined(CONFIG_ARCH_OMAP2420)
-
-static struct omap_globals omap242x_globals =3D {
-=09.class=09=3D OMAP242X_CLASS,
-=09.tap=09=3D OMAP2_L4_IO_ADDRESS(0x48014000),
-=09.sdrc=09=3D OMAP2420_SDRC_BASE,
-=09.sms=09=3D OMAP2420_SMS_BASE,
-=09.ctrl=09=3D OMAP242X_CTRL_BASE,
-=09.prm=09=3D OMAP2420_PRM_BASE,
-=09.cm=09=3D OMAP2420_CM_BASE,
-=09.uart1_phys=09=3D OMAP2_UART1_BASE,
-=09.uart2_phys=09=3D OMAP2_UART2_BASE,
-=09.uart3_phys=09=3D OMAP2_UART3_BASE,
-};
-
-void __init omap2_set_globals_242x(void)
-{
-=09__omap2_set_globals(&omap242x_globals);
-}
-#endif
-
-#if defined(CONFIG_ARCH_OMAP2430)
-
-static struct omap_globals omap243x_globals =3D {
-=09.class=09=3D OMAP243X_CLASS,
-=09.tap=09=3D OMAP2_L4_IO_ADDRESS(0x4900a000),
-=09.sdrc=09=3D OMAP243X_SDRC_BASE,
-=09.sms=09=3D OMAP243X_SMS_BASE,
-=09.ctrl=09=3D OMAP243X_CTRL_BASE,
-=09.prm=09=3D OMAP2430_PRM_BASE,
-=09.cm=09=3D OMAP2430_CM_BASE,
-=09.uart1_phys=09=3D OMAP2_UART1_BASE,
-=09.uart2_phys=09=3D OMAP2_UART2_BASE,
-=09.uart3_phys=09=3D OMAP2_UART3_BASE,
-};
-
-void __init omap2_set_globals_243x(void)
-{
-=09__omap2_set_globals(&omap243x_globals);
-}
-#endif
-
-#if defined(CONFIG_ARCH_OMAP3)
-
-static struct omap_globals omap3_globals =3D {
-=09.class=09=3D OMAP343X_CLASS,
-=09.tap=09=3D OMAP2_L4_IO_ADDRESS(0x4830A000),
-=09.sdrc=09=3D OMAP343X_SDRC_BASE,
-=09.sms=09=3D OMAP343X_SMS_BASE,
-=09.ctrl=09=3D OMAP343X_CTRL_BASE,
-=09.prm=09=3D OMAP3430_PRM_BASE,
-=09.cm=09=3D OMAP3430_CM_BASE,
-=09.uart1_phys=09=3D OMAP3_UART1_BASE,
-=09.uart2_phys=09=3D OMAP3_UART2_BASE,
-=09.uart3_phys=09=3D OMAP3_UART3_BASE,
-=09.uart4_phys=09=3D OMAP3_UART4_BASE,=09/* Only on 3630 */
-};
-
-void __init omap2_set_globals_3xxx(void)
-{
-=09__omap2_set_globals(&omap3_globals);
-}
-
-void __init omap3_map_io(void)
-{
-=09omap2_set_globals_3xxx();
-=09omap34xx_map_common_io();
-}
-#endif
-
-#if defined(CONFIG_ARCH_OMAP4)
-static struct omap_globals omap4_globals =3D {
-=09.class=09=3D OMAP443X_CLASS,
-=09.tap=09=3D OMAP2_L4_IO_ADDRESS(OMAP443X_SCM_BASE),
-=09.ctrl=09=3D OMAP443X_SCM_BASE,
-=09.ctrl_pad=09=3D OMAP443X_CTRL_BASE,
-=09.prm=09=3D OMAP4430_PRM_BASE,
-=09.cm=09=3D OMAP4430_CM_BASE,
-=09.cm2=09=3D OMAP4430_CM2_BASE,
-=09.uart1_phys=09=3D OMAP4_UART1_BASE,
-=09.uart2_phys=09=3D OMAP4_UART2_BASE,
-=09.uart3_phys=09=3D OMAP4_UART3_BASE,
-=09.uart4_phys=09=3D OMAP4_UART4_BASE,
-};
-
-void __init omap2_set_globals_443x(void)
-{
-=09omap2_set_globals_tap(&omap4_globals);
-=09omap2_set_globals_control(&omap4_globals);
-=09omap2_set_globals_prcm(&omap4_globals);
-=09omap2_set_globals_uart(&omap4_globals);
-}
-#endif
-
diff --git a/arch/arm/plat-omap/counter_32k.c b/arch/arm/plat-omap/counter_=
32k.c
new file mode 100644
index 0000000..155fe43
--- /dev/null
+++ b/arch/arm/plat-omap/counter_32k.c
@@ -0,0 +1,183 @@
+/*
+ * OMAP 32ksynctimer/counter_32k-related code
+ *
+ * Copyright (C) 2009 Texas Instruments
+ * Copyright (C) 2010 Nokia Corporation
+ * Tony Lindgren <tony@atomide.com>
+ * Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * NOTE: This timer is not the same timer as the old OMAP1 MPU timer.
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+
+#include <plat/common.h>
+#include <plat/board.h>
+
+#include <plat/clock.h>
+
+
+/*
+ * 32KHz clocksource ... always available, on pretty most chips except
+ * OMAP 730 and 1510.  Other timers could be used as clocksources, with
+ * higher resolution in free-running counter modes (e.g. 12 MHz xtal),
+ * but systems won't necessarily want to spend resources that way.
+ */
+
+#define OMAP16XX_TIMER_32K_SYNCHRONIZED=09=090xfffbc410
+
+#if !(defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP15XX))
+
+#include <linux/clocksource.h>
+
+/*
+ * offset_32k holds the init time counter value. It is then subtracted
+ * from every counter read to achieve a counter that counts time from the
+ * kernel boot (needed for sched_clock()).
+ */
+static u32 offset_32k __read_mostly;
+
+#ifdef CONFIG_ARCH_OMAP16XX
+static cycle_t omap16xx_32k_read(struct clocksource *cs)
+{
+=09return omap_readl(OMAP16XX_TIMER_32K_SYNCHRONIZED) - offset_32k;
+}
+#else
+#define omap16xx_32k_read=09NULL
+#endif
+
+#ifdef CONFIG_ARCH_OMAP2420
+static cycle_t omap2420_32k_read(struct clocksource *cs)
+{
+=09return omap_readl(OMAP2420_32KSYNCT_BASE + 0x10) - offset_32k;
+}
+#else
+#define omap2420_32k_read=09NULL
+#endif
+
+#ifdef CONFIG_ARCH_OMAP2430
+static cycle_t omap2430_32k_read(struct clocksource *cs)
+{
+=09return omap_readl(OMAP2430_32KSYNCT_BASE + 0x10) - offset_32k;
+}
+#else
+#define omap2430_32k_read=09NULL
+#endif
+
+#ifdef CONFIG_ARCH_OMAP3
+static cycle_t omap34xx_32k_read(struct clocksource *cs)
+{
+=09return omap_readl(OMAP3430_32KSYNCT_BASE + 0x10) - offset_32k;
+}
+#else
+#define omap34xx_32k_read=09NULL
+#endif
+
+#ifdef CONFIG_ARCH_OMAP4
+static cycle_t omap44xx_32k_read(struct clocksource *cs)
+{
+=09return omap_readl(OMAP4430_32KSYNCT_BASE + 0x10) - offset_32k;
+}
+#else
+#define omap44xx_32k_read=09NULL
+#endif
+
+/*
+ * Kernel assumes that sched_clock can be called early but may not have
+ * things ready yet.
+ */
+static cycle_t omap_32k_read_dummy(struct clocksource *cs)
+{
+=09return 0;
+}
+
+static struct clocksource clocksource_32k =3D {
+=09.name=09=09=3D "32k_counter",
+=09.rating=09=09=3D 250,
+=09.read=09=09=3D omap_32k_read_dummy,
+=09.mask=09=09=3D CLOCKSOURCE_MASK(32),
+=09.shift=09=09=3D 10,
+=09.flags=09=09=3D CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+/*
+ * Returns current time from boot in nsecs. It's OK for this to wrap
+ * around for now, as it's just a relative time stamp.
+ */
+unsigned long long sched_clock(void)
+{
+=09return clocksource_cyc2ns(clocksource_32k.read(&clocksource_32k),
+=09=09=09=09  clocksource_32k.mult, clocksource_32k.shift);
+}
+
+/**
+ * read_persistent_clock -  Return time from a persistent clock.
+ *
+ * Reads the time from a source which isn't disabled during PM, the
+ * 32k sync timer.  Convert the cycles elapsed since last read into
+ * nsecs and adds to a monotonically increasing timespec.
+ */
+static struct timespec persistent_ts;
+static cycles_t cycles, last_cycles;
+void read_persistent_clock(struct timespec *ts)
+{
+=09unsigned long long nsecs;
+=09cycles_t delta;
+=09struct timespec *tsp =3D &persistent_ts;
+
+=09last_cycles =3D cycles;
+=09cycles =3D clocksource_32k.read(&clocksource_32k);
+=09delta =3D cycles - last_cycles;
+
+=09nsecs =3D clocksource_cyc2ns(delta,
+=09=09=09=09   clocksource_32k.mult, clocksource_32k.shift);
+
+=09timespec_add_ns(tsp, nsecs);
+=09*ts =3D *tsp;
+}
+
+static int __init omap_init_clocksource_32k(void)
+{
+=09static char err[] __initdata =3D KERN_ERR
+=09=09=09"%s: can't register clocksource!\n";
+
+=09if (cpu_is_omap16xx() || cpu_class_is_omap2()) {
+=09=09struct clk *sync_32k_ick;
+
+=09=09if (cpu_is_omap16xx())
+=09=09=09clocksource_32k.read =3D omap16xx_32k_read;
+=09=09else if (cpu_is_omap2420())
+=09=09=09clocksource_32k.read =3D omap2420_32k_read;
+=09=09else if (cpu_is_omap2430())
+=09=09=09clocksource_32k.read =3D omap2430_32k_read;
+=09=09else if (cpu_is_omap34xx())
+=09=09=09clocksource_32k.read =3D omap34xx_32k_read;
+=09=09else if (cpu_is_omap44xx())
+=09=09=09clocksource_32k.read =3D omap44xx_32k_read;
+=09=09else
+=09=09=09return -ENODEV;
+
+=09=09sync_32k_ick =3D clk_get(NULL, "omap_32ksync_ick");
+=09=09if (sync_32k_ick)
+=09=09=09clk_enable(sync_32k_ick);
+
+=09=09clocksource_32k.mult =3D clocksource_hz2mult(32768,
+=09=09=09=09=09    clocksource_32k.shift);
+
+=09=09offset_32k =3D clocksource_32k.read(&clocksource_32k);
+
+=09=09if (clocksource_register(&clocksource_32k))
+=09=09=09printk(err, clocksource_32k.name);
+=09}
+=09return 0;
+}
+arch_initcall(omap_init_clocksource_32k);
+
+#endif=09/* !(defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP15XX=
)) */
+
diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index d1920be..78162a0 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -21,7 +21,6 @@
 #include <asm/mach/map.h>
=20
 #include <plat/tc.h>
-#include <plat/control.h>
 #include <plat/board.h>
 #include <plat/mmc.h>
 #include <mach/gpio.h>
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 98c86ff..79ce946 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -30,8 +30,6 @@
 #include <plat/cpu.h>
 #include <plat/vram.h>
=20
-#include <plat/control.h>
-
 #if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 # include "../mach-omap2/prm.h"
 # include "../mach-omap2/cm.h"
@@ -68,7 +66,6 @@
 #define OMAP34XX_VA_WRITEPERM0=09=09OMAP2_L3_IO_ADDRESS(0x68012858)
 #define OMAP34XX_VA_ADDR_MATCH2=09=09OMAP2_L3_IO_ADDRESS(0x68012880)
 #define OMAP34XX_VA_SMS_RG_ATT0=09=09OMAP2_L3_IO_ADDRESS(0x6C000048)
-#define OMAP34XX_VA_CONTROL_STAT=09OMAP2_L4_IO_ADDRESS(0x480022F0)
=20
 #define GP_DEVICE=09=090x300
=20
--=20
1.7.1

--155748971-1436174072-1286220389=:13816--
