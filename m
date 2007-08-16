From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 33/36] musb_hdrc: Search and replace bMore with more
Date: Thu, 16 Aug 2007 02:40:56 -0700
Message-ID: <11872573361440-git-send-email-tony@atomide.com>
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
	<1187257301587-git-send-email-tony@atomide.com>
	<1187257303715-git-send-email-tony@atomide.com>
	<11872573062287-git-send-email-tony@atomide.com>
	<11872573092269-git-send-email-tony@atomide.com>
	<1187257311394-git-send-email-tony@atomide.com>
	<11872573133142-git-send-email-tony@atomide.com>
	<11872573161558-git-send-email-tony@atomide.com>
	<1187257318333-git-send-email-tony@atomide.com>
	<11872573202855-git-send-email-tony@atomide.com>
	<11872573222937-git-send-email-tony@atomide.com>
	<1187257324463-git-send-email-tony@atomide.com>
	<11872573273963-git-send-email-tony@atomide.com>
	<1187257329166-git-send-email-tony@atomide.com>
	<118725733255-git-send-email-tony@atomide.com>
	<1187257334140-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1187257334140-git-send-email-tony@atomide.com>
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

Search and replace bMore with more

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/musb_host.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 68c7ca1..29fc80d 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -945,7 +945,7 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 static int musb_h_ep0_continue(struct musb *musb,
 				u16 len, struct urb *urb)
 {
-	int			 bMore = FALSE;
+	int			 more = FALSE;
 	u8 *fifo_dest = NULL;
 	u16 fifo_count = 0;
 	struct musb_hw_ep	*hw_ep = musb->control_ep;
@@ -969,7 +969,7 @@ static int musb_h_ep0_continue(struct musb *musb,
 			 */
 		} else if (urb->actual_length <
 				urb->transfer_buffer_length)
-			bMore = TRUE;
+			more = TRUE;
 		break;
 	case MGC_END0_START:
 		request = (struct usb_ctrlrequest *) urb->setup_packet;
@@ -980,12 +980,12 @@ static int musb_h_ep0_continue(struct musb *musb,
 		} else if (request->bRequestType & USB_DIR_IN) {
 			DBG(4, "start IN-DATA\n");
 			musb->ep0_stage = MGC_END0_IN;
-			bMore = TRUE;
+			more = TRUE;
 			break;
 		} else {
 			DBG(4, "start OUT-DATA\n");
 			musb->ep0_stage = MGC_END0_OUT;
-			bMore = TRUE;
+			more = TRUE;
 		}
 		/* FALLTHROUGH */
 	case MGC_END0_OUT:
@@ -1001,7 +1001,7 @@ static int musb_h_ep0_continue(struct musb *musb,
 			musb_write_fifo(hw_ep, fifo_count, fifo_dest);
 
 			urb->actual_length += fifo_count;
-			bMore = TRUE;
+			more = TRUE;
 		}
 		break;
 	default:
@@ -1009,7 +1009,7 @@ static int musb_h_ep0_continue(struct musb *musb,
 		break;
 	}
 
-	return bMore;
+	return more;
 }
 
 /*
-- 
1.5.2.3
