From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 3/6] OMAP3EVM: Update pad configuration for wakeup enabled pads
Date: Tue, 11 May 2010 16:47:08 -0700
Message-ID: <1273621631-9148-4-git-send-email-khilman@deeprootsystems.com>
References: <1273621631-9148-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:43790 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752716Ab0EKXrZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 May 2010 19:47:25 -0400
Received: by gwb19 with SMTP id 19so682826gwb.19
        for <linux-omap@vger.kernel.org>; Tue, 11 May 2010 16:47:24 -0700 (PDT)
In-Reply-To: <1273621631-9148-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Ranjith Lohithakshan <ranjithl@ti.com>

From: Ranjith Lohithakshan <ranjithl@ti.com>

OMAP3530 TRM section 7.4.4.4.2 requires OFFOUTENABLE to be set (active low)
if wakeup capabilities are enabled on a pad. During OFF mode testing
on OMAP3530 EVM, it was observed that the device was not residing in
the OFF state. The device enters into the OFF state and immediately exits
from that state as if an IO wakeup event has occured. The issue was traced
down to the pad configuration of wkaeup enabled pad's.

Signed-off-by: Ranjith Lohithakshan <ranjithl@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/board-omap3evm.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 017bb2f..3548fb8 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -651,10 +651,10 @@ static struct ehci_hcd_omap_platform_data ehci_pdata __initdata = {
 #ifdef CONFIG_OMAP_MUX
 static struct omap_board_mux board_mux[] __initdata = {
 	OMAP3_MUX(SYS_NIRQ, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP |
-				OMAP_PIN_OFF_INPUT_PULLUP |
+				OMAP_PIN_OFF_INPUT_PULLUP | OMAP_PIN_OFF_OUTPUT_LOW |
 				OMAP_PIN_OFF_WAKEUPENABLE),
 	OMAP3_MUX(MCSPI1_CS1, OMAP_MUX_MODE4 | OMAP_PIN_INPUT_PULLUP |
-				OMAP_PIN_OFF_INPUT_PULLUP |
+				OMAP_PIN_OFF_INPUT_PULLUP | OMAP_PIN_OFF_OUTPUT_LOW |
 				OMAP_PIN_OFF_WAKEUPENABLE),
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
-- 
1.7.0.2

