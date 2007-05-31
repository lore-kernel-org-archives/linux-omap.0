From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: [PATCH 2/12] OMAP3 support in Makefile & Kconfig
Date: Thu, 31 May 2007 12:57:20 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C470106320D@dlee13.ent.ti.com>
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

Add OMAP3 support in arch/arm/Makefile and mm/Kconfig

Signed-off-by: Syed Mohammed Khasim  <x0khasim@ti.com>

Files:
 Makefile   |    1 +
 mm/Kconfig |    2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-omap/arch/arm/Makefile	2007-05-16 14:32:39.000000000 -0500
+++ val_3430_GIT/arch/arm/Makefile	2007-05-29 15:52:45.000000000 -0500
@@ -121,6 +121,7 @@ endif
  machine-$(CONFIG_ARCH_IXP23XX)    :=3D ixp23xx
  machine-$(CONFIG_ARCH_OMAP1)	   :=3D omap1
  machine-$(CONFIG_ARCH_OMAP2)	   :=3D omap2
+ machine-$(CONFIG_ARCH_OMAP3)	   :=3D omap2
   incdir-$(CONFIG_ARCH_OMAP)	   :=3D omap
  machine-$(CONFIG_ARCH_S3C2410)	   :=3D s3c2410
  machine-$(CONFIG_ARCH_LH7A40X)	   :=3D lh7a40x

--- linux-omap/arch/arm/mm/Kconfig	2007-05-25 13:27:03.000000000 -0500
+++ val_3430_GIT/arch/arm/mm/Kconfig	2007-05-25 23:07:56.000000000 -0500
@@ -370,7 +370,7 @@ config CPU_32v6K
 # ARMv7
 config CPU_V7
 	bool "Support ARM V7 processor"
-	depends on ARCH_INTEGRATOR
+	depends on ARCH_INTEGRATOR || ARCH_OMAP3
 	select CPU_32v6K
 	select CPU_32v7
 	select CPU_ABRT_EV7
