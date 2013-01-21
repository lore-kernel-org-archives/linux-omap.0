From: Luciano Coelho <coelho@ti.com>
Subject: [PATCH] OMAP: omap4-panda: add UART2 muxing for WiLink shared transport
Date: Mon, 21 Jan 2013 13:14:12 +0200
Message-ID: <1358766852-24503-1-git-send-email-coelho@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: peter.ujfalusi@ti.com, balbi@ti.com, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Add the UART2 muxing data to the board file (this used to be,
erroneously, done in the bootloader).

Cc: stable <stable@vger.kernel.org> [3.7]
Signed-off-by: Luciano Coelho <coelho@ti.com>
---
 arch/arm/mach-omap2/board-omap4panda.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 5c8e9ce..769c1fe 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -397,6 +397,12 @@ static struct omap_board_mux board_mux[] __initdata = {
 		  OMAP_PULL_ENA),
 	OMAP4_MUX(ABE_MCBSP1_FSX, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
 
+	/* UART2 - BT/FM/GPS shared transport */
+	OMAP4_MUX(UART2_CTS,	OMAP_PIN_INPUT	| OMAP_MUX_MODE0),
+	OMAP4_MUX(UART2_RTS,	OMAP_PIN_OUTPUT	| OMAP_MUX_MODE0),
+	OMAP4_MUX(UART2_RX,	OMAP_PIN_INPUT	| OMAP_MUX_MODE0),
+	OMAP4_MUX(UART2_TX,	OMAP_PIN_OUTPUT	| OMAP_MUX_MODE0),
+
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
 
-- 
1.7.10.4
