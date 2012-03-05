From: Keshava Munegowda <keshava_mgowda@ti.com>
Subject: [PATCH] ARM: OMAP: USB: fix the pointer type mismatch compilation warning
Date: Mon, 5 Mar 2012 16:49:36 +0530
Message-ID: <1330946376-17672-1-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35877 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756525Ab2CELT5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Mar 2012 06:19:57 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org
Cc: Keshava Munegowda <keshava_mgowda@ti.com>, balbi@ti.com, parthab@india.ti.com, govindraj.raja@ti.com, paul@pwsan.com, b-cousson@ti.com, Keshava Munegowda <Keshava_mgowda@ti.com>

From: Keshava Munegowda <Keshava_mgowda@ti.com>

The compilation of usb-host.c file was resulting compilation warning
due to pointer type mismatch in assignment of return pointer type
of the function omap_device_build_ss to local pointer type.
This warning is fixed.

Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
---
 arch/arm/mach-omap2/usb-host.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-host.c b/arch/arm/mach-omap2/usb-host.c
index 771dc78..88d4a19 100644
--- a/arch/arm/mach-omap2/usb-host.c
+++ b/arch/arm/mach-omap2/usb-host.c
@@ -486,7 +486,7 @@ static void setup_4430ohci_io_mux(const enum usbhs_omap_port_mode *port_mode)
 void __init usbhs_init(const struct usbhs_omap_board_data *pdata)
 {
 	struct omap_hwmod	*oh[2];
-	struct omap_device	*od;
+	struct platform_device	*od;
 	int			bus_id = -1;
 	int			i;
 
-- 
1.6.0.4

