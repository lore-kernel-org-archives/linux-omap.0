From: Paul Walmsley <paul@pwsan.com>
Subject: Re: beagle hangs in uart3 disabling clocks
Date: Tue, 5 Oct 2010 00:14:07 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1010050013210.13816@utopia.booyaka.com>
References: <AANLkTi=9T=5swvF2UcrfDAL8cpHOcfpOU3Fi1O50Z6Tm@mail.gmail.com> <B85A65D85D7EB246BE421B3FB0FBB593023412B5A0@dbde02.ent.ti.com> <4CA9C5F6.7060902@ti.com> <AANLkTi=C55AbJhCWkFAM06vL2c5UM=aH3z2r8i4_55Mk@mail.gmail.com>
 <AANLkTin++-F7dZWhqM6DG4v-95rfOpOwHSqj8xhTdS3k@mail.gmail.com> <87wrpy0xp3.fsf@deeprootsystems.com> <AANLkTi=k+aZ2t2ZgXMcwuoBVPEjzyiGov1ZmSxe+Pe4-@mail.gmail.com> <87iq1hzt3u.fsf@deeprootsystems.com>
 <AANLkTimtfm+Tq6y=Gv=-JWEZ-1CYUpsO71aE0AjkSbHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1120537354-1286259247=:13816"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:32781 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754548Ab0JEGOJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Oct 2010 02:14:09 -0400
In-Reply-To: <AANLkTimtfm+Tq6y=Gv=-JWEZ-1CYUpsO71aE0AjkSbHQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Govindraj <govindraj.ti@gmail.com>, Pramod <pramod.gurav@ti.com>, "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1120537354-1286259247=:13816
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hello Lei,

On Tue, 5 Oct 2010, Ming Lei wrote:

> 2010/10/5 Kevin Hilman <khilman@deeprootsystems.com>:
> > Ming Lei <tom.leiming@gmail.com> writes:
> >
> >> 2010/10/4 Kevin Hilman <khilman@deeprootsystems.com>:
> >>>
> >>> Why? =A0What do you need from the PM branch that is not in l-o master=
?
> >>
> >> Seems master branch works fine for me, my beagle board doesn't hang
> >> uart3 disabling clocks.
> >
> > Master branch and PM branch have exactly the same functionality for
> > UART hwmods. =A0The problem was that you manually enabled DEBUG in
> > omap_hwmod.c.
>=20
> Yes, you are correct. If DEBUG in omap_hwmod.c is enabled manually,
> and pass the parameter of 'earlyprintk loglevel=3D8' to kernel from bootl=
oader,
> this issue can be triggered even with master branch.

Does this experimental patch solve the problem, even if DEBUG is enabled=20
in the hwmod code?


- Paul

From=20d928bd31c9c4ad16a044b244ef3d2ad3ed648f6f Mon Sep 17 00:00:00 2001
From: Paul Walmsley <paul@pwsan.com>
Date: Tue, 5 Oct 2010 00:11:27 -0600
Subject: [PATCH] RFC: omap serial: block console output while resetting ear=
lyconsole UART

Currently, no attempt is made to block console output while the
earlyconsole UART is unavailable.  This can result in silent crashes
that are very difficult to debug due to the lack of console output.
This patch holds the console semaphore while resetting the active console
UART, which causes all console output during that time to be buffered and
then transmitted after the console semaphore is released.

Not-yet-signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/serial.c |  100 ++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 100 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 338e46a..577f8f9 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -28,10 +28,13 @@
 #include <linux/serial_8250.h>
 #include <linux/pm_runtime.h>
=20
+#include <linux/console.h>
+
 #ifdef CONFIG_SERIAL_OMAP
 #include <plat/omap-serial.h>
 #endif
=20
+#include <plat/serial.h>
 #include <plat/common.h>
 #include <plat/board.h>
 #include <plat/clock.h>
@@ -39,6 +42,8 @@
 #include <plat/omap_hwmod.h>
 #include <plat/omap_device.h>
=20
+#include <asm/memory.h>
+
 #include "prm.h"
 #include "pm.h"
 #include "cm.h"
@@ -51,6 +56,8 @@
 #define UART_ERRATA_FIFO_FULL_ABORT=09(0x1 << 0)
 #define UART_ERRATA_i202_MDR1_ACCESS=09(0x1 << 1)
