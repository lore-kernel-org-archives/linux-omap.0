From: sricharan <r.sricharan@ti.com>
Subject: [PATCH 4/5] OMAP4: board-4430sdp: Initialise the mcspi mux pins
Date: Mon, 15 Nov 2010 13:08:04 +0530
Message-ID: <1289806685-20688-5-git-send-email-r.sricharan@ti.com>
References: <1289806685-20688-1-git-send-email-r.sricharan@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39688 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752808Ab0KOHf3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Nov 2010 02:35:29 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id oAF7ZQJH026156
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 15 Nov 2010 01:35:28 -0600
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dbdp31.itg.ti.com (8.13.8/8.13.8) with ESMTP id oAF7ZO9d024066
	for <linux-omap@vger.kernel.org>; Mon, 15 Nov 2010 13:05:25 +0530 (IST)
In-Reply-To: <1289806685-20688-1-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Use the mux framework to initialise the mcspi mux pins.

Signed-off-by: sricharan <r.sricharan@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 323b62e..c0ffea1 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -501,6 +501,25 @@ static void __init omap_sfh7741prox_init(void)
 	}
 }
 
+static void __init omap_mcspi_mux_init(void)
+{
+	/* PIN MUX for MCSPI1 */
+	omap_mux_init_signal("mcspi1_clk.mcspi1_clk", OMAP_PIN_INPUT);
+	omap_mux_init_signal("mcspi1_somi.mcspi1_somi",	OMAP_PIN_INPUT);
+	omap_mux_init_signal("mcspi1_simo.mcspi1_simo",	OMAP_PIN_INPUT);
+	omap_mux_init_signal("mcspi1_cs0.mcspi1_cs0", OMAP_PIN_INPUT);
+	/*
+	 * CS1 should be configured as gpio 138
+	 * to avoid interference with CS0
+	 */
+	omap_mux_init_signal("mcspi1_cs1.gpio_138", OMAP_PIN_INPUT);
+
+	/* PIN MUX for MCSPI4. This is not connected to any device */
+	omap_mux_init_signal("mcspi4_clk.mcspi4_clk", OMAP_PIN_INPUT);
+	omap_mux_init_signal("mcspi4_somi.mcspi4_somi",	OMAP_PIN_INPUT);
+	omap_mux_init_signal("mcspi4_simo.mcspi4_simo",	OMAP_PIN_INPUT);
+	omap_mux_init_signal("mcspi4_cs0.mcspi4_cs0", OMAP_PIN_INPUT_PULLDOWN);
+}
 #ifdef CONFIG_OMAP_MUX
 static struct omap_board_mux board_mux[] __initdata = {
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
@@ -529,6 +548,7 @@ static void __init omap_4430sdp_init(void)
 	if (!cpu_is_omap44xx())
 		usb_musb_init(&musb_board_data);
 
+	omap_mcspi_mux_init();
 	status = omap_ethernet_init();
 	if (status) {
 		pr_err("Ethernet initialization failed: %d\n", status);
-- 
1.7.0.4

