From: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/2] MUSB: fix bug - since 2.6.24 urb API changed, giveback function return wrong status
Date: Sat, 17 May 2008 19:01:20 +0800
Message-ID: <1211022081-27298-2-git-send-email-cooloney@kernel.org>
References: <1211022081-27298-1-git-send-email-cooloney@kernel.org>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1211022081-27298-1-git-send-email-cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org, david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

When MUSB got STALL, but reported "short read trasfer"
usb-storage: Command MODE_SENSE (6 bytes)
usb-storage:  1a 00 3f 00 c0 00
usb-storage: Bulk Command S 0x43425355 T 0x18 L 192 F 128 Trg 0 LUN 0 CL 6
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_sglist: xfer 192 bytes, 1 entries
usb-storage: Status code -121; transferred 0/192
usb-storage: -- short read transfer
usb-storage: Bulk data transfer result 0x1
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 0/13
usb-storage: -- short transfer
usb-storage: Received 0-length CSW; retrying...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 0/13
usb-storage: -- short transfer
usb-storage: Bulk status result = 1
usb-storage: -- transport indicates error, resetting
usb-storage: storage_pre_reset


The right message is:

usb-storage: Command MODE_SENSE (6 bytes)
usb-storage:  1a 00 3f 00 c0 00
usb-storage: Bulk Command S 0x43425355 T 0x6 L 192 F 128 Trg 0 LUN 0 CL 6
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_sglist: xfer 192 bytes, 1 entries
usb-storage: Status code -121; transferred 4/192
usb-storage: -- short read transfer
usb-storage: Bulk data transfer result 0x1
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code -32; transferred 0/13
usb-storage: clearing endpoint halt for pipe 0xc0010280
usb-storage: usb_stor_control_msg: rq=01 rqtype=02 value=0000 index=82 len=0
usb-storage: usb_stor_clear_halt: result = 0
usb-storage: Attempting to get CSW (2nd try)...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete

Signed-off-by: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/usb/musb/musb_host.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 3d4fc3e..535922d 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -422,7 +422,11 @@ musb_advance_schedule(struct musb *musb, struct urb *urb,
 		qh = hw_ep->in_qh;
 	else
 		qh = hw_ep->out_qh;
-	qh = musb_giveback(qh, urb, 0);
+
+	if (urb->status == -EINPROGRESS)
+		qh = musb_giveback(qh, urb, 0);
+	else
+		qh = musb_giveback(qh, urb, urb->status);
 
 	if (qh && qh->is_ready && !list_empty(&qh->hep->urb_list)) {
 		DBG(4, "... next ep%d %cX urb %p\n",
-- 
1.5.5

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
