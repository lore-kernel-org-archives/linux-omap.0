From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: [PATCH 6/11] Update OMAP3430 config in mach-omap2
Date: Thu, 5 Jul 2007 23:39:49 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C470142E61D@dlee13.ent.ti.com>
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

Signed-off-by: Syed Mohammed Khasim  <x0khasim@ti.com>

Files:
 arch/arm/mach-omap2/Kconfig
 arch/arm/mach-omap2/Makefile
=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff -purN linux-omap/arch/arm/mach-omap2/Kconfig =
val_3430_GIT/arch/arm/mach-omap2/Kconfig
--- linux-omap/arch/arm/mach-omap2/Kconfig	2007-04-02 02:29:57.000000000 =
-0500
+++ val_3430_GIT/arch/arm/mach-omap2/Kconfig	2007-07-05 =
17:09:49.000000000 -0500
@@ -5,6 +5,10 @@ config ARCH_OMAP24XX
 	bool "OMAP24xx Based System"
 	depends on ARCH_OMAP2
=20
+config ARCH_OMAP34XX
+	bool "OMAP34xx Based System"
+	depends on ARCH_OMAP3
+
 config ARCH_OMAP2420
 	bool "OMAP2420 support"
 	depends on ARCH_OMAP24XX
@@ -15,8 +19,12 @@ config ARCH_OMAP2430
 	bool "OMAP2430 support"
 	depends on ARCH_OMAP24XX
=20
+config ARCH_OMAP3430
+	bool "OMAP3430 support"
+	depends on ARCH_OMAP3 && ARCH_OMAP34XX
+
 comment "OMAP Board Type"
-	depends on ARCH_OMAP2
+	depends on ARCH_OMAP2 || ARCH_OMAP3
=20
 config MACH_OMAP_GENERIC
 	bool "Generic OMAP board"
@@ -37,6 +45,10 @@ config MACH_OMAP_H4
 	select OMAP_DEBUG_DEVICES
 	select GPIOEXPANDER_OMAP
=20
+
+config MACH_OMAP_3430SDP
+	bool "OMAP 3430 SDP board"
+	depends on ARCH_OMAP3 && ARCH_OMAP34XX
 config MACH_OMAP_H4_TUSB
 	bool "TUSB 6010 EVM board"
 	depends on MACH_OMAP_H4
diff -purN linux-omap/arch/arm/mach-omap2/Makefile =
val_3430_GIT/arch/arm/mach-omap2/Makefile
--- linux-omap/arch/arm/mach-omap2/Makefile	2007-06-13 =
16:33:00.000000000 -0500
+++ val_3430_GIT/arch/arm/mach-omap2/Makefile	2007-07-05 =
18:00:25.000000000 -0500
@@ -23,6 +23,7 @@ obj-$(CONFIG_MACH_OMAP_H4)		+=3D board-h4.
 obj-$(CONFIG_MACH_OMAP_2430SDP)		+=3D board-2430sdp.o \
 					   board-2430sdp-flash.o \
 					   board-2430sdp-usb.o
+obj-$(CONFIG_MACH_OMAP_3430SDP)		+=3D board-3430sdp.o
 obj-$(CONFIG_MACH_OMAP_APOLLON)		+=3D board-apollon.o \
 					   board-apollon-keys.o
 obj-$(CONFIG_MACH_NOKIA_N800)		+=3D board-n800.o board-n800-flash.o \
