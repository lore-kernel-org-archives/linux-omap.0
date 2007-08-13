From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 46/52] musb_hdrc: Search and replace bSetAddress with
	set_address
Date: Mon, 13 Aug 2007 06:49:21 -0700
Message-ID: <11870130913983-git-send-email-tony@atomide.com>
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
	<11870130521115-git-send-email-tony@atomide.com>
	<11870130543254-git-send-email-tony@atomide.com>
	<11870130573814-git-send-email-tony@atomide.com>
	<1187013062890-git-send-email-tony@atomide.com>
	<11870130643220-git-send-email-tony@atomide.com>
	<1187013066263-git-send-email-tony@atomide.com>
	<11870130701028-git-send-email-tony@atomide.com>
	<1187013072449-git-send-email-tony@atomide.com>
	<11870130741506-git-send-email-tony@atomide.com>
	<11870130771666-git-send-email-tony@atomide.com>
	<11870130793168-git-send-email-tony@atomide.com>
	<11870130811602-git-send-email-tony@atomide.com>
	<1187013084570-git-send-email-tony@atomide.com>
	<11870130862981-git-send-email-tony@atomide.com>
	<11870130891386-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11870130891386-git-send-email-tony@atomide.com>
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

Search and replace bSetAddress with set_address

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/g_ep0.c    |    8 ++++----
 drivers/usb/musb/musbdefs.h |    2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

--- a/drivers/usb/musb/g_ep0.c
+++ b/drivers/usb/musb/g_ep0.c
@@ -239,7 +239,7 @@ __acquires(musb->lock)
 		switch (ctrlrequest->bRequest) {
 		case USB_REQ_SET_ADDRESS:
 			/* change it after the status stage */
-			musb->bSetAddress = TRUE;
+			musb->set_address = TRUE;
 			musb->address = (u8) (ctrlrequest->wValue & 0x7f);
 			handled = 1;
 			break;
@@ -559,7 +559,7 @@ musb_read_setup(struct musb *musb, struct usb_ctrlrequest *req)
 	 * the TX FIFO right away, and give the controller a moment
 	 * to switch modes...
 	 */
-	musb->bSetAddress = FALSE;
+	musb->set_address = FALSE;
 	musb->ackpend = MGC_M_CSR0_P_SVDRXPKTRDY;
 	if (req->wLength == 0) {
 		if (req->bRequestType & USB_DIR_IN)
@@ -661,8 +661,8 @@ irqreturn_t musb_g_ep0_irq(struct musb *musb)
 		 * we get 10 msec to receive this irq... until this
 		 * is done we won't see the next packet.
 		 */
-		if (musb->bSetAddress) {
-			musb->bSetAddress = FALSE;
+		if (musb->set_address) {
+			musb->set_address = FALSE;
 			musb_writeb(mbase, MGC_O_HDRC_FADDR, musb->address);
 		}
 
--- a/drivers/usb/musb/musbdefs.h
+++ b/drivers/usb/musb/musbdefs.h
@@ -437,7 +437,7 @@ struct musb {
 	unsigned		is_self_powered:1;
 	unsigned		is_bus_powered:1;
 
-	unsigned bSetAddress:1;
+	unsigned set_address:1;
 	unsigned test_mode:1;
 	unsigned softconnect:1;
 
-- 
1.5.2.3
