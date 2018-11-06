From: Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH 2/2] ARM: Kconfig: remove useless "default n"
Date: Tue, 06 Nov 2018 12:49:40 +0000
Message-ID: <E1gK0nc-0007fv-En@rmk-PC.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, linux-omap@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>, Daniel Mack <daniel@zonque.org>
List-Id: linux-omap@vger.kernel.org

The default for Kconfig options is always n, so there's no need to
explicitly state a "n" default.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/Kconfig            | 1 -
 arch/arm/mach-omap2/Kconfig | 1 -
 arch/arm/mach-pxa/Kconfig   | 1 -
 arch/arm/plat-omap/Kconfig  | 1 -
 4 files changed, 4 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 78a8e96f5376..6b41ad365e9c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1803,7 +1803,6 @@ config PARAVIRT
 config PARAVIRT_TIME_ACCOUNTING
 	bool "Paravirtual steal time accounting"
 	select PARAVIRT
-	default n
 	help
 	  Select this option to enable fine granularity task steal time
 	  accounting. Time spent executing other tasks in parallel with
diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 9f27b486a536..5e33d1a90664 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -223,7 +223,6 @@ config MACH_NOKIA_N8X0
 config OMAP3_SDRC_AC_TIMING
 	bool "Enable SDRC AC timing register changes"
 	depends on ARCH_OMAP3
-	default n
 	help
 	  If you know that none of your system initiators will attempt to
 	  access SDRAM during CORE DVFS, select Y here.  This should boost
diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index fd724a71c2e1..7298d07a9f71 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -552,7 +552,6 @@ config TOSA_BT
 config TOSA_USE_EXT_KEYCODES
 	bool "Tosa keyboard: use extended keycodes"
 	depends on MACH_TOSA
-	default n
 	help
 	  Say Y here to enable the tosa keyboard driver to generate extended
 	  (>= 127) keycodes. Be aware, that they can't be correctly interpreted
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index c0a242cae79a..93fd7fc537cf 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -92,7 +92,6 @@ config OMAP_32K_TIMER
 config OMAP3_L2_AUX_SECURE_SAVE_RESTORE
 	bool "OMAP3 HS/EMU save and restore for L2 AUX control register"
 	depends on ARCH_OMAP3 && PM
-	default n
 	help
 	  Without this option, L2 Auxiliary control register contents are
 	  lost during off-mode entry on HS/EMU devices. This feature
-- 
2.7.4
