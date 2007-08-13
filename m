From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 44/52] musb_hdrc: Search and replace pControlRequest with
	ctrlrequest
Date: Mon, 13 Aug 2007 06:49:19 -0700
Message-ID: <11870130862981-git-send-email-tony@atomide.com>
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
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1187013084570-git-send-email-tony@atomide.com>
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

Search and replace pControlRequest with ctrlrequest

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/g_ep0.c |   50 +++++++++++++++++++++++-----------------------
 1 files changed, 25 insertions(+), 25 deletions(-)

--- a/drivers/usb/musb/g_ep0.c
+++ b/drivers/usb/musb/g_ep0.c
@@ -72,12 +72,12 @@ static char *decode_ep0stage(u8 stage)
  */
 static int service_tx_status_request(
 	struct musb *musb,
-	const struct usb_ctrlrequest *pControlRequest)
+	const struct usb_ctrlrequest *ctrlrequest)
 {
 	void __iomem	*mbase = musb->mregs;
 	int handled = 1;
 	u8 bResult[2], epnum = 0;
-	const u8 bRecip = pControlRequest->bRequestType & USB_RECIP_MASK;
+	const u8 bRecip = ctrlrequest->bRequestType & USB_RECIP_MASK;
 
 	bResult[1] = 0;
 
@@ -107,7 +107,7 @@ static int service_tx_status_request(
 		u16		tmp;
 		void __iomem	*regs;
 
-		epnum = (u8) pControlRequest->wIndex;
+		epnum = (u8) ctrlrequest->wIndex;
 		if (!epnum) {
 			bResult[0] = 0;
 			break;
@@ -147,7 +147,7 @@ static int service_tx_status_request(
 
 	/* fill up the fifo; caller updates csr0 */
 	if (handled > 0) {
-		u16	len = le16_to_cpu(pControlRequest->wLength);
+		u16	len = le16_to_cpu(ctrlrequest->wLength);
 
 		if (len > 2)
 			len = 2;
@@ -170,16 +170,16 @@ static int service_tx_status_request(
  */
 static int
 service_in_request(struct musb *musb,
-		const struct usb_ctrlrequest *pControlRequest)
+		const struct usb_ctrlrequest *ctrlrequest)
 {
 	int handled = 0;	/* not handled */
 
-	if ((pControlRequest->bRequestType & USB_TYPE_MASK)
+	if ((ctrlrequest->bRequestType & USB_TYPE_MASK)
 			== USB_TYPE_STANDARD) {
-		switch (pControlRequest->bRequest) {
+		switch (ctrlrequest->bRequest) {
 		case USB_REQ_GET_STATUS:
 			handled = service_tx_status_request(musb,
-					pControlRequest);
+					ctrlrequest);
 			break;
 
 		/* case USB_REQ_SYNC_FRAME: */
@@ -225,29 +225,29 @@ static inline void musb_try_b_hnp_enable(struct musb *musb)
  */
 static int
 service_zero_data_request(struct musb *musb,
-		struct usb_ctrlrequest *pControlRequest)
+		struct usb_ctrlrequest *ctrlrequest)
 __releases(musb->lock)
 __acquires(musb->lock)
 {
 	int handled = -EINVAL;
 	void __iomem *mbase = musb->mregs;
-	const u8 bRecip = pControlRequest->bRequestType & USB_RECIP_MASK;
+	const u8 bRecip = ctrlrequest->bRequestType & USB_RECIP_MASK;
 
 	/* the gadget driver handles everything except what we MUST handle */
-	if ((pControlRequest->bRequestType & USB_TYPE_MASK)
+	if ((ctrlrequest->bRequestType & USB_TYPE_MASK)
 			== USB_TYPE_STANDARD) {
-		switch (pControlRequest->bRequest) {
+		switch (ctrlrequest->bRequest) {
 		case USB_REQ_SET_ADDRESS:
 			/* change it after the status stage */
 			musb->bSetAddress = TRUE;
-			musb->address = (u8) (pControlRequest->wValue & 0x7f);
+			musb->address = (u8) (ctrlrequest->wValue & 0x7f);
 			handled = 1;
 			break;
 
 		case USB_REQ_CLEAR_FEATURE:
 			switch (bRecip) {
 			case USB_RECIP_DEVICE:
-				if (pControlRequest->wValue
+				if (ctrlrequest->wValue
 						!= USB_DEVICE_REMOTE_WAKEUP)
 					break;
 				musb->may_wakeup = 0;
@@ -256,16 +256,16 @@ __acquires(musb->lock)
 			case USB_RECIP_INTERFACE:
 				break;
 			case USB_RECIP_ENDPOINT:{
-				const u8 epnum = pControlRequest->wIndex & 0x0f;
+				const u8 epnum = ctrlrequest->wIndex & 0x0f;
 				struct musb_ep *musb_ep;
 
 				if (epnum == 0
 						|| epnum >= MUSB_C_NUM_EPS
-						|| pControlRequest->wValue
+						|| ctrlrequest->wValue
 							!= USB_ENDPOINT_HALT)
 					break;
 
-				if (pControlRequest->wIndex & USB_DIR_IN)
+				if (ctrlrequest->wIndex & USB_DIR_IN)
 					musb_ep = &musb->endpoints[epnum].ep_in;
 				else
 					musb_ep = &musb->endpoints[epnum].ep_out;
@@ -292,17 +292,17 @@ __acquires(musb->lock)
 			switch (bRecip) {
 			case USB_RECIP_DEVICE:
 				handled = 1;
-				switch (pControlRequest->wValue) {
+				switch (ctrlrequest->wValue) {
 				case USB_DEVICE_REMOTE_WAKEUP:
 					musb->may_wakeup = 1;
 					break;
 				case USB_DEVICE_TEST_MODE:
 					if (musb->g.speed != USB_SPEED_HIGH)
 						goto stall;
-					if (pControlRequest->wIndex & 0xff)
+					if (ctrlrequest->wIndex & 0xff)
 						goto stall;
 
-					switch (pControlRequest->wIndex >> 8) {
+					switch (ctrlrequest->wIndex >> 8) {
 					case 1:
 						pr_debug("TEST_J\n");
 						/* TEST_J */
@@ -365,7 +365,7 @@ stall:
 
 			case USB_RECIP_ENDPOINT:{
 				const u8		epnum =
-					pControlRequest->wIndex & 0x0f;
+					ctrlrequest->wIndex & 0x0f;
 				struct musb_ep		*musb_ep;
 				struct musb_hw_ep	*ep;
 				void __iomem		*regs;
@@ -374,13 +374,13 @@ stall:
 
 				if (epnum == 0
 						|| epnum >= MUSB_C_NUM_EPS
-						|| pControlRequest->wValue
+						|| ctrlrequest->wValue
 							!= USB_ENDPOINT_HALT)
 					break;
 
 				ep = musb->endpoints + epnum;
 				regs = ep->regs;
-				is_in = pControlRequest->wIndex & USB_DIR_IN;
+				is_in = ctrlrequest->wIndex & USB_DIR_IN;
 				if (is_in)
 					musb_ep = &ep->ep_in;
 				else
@@ -578,7 +578,7 @@ musb_read_setup(struct musb *musb, struct usb_ctrlrequest *req)
 
 static int
 forward_to_driver(struct musb *musb,
-		const struct usb_ctrlrequest *pControlRequest)
+		const struct usb_ctrlrequest *ctrlrequest)
 __releases(musb->lock)
 __acquires(musb->lock)
 {
@@ -586,7 +586,7 @@ __acquires(musb->lock)
 	if (!musb->gadget_driver)
 		return -EOPNOTSUPP;
 	spin_unlock(&musb->lock);
-	retval = musb->gadget_driver->setup(&musb->g, pControlRequest);
+	retval = musb->gadget_driver->setup(&musb->g, ctrlrequest);
 	spin_lock(&musb->lock);
 	return retval;
 }
-- 
1.5.2.3
