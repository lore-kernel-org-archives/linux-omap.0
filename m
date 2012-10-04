From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/9] ARM: OMAP: board-4430-sdp: Pin mux configuration for audio needs
Date: Thu,  4 Oct 2012 14:57:20 +0300
Message-ID: <1349351848-12972-2-git-send-email-peter.ujfalusi@ti.com>
References: <1349351848-12972-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:40553 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755222Ab2JDL4U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Oct 2012 07:56:20 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so333191obb.19
        for <linux-omap@vger.kernel.org>; Thu, 04 Oct 2012 04:56:19 -0700 (PDT)
In-Reply-To: <1349351848-12972-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

u-boot stopped configuring 'non essential' pins recently. These pins are
essential for audio and need to be done to have working audio on the board.
Pin Mux configuration for: twl6040 audpwron gpio, McPDM, DMIC, McBSP1 and
McBSP2.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 09644af..41a9b01 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -753,6 +753,32 @@ static struct omap_board_mux board_mux[] __initdata = {
 	/* NIRQ2 for twl6040 */
 	OMAP4_MUX(SYS_NIRQ2, OMAP_MUX_MODE0 |
 		  OMAP_PIN_INPUT_PULLUP | OMAP_PIN_OFF_WAKEUPENABLE),
+	/* GPIO_127 for twl6040 */
+	OMAP4_MUX(HDQ_SIO, OMAP_MUX_MODE3 | OMAP_PIN_OUTPUT),
+	/* McPDM */
+	OMAP4_MUX(ABE_PDM_UL_DATA, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLDOWN),
+	OMAP4_MUX(ABE_PDM_DL_DATA, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLDOWN),
+	OMAP4_MUX(ABE_PDM_FRAME, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP),
+	OMAP4_MUX(ABE_PDM_LB_CLK, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLDOWN),
+	OMAP4_MUX(ABE_CLKS, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLDOWN),
+	/* DMIC */
+	OMAP4_MUX(ABE_DMIC_CLK1, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
+	OMAP4_MUX(ABE_DMIC_DIN1, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+	OMAP4_MUX(ABE_DMIC_DIN2, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+	OMAP4_MUX(ABE_DMIC_DIN3, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+	/* McBSP1 */
+	OMAP4_MUX(ABE_MCBSP1_CLKX, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+	OMAP4_MUX(ABE_MCBSP1_DR, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLDOWN),
+	OMAP4_MUX(ABE_MCBSP1_DX, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT |
+		  OMAP_PULL_ENA),
+	OMAP4_MUX(ABE_MCBSP1_FSX, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+	/* McBSP2 */
+	OMAP4_MUX(ABE_MCBSP2_CLKX, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+	OMAP4_MUX(ABE_MCBSP2_DR, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLDOWN),
+	OMAP4_MUX(ABE_MCBSP2_DX, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT |
+		  OMAP_PULL_ENA),
+	OMAP4_MUX(ABE_MCBSP2_FSX, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
 
-- 
1.7.12

