From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: [Patch 2/4] Makefile and Kconfig changes for V7 Cache updates
Date: Tue, 5 Jun 2007 19:26:41 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C4701120B43@dlee13.ent.ti.com>
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

Makefile and Kconfig changes for V7 Cache update.

Signed-off-by: Syed Mohammed Khasim  <x0khasim@ti.com>

Files:
 arch/arm/mm/Kconfig               |    7 +++++--
 val_3430_GIT/arch/arm/mm/Makefile |    1 +
 2 files changed, 6 insertions(+), 2 deletions(-)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-omap/arch/arm/mm/Makefile	2007-05-16 14:32:40.000000000 -0500
--- linux-omap/arch/arm/mm/Kconfig	2007-05-25 13:27:03.000000000 -0500
+++ val_3430_GIT/arch/arm/mm/Kconfig	2007-06-05 16:06:28.000000000 -0500
@@ -370,7 +370,7 @@ config CPU_32v6K
 # ARMv7
 config CPU_V7
 	bool "Support ARM V7 processor"
-	depends on ARCH_INTEGRATOR
+	depends on ARCH_INTEGRATOR || ARCH_OMAP3
 	select CPU_32v6K
 	select CPU_32v7
 	select CPU_ABRT_EV7
@@ -379,7 +379,7 @@ config CPU_V7
 	select CPU_CP15_MMU
 	select CPU_HAS_ASID
 	select CPU_COPY_V6 if MMU
-	select CPU_TLB_V6 if MMU
+	select CPU_TLB_V7 if MMU
=20
 # Figure out what processor architecture version we should be using.
 # This defines the compiler instruction set which depends on the =
machine type.
@@ -498,6 +498,9 @@ config CPU_TLB_V4WBI
 config CPU_TLB_V6
 	bool
=20
+config CPU_TLB_V7
+	bool
+
 endif
=20
 config CPU_HAS_ASID

+++ val_3430_GIT/arch/arm/mm/Makefile	2007-06-05 15:55:22.000000000 =
-0500
@@ -46,6 +46,7 @@ obj-$(CONFIG_CPU_TLB_V4WT)	+=3D tlb-v4.o
 obj-$(CONFIG_CPU_TLB_V4WB)	+=3D tlb-v4wb.o
 obj-$(CONFIG_CPU_TLB_V4WBI)	+=3D tlb-v4wbi.o
 obj-$(CONFIG_CPU_TLB_V6)	+=3D tlb-v6.o
+obj-$(CONFIG_CPU_TLB_V7)        +=3D tlb-v7.o
=20
 obj-$(CONFIG_CPU_ARM610)	+=3D proc-arm6_7.o
 obj-$(CONFIG_CPU_ARM710)	+=3D proc-arm6_7.o
