From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 47/52] musb_hdrc: Search and replace bRecip with recip
Date: Mon, 13 Aug 2007 06:49:22 -0700
Message-ID: <11870130932989-git-send-email-tony@atomide.com>
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
	<11870130913983-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11870130913983-git-send-email-tony@atomide.com>
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

Search and replace bRecip with recip

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/g_ep0.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

--- a/drivers/usb/musb/g_ep0.c
+++ b/drivers/usb/musb/g_ep0.c
@@ -77,11 +77,11 @@ static int service_tx_status_request(
 	void __iomem	*mbase = musb->mregs;
 	int handled = 1;
 	u8 result[2], epnum = 0;
-	const u8 bRecip = ctrlrequest->bRequestType & USB_RECIP_MASK;
+	const u8 recip = ctrlrequest->bRequestType & USB_RECIP_MASK;
 
 	result[1] = 0;
 
-	switch (bRecip) {
+	switch (recip) {
 	case USB_RECIP_DEVICE:
 		result[0] = musb->is_self_powered << USB_DEVICE_SELF_POWERED;
 		result[0] |= musb->may_wakeup << USB_DEVICE_REMOTE_WAKEUP;
@@ -231,7 +231,7 @@ __acquires(musb->lock)
 {
 	int handled = -EINVAL;
 	void __iomem *mbase = musb->mregs;
-	const u8 bRecip = ctrlrequest->bRequestType & USB_RECIP_MASK;
+	const u8 recip = ctrlrequest->bRequestType & USB_RECIP_MASK;
 
 	/* the gadget driver handles everything except what we MUST handle */
 	if ((ctrlrequest->bRequestType & USB_TYPE_MASK)
@@ -245,7 +245,7 @@ __acquires(musb->lock)
 			break;
 
 		case USB_REQ_CLEAR_FEATURE:
-			switch (bRecip) {
+			switch (recip) {
 			case USB_RECIP_DEVICE:
 				if (ctrlrequest->wValue
 						!= USB_DEVICE_REMOTE_WAKEUP)
@@ -289,7 +289,7 @@ __acquires(musb->lock)
 			break;
 
 		case USB_REQ_SET_FEATURE:
-			switch (bRecip) {
+			switch (recip) {
 			case USB_RECIP_DEVICE:
 				handled = 1;
 				switch (ctrlrequest->wValue) {
-- 
1.5.2.3
