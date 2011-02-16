From: Anand Gadiyar <gadiyar@ti.com>
Subject: [PATCH 2/2] omap4: 4430sdp: mux GPIO_157 to safe mode
Date: Wed, 16 Feb 2011 16:47:20 +0530
Message-ID: <1297855040-1337-2-git-send-email-gadiyar@ti.com>
References: <1297855040-1337-1-git-send-email-gadiyar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47816 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752313Ab1BPLRa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Feb 2011 06:17:30 -0500
In-Reply-To: <1297855040-1337-1-git-send-email-gadiyar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Anand Gadiyar <gadiyar@ti.com>, Tony Lindgren <tony@atomide.com>

Commit 7d4ca85a5 (omap4: Fix ULPI PHY init for ES1.0 SDP)
changed the mux mode of the pad for GPIO_157 to HSI_MODE
by accident - the original intent was to mux it properly
to solve a board reboot problem.

The board reboot is caused by a bug on many revs of the
board that causes an accidental short circuilt when this
pad is driven high. To ensure this never happens (even
with misbehaving bootloaders), mux the pad to safe mode instead.

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

Index: linux-omap-usb/arch/arm/mach-omap2/board-4430sdp.c
===================================================================
--- linux-omap-usb.orig/arch/arm/mach-omap2/board-4430sdp.c
+++ linux-omap-usb/arch/arm/mach-omap2/board-4430sdp.c
@@ -543,7 +543,15 @@ static void __init omap_sfh7741prox_init
 
 #ifdef CONFIG_OMAP_MUX
 static struct omap_board_mux board_mux[] __initdata = {
-	OMAP4_MUX(USBB2_ULPITLL_CLK, OMAP_MUX_MODE4 | OMAP_PIN_OUTPUT),
+	/*
+	 * USBB2_ULPITLL_CLK/GPIO_157 controls the circuitry
+	 * that turns on the PHY connected to the EHCI port.
+	 * several revisions of the Blaze are affected by
+	 * an accidental short-circuit that causes a reboot
+	 * if this pad is driven high. So, explicitly configure
+	 * the pad in safe mode to ensure this never happens
+	 */
+	OMAP4_MUX(USBB2_ULPITLL_CLK, OMAP_MUX_MODE7),
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
 #else
