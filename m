From: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] arm: defconfig: rx51: enable phonet and g_nokia
Date: Tue,  5 Jan 2010 16:10:14 +0200
Message-ID: <1262700614-16438-2-git-send-email-felipe.balbi@nokia.com>
References: <1262700614-16438-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1262700614-16438-1-git-send-email-felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

trivial patch enabling g_nokia on rx51_defconfig.

Signed-off-by: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
---
 arch/arm/configs/rx51_defconfig |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/rx51_defconfig b/arch/arm/configs/rx51_defconfig
index b6eeebb..72e27d8 100644
--- a/arch/arm/configs/rx51_defconfig
+++ b/arch/arm/configs/rx51_defconfig
@@ -445,6 +445,8 @@ CONFIG_IP_NF_FILTER=m
 # CONFIG_LAPB is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
+CONFIG_PHONET=y
+# CONFIG_IEEE802154 is not set
 # CONFIG_NET_SCHED is not set
 # CONFIG_DCB is not set
 
@@ -1325,27 +1327,34 @@ CONFIG_USB_GADGET_SELECTED=y
 # CONFIG_USB_GADGET_LH7A40X is not set
 # CONFIG_USB_GADGET_OMAP is not set
 # CONFIG_USB_GADGET_PXA25X is not set
+# CONFIG_USB_GADGET_R8A66597 is not set
 # CONFIG_USB_GADGET_PXA27X is not set
-# CONFIG_USB_GADGET_S3C2410 is not set
+# CONFIG_USB_GADGET_S3C_HSOTG is not set
 # CONFIG_USB_GADGET_IMX is not set
+# CONFIG_USB_GADGET_S3C2410 is not set
 # CONFIG_USB_GADGET_M66592 is not set
 # CONFIG_USB_GADGET_AMD5536UDC is not set
 # CONFIG_USB_GADGET_FSL_QE is not set
 # CONFIG_USB_GADGET_CI13XXX is not set
 # CONFIG_USB_GADGET_NET2280 is not set
 # CONFIG_USB_GADGET_GOKU is not set
+# CONFIG_USB_GADGET_LANGWELL is not set
 # CONFIG_USB_GADGET_DUMMY_HCD is not set
 CONFIG_USB_GADGET_DUALSPEED=y
 CONFIG_USB_ZERO=m
 # CONFIG_USB_ZERO_HNPTEST is not set
+# CONFIG_USB_AUDIO is not set
 # CONFIG_USB_ETH is not set
 # CONFIG_USB_GADGETFS is not set
 CONFIG_USB_FILE_STORAGE=m
 # CONFIG_USB_FILE_STORAGE_TEST is not set
+# CONFIG_USB_MASS_STORAGE is not set
 # CONFIG_USB_G_SERIAL is not set
 # CONFIG_USB_MIDI_GADGET is not set
 # CONFIG_USB_G_PRINTER is not set
 # CONFIG_USB_CDC_COMPOSITE is not set
+CONFIG_USB_G_NOKIA=m
+# CONFIG_USB_G_MULTI is not set
 
 #
 # OTG and related infrastructure
-- 
1.6.6.rc0

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
