From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 31/52] musb_hdrc: Search and replace bAddress with address
Date: Mon, 13 Aug 2007 06:49:06 -0700
Message-ID: <11870130521115-git-send-email-tony@atomide.com>
References: musb <11870129672745-git-send-email-tony@atomide.com>
	<11870129702817-git-send-email-tony@atomide.com>
	<11870129721700-git-send-email-tony@atomide.com>
	<1187012975431-git-send-email-tony@atomide.com>
	<11870129782148-git-send-email-tony@atomide.com>
	<1187012980445-git-send-email-tony@atomide.com>
	<11870129834092-git-send-email-tony@atomide.com>
	<11870129861917-git-send-email-tony@atomide.com>
	<118701298833-git-send-email-tony@atomide.com>
	<11870129901657-git-send-email-tony@atomide.com>
	<11870129934099-git-send-email-tony@atomide.com>
	<1187012995338-git-send-email-tony@atomide.com>
	<1187012998290-git-send-email-tony@atomide.com>
	<1187013000811-git-send-email-tony@atomide.com>
	<11870130023665-git-send-email-tony@atomide.com>
	<11870130052666-git-send-email-tony@atomide.com>
	<1187013007355-git-send-email-tony@atomide.com>
	<11870130103320-git-send-email-tony@atomide.com>
	<11870130122117-git-send-email-tony@atomide.com>
	<11870130153038-git-send-email-tony@atomide.com>
	<11870130183634-git-send-email-tony@atomide.com>
	<11870130203742-git-send-email-tony@atomide.com>
	<1187013022688-git-send-email-tony@atomide.com>
	<1187013024836-git-send-email-tony@atomide.com>
	<11870130272865-git-send-email-tony@atomide.com>
	<1187013029823-git-send-email-tony@atomide.com>
	<11870130314189-git-send-email-tony@atomide.com>
	<11870130343298-git-send-email-tony@atomide.com>
	<11870130371106-git-send-email-tony@atomide.com>
	<11870130411622-git-send-email-tony@atomide.com>
	<1187013048432-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1187013048432-git-send-email-tony@atomide.com>
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

Search and replace bAddress with address

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/g_ep0.c       |    4 ++--
 drivers/usb/musb/musb_gadget.c |    2 +-
 drivers/usb/musb/musb_host.c   |    4 ++--
 drivers/usb/musb/musbdefs.h    |    2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

--- a/drivers/usb/musb/g_ep0.c
+++ b/drivers/usb/musb/g_ep0.c
@@ -240,7 +240,7 @@ __acquires(musb->lock)
 		case USB_REQ_SET_ADDRESS:
 			/* change it after the status stage */
 			musb->bSetAddress = TRUE;
-			musb->bAddress = (u8) (pControlRequest->wValue & 0x7f);
+			musb->address = (u8) (pControlRequest->wValue & 0x7f);
 			handled = 1;
 			break;
 
@@ -663,7 +663,7 @@ irqreturn_t musb_g_ep0_irq(struct musb *musb)
 		 */
 		if (musb->bSetAddress) {
 			musb->bSetAddress = FALSE;
-			musb_writeb(mbase, MGC_O_HDRC_FADDR, musb->bAddress);
+			musb_writeb(mbase, MGC_O_HDRC_FADDR, musb->address);
 		}
 
 		/* enter test mode if needed (exit by reset) */
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -2010,7 +2010,7 @@ __acquires(musb->lock)
 	musb->is_active = 1;
 	musb->is_suspended = 0;
 	MUSB_DEV_MODE(musb);
-	musb->bAddress = 0;
+	musb->address = 0;
 	musb->ep0_state = MGC_END0_STAGE_SETUP;
 
 	musb->may_wakeup = 0;
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -176,7 +176,7 @@ musb_start_urb(struct musb *musb, int is_in, struct musb_qh *qh)
 	struct urb		*urb = next_urb(qh);
 	struct musb_hw_ep	*hw_ep = qh->hw_ep;
 	unsigned		nPipe = urb->pipe;
-	u8			bAddress = usb_pipedevice(nPipe);
+	u8			address = usb_pipedevice(nPipe);
 	int			epnum = hw_ep->epnum;
 
 	/* initialize software qh state */
@@ -205,7 +205,7 @@ musb_start_urb(struct musb *musb, int is_in, struct musb_qh *qh)
 	}
 
 	DBG(4, "qh %p urb %p dev%d ep%d%s%s, hw_ep %d, %p/%d\n",
-			qh, urb, bAddress, qh->epnum,
+			qh, urb, address, qh->epnum,
 			is_in ? "in" : "out",
 			({char *s; switch (qh->type) {
 			case USB_ENDPOINT_XFER_CONTROL:	s = ""; break;
--- a/drivers/usb/musb/musbdefs.h
+++ b/drivers/usb/musb/musbdefs.h
@@ -442,7 +442,7 @@ struct musb {
 	unsigned softconnect:1;
 
 	enum musb_g_ep0_state	ep0_state;
-	u8			bAddress;
+	u8			address;
 	u8			bTestModeValue;
 	u16			ackpend;		/* ep0 */
 	struct usb_gadget	g;			/* the gadget */
-- 
1.5.2.3
