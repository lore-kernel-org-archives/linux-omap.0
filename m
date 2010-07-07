From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 01/13] omap: zoom2: wlan board muxing
Date: Wed, 07 Jul 2010 12:43:54 +0300
Message-ID: <20100707094354.2562.48930.stgit@baageli.muru.com>
References: <20100707094308.2562.91921.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:59274 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754518Ab0GGJoE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jul 2010 05:44:04 -0400
In-Reply-To: <20100707094308.2562.91921.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Ohad Ben-Cohen <ohadb@ti.com>

From: Ohad Ben-Cohen <ohadb@ti.com>

Add board muxing to support the wlan wl1271 chip that is
hardwired to mmc2 (third mmc controller) on the ZOOM2.

Signed-off-by: Ohad Ben-Cohen <ohadb@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-zoom2.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/board-zoom2.c
index 803ef14..00871be 100644
--- a/arch/arm/mach-omap2/board-zoom2.c
+++ b/arch/arm/mach-omap2/board-zoom2.c
@@ -71,6 +71,21 @@ static struct twl4030_platform_data zoom2_twldata = {
 
 #ifdef CONFIG_OMAP_MUX
 static struct omap_board_mux board_mux[] __initdata = {
+#ifdef CONFIG_OMAP_ZOOM_WLAN
+	/* WLAN IRQ - GPIO 162 */
+	OMAP3_MUX(MCBSP1_CLKX, OMAP_MUX_MODE4 | OMAP_PIN_INPUT_PULLUP),
+	/* WLAN POWER ENABLE - GPIO 101 */
+	OMAP3_MUX(CAM_D2, OMAP_MUX_MODE4 | OMAP_PIN_OUTPUT),
+	/* WLAN SDIO: MMC3 CMD */
+	OMAP3_MUX(MCSPI1_CS1, OMAP_MUX_MODE3 | OMAP_PIN_INPUT_PULLUP),
+	/* WLAN SDIO: MMC3 CLK */
+	OMAP3_MUX(ETK_CLK, OMAP_MUX_MODE2 | OMAP_PIN_INPUT_PULLUP),
+	/* WLAN SDIO: MMC3 DAT[0-3] */
+	OMAP3_MUX(ETK_D3, OMAP_MUX_MODE2 | OMAP_PIN_INPUT_PULLUP),
+	OMAP3_MUX(ETK_D4, OMAP_MUX_MODE2 | OMAP_PIN_INPUT_PULLUP),
+	OMAP3_MUX(ETK_D5, OMAP_MUX_MODE2 | OMAP_PIN_INPUT_PULLUP),
+	OMAP3_MUX(ETK_D6, OMAP_MUX_MODE2 | OMAP_PIN_INPUT_PULLUP),
+#endif
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
 #else

