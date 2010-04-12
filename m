From: <viral.mehta-oonXi/34qI7c+919tysfdA@public.gmane.org>
Subject: [PATCH] Add OHCI USB platform init
Date: Mon, 12 Apr 2010 10:01:53 +0530
Message-ID: <1271046713-10475-1-git-send-email-viral.mehta@lntinfotech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Viral Mehta <viral.mehta-oonXi/34qI7c+919tysfdA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Viral Mehta <viral.mehta-oonXi/34qI7c+919tysfdA@public.gmane.org>

Add platform init code for OHCI USB on OMAP2430 SDP

Signed-off-by: Viral Mehta <viral.mehta-oonXi/34qI7c+919tysfdA@public.gmane.org>
---
 arch/arm/mach-omap2/board-2430sdp.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 346e1d2..047d5ae 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -206,6 +206,15 @@ static struct omap_musb_board_data musb_board_data = {
        .mode                   = MUSB_OTG,
        .power                  = 100,
 };
+static struct omap_usb_config sdp2430_usb_config __initdata = {
+       .otg            = 1,
+#ifdef  CONFIG_USB_GADGET_OMAP
+       .hmc_mode       = 0x0,
+#elif   defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
+       .hmc_mode       = 0x1,
+#endif
+       .pins[0]        = 3,
+}

 static void __init omap_2430sdp_init(void)
 {
@@ -216,6 +225,7 @@ static void __init omap_2430sdp_init(void)
        platform_add_devices(sdp2430_devices, ARRAY_SIZE(sdp2430_devices));
        omap_serial_init();
        omap2_hsmmc_init(mmc);
+       omap_usb_init(&sdp2430_usb_config);
        usb_musb_init(&musb_board_data);
        board_smc91x_init();

--
1.6.6


This Email may contain confidential or privileged information for the intended recipient (s) If you are not the intended recipient, please do not use or disseminate the information, notify the sender and delete it from your system.

______________________________________________________________________
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
