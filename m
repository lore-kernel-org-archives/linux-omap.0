From: Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 1/3] usb: fix Kconfig warning
Date: Tue, 19 Oct 2010 13:03:26 +0300
Message-ID: <1287482608-11320-2-git-send-email-felipe.contreras@gmail.com>
References: <1287482608-11320-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1287482608-11320-1-git-send-email-felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-main <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

warning: (USB_MUSB_HDRC_HCD && USB_SUPPORT && USB_MUSB_HDRC &&
(USB_MUSB_HOST || USB_MUSB_OTG) && USB_GADGET_MUSB_HDRC || USB_MUSB_OTG
&& <choice> && USB && USB_GADGET && PM && EXPERIMENTAL) selects USB_OTG
which has unmet direct dependencies (USB_GADGET_OMAP && ARCH_OMAP_OTG &&
USB_OHCI_HCD)

This doesn't seem to happen on 2.6.36-rc8, but still doesn't make sense
to keep this duplicated config that is already defined in usb/core.

Signed-off-by: Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/usb/gadget/Kconfig |   11 -----------
 1 files changed, 0 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index cd27f9b..19a6eb6 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -209,17 +209,6 @@ config USB_OMAP
 	default USB_GADGET
 	select USB_GADGET_SELECTED
 
-config USB_OTG
-	boolean "OTG Support"
-	depends on USB_GADGET_OMAP && ARCH_OMAP_OTG && USB_OHCI_HCD
-	help
-	   The most notable feature of USB OTG is support for a
-	   "Dual-Role" device, which can act as either a device
-	   or a host.  The initial role choice can be changed
-	   later, when two dual-role devices talk to each other.
-
-	   Select this only if your OMAP board has a Mini-AB connector.
