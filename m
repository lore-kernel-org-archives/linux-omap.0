From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 18/36] musb_hdrc: Search and replace pFifoDest with fifo_dest
Date: Thu, 16 Aug 2007 02:40:41 -0700
Message-ID: <1187257301587-git-send-email-tony@atomide.com>
References: <11872572591844-git-send-email-tony@atomide.com>
	<11872572612810-git-send-email-tony@atomide.com>
	<11872572643880-git-send-email-tony@atomide.com>
	<11872572672740-git-send-email-tony@atomide.com>
	<11872572693807-git-send-email-tony@atomide.com>
	<11872572713057-git-send-email-tony@atomide.com>
	<11872572743878-git-send-email-tony@atomide.com>
	<11872572762670-git-send-email-tony@atomide.com>
	<1187257278289-git-send-email-tony@atomide.com>
	<11872572803477-git-send-email-tony@atomide.com>
	<1187257282941-git-send-email-tony@atomide.com>
	<11872572842479-git-send-email-tony@atomide.com>
	<11872572872790-git-send-email-tony@atomide.com>
	<11872572893163-git-send-email-tony@atomide.com>
	<1187257291525-git-send-email-tony@atomide.com>
	<1187257294890-git-send-email-tony@atomide.com>
	<11872572962771-git-send-email-tony@atomide.com>
	<11872572981150-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11872572981150-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Search and replace pFifoDest with fifo_dest

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/musb_host.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 5268d9b..2607860 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -946,7 +946,7 @@ static int musb_h_ep0_continue(struct musb *musb,
 				u16 len, struct urb *urb)
 {
 	int			 bMore = FALSE;
-	u8 *pFifoDest = NULL;
+	u8 *fifo_dest = NULL;
 	u16 fifo_count = 0;
 	struct musb_hw_ep	*hw_ep = musb->control_ep;
 	struct musb_qh		*qh = hw_ep->in_qh;
@@ -954,13 +954,13 @@ static int musb_h_ep0_continue(struct musb *musb,
 
 	switch (musb->ep0_stage) {
 	case MGC_END0_IN:
-		pFifoDest = urb->transfer_buffer + urb->actual_length;
+		fifo_dest = urb->transfer_buffer + urb->actual_length;
 		fifo_count = min(len, ((u16) (urb->transfer_buffer_length
 					- urb->actual_length)));
 		if (fifo_count < len)
 			urb->status = -EOVERFLOW;
 
-		musb_read_fifo(hw_ep, fifo_count, pFifoDest);
+		musb_read_fifo(hw_ep, fifo_count, fifo_dest);
 
 		urb->actual_length += fifo_count;
 		if (len < qh->maxpacket) {
@@ -994,11 +994,11 @@ static int musb_h_ep0_continue(struct musb *musb,
 				- urb->actual_length)));
 
 		if (fifo_count) {
-			pFifoDest = (u8 *) (urb->transfer_buffer
+			fifo_dest = (u8 *) (urb->transfer_buffer
 					+ urb->actual_length);
 			DBG(3, "Sending %d bytes to %p\n",
-					fifo_count, pFifoDest);
-			musb_write_fifo(hw_ep, fifo_count, pFifoDest);
+					fifo_count, fifo_dest);
+			musb_write_fifo(hw_ep, fifo_count, fifo_dest);
 
 			urb->actual_length += fifo_count;
 			bMore = TRUE;
-- 
1.5.2.3
