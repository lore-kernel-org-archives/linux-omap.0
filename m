From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 4.13 (and probably all recent) kernels refuse to boot on one
 Nokia N950, work or another
Date: Thu, 26 Oct 2017 10:49:08 +0200
Message-ID: <20171026084908.GA17741@amd>
References: <20171025203459.GA22035@amd>
 <20171025212806.GA21504@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171025212806.GA21504@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, filip.matijevic.pz@gmail.com
List-Id: linux-omap@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > ...hardware should be identical. 3.5.3-nemo kernel seems to work on
> > both. 4.13-rc2 with display and clock patches boots on phone "S", but
> > does not on phone "P"; nothing nothing is received on serial port.
> >=20
> > There is some difference in the bootloaders: S's bootloader provides
> > lots of debug info, P's is silent. R&D settings do _not_ have
> > influence on bootloader. We know P's serial works, as 3.5.3 kernel
> > prints "Uncompressing linux...booting" there.
> >=20
> > I'll need to return "S" phone and serial cable tommorow. If you have
> > any ideas, let me know.
>=20
> If you get nothing out of the uart, chances are the pins are
> not muxed for the uart in nolo and maybe kernel dts is missing the
> pinctrl entries for uart?

Ok. With patch below, I get:

[    4.770965] Booting...
Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.13.0-rc2-12806-g7603303-dirty
(pavel@duo) (gcc version 4.7.2 (GCC)) #7

=2E.. on "S" machine. (But still nothing on "P" machine).

3.5.3 does have to set up pinmux for debug printing somewhere, right?
Where can I copy that from?

Thanks,
								Pavel

commit 5dc1c6ea8f20b6480e01c24710514434c00d53f8
Author: Pavel <pavel@ucw.cz>
Date:   Thu Oct 26 10:42:06 2017 +0200

    Add debugging hacks. In particular, Uncompressing Linux.... done,
    booting... is now printed.

diff --git a/.config b/.config
index 40aaa5e..60750b3 100644
--- a/.config
+++ b/.config
@@ -2534,10 +2534,29 @@ CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=3Dy
 # CONFIG_ARM_PTDUMP is not set
 # CONFIG_ARM_UNWIND is not set
 # CONFIG_DEBUG_USER is not set
-# CONFIG_DEBUG_LL is not set
-CONFIG_DEBUG_LL_INCLUDE=3D"mach/debug-macro.S"
+CONFIG_DEBUG_LL=3Dy
+# CONFIG_DEBUG_OMAP2UART1 is not set
+# CONFIG_DEBUG_OMAP2UART2 is not set
+# CONFIG_DEBUG_OMAP2UART3 is not set
+CONFIG_DEBUG_OMAP3UART3=3Dy
+# CONFIG_DEBUG_OMAP4UART3 is not set
+# CONFIG_DEBUG_OMAP3UART4 is not set
+# CONFIG_DEBUG_OMAP4UART4 is not set
+# CONFIG_DEBUG_TI81XXUART1 is not set
+# CONFIG_DEBUG_TI81XXUART2 is not set
+# CONFIG_DEBUG_TI81XXUART3 is not set
+# CONFIG_DEBUG_AM33XXUART1 is not set
+# CONFIG_DEBUG_ZOOM_UART is not set
+# CONFIG_DEBUG_ICEDCC is not set
+# CONFIG_DEBUG_SEMIHOSTING is not set
+# CONFIG_DEBUG_LL_UART_8250 is not set
+# CONFIG_DEBUG_LL_UART_PL01X is not set
+CONFIG_DEBUG_OMAP2PLUS_UART=3Dy
+CONFIG_DEBUG_LL_INCLUDE=3D"debug/omap2plus.S"
 # CONFIG_DEBUG_UART_8250 is not set
+CONFIG_DEBUG_UNCOMPRESS=3Dy
 CONFIG_UNCOMPRESS_INCLUDE=3D"debug/uncompress.h"
