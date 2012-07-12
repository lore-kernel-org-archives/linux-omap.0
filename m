From: Damodar Santhapuri <damodar.santhapuri@ti.com>
Subject: [PATCH v3 3/3] usb: musb: dsps: enable phy control for am335x
Date: Thu, 12 Jul 2012 15:40:37 +0530
Message-ID: <1342087837-32161-3-git-send-email-damodar.santhapuri@ti.com>
References: <1342087837-32161-1-git-send-email-damodar.santhapuri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36751 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759138Ab2GLKMS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Jul 2012 06:12:18 -0400
In-Reply-To: <1342087837-32161-1-git-send-email-damodar.santhapuri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: balbi@ti.com, linux-omap@vger.kernel.org, Ajay Kumar Gupta <ajay.gupta@ti.com>, Damodar Santhapuri <damodar.santhapuri@ti.com>

From: Ajay Kumar Gupta <ajay.gupta@ti.com>

Enabled the phy control logic for am335x also based on usbss
revision register.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
Signed-off-by: Damodar Santhapuri <damodar.santhapuri@ti.com>
---
 arch/arm/plat-omap/include/plat/usb.h |    1 +
 drivers/usb/musb/musb_dsps.c          |   17 +++++++++++------
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-omap/include/plat/usb.h
index c2aa4ae..6459b10 100644
--- a/arch/arm/plat-omap/include/plat/usb.h
+++ b/arch/arm/plat-omap/include/plat/usb.h
@@ -121,6 +121,7 @@ extern void am35x_set_mode(u8 musb_mode);
 /* TI81XX specific definitions */
 #define MUSB_USBSS_REV_816X	0x9
 #define MUSB_USBSS_REV_814X	0xb
+#define MUSB_USBSS_REV_33XX	0xd
 
 /* TI816X PHY controls bits */
 #define TI816X_USBPHY0_NORMAL_MODE	(1 << 0)
diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index 72eda64..46b07cc 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -140,16 +140,21 @@ static void musb_dsps_phy_control(struct dsps_glue *glue, u8 on)
 		if (glue->usbss_rev == MUSB_USBSS_REV_816X) {
 			usbphycfg |= TI816X_USBPHY0_NORMAL_MODE;
 			usbphycfg &= ~TI816X_USBPHY_REFCLK_OSC;
-		} else if (glue->usbss_rev == MUSB_USBSS_REV_814X) {
-			usbphycfg &= ~(USBPHY_CM_PWRDN | USBPHY_OTG_PWRDN
-				| USBPHY_DPINPUT | USBPHY_DMINPUT);
-			usbphycfg |= (USBPHY_OTGVDET_EN | USBPHY_OTGSESSEND_EN
-				| USBPHY_DPOPBUFCTL | USBPHY_DMOPBUFCTL);
+		} else if (glue->usbss_rev == MUSB_USBSS_REV_814X ||
+				glue->usbss_rev == MUSB_USBSS_REV_33XX) {
+			usbphycfg &= ~(USBPHY_CM_PWRDN | USBPHY_OTG_PWRDN);
+			usbphycfg |= USBPHY_OTGVDET_EN | USBPHY_OTGSESSEND_EN;
+			if (glue->usbss_rev == MUSB_USBSS_REV_814X) {
+				usbphycfg &= ~(USBPHY_DPINPUT | USBPHY_DMINPUT);
+				usbphycfg |= USBPHY_DPOPBUFCTL
+						| USBPHY_DMOPBUFCTL;
+			}
 		}
 	} else {
 		if (glue->usbss_rev == MUSB_USBSS_REV_816X)
 			usbphycfg &= ~TI816X_USBPHY0_NORMAL_MODE;
-		else if (glue->usbss_rev == MUSB_USBSS_REV_814X)
+		else if (glue->usbss_rev == MUSB_USBSS_REV_814X ||
+				glue->usbss_rev == MUSB_USBSS_REV_33XX)
 			usbphycfg |= USBPHY_CM_PWRDN | USBPHY_OTG_PWRDN;
 	}
 	__raw_writel(usbphycfg, glue->usb_ctrl);
-- 
1.7.0.4

