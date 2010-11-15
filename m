From: sricharan <r.sricharan@ti.com>
Subject: [PATCH 3/5] OMAP4: mcbsp: Initialise the mcbsp mux pins
Date: Mon, 15 Nov 2010 13:08:03 +0530
Message-ID: <1289806685-20688-4-git-send-email-r.sricharan@ti.com>
References: <1289806685-20688-1-git-send-email-r.sricharan@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39687 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757576Ab0KOHf3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Nov 2010 02:35:29 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id oAF7ZP6P026155
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 15 Nov 2010 01:35:28 -0600
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dbdp31.itg.ti.com (8.13.8/8.13.8) with ESMTP id oAF7ZO9c024066
	for <linux-omap@vger.kernel.org>; Mon, 15 Nov 2010 13:05:25 +0530 (IST)
In-Reply-To: <1289806685-20688-1-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Use the mux framework to initialise the mcbsp mux pins

Signed-off-by: sricharan <r.sricharan@ti.com>
---
 arch/arm/mach-omap2/mcbsp.c |   33 ++++++++++++++++++++++++++++++++-
 1 files changed, 32 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index f9c9df5..491e3f6 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -25,6 +25,7 @@
 
 #include "control.h"
 
+#include "mux.h"
 
 /* McBSP internal signal muxing functions */
 
@@ -287,9 +288,39 @@ static int __init omap2_mcbsp_init(void)
 	if (cpu_is_omap34xx())
 		omap_mcbsp_register_board_cfg(omap34xx_mcbsp_pdata,
 						OMAP34XX_MCBSP_PDATA_SZ);
-	if (cpu_is_omap44xx())
+	if (cpu_is_omap44xx()) {
 		omap_mcbsp_register_board_cfg(omap44xx_mcbsp_pdata,
 						OMAP44XX_MCBSP_PDATA_SZ);
+		/* MCBSP1 PIN MUX configurations */
+		omap_mux_init_signal("abe_mcbsp1_clkx.abe_slimbus1_clock",
+							OMAP_PIN_INPUT);
+		omap_mux_init_signal("abe_mcbsp1_dr.abe_slimbus1_data",
+							OMAP_PIN_INPUT);
+		omap_mux_init_signal("abe_mcbsp1_dx.abe_mcbsp1_dx",
+							OMAP_PIN_OUTPUT);
+		omap_mux_init_signal("abe_mcbsp1_fsx.abe_mcbsp1_fsx",
+							OMAP_PIN_INPUT);
+
+		/* MCBSP2 PIN MUX configurations */
+		omap_mux_init_signal("abe_mcbsp2_clkx.abe_mcbsp2_clkx",
+							OMAP_PIN_INPUT);
+		omap_mux_init_signal("abe_mcbsp2_dr.abe_mcbsp2_dr",
+							OMAP_PIN_INPUT);
+		omap_mux_init_signal("abe_mcbsp2_dx.abe_mcbsp2_dx",
+							OMAP_PIN_OUTPUT);
+		omap_mux_init_signal("abe_mcbsp2_fsx.abe_mcbsp2_fsx",
+							OMAP_PIN_INPUT);
+
+		/* MCBSP 3 is configured as MCPDM */
+		omap_mux_init_signal("abe_pdm_ul_data.abe_pdm_ul_data",
+						OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("abe_pdm_dl_data.abe_pdm_dl_data",
+						OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("abe_pdm_frame.abe_pdm_frame",
+						OMAP_PIN_INPUT_PULLUP);
+		omap_mux_init_signal("abe_pdm_lb_clk.abe_pdm_lb_clk",
+						OMAP_PIN_INPUT_PULLDOWN);
+	}
 
 	return omap_mcbsp_init();
 }
-- 
1.7.0.4

