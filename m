From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: [PATCH 1/ 12] Kconfig and Makefile for OMAP3
Date: Thu, 14 Jun 2007 00:00:16 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47011E6090@dlee13.ent.ti.com>
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
To: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Kconfig and Makefile changes for OMAP3

Signed-off-by: Syed Mohammed Khasim  <x0khasim@ti.com>

Files:
arch/arm/Kconfig
arch/arm/Makefile

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff -purN linux-omap/arch/arm/Kconfig val_3430_GIT/arch/arm/Kconfig
--- linux-omap/arch/arm/Kconfig	2007-06-12 15:08:45.000000000 -0500
+++ val_3430_GIT/arch/arm/Kconfig	2007-06-12 15:12:08.000000000 -0500
@@ -393,7 +393,7 @@ config ARCH_OMAP
 	select GENERIC_TIME
 	select GENERIC_CLOCKEVENTS
 	help
-	  Support for TI's OMAP platform (OMAP1 and OMAP2).
+	  Support for TI's OMAP platform (OMAP1, OMAP2 and OMAP3).
=20
 endchoice
=20
@@ -947,6 +947,18 @@ config NEON
 	  Say Y to include support code for NEON, the ARMv7 Advanced SIMD
 	  Extensions.
=20
+config VFPv3
+	bool
+	depends on VFP
+	default y if CPU_V7
+
+config NEON
+	bool "NEON Advanced SIMD Extension support"
+	depends on VFPv3 && CPU_V7
+	help
+	  Say Y to include support code for NEON, the ARMv7 Advanced SIMD
+	  Extensions.
+
 endmenu
=20
 menu "Userspace binary formats"
diff -purN linux-omap/arch/arm/Makefile val_3430_GIT/arch/arm/Makefile
--- linux-omap/arch/arm/Makefile	2007-05-16 14:32:39.000000000 -0500
+++ val_3430_GIT/arch/arm/Makefile	2007-06-12 15:12:08.000000000 -0500
@@ -121,6 +121,7 @@ endif
  machine-$(CONFIG_ARCH_IXP23XX)    :=3D ixp23xx
  machine-$(CONFIG_ARCH_OMAP1)	   :=3D omap1
  machine-$(CONFIG_ARCH_OMAP2)	   :=3D omap2
+ machine-$(CONFIG_ARCH_OMAP3)		:=3D omap2
   incdir-$(CONFIG_ARCH_OMAP)	   :=3D omap
  machine-$(CONFIG_ARCH_S3C2410)	   :=3D s3c2410
  machine-$(CONFIG_ARCH_LH7A40X)	   :=3D lh7a40x
