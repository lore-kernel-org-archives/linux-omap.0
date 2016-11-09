From: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Subject: [PATCH] usb: musb: omap2430: make complain on -EPROBE_DEFER dev_dbg
Date: Wed, 9 Nov 2016 15:10:26 +0100
Message-ID: <20161109141026.GF20859@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

There is no point having this complaint to be dev_err as it is just adding
noise to bootlog.

Signed-off-by: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
---
 drivers/usb/musb/omap2430.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 451b372..7c9aa5e 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -277,7 +277,7 @@ static int omap2430_musb_init(struct musb *musb)
 		if (status == -ENXIO)
 			return status;
 
-		dev_err(dev, "HS USB OTG: no transceiver configured\n");
+		dev_dbg(dev, "HS USB OTG: no transceiver configured\n");
 		return -EPROBE_DEFER;
 	}
 
-- 
2.1.4


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
