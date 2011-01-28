From: sricharan <r.sricharan@ti.com>
Subject: [PATCH 5/5] omap2+: board-n8x0: Change the flags for the serial pads.
Date: Fri, 28 Jan 2011 10:38:18 +0530
Message-ID: <1296191298-17545-6-git-send-email-r.sricharan@ti.com>
References: <1296191298-17545-1-git-send-email-r.sricharan@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33962 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751393Ab1A1FGK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Jan 2011 00:06:10 -0500
In-Reply-To: <1296191298-17545-1-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: r.sricharan@ti.com, linux-omap@vger.kernel.org
Cc: santosh.shilimkar@ti.com, tony@atomide.com, paul@pwsan.com

The flag for remuxing uart3_rx_irxx pad is changed.

Signed-off-by: sricharan <r.sricharan@ti.com>
---
 arch/arm/mach-omap2/board-n8x0.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index 9b52e2d..bd51356 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -751,7 +751,7 @@ static struct omap_board_mux board_mux[] __initdata = {
 static struct omap_device_pad serial2_pads[] __initdata = {
 	{
 		.name	= "uart3_rx_irrx.uart3_rx_irrx",
-		.flags	= OMAP_DEVICE_PAD_REMUX | OMAP_DEVICE_PAD_WAKEUP,
+		.flags	= OMAP_DEVICE_PAD_REMUX_IDLE | OMAP_DEVICE_PAD_WAKEUP,
 		.enable	= OMAP_MUX_MODE0,
 		.idle	= OMAP_MUX_MODE3	/* Mux as GPIO for idle */
 	},
-- 
1.7.0.4

