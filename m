From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 4/6] OMAP3: PM: Enable wakeup from ads7846 touchscreen
Date: Tue, 11 May 2010 16:47:09 -0700
Message-ID: <1273621631-9148-5-git-send-email-khilman@deeprootsystems.com>
References: <1273621631-9148-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:38417 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752716Ab0EKXr2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 May 2010 19:47:28 -0400
Received: by mail-vw0-f46.google.com with SMTP id 17so1655954vws.19
        for <linux-omap@vger.kernel.org>; Tue, 11 May 2010 16:47:28 -0700 (PDT)
In-Reply-To: <1273621631-9148-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Ranjith Lohithakshan <ranjithl@ti.com>

From: Ranjith Lohithakshan <ranjithl@ti.com>

This  patch enables the wakeup capabilities of ads7846 touchscreen driver.
ads7846 driver can now wakeup the system from suspend on OMAP3430 EVM
and SDP boards.

The earlier approach of enabling wakeup on the touchscreen GPIO pin during
board level mux init is removed. Instead the wakeup flag in
ads7846_platform_data is enabled. Based on the flag, the ads7846 driver
will do an enable_irq_wake which will eventually call into the OMAP GPIO
layer and will enable the wakeup capability on the GPIO pin.

Signed-off-by: Ranjith Lohithakshan <ranjithl@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/board-3430sdp.c  |    1 +
 arch/arm/mach-omap2/board-omap3evm.c |    4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 5822bcf..e7d629b 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -150,6 +150,7 @@ static int ads7846_get_pendown_state(void)
 static struct ads7846_platform_data tsc2046_config __initdata = {
 	.get_pendown_state	= ads7846_get_pendown_state,
 	.keep_vref_on		= 1,
+	.wakeup				= true,
 };
 
 
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 3548fb8..cfbe695 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -600,6 +600,7 @@ struct ads7846_platform_data ads7846_config = {
 	.get_pendown_state	= ads7846_get_pendown_state,
 	.keep_vref_on		= 1,
 	.settle_delay_usecs	= 150,
+	.wakeup				= true,
 };
 
 static struct omap2_mcspi_device_config ads7846_mcspi_config = {
@@ -654,8 +655,7 @@ static struct omap_board_mux board_mux[] __initdata = {
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
1.7.0.2

