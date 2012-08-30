From: Ravi Babu <ravibabu@ti.com>
Subject: [PATCH v8 02/13] usb: musb: dsps: enable phy control for am335x
Date: Thu, 30 Aug 2012 16:20:14 +0530
Message-ID: <1346323825-24385-3-git-send-email-ravibabu@ti.com>
References: <1346323825-24385-1-git-send-email-ravibabu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34755 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753286Ab2H3Kus (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Aug 2012 06:50:48 -0400
In-Reply-To: <1346323825-24385-1-git-send-email-ravibabu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, balbi@ti.com, grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, tony@atomide.com, ajayguptaj@gmail.com

From: Ajay Kumar Gupta <ajay.gupta@ti.com>

Enabled the phy control logic for am335x also based on usbss
revision register.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
Signed-off-by: Santhapuri, Damodar <damodar.santhapuri@ti.com>
Signed-off-by: Ravi Babu <ravibabu@ti.com>
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
index 960258d..e62fa05 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -141,16 +141,21 @@ static void musb_dsps_phy_control(struct dsps_glue *glue, u8 on)
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

