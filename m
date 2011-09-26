From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH 2/3] arm: omap: am335x: enable phy controls
Date: Mon, 26 Sep 2011 15:33:12 +0530
Message-ID: <1317031393-9333-2-git-send-email-ajay.gupta@ti.com>
References: <1317031393-9333-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57700 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752927Ab1IZKDT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Sep 2011 06:03:19 -0400
In-Reply-To: <1317031393-9333-1-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, balbi@ti.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

Switch on the phy for am335x.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 arch/arm/mach-omap2/omap_phy_internal.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_phy_internal.c b/arch/arm/mach-omap2/omap_phy_internal.c
index d5e8497..ce616a1 100644
--- a/arch/arm/mach-omap2/omap_phy_internal.c
+++ b/arch/arm/mach-omap2/omap_phy_internal.c
@@ -269,16 +269,19 @@ void ti81xx_musb_phy_power(u8 on)
 		if (cpu_is_ti816x()) {
 			usbphycfg |= TI816X_USBPHY0_NORMAL_MODE;
 			usbphycfg &= ~TI816X_USBPHY_REFCLK_OSC;
-		} else if (cpu_is_ti814x()) {
-			usbphycfg &= ~(USBPHY_CM_PWRDN | USBPHY_OTG_PWRDN
-				| USBPHY_DPINPUT | USBPHY_DMINPUT);
-			usbphycfg |= (USBPHY_OTGVDET_EN | USBPHY_OTGSESSEND_EN
-				| USBPHY_DPOPBUFCTL | USBPHY_DMOPBUFCTL);
+		} else if (cpu_is_ti814x() || cpu_is_am335x()) {
+			usbphycfg &= ~(USBPHY_CM_PWRDN | USBPHY_OTG_PWRDN);
+			usbphycfg |= USBPHY_OTGVDET_EN | USBPHY_OTGSESSEND_EN;
+			if (cpu_is_ti814x()) {
+				usbphycfg &= ~(USBPHY_DPINPUT | USBPHY_DMINPUT);
+				usbphycfg |= USBPHY_DPOPBUFCTL
+					| USBPHY_DMOPBUFCTL;
+			}
 		}
 	} else {
 		if (cpu_is_ti816x())
 			usbphycfg &= ~TI816X_USBPHY0_NORMAL_MODE;
-		else if (cpu_is_ti814x())
+		else if (cpu_is_ti814x() || cpu_is_am335x())
 			usbphycfg |= USBPHY_CM_PWRDN | USBPHY_OTG_PWRDN;
 
 	}
-- 
1.6.2.4