=20
+#define uart_id_to_ttys_id(u)=09=09(u - 1)
+
 /*
  * NOTE: By default the serial timeout is disabled as it causes lost chara=
cters
  * over the serial ports. This means that the UART clocks will stay on unt=
il
@@ -106,6 +113,83 @@ static LIST_HEAD(uart_list);
 static u8 num_uarts;
=20
 /*
+ * early_console_uart: if earlyconsole is enabled and active, the UART
+ * ID (e.g., 1, 2, 3, 4) will be stored here.  '0' means earlyconsole
+ * is disabled or some problem occurred during earlyconsole handling.
+ */
+static int early_console_uart;
+
+#define for_each_console(con) \
+=09for (con =3D console_drivers; con !=3D NULL; con =3D con->next)
+
+/* XXX belongs in kernel/printk.c or some earlyconsole file */
+/* XXX The "earlycon" string is an ugly hack */
+int _is_early_console_enabled(void)
+{
+=09int ret =3D 0;
+=09struct console *c;
+
+=09acquire_console_sem();
+=09for_each_console(c)
+=09=09if (!strcmp("earlycon", c->name))
+=09=09=09ret =3D 1;
+=09release_console_sem();
+
+=09return ret;
+}
+
+/* XXX document */
+static int _get_early_console_uart(void)
+{
+=09u32 v;
+=09int u =3D -EINVAL;
+
+=09v =3D __raw_readl(phys_to_virt(OMAP_UART_INFO));
+=09/* XXX see the OMAP debug-macro.S for this table */
+=09switch (v) {
+=09case 0:
+=09case OMAP2UART1:
+=09=09u =3D 1;
+=09=09break;
+=09case OMAP2UART2:
+=09=09u =3D 2;
+=09=09break;
+=09case OMAP2UART3:
+=09case OMAP3UART3:
+=09case OMAP4UART3:
+=09=09u =3D 3;
+=09=09break;
+=09case OMAP3UART4:
+=09case OMAP4UART4:
+=09=09u =3D 4;
+=09=09break;
+=09case ZOOM_UART:
+=09=09WARN(1, "omap serial: ZOOM UART in use - does that go through "
+=09=09     "the OMAP serial code?\n");
+=09=09break;
+=09default:
+=09=09WARN(1, "omap serial: unknown serial port in use!\n");
+=09}
+
+=09return u;
+}
+
+/* XXX document */
+static void _store_early_console_uart_id(void)
+{
+=09int uart_id;
+
+=09if (_is_early_console_enabled()) {
+=09=09uart_id =3D _get_early_console_uart();
+=09=09if (uart_id > 0) {
+=09=09=09early_console_uart =3D uart_id;
+=09=09=09pr_info("omap serial: early console active on UART%d (ttyS%d)\n",
+=09=09=09=09uart_id, uart_id_to_ttys_id(uart_id));
+=09=09}
+=09}
+}
+
+/*
  * Since these idle/enable hooks are used in the idle path itself
  * which has interrupts disabled, use the non-locking versions of
  * the hwmod enable/disable functions.
@@ -801,6 +885,17 @@ void __init omap_serial_init_port(int port)
 =09oh->dev_attr =3D uart;
=20
 =09/*
+=09 * XXX How do we know whether the console is on this UART or not?
+=09 * We should only call acquire_console_sem() if the console is on
+=09 * this UART.
+=09 *
+=09 * Of course, the console is not the only thing that could be using
+=09 * this UART.
+=09 */
+=09if (uart->num =3D=3D uart_id_to_ttys_id(early_console_uart))
+=09=09acquire_console_sem();
+
+=09/*
 =09 * Because of early UART probing, UART did not get idled
 =09 * on init.  Now that omap_device is ready, ensure full idle
 =09 * before doing omap_device_enable().
@@ -824,6 +919,9 @@ void __init omap_serial_init_port(int port)
 =09omap_uart_block_sleep(uart);
 =09uart->timeout =3D DEFAULT_TIMEOUT;
=20
+=09if (uart->num =3D=3D uart_id_to_ttys_id(early_console_uart))
+=09=09release_console_sem();
+
 =09if ((cpu_is_omap34xx() && uart->padconf) ||
 =09    (uart->wk_en && uart->wk_mask)) {
 =09=09device_init_wakeup(&od->pdev.dev, true);
@@ -846,6 +944,8 @@ void __init omap_serial_init(void)
 {
 =09struct omap_uart_state *uart;
=20
+=09_store_early_console_uart_id();
+
 =09list_for_each_entry(uart, &uart_list, node)
 =09=09omap_serial_init_port(uart->num);
 }
--=20
1.7.1

--155748971-1120537354-1286259247=:13816--