+CONFIG_EARLY_PRINTK=3Dy
 # CONFIG_PID_IN_CONTEXTIDR is not set
 # CONFIG_CORESIGHT is not set
=20
diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 447629d..0f50439 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1736,7 +1736,7 @@ config DEBUG_UART_8250_FLOW_CONTROL
 config DEBUG_UNCOMPRESS
 	bool
 	depends on ARCH_MULTIPLATFORM || PLAT_SAMSUNG || ARM_SINGLE_ARMV7M
-	default y if DEBUG_LL && !DEBUG_OMAP2PLUS_UART && \
+	default y if DEBUG_LL && (!DEBUG_OMAP2PLUS_UART || !ZROM_BOOT) && \
 		     (!DEBUG_TEGRA_UART || !ZBOOT_ROM) && \
 		     !DEBUG_BRCMSTB_UART
 	help
diff --git a/arch/arm/include/debug/omap2plus.S b/arch/arm/include/debug/om=
ap2plus.S
index 6d867ae..3684e04 100644
--- a/arch/arm/include/debug/omap2plus.S
+++ b/arch/arm/include/debug/omap2plus.S
@@ -58,12 +58,17 @@
=20
 #define UART_OFFSET(addr)	((addr) & 0x00ffffff)
=20
+#if defined(ZIMAGE)
+	omap_uart_phys:	.word	0
+	omap_uart_virt:	.word	0
+	omap_uart_lsr:	.word	0
+#else
 		.pushsection .data
-omap_uart_phys:	.word	0
-omap_uart_virt:	.word	0
-omap_uart_lsr:	.word	0
+	omap_uart_phys:	.word	0
+	omap_uart_virt:	.word	0
+	omap_uart_lsr:	.word	0
 		.popsection
-
+#endif
 		.macro	addruart, rp, rv, tmp
=20
 		/* Use omap_uart_phys/virt if already configured */
