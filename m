From: Kyle Manna <kyle.manna@fuel7.com>
Subject: [PATCH] ARM: OMAP: Fix early init definitions
Date: Tue, 18 Oct 2011 13:43:06 -0500
Message-ID: <1318963386-27382-1-git-send-email-kyle.manna@fuel7.com>
References: <CAM9fjH6TZnAWAPvp8Uvr4hHpf77CeRz3k=hv6FGN73X1aXTXQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAM9fjH6TZnAWAPvp8Uvr4hHpf77CeRz3k=hv6FGN73X1aXTXQQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: Kyle Manna <kyle.manna@fuel7.com>, Russell King <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Depending on the archs defined in the config, some functions are
referenced without being defined. This fixes compile time errors that
would otherwise result.

Signed-off-by: Kyle Manna <kyle.manna@fuel7.com>
---
 arch/arm/mach-omap2/io.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index aa96538..f1d18a2 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -359,6 +359,8 @@ static void __init omap_hwmod_init_postsetup(void)
 	omap_pm_if_early_init();
 }
 
+#if defined(CONFIG_SOC_OMAP2420)
+
 void __init omap2420_init_early(void)
 {
 	omap2_set_globals_242x();
@@ -370,6 +372,9 @@ void __init omap2420_init_early(void)
 	omap_hwmod_init_postsetup();
 	omap2420_clk_init();
 }
+#endif
+
+#if defined(CONFIG_SOC_OMAP2430)
 
 void __init omap2430_init_early(void)
 {
@@ -382,11 +387,14 @@ void __init omap2430_init_early(void)
 	omap_hwmod_init_postsetup();
 	omap2430_clk_init();
 }
+#endif
 
 /*
  * Currently only board-omap3beagle.c should call this because of the
  * same machine_id for 34xx and 36xx beagle.. Will get fixed with DT.
  */
+#if defined(CONFIG_ARCH_OMAP3)
+
 void __init omap3_init_early(void)
 {
 	omap2_set_globals_3xxx();
@@ -398,6 +406,7 @@ void __init omap3_init_early(void)
 	omap_hwmod_init_postsetup();
 	omap3xxx_clk_init();
 }
+#endif
 
 void __init omap3430_init_early(void)
 {
@@ -431,6 +440,8 @@ void __init ti816x_init_early(void)
 	omap3xxx_clk_init();
 }
 
+#if defined(CONFIG_ARCH_OMAP4)
+
 void __init omap4430_init_early(void)
 {
 	omap2_set_globals_443x();
@@ -442,6 +453,8 @@ void __init omap4430_init_early(void)
 	omap_hwmod_init_postsetup();
 	omap4xxx_clk_init();
 }
+#endif
+
 
 void __init omap_sdrc_init(struct omap_sdrc_params *sdrc_cs0,
 				      struct omap_sdrc_params *sdrc_cs1)
-- 
1.7.5.4
