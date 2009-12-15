From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 2/4] musb: save dynfifo in musb struct
Date: Tue, 15 Dec 2009 19:01:47 +0530
Message-ID: <1260883909-26836-2-git-send-email-ajay.gupta@ti.com>
References: <1260883909-26836-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1260883909-26836-1-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Save dynamic FIFO read only information for later uses during
musb_save/restore_context functions.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/musb/musb_core.c |    4 +++-
 drivers/usb/musb/musb_core.h |    1 +
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 2858940..9d3b97d 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1328,8 +1328,10 @@ static int __init musb_core_init(u16 musb_type, struct musb *musb)
 	reg = musb_read_configdata(mbase);
 
 	strcpy(aInfo, (reg & MUSB_CONFIGDATA_UTMIDW) ? "UTMI-16" : "UTMI-8");
-	if (reg & MUSB_CONFIGDATA_DYNFIFO)
+	if (reg & MUSB_CONFIGDATA_DYNFIFO) {
 		strcat(aInfo, ", dyn FIFOs");
+		musb->dyn_fifo = true;
+	}
 	if (reg & MUSB_CONFIGDATA_MPRXE) {
 		strcat(aInfo, ", bulk combine");
 #ifdef C_MP_RX
diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
index 03d5090..969287c 100644
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -411,6 +411,7 @@ struct musb {
 
 	unsigned		hb_iso_rx:1;	/* high bandwidth iso rx? */
 	unsigned		hb_iso_tx:1;	/* high bandwidth iso tx? */
+	unsigned		dyn_fifo:1;	/* dynamic FIFO supported? */
 
 #ifdef C_MP_TX
 	unsigned bulk_split:1;
-- 
1.6.2.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