diff --git a/arch/arm/include/debug/uncompress.h b/arch/arm/include/debug/u=
ncompress.h
index 0e2949b..f660c51 100644
--- a/arch/arm/include/debug/uncompress.h
+++ b/arch/arm/include/debug/uncompress.h
@@ -1,7 +1,109 @@
-#ifdef CONFIG_DEBUG_UNCOMPRESS
-extern void putc(int c);
-#else
-static inline void putc(int c) {}
-#endif
-static inline void flush(void) {}
-static inline void arch_decomp_setup(void) {}
+/*
+ * arch/arm/plat-omap/include/mach/uncompress.h
+ *
+ * Serial port stubs for kernel decompress status messages
+ *
+ * Initially based on:
+ * linux-2.4.15-rmk1-dsplinux1.6/arch/arm/plat-omap/include/mach1510/uncom=
press.h
+ * Copyright (C) 2000 RidgeRun, Inc.
+ * Author: Greg Lonnon <glonnon@ridgerun.com>
+ *
+ * Rewritten by:
+ * Author: <source@mvista.com>
+ * 2004 (c) MontaVista Software, Inc.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include <linux/types.h>
+#include <linux/serial_reg.h>
+
+#include <asm/memory.h>
+#include <asm/mach-types.h>
+
+//#include <mach/serial.h>
+
+#define OMAP_UART_INFO_OFS 0x3ffc
+
+#define MDR1_MODE_MASK			0x07
+
+volatile u8 *uart_base;
+int uart_shift;
+
+/*
+ * Store the DEBUG_LL uart number into memory.
+ * See also debug-macro.S, and serial.c for related code.
+ */
+static void set_omap_uart_info(unsigned char port)
+{
+	/*
+	 * Get address of some.bss variable and round it down
+	 * a la CONFIG_AUTO_ZRELADDR.
+	 */
+	u32 ram_start =3D (u32)&uart_shift & 0xf8000000;
+	u32 *uart_info =3D (u32 *)(ram_start + OMAP_UART_INFO_OFS);
+	*uart_info =3D port;
+}
+
+static inline void putc(int c)
+{
+	if (!uart_base)
+		return;
+
+	/* Check for UART 16x mode */
+	if ((uart_base[UART_OMAP_MDR1 << uart_shift] & MDR1_MODE_MASK) !=3D 0)
+		return;
+
+	while (!(uart_base[UART_LSR << uart_shift] & UART_LSR_THRE))
+		barrier();
+	uart_base[UART_TX << uart_shift] =3D c;
+}
+
+static inline void flush(void)
+{
+}
+
+/*
+ * Macros to configure UART1 and debug UART
+ */
+#define _DEBUG_LL_ENTRY(mach, dbg_uart, dbg_shft, dbg_id)		\
+	if (1) {					\
+		uart_base =3D (volatile u8 *)(dbg_uart);			\
+		uart_shift =3D (dbg_shft);				\
+		port =3D (dbg_id);					\
+		set_omap_uart_info(port);				\
+		break;							\
+	}
+
+#define DEBUG_LL_OMAP7XX(p, mach)					\
+	_DEBUG_LL_ENTRY(mach, OMAP1_UART##p##_BASE, OMAP7XX_PORT_SHIFT,	\
+		OMAP1UART##p)
+
+#define DEBUG_LL_OMAP1(p, mach)						\
+	_DEBUG_LL_ENTRY(mach, OMAP1_UART##p##_BASE, OMAP_PORT_SHIFT,	\
+		OMAP1UART##p)
+
+#define DEBUG_LL_OMAP3(p, mach)                                         \
+	_DEBUG_LL_ENTRY(mach, OMAP3_UART##p##_BASE, OMAP_PORT_SHIFT,    \
+			OMAP3UART##p)
+
+#define OMAP3_UART3_BASE 0x49020000
+#define OMAP_PORT_SHIFT 2
+#define OMAP3UART3 33
+
+static inline void arch_decomp_setup(void)
+{
+	int port =3D 0;
+
+	/*
+	 * Initialize the port based on the machine ID from the bootloader.
+	 * Note that we're using macros here instead of switch statement
+	 * as machine_is functions are optimized out for the boards that
+	 * are not selected.
+	 */
+	do {
+		DEBUG_LL_OMAP3(3, nokia_rm680);
+	} while (0);
+}
diff --git a/arch/arm/mach-omap2/common.c b/arch/arm/mach-omap2/common.c
index 484cdad..7d3e635 100644
--- a/arch/arm/mach-omap2/common.c
+++ b/arch/arm/mach-omap2/common.c
@@ -14,6 +14,7 @@
  */
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/gpio.h>
=20
 #include "common.h"
 #include "omap-secure.h"
@@ -32,3 +33,20 @@ void __init omap_reserve(void)
 	omap_secure_ram_reserve_memblock();
 	omap_barrier_reserve_memblock();
 }
+
+void iam_alive(void)
+{
+	int i;
+	int debug_gpio =3D 92;
+	printk("request: %d\n", gpio_request(debug_gpio, "debug"));
+	printk("output: %d\n", gpio_direction_output(debug_gpio, 1));
+
+	for (i=3D0; i<5; i++) {
+		gpio_set_value(debug_gpio, 0);
+		msleep(1000);
+		gpio_set_value(debug_gpio, 1);
+		msleep(1000);
+	}
+=09
+}
+
diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
index 0b77a01..97b59e0 100644
--- a/arch/arm/mach-omap2/dma.c
+++ b/arch/arm/mach-omap2/dma.c
@@ -118,6 +118,10 @@ static void omap2_show_dma_caps(void)
 	u8 revision =3D dma_read(REVISION, 0) & 0xff;
 	printk(KERN_INFO "OMAP DMA hardware revision %d.%d\n",
 				revision >> 4, revision & 0xf);
+       {
+              extern void iam_alive(void);
+               iam_alive();
+      }
 }
=20
 static unsigned configure_dma_errata(void)

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlnxoYQACgkQMOfwapXb+vIveACdFIJ5GeCh0jOknh618xWBoib2
CPQAoK4HMB02RI3LG7h5Crm/afSYJaJJ
=oHA7
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
