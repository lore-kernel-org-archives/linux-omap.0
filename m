From: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Subject: [PATCH v4] usb: ehci-omap: don't complain on -EPROBE_DEFER when no
 PHY found
Date: Thu, 18 Jan 2018 22:13:18 +0100
Message-ID: <20180118211317.GA27821@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Don't complain on -EPROBE_DEFER when no PHY found, the driver
probe will be retried later.

Signed-off-by: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Acked-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Acked-by: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
---
 Changes:
 - v2: None, just added Tony's ack
 - v3: Fixed commit message typo spotted by Jaejoong Kim, added Roger's ack
 - v4: Do not break printk string, Alan's ack. I hope he forgives me
       changing error message a bit. IMHO shorter with the same meaning.
       (this patch gained unbelievable lines_changed/versions ratio ;-))

 drivers/usb/host/ehci-omap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 854b146a457d..8d8bafc70c1f 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -167,7 +167,8 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
 				continue;
 
 			ret = PTR_ERR(phy);
-			dev_err(dev, "Can't get PHY device for port %d: %d\n",
+			if (ret != -EPROBE_DEFER)
+				dev_err(dev, "Can't get PHY for port %d: %d\n",
 					i, ret);
 			goto err_phy;
 		}
-- 
2.15.1
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
