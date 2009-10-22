From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 09/10] omap4: Allow omap_serial_early_init() for OMAP4430 board
Date: Thu, 22 Oct 2009 15:13:02 -0700
Message-ID: <20091022221302.27408.10116.stgit@localhost>
References: <20091022221013.27408.443.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20091022221013.27408.443.stgit@localhost>
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
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch enables omap_serial_early_init() function for OMAP4430
SDP. Without this the bootup would throw oops in omap_serial_init().

Note that the ifndef CONFIG_ARCH_OMAP4 is split into two sections
to enable omap_serial_early_init(). This ifndef cannot be removed
until omap4 clock framework is implemented.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Reviewed-By: Tony Lindgren <tony@atomide.com>
Reviewed-By: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |    4 ++--
 arch/arm/mach-omap2/io.c            |    2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index eb37c40..609a5a4 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -58,6 +58,8 @@ static void __init gic_init_irq(void)
 
 static void __init omap_4430sdp_init_irq(void)
 {
+	omap_board_config = sdp4430_config;
+	omap_board_config_size = ARRAY_SIZE(sdp4430_config);
 	omap2_init_common_hw(NULL, NULL);
 #ifdef CONFIG_OMAP_32K_TIMER
 	omap2_gp_clockevent_set_gptimer(1);
@@ -70,8 +72,6 @@ static void __init omap_4430sdp_init_irq(void)
 static void __init omap_4430sdp_init(void)
 {
 	platform_add_devices(sdp4430_devices, ARRAY_SIZE(sdp4430_devices));
-	omap_board_config = sdp4430_config;
-	omap_board_config_size = ARRAY_SIZE(sdp4430_config);
 	omap_serial_init();
 }
 
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index e3a3bad..56be87d 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -302,7 +302,9 @@ void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
 	pwrdm_init(powerdomains_omap);
 	clkdm_init(clockdomains_omap, clkdm_pwrdm_autodeps);
 	omap2_clk_init();
+#endif
 	omap_serial_early_init();
+#ifndef CONFIG_ARCH_OMAP4
 	omap_hwmod_late_init();
 	omap_pm_if_init();
 	omap2_sdrc_init(sdrc_cs0, sdrc_cs1);
