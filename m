From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: [PATCH 8/11] Adding OMAP3 content in mach-omap2 files
Date: Thu, 5 Jul 2007 23:40:14 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C470142E61F@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Adding OMAP3 content to mach-omap2 files

Signed-off-by: Syed Mohammed Khasim  <x0khasim@ti.com>

Files:
 mach-omap2/gpmc.c
 mach-omap2/id.c
 mach-omap2/irq.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff -purN linux-omap/arch/arm/mach-omap2/gpmc.c =
val_3430_GIT/arch/arm/mach-omap2/gpmc.c
--- linux-omap/arch/arm/mach-omap2/gpmc.c	2007-05-16 14:32:40.000000000 =
-0500
+++ val_3430_GIT/arch/arm/mach-omap2/gpmc.c	2007-07-05 =
17:09:49.000000000 -0500
@@ -22,12 +22,10 @@
=20
 #undef DEBUG
=20
-#ifdef CONFIG_ARCH_OMAP2420
+#if defined(CONFIG_ARCH_OMAP2420)
 #define GPMC_BASE		0x6800a000
-#endif
-
-#ifdef CONFIG_ARCH_OMAP2430
-#define GPMC_BASE		0x6E000000
+#elif defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3430)
+#define GPMC_BASE		0x6e000000
 #endif
=20
 #define GPMC_REVISION		0x00
diff -purN linux-omap/arch/arm/mach-omap2/id.c =
val_3430_GIT/arch/arm/mach-omap2/id.c
--- linux-omap/arch/arm/mach-omap2/id.c	2006-11-20 21:54:01.000000000 =
-0600
+++ val_3430_GIT/arch/arm/mach-omap2/id.c	2007-07-05 17:09:49.000000000 =
-0500
@@ -18,11 +18,11 @@
 #include <asm/io.h>
=20
 #if defined(CONFIG_ARCH_OMAP2420)
-#define OMAP24XX_TAP_BASE	io_p2v(0x48014000)
-#endif
-
-#if defined(CONFIG_ARCH_OMAP2430)
-#define OMAP24XX_TAP_BASE	io_p2v(0x4900A000)
+#define TAP_BASE	io_p2v(0x48014000)
+#elif defined(CONFIG_ARCH_OMAP2430)
+#define TAP_BASE	io_p2v(0x4900A000)
+#elif defined(CONFIG_ARCH_OMAP34XX)
+#define TAP_BASE	io_p2v(0x54004000)
 #endif
=20
 #define OMAP_TAP_IDCODE		0x0204
@@ -58,7 +58,7 @@ static struct omap_id omap_ids[] __initd
=20
 static u32 __init read_tap_reg(int reg)
 {
-	return __raw_readl(OMAP24XX_TAP_BASE + reg);
+	return __raw_readl(TAP_BASE + reg);
 }
=20
 void __init omap2_check_revision(void)
@@ -118,9 +118,16 @@ void __init omap2_check_revision(void)
=20
 	system_rev |=3D rev << 8;
=20
-	/* Add the cpu class info (24xx) */
-	system_rev |=3D 0x24;
+	/* REVISIT:
+	 * OMAP 3430 ES 1.0 does't populate IDCODE registers
+	 * Following lines have to be revisited for next version
+	 */
=20
+#ifndef CONFIG_ARCH_OMAP3
+	system_rev |=3D 0x24;
+#else
+	system_rev |=3D 0x34;
+#endif
 	pr_info("OMAP%04x", system_rev >> 16);
 	if ((system_rev >> 8) & 0x0f)
 		printk("%x", (system_rev >> 8) & 0x0f);
diff -purN linux-omap/arch/arm/mach-omap2/irq.c =
val_3430_GIT/arch/arm/mach-omap2/irq.c
--- linux-omap/arch/arm/mach-omap2/irq.c	2007-06-21 08:19:04.000000000 =
-0500
+++ val_3430_GIT/arch/arm/mach-omap2/irq.c	2007-07-05 18:05:53.000000000 =
-0500
@@ -17,7 +17,6 @@
 #include <asm/mach/irq.h>
 #include <asm/irq.h>
 #include <asm/io.h>
-#include <asm/arch/cpu.h>
=20
 #define INTC_REVISION	0x0000
 #define INTC_SYSCONFIG	0x0010
@@ -117,10 +116,12 @@ void __init omap_init_irq(void)
 	for (i =3D 0; i < ARRAY_SIZE(irq_banks); i++) {
 		struct omap_irq_bank *bank =3D irq_banks + i;
=20
-		if (cpu_is_omap24xx())
+		if (cpu_is_omap24xx()) {
 			bank->base_reg =3D IO_ADDRESS(OMAP24XX_IC_BASE);
-		else if (cpu_is_omap34xx())
+		}
+		if (cpu_is_omap34xx()) {
 			bank->base_reg =3D IO_ADDRESS(OMAP34XX_IC_BASE);
+		}
 		omap_irq_bank_init_one(bank);
=20
 		nr_irqs +=3D bank->nr_irqs;
