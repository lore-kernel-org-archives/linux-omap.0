From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5/4] ARM: OMAP: Move set_globals initialization to happen
	in init_early
Date: Tue, 4 Oct 2011 18:40:45 -0700
Message-ID: <20111005014044.GZ6324@atomide.com>
References: <20111005004339.26980.31149.stgit@kaulin.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20111005004339.26980.31149.stgit@kaulin.local>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Otherwise we can't do generic map_io as we currently rely on
static mappings that work only because of arch_ioremap.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/board-ti8168evm.c b/arch/arm/mach-omap2/board-ti8168evm.c
index e26c79c..e6ee884 100644
--- a/arch/arm/mach-omap2/board-ti8168evm.c
+++ b/arch/arm/mach-omap2/board-ti8168evm.c
@@ -37,7 +37,6 @@ static void __init ti8168_evm_init(void)
 
 static void __init ti8168_evm_map_io(void)
 {
-	omap2_set_globals_ti816x();
 	omapti816x_map_common_io();
 }
 
diff --git a/arch/arm/mach-omap2/common.c b/arch/arm/mach-omap2/common.c
index de61f15..f19a332 100644
--- a/arch/arm/mach-omap2/common.c
+++ b/arch/arm/mach-omap2/common.c
@@ -59,7 +59,6 @@ void __init omap2_set_globals_242x(void)
 
 void __init omap242x_map_io(void)
 {
-	omap2_set_globals_242x();
 	omap242x_map_common_io();
 }
 #endif
@@ -83,7 +82,6 @@ void __init omap2_set_globals_243x(void)
 
 void __init omap243x_map_io(void)
 {
-	omap2_set_globals_243x();
 	omap243x_map_common_io();
 }
 #endif
@@ -107,7 +105,6 @@ void __init omap2_set_globals_3xxx(void)
 
 void __init omap3_map_io(void)
 {
-	omap2_set_globals_3xxx();
 	omap34xx_map_common_io();
 }
 
@@ -153,7 +150,6 @@ void __init omap2_set_globals_443x(void)
 
 void __init omap4_map_io(void)
 {
-	omap2_set_globals_443x();
 	omap44xx_map_common_io();
 }
 #endif
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 4957554..527abdd 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -44,6 +44,7 @@
 #include "clockdomain.h"
 #include <plat/omap_hwmod.h>
 #include <plat/multi.h>
+#include <plat/common.h>
 
 /*
  * The machine specific code may provide the extra mapping besides the
@@ -363,6 +364,7 @@ static void __init omap_hwmod_init_postsetup(void)
 
 void __init omap2420_init_early(void)
 {
+	omap2_set_globals_242x();
 	omap_common_init_early();
 	omap2xxx_voltagedomains_init();
 	omap242x_powerdomains_init();
@@ -374,6 +376,7 @@ void __init omap2420_init_early(void)
 
 void __init omap2430_init_early(void)
 {
+	omap2_set_globals_243x();
 	omap_common_init_early();
 	omap2xxx_voltagedomains_init();
 	omap243x_powerdomains_init();
@@ -389,6 +392,7 @@ void __init omap2430_init_early(void)
  */
 void __init omap3_init_early(void)
 {
+	omap2_set_globals_3xxx();
 	omap_common_init_early();
 	omap3xxx_voltagedomains_init();
 	omap3xxx_powerdomains_init();
@@ -420,11 +424,19 @@ void __init am35xx_init_early(void)
 
 void __init ti816x_init_early(void)
 {
-	omap3_init_early();
+	omap2_set_globals_ti816x();
+	omap_common_init_early();
+	omap3xxx_voltagedomains_init();
+	omap3xxx_powerdomains_init();
+	omap3xxx_clockdomains_init();
+	omap3xxx_hwmod_init();
+	omap_hwmod_init_postsetup();
+	omap3xxx_clk_init();
 }
 
 void __init omap4430_init_early(void)
 {
+	omap2_set_globals_443x();
 	omap_common_init_early();
 	omap44xx_voltagedomains_init();
 	omap44xx_powerdomains_init();
