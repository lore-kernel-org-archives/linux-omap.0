From: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Subject: [PATCH] usb: ehci-omap: don't complain on -EPROBE_DEFER when no PHY
 found
Date: Wed, 9 Nov 2016 15:02:47 +0100
Message-ID: <20161109140247.GC20859@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Don't complain on -EPROBE_DEFER when when no PHY found, the driver
probe will be retried later.

Signed-off-by: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
---
 drivers/usb/host/ehci-omap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 94ea9ff..44945eb 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -181,8 +181,9 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
 				continue;
 
 			ret = PTR_ERR(phy);
-			dev_err(dev, "Can't get PHY device for port %d: %d\n",
-					i, ret);
+			if (ret != -EPROBE_DEFER)
+				dev_err(dev, "Can't get PHY device for port "
+					"%d: %d\n", i, ret);
 			goto err_phy;
 		}
 
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
