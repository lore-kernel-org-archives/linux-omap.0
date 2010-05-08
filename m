From: Ranjith Lohithakshan <ranjithl@ti.com>
Subject: [PATCH] OMAP3: PM: Enable wakeup from ads7846 touchscreen
Date: Sat,  8 May 2010 12:39:21 +0530
Message-ID: <1273302561-27539-1-git-send-email-ranjithl@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56039 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751162Ab0EHHJa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 8 May 2010 03:09:30 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, ranjithl@ti.com

This  patch enables the wakeup capabilities of ads7846 touchscreen driver.
ads7846 driver can now wakeup the system from suspend on OMAP3430 EVM
and SDP boards.

The earlier approach of enabling wakeup on the touchscreen GPIO pin during
board level mux init is removed. Instead the wakeup flag in
ads7846_platform_data is enabled. Based on the flag, the ads7846 driver
will do an enable_irq_wake which will eventually call into the OMAP GPIO
layer and will enable the wakeup capability on the GPIO pin.

Signed-off-by: Ranjith Lohithakshan <ranjithl@ti.com>
---
This patch is tested on OMAP3 EVM and compile tested for OMAP3430 SDP.
This patch has a dependency with the following patch
https://patchwork.kernel.org/patch/96461/

 arch/arm/mach-omap2/board-3430sdp.c  |    1 +
 arch/arm/mach-omap2/board-omap3evm.c |    4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index c1742d0..343f817 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -166,6 +166,7 @@ static int ads7846_get_pendown_state(void)
 static struct ads7846_platform_data tsc2046_config __initdata = {
 	.get_pendown_state	= ads7846_get_pendown_state,
 	.keep_vref_on		= 1,
+	.wakeup				= true,
 };
 
 
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index a8b1f04..de64815 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -601,6 +601,7 @@ struct ads7846_platform_data ads7846_config = {
 	.get_pendown_state	= ads7846_get_pendown_state,
 	.keep_vref_on		= 1,
 	.settle_delay_usecs	= 150,
+	.wakeup				= true,
 };
 
 static struct omap2_mcspi_device_config ads7846_mcspi_config = {
@@ -656,8 +657,7 @@ static struct omap_board_mux board_mux[] __initdata = {
 				OMAP_PIN_OFF_INPUT_PULLUP | OMAP_PIN_OFF_OUTPUT_LOW |
 				OMAP_PIN_OFF_WAKEUPENABLE),
 	OMAP3_MUX(MCSPI1_CS1, OMAP_MUX_MODE4 | OMAP_PIN_INPUT_PULLUP |
-				OMAP_PIN_OFF_INPUT_PULLUP | OMAP_PIN_OFF_OUTPUT_LOW |
-				OMAP_PIN_OFF_WAKEUPENABLE),
+				OMAP_PIN_OFF_INPUT_PULLUP | OMAP_PIN_OFF_OUTPUT_LOW),
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
 #else
-- 
1.6.2.4

