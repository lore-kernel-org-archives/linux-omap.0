From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/2] USB: ehci-omap: Don't free gpios that we didn't request
Date: Thu, 14 Feb 2013 17:08:08 +0200
Message-ID: <1360854489-9972-2-git-send-email-rogerq@ti.com>
References: <1360854489-9972-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1360854489-9972-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
Cc: stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This driver does not request any gpios so don't free them.
Fixes L3 bus error on multiple modprobe/rmmod of ehci_hcd
with ehci-omap in use.

Without this patch, EHCI will break on repeated insmod/rmmod
of ehci_hcd for all OMAP2+ platforms that use EHCI and
set 'phy_reset = true' in usbhs_omap_board_data.
i.e.

board-3430sdp.c:	.phy_reset  = true,
board-3630sdp.c:	.phy_reset  = true,
board-am3517crane.c:	.phy_reset  = true,
board-am3517evm.c:	.phy_reset  = true,
board-cm-t3517.c:	.phy_reset  = true,
board-cm-t35.c:	.phy_reset  = true,
board-devkit8000.c:	.phy_reset  = true,
board-igep0020.c:	.phy_reset = true,
board-igep0020.c:	.phy_reset = true,
board-omap3beagle.c:	.phy_reset  = true,
board-omap3evm.c:	.phy_reset  = true,
board-omap3pandora.c:	.phy_reset  = true,
board-omap3stalker.c:	.phy_reset = true,
board-omap3touchbook.c:	.phy_reset  = true,
board-omap4panda.c:	.phy_reset  = false,
board-overo.c:	.phy_reset  = true,
board-zoom.c:	.phy_reset		= true,

CC: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
CC: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
CC: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Reviewed-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Acked-by: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
---
 drivers/usb/host/ehci-omap.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index ac17a7c..e9d9b09 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -288,7 +288,6 @@ static int ehci_hcd_omap_remove(struct platform_device *pdev)
 {
 	struct device *dev				= &pdev->dev;
 	struct usb_hcd *hcd				= dev_get_drvdata(dev);
-	struct ehci_hcd_omap_platform_data *pdata	= dev->platform_data;
 
 	usb_remove_hcd(hcd);
 	disable_put_regulator(dev->platform_data);
@@ -298,13 +297,6 @@ static int ehci_hcd_omap_remove(struct platform_device *pdev)
 	pm_runtime_put_sync(dev);
 	pm_runtime_disable(dev);
 
-	if (pdata->phy_reset) {
-		if (gpio_is_valid(pdata->reset_gpio_port[0]))
-			gpio_free(pdata->reset_gpio_port[0]);
