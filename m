From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/8] ARM: OMAP2+: Move DISPC L3 firewall to happen in
 omap_display_init()
Date: Tue, 21 Feb 2012 15:40:35 -0800
Message-ID: <20120221234035.18709.40664.stgit@kaulin.local>
References: <20120221233619.18709.87982.stgit@kaulin.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:17160 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751928Ab2BUXkg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Feb 2012 18:40:36 -0500
In-Reply-To: <20120221233619.18709.87982.stgit@kaulin.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

Otherwise we cannot move most of plat/io.h to be a local
iomap.h for mach-omap2.

Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/display.c   |    3 +++
 drivers/video/omap2/dss/dispc.c |    5 -----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index 3677b1f..5a7f12f 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -191,6 +191,9 @@ int __init omap_display_init(struct omap_dss_board_info *board_data)
 	memset(&pdata, 0, sizeof(pdata));
 
 	if (cpu_is_omap24xx()) {
+		/* L3 firewall setting: enable access to OCM RAM */
+		__raw_writel(0x402000b0, OMAP2_L3_IO_ADDRESS(0x680050a0));
+
 		curr_dss_hwmod = omap2_dss_hwmod_data;
 		oh_count = ARRAY_SIZE(omap2_dss_hwmod_data);
 	} else if (cpu_is_omap34xx()) {
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index e1626a1..cce0820 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -3272,11 +3272,6 @@ static void _omap_dispc_initial_config(void)
 	if (dss_has_feature(FEAT_FUNCGATED))
 		REG_FLD_MOD(DISPC_CONFIG, 1, 9, 9);
 
-	/* L3 firewall setting: enable access to OCM RAM */
-	/* XXX this should be somewhere in plat-omap */
-	if (cpu_is_omap24xx())
-		__raw_writel(0x402000b0, OMAP2_L3_IO_ADDRESS(0x680050a0));
-
 	_dispc_setup_color_conv_coef();
 
 	dispc_set_loadmode(OMAP_DSS_LOAD_FRAME_ONLY);

