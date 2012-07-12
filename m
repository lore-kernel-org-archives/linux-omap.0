From: Ruslan Bilovol <ruslan.bilovol@ti.com>
Subject: [PATCH] OMAP4: 4430sdp: OTG: increase max allowed output current
Date: Thu, 12 Jul 2012 16:25:42 +0300
Message-ID: <1342099542-13862-1-git-send-email-ruslan.bilovol@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49989 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754790Ab2GLNZp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Jul 2012 09:25:45 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com, tony@atomide.com, linux-omap@vger.kernel.org

TWL6030/32 that is used on 4430sdp board can deliver up to 200mA
for OTG port power supply in the HOST mode.

Signed-off-by: Ruslan Bilovol <ruslan.bilovol@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 8e17284..10223f5 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -429,7 +429,7 @@ static struct platform_device *sdp4430_devices[] __initdata = {
 static struct omap_musb_board_data musb_board_data = {
 	.interface_type		= MUSB_INTERFACE_UTMI,
 	.mode			= MUSB_OTG,
-	.power			= 100,
+	.power			= 200,
 };
 
 static struct omap2_hsmmc_info mmc[] = {
-- 
1.7.1

