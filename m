From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/4] musb: get rid of unneeded musb->config->dyn_fifo
Date: Tue, 15 Dec 2009 19:01:46 +0530
Message-ID: <1260883909-26836-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

We can get dynamic FIFO information from CONFIGDATA register and
thus there is no need for any user defiend dyn_fifo.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/musb/musb_core.c |   19 ++++---------------
 include/linux/usb/musb.h     |    1 -
 2 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 49f2346..2858940 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1404,21 +1404,10 @@ static int __init musb_core_init(u16 musb_type, struct musb *musb)
 	musb->nr_endpoints = 1;
 	musb->epmask = 1;
 
-	if (reg & MUSB_CONFIGDATA_DYNFIFO) {
-		if (musb->config->dyn_fifo)
-			status = ep_config_from_table(musb);
-		else {
-			ERR("reconfigure software for Dynamic FIFOs\n");
-			status = -ENODEV;
-		}
-	} else {
-		if (!musb->config->dyn_fifo)
-			status = ep_config_from_hw(musb);
-		else {
-			ERR("reconfigure software for static FIFOs\n");
-			return -ENODEV;
-		}
-	}
+	if (reg & MUSB_CONFIGDATA_DYNFIFO)
+		status = ep_config_from_table(musb);
+	else
+		status = ep_config_from_hw(musb);
 
 	if (status < 0)
 		return status;
diff --git a/include/linux/usb/musb.h b/include/linux/usb/musb.h
index d437556..c5f006e 100644
--- a/include/linux/usb/musb.h
+++ b/include/linux/usb/musb.h
@@ -30,7 +30,6 @@ struct musb_hdrc_eps_bits {
 struct musb_hdrc_config {
 	/* MUSB configuration-specific details */
 	unsigned	multipoint:1;	/* multipoint device */
-	unsigned	dyn_fifo:1;	/* supports dynamic fifo sizing */
 	unsigned	soft_con:1;	/* soft connect required */
 	unsigned	utm_16:1;	/* utm data witdh is 16 bits */
 	unsigned	big_endian:1;	/* true if CPU uses big-endian */
-- 
1.6.2.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
