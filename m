From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 2/2] USB: ehci-omap: Improve PHY error handling
Date: Wed, 17 Apr 2013 11:24:25 +0300
Message-ID: <1366187065-10795-1-git-send-email-rogerq@ti.com>
References: <1366026636-29198-2-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1366026636-29198-2-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
Cc: stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, holler-SXC+2es9fhnfWeYVQQPykw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

As the USB PHY layer never returns NULL we don't need
to check for that condition.

CC: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/host/ehci-omap.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 5de3e43..3d1491b 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -175,12 +175,12 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
 			phy = devm_usb_get_phy_by_phandle(dev, "phys", i);
 		else
 			phy = devm_usb_get_phy_dev(dev, i);
-		if (IS_ERR(phy) || !phy) {
+		if (IS_ERR(phy)) {
 			/* Don't bail out if PHY is not absolutely necessary */
 			if (pdata->port_mode[i] != OMAP_EHCI_PORT_MODE_PHY)
 				continue;
 
-			ret = IS_ERR(phy) ? PTR_ERR(phy) : -ENODEV;
+			ret = PTR_ERR(phy);
 			dev_err(dev, "Can't get PHY device for port %d: %d\n",
 					i, ret);
 			goto err_phy;
-- 
1.7.4.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
