From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH 5/5] OMAP3EVM: Set TSC wakeup option in pad config
Date: Tue, 25 Jan 2011 23:07:41 +0530
Message-ID: <1295977061-11086-6-git-send-email-hvaibhav@ti.com>
References: <1295977061-11086-1-git-send-email-hvaibhav@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58812 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753259Ab1AYRhu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Jan 2011 12:37:50 -0500
In-Reply-To: <1295977061-11086-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Vaibhav Hiremath <hvaibhav@ti.com>

Set OMAP_PIN_OFF_WAKEUPENABLE to enable the wake-up
functionality from touchscreen controller.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
 arch/arm/mach-omap2/board-omap3evm.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 2a2efa9..5eddf93 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -716,7 +716,8 @@ static struct omap_board_mux omap35x_board_mux[] __initdata = {
 				OMAP_PIN_OFF_INPUT_PULLUP | OMAP_PIN_OFF_OUTPUT_LOW |
 				OMAP_PIN_OFF_WAKEUPENABLE),
 	OMAP3_MUX(MCSPI1_CS1, OMAP_MUX_MODE4 | OMAP_PIN_INPUT_PULLUP |
-				OMAP_PIN_OFF_INPUT_PULLUP | OMAP_PIN_OFF_OUTPUT_LOW),
+				OMAP_PIN_OFF_INPUT_PULLUP | OMAP_PIN_OFF_OUTPUT_LOW |
+				OMAP_PIN_OFF_WAKEUPENABLE),
 	OMAP3_MUX(SYS_BOOT5, OMAP_MUX_MODE4 | OMAP_PIN_INPUT_PULLUP |
 				OMAP_PIN_OFF_NONE),
 	OMAP3_MUX(GPMC_WAIT2, OMAP_MUX_MODE4 | OMAP_PIN_INPUT_PULLUP |
@@ -729,7 +730,8 @@ static struct omap_board_mux omap36x_board_mux[] __initdata = {
 				OMAP_PIN_OFF_INPUT_PULLUP | OMAP_PIN_OFF_OUTPUT_LOW |
 				OMAP_PIN_OFF_WAKEUPENABLE),
 	OMAP3_MUX(MCSPI1_CS1, OMAP_MUX_MODE4 | OMAP_PIN_INPUT_PULLUP |
-				OMAP_PIN_OFF_INPUT_PULLUP | OMAP_PIN_OFF_OUTPUT_LOW),
+				OMAP_PIN_OFF_INPUT_PULLUP | OMAP_PIN_OFF_OUTPUT_LOW |
+				OMAP_PIN_OFF_WAKEUPENABLE),
 	/* AM/DM37x EVM: DSS data bus muxed with sys_boot */
 	OMAP3_MUX(DSS_DATA18, OMAP_MUX_MODE3 | OMAP_PIN_OFF_NONE),
 	OMAP3_MUX(DSS_DATA19, OMAP_MUX_MODE3 | OMAP_PIN_OFF_NONE),
-- 
1.6.2.4

