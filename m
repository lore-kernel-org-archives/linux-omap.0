From: Ruslan Bilovol <ruslan.bilovol-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 resend] omap: usb: host: remove deprecated flags and structures
Date: Sat,  3 Jun 2017 01:52:31 +0300
Message-ID: <1496443951-9158-1-git-send-email-ruslan.bilovol@gmail.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

From: Ruslan Bilovol <ruslan.bilovol-l0cyMroinI0@public.gmane.org>

These flags and structures are deprecated and there is
no anymore users of them, so it's safe to remove them.

Signed-off-by: Ruslan Bilovol <ruslan.bilovol-l0cyMroinI0@public.gmane.org>
---

Although this patch was acked-by Felipe Balbi and Roger Quadros back
in 2013, it was never picked up by maintainers.

Still applies to v4.12-rc3 and saves few bytes of memory


 include/linux/platform_data/usb-omap.h | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/include/linux/platform_data/usb-omap.h b/include/linux/platform_data/usb-omap.h
index fa579b4..4c7acbe 100644
--- a/include/linux/platform_data/usb-omap.h
+++ b/include/linux/platform_data/usb-omap.h
@@ -38,34 +38,14 @@ enum usbhs_omap_port_mode {
 	OMAP_OHCI_PORT_MODE_TLL_2PIN_DPDM
 };
 
-struct usbtll_omap_platform_data {
-	enum usbhs_omap_port_mode		port_mode[OMAP3_HS_USB_PORTS];
-};
-
-struct ehci_hcd_omap_platform_data {
-	enum usbhs_omap_port_mode	port_mode[OMAP3_HS_USB_PORTS];
-	int				reset_gpio_port[OMAP3_HS_USB_PORTS];
-	struct regulator		*regulator[OMAP3_HS_USB_PORTS];
-	unsigned			phy_reset:1;
-};
-
-struct ohci_hcd_omap_platform_data {
-	enum usbhs_omap_port_mode	port_mode[OMAP3_HS_USB_PORTS];
-	unsigned			es2_compatibility:1;
-};
-
 struct usbhs_omap_platform_data {
 	int				nports;
 	enum usbhs_omap_port_mode	port_mode[OMAP3_HS_USB_PORTS];
 	int				reset_gpio_port[OMAP3_HS_USB_PORTS];
 	struct regulator		*regulator[OMAP3_HS_USB_PORTS];
 
-	struct ehci_hcd_omap_platform_data	*ehci_data;
-	struct ohci_hcd_omap_platform_data	*ohci_data;
