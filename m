From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 01/10] OMAP2+: Kconfig: disallow builds for boards that don't
	use the currently-selected SoC
Date: Fri, 01 Oct 2010 15:34:49 -0600
Message-ID: <20101001213445.1408.96821.stgit@twilight.localdomain>
References: <20101001213119.1408.65395.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49824 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755084Ab0JAVlY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 17:41:24 -0400
In-Reply-To: <20101001213119.1408.65395.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>

Currently, if, for example, CONFIG_ARCH_OMAP2420 is not selected, OMAP2420
board files can still be included in the build.  This results in link errors:

arch/arm/mach-omap2/built-in.o: In function `omap_generic_map_io':
.../arch/arm/mach-omap2/board-generic.c:51: undefined reference to `omap2_set_globals_242x'
arch/arm/mach-omap2/built-in.o: In function `omap_h4_init':
.../arch/arm/mach-omap2/board-h4.c:330: undefined reference to `omap2420_mux_init'
arch/arm/mach-omap2/built-in.o: In function `omap_h4_map_io':
.../arch/arm/mach-omap2/board-h4.c:373: undefined reference to `omap2_set_globals_242x'
arch/arm/mach-omap2/built-in.o: In function `omap_apollon_init':
.../arch/arm/mach-omap2/board-apollon.c:325: undefined reference to `omap2420_mux_init'
arch/arm/mach-omap2/built-in.o: In function `omap_apollon_map_io':
.../arch/arm/mach-omap2/board-apollon.c:353: undefined reference to `omap2_set_globals_242x'
make: *** [.tmp_vmlinux1] Error 1

Fix this by making the boards depend on the Kconfig option for the
specific SoC that they use.

Also, while here, fix the mach-omap2/board-generic.c file to remove the
dependency on OMAP2420.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Kconfig         |    6 +++---
 arch/arm/mach-omap2/board-generic.c |   16 ++++++++++++++--
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 1c4b237..7f740bd 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -101,20 +101,20 @@ config MACH_OMAP2_TUSB6010
 
 config MACH_OMAP_H4
 	bool "OMAP 2420 H4 board"
-	depends on ARCH_OMAP2
+	depends on ARCH_OMAP2420
 	default y
 	select OMAP_PACKAGE_ZAF
 	select OMAP_DEBUG_DEVICES
 
 config MACH_OMAP_APOLLON
 	bool "OMAP 2420 Apollon board"
-	depends on ARCH_OMAP2
+	depends on ARCH_OMAP2420
 	default y
 	select OMAP_PACKAGE_ZAC
 
 config MACH_OMAP_2430SDP
 	bool "OMAP 2430 SDP board"
-	depends on ARCH_OMAP2
+	depends on ARCH_OMAP2430
 	default y
 	select OMAP_PACKAGE_ZAC
 
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 3482b99..c7ec3f3 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -48,10 +48,22 @@ static void __init omap_generic_init(void)
 
 static void __init omap_generic_map_io(void)
 {
-	omap2_set_globals_242x(); /* should be 242x, 243x, or 343x */
-	omap242x_map_common_io();
+	if (cpu_is_omap242x()) {
+		omap2_set_globals_242x();
+		omap242x_map_common_io();
+	} else if (cpu_is_omap242x()) {
+		omap2_set_globals_243x();
+		omap243x_map_common_io();
+	} else if (cpu_is_omap34xx()) {
+		omap2_set_globals_3xxx();
+		omap34xx_map_common_io();
+	} else if (cpu_is_omap44xx()) {
+		omap2_set_globals_443x();
+		omap44xx_map_common_io();
+	}
 }
 
+/* XXX This machine entry name should be updated */
 MACHINE_START(OMAP_GENERIC, "Generic OMAP24xx")
 	/* Maintainer: Paul Mundt <paul.mundt@nokia.com> */
 	.phys_io	= 0x48000000,


