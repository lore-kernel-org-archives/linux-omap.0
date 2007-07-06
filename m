From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: [PATCH 10/ 11] plat-omap dsp updates for 3430
Date: Thu, 5 Jul 2007 23:40:37 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C470142E621@dlee13.ent.ti.com>
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

plat-omap dsp updates for 3430

Signed-off-by: Syed Mohammed Khasim  <x0khasim@ti.com>

Files:
 arch/arm/plat-omap/dsp/dsp_common.c
 arch/arm/plat-omap/dsp/hardware_dsp.h
 arch/arm/plat-omap/dsp/omap2_dsp.h

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff -purN linux-omap/arch/arm/plat-omap/dsp/dsp_common.c =
val_3430_GIT/arch/arm/plat-omap/dsp/dsp_common.c
--- linux-omap/arch/arm/plat-omap/dsp/dsp_common.c	2007-05-23 =
23:29:28.000000000 -0500
+++ val_3430_GIT/arch/arm/plat-omap/dsp/dsp_common.c	2007-07-05 =
17:09:49.000000000 -0500
@@ -39,7 +39,8 @@
=20
 #if defined(CONFIG_ARCH_OMAP1)
 #define dsp_boot_config(mode)	omap_writew((mode), MPUI_DSP_BOOT_CONFIG)
-#elif defined(CONFIG_ARCH_OMAP2)
+#endif
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 #define dsp_boot_config(mode)	writel((mode), DSP_IPI_DSPBOOTCONFIG)
 #endif
=20
@@ -303,6 +304,12 @@ static int omap_dsp_init(void)
 		saram_size =3D OMAP24XX_SARAM_SIZE;
 	}
 #endif
+#ifdef CONFIG_ARCH_OMAP34XX
+	/* To be Revisited for 3430 */
+	if (cpu_is_omap34xx()) {
+		return -ENODEV;
+	}
+#endif
 	if (dspmem_size =3D=3D 0) {
 		printk(KERN_ERR "omapdsp: unsupported omap architecture.\n");
 		return -ENODEV;
diff -purN linux-omap/arch/arm/plat-omap/dsp/hardware_dsp.h =
val_3430_GIT/arch/arm/plat-omap/dsp/hardware_dsp.h
--- linux-omap/arch/arm/plat-omap/dsp/hardware_dsp.h	2006-11-20 =
21:54:06.000000000 -0600
+++ val_3430_GIT/arch/arm/plat-omap/dsp/hardware_dsp.h	2007-07-05 =
17:09:49.000000000 -0500
@@ -27,7 +27,7 @@
 #ifdef CONFIG_ARCH_OMAP1
 #include "omap1_dsp.h"
 #endif
-#ifdef CONFIG_ARCH_OMAP2
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3430)
 #include "omap2_dsp.h"
 #endif
=20
diff -purN linux-omap/arch/arm/plat-omap/dsp/omap2_dsp.h =
val_3430_GIT/arch/arm/plat-omap/dsp/omap2_dsp.h
--- linux-omap/arch/arm/plat-omap/dsp/omap2_dsp.h	2007-05-25 =
15:52:23.000000000 -0500
+++ val_3430_GIT/arch/arm/plat-omap/dsp/omap2_dsp.h	2007-07-05 =
17:09:49.000000000 -0500
@@ -36,7 +36,14 @@
 /*
  * DSP IPI registers: mapped to 0xe1000000 -- use readX(), writeX()
  */
+#ifdef CONFIG_ARCH_OMAP24XX
 #define DSP_IPI_BASE			DSP_IPI_24XX_VIRT
+#endif
+
+#ifdef CONFIG_ARCH_OMAP34XX
+#define DSP_IPI_BASE			DSP_IPI_34XX_VIRT
+#endif
+
 #define DSP_IPI_REVISION		(DSP_IPI_BASE + 0x00)
 #define DSP_IPI_SYSCONFIG		(DSP_IPI_BASE + 0x10)
 #define DSP_IPI_INDEX			(DSP_IPI_BASE + 0x40)
