From: Rolf Peukert <rolf.peukert-cSCHQGRfioA@public.gmane.org>
Subject: [PATCH 2/5] Export am35x helper functions
Date: Fri, 23 Oct 2015 17:46:29 +0200
Message-ID: <562A5655.3000406@imms.de>
References: <562A557B.4090501@imms.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <562A557B.4090501-cSCHQGRfioA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

To be able to call these four helper functions from a M-USB AM35x driver
module, their name symbols need to be exported.

Signed-off-by: Rolf Peukert <rolf.peukert-cSCHQGRfioA@public.gmane.org>
---
 arch/arm/mach-omap2/omap_phy_internal.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_phy_internal.c
b/arch/arm/mach-omap2/omap_phy_internal.c
index 8e90356..648a60f 100644
--- a/arch/arm/mach-omap2/omap_phy_internal.c
+++ b/arch/arm/mach-omap2/omap_phy_internal.c
@@ -82,6 +82,7 @@ void am35x_musb_reset(void)

 	regval = omap_ctrl_readl(AM35XX_CONTROL_IP_SW_RESET);
 }
+EXPORT_SYMBOL(am35x_musb_reset);

 void am35x_musb_phy_power(u8 on)
 {
@@ -120,6 +121,7 @@ void am35x_musb_phy_power(u8 on)
 		omap_ctrl_writel(devconf2, AM35XX_CONTROL_DEVCONF2);
 	}
 }
+EXPORT_SYMBOL(am35x_musb_phy_power);

 void am35x_musb_clear_irq(void)
 {
@@ -130,6 +132,7 @@ void am35x_musb_clear_irq(void)
 	omap_ctrl_writel(regval, AM35XX_CONTROL_LVL_INTR_CLEAR);
 	regval = omap_ctrl_readl(AM35XX_CONTROL_LVL_INTR_CLEAR);
 }
+EXPORT_SYMBOL(am35x_musb_clear_irq);

 void am35x_set_mode(u8 musb_mode)
 {
@@ -152,3 +155,4 @@ void am35x_set_mode(u8 musb_mode)

 	omap_ctrl_writel(devconf2, AM35XX_CONTROL_DEVCONF2);
 }
+EXPORT_SYMBOL(am35x_set_mode);
-- 
2.4.10

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
