From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 1/6] arm: boot: dts: am437x-sk: remove internal pulls from QSPI
Date: Thu, 4 Dec 2014 11:01:54 -0600
Message-ID: <1417712519-4615-2-git-send-email-balbi@ti.com>
References: <1417712519-4615-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33529 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754145AbaLDRCW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Dec 2014 12:02:22 -0500
In-Reply-To: <1417712519-4615-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

QSPI doesn't need any pullups of any sort,
let's remove them.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/boot/dts/am437x-sk-evm.dts | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am437x-sk-evm.dts
index 0eceb8a..d0ce2d4 100644
--- a/arch/arm/boot/dts/am437x-sk-evm.dts
+++ b/arch/arm/boot/dts/am437x-sk-evm.dts
@@ -300,12 +300,12 @@
 
 	qspi_pins: qspi_pins {
 		pinctrl-single,pins = <
-			0x7c (PIN_OUTPUT_PULLUP | MUX_MODE3)	/* gpmc_csn0.qspi_csn */
-			0x88 (PIN_OUTPUT | MUX_MODE2)		/* gpmc_csn3.qspi_clk */
-			0x90 (PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_advn_ale.qspi_d0 */
-			0x94 (PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_oen_ren.qspi_d1 */
-			0x98 (PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_wen.qspi_d2 */
-			0x9c (PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_be0n_cle.qspi_d3 */
+			0x7c (PIN_OUTPUT | MUX_MODE3)	/* gpmc_csn0.qspi_csn */
+			0x88 (PIN_OUTPUT | MUX_MODE2)	/* gpmc_csn3.qspi_clk */
+			0x90 (PIN_INPUT | MUX_MODE3)	/* gpmc_advn_ale.qspi_d0 */
+			0x94 (PIN_INPUT | MUX_MODE3)	/* gpmc_oen_ren.qspi_d1 */
+			0x98 (PIN_INPUT | MUX_MODE3)	/* gpmc_wen.qspi_d2 */
+			0x9c (PIN_INPUT | MUX_MODE3)	/* gpmc_be0n_cle.qspi_d3 */
 		>;
 	};
 
-- 
2.1.0.GIT

