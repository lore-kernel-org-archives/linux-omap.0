From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: [PATCH 2/3] [OMAP] USB: Add omap7xx-specific pin muxing
Date: Sun, 22 Nov 2009 13:27:08 -0800
Message-ID: <1258925228.11242.4.camel@runt>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f204.google.com ([209.85.216.204]:49599 "EHLO
	mail-px0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755767AbZKVV1D (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 22 Nov 2009 16:27:03 -0500
Received: by pxi42 with SMTP id 42so2880405pxi.5
        for <linux-omap@vger.kernel.org>; Sun, 22 Nov 2009 13:27:10 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This adds the initialization for the pin muxing required
for USB to function properly on omap7xx hardware.

Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
---
 arch/arm/plat-omap/usb.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/usb.c b/arch/arm/plat-omap/usb.c
index 51033a4..d3bf17c 100644
--- a/arch/arm/plat-omap/usb.c
+++ b/arch/arm/plat-omap/usb.c
@@ -137,7 +137,13 @@ static u32 __init omap_usb0_init(unsigned nwires, unsigned is_device)
 	if (is_device) {
 		if (cpu_is_omap24xx())
 			omap_cfg_reg(J20_24XX_USB0_PUEN);
-		else
+		else if (cpu_is_omap7xx()) {
+			omap_cfg_reg(AA17_7XX_USB_DM);
+			omap_cfg_reg(W16_7XX_USB_PU_EN);
+			omap_cfg_reg(W17_7XX_USB_VBUSI);
+			omap_cfg_reg(W18_7XX_USB_DMCK_OUT);
+			omap_cfg_reg(W19_7XX_USB_DCRST);
+		} else
 			omap_cfg_reg(W4_USB_PUEN);
 	}
 
-- 
1.6.3.3


