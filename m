From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 45/52] musb_hdrc: Search and replace bResult with result
Date: Mon, 13 Aug 2007 06:49:20 -0700
Message-ID: <11870130891386-git-send-email-tony@atomide.com>
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
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <11870130862981-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Search and replace bResult with result

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/g_ep0.c |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

--- a/drivers/usb/musb/g_ep0.c
+++ b/drivers/usb/musb/g_ep0.c
@@ -76,29 +76,29 @@ static int service_tx_status_request(
 {
 	void __iomem	*mbase = musb->mregs;
 	int handled = 1;
-	u8 bResult[2], epnum = 0;
+	u8 result[2], epnum = 0;
 	const u8 bRecip = ctrlrequest->bRequestType & USB_RECIP_MASK;
 
-	bResult[1] = 0;
+	result[1] = 0;
 
 	switch (bRecip) {
 	case USB_RECIP_DEVICE:
-		bResult[0] = musb->is_self_powered << USB_DEVICE_SELF_POWERED;
-		bResult[0] |= musb->may_wakeup << USB_DEVICE_REMOTE_WAKEUP;
+		result[0] = musb->is_self_powered << USB_DEVICE_SELF_POWERED;
+		result[0] |= musb->may_wakeup << USB_DEVICE_REMOTE_WAKEUP;
 #ifdef CONFIG_USB_MUSB_OTG
 		if (musb->g.is_otg) {
-			bResult[0] |= musb->g.b_hnp_enable
+			result[0] |= musb->g.b_hnp_enable
 				<< USB_DEVICE_B_HNP_ENABLE;
-			bResult[0] |= musb->g.a_alt_hnp_support
+			result[0] |= musb->g.a_alt_hnp_support
 				<< USB_DEVICE_A_ALT_HNP_SUPPORT;
-			bResult[0] |= musb->g.a_hnp_support
+			result[0] |= musb->g.a_hnp_support
 				<< USB_DEVICE_A_HNP_SUPPORT;
 		}
 #endif
 		break;
 
 	case USB_RECIP_INTERFACE:
-		bResult[0] = 0;
+		result[0] = 0;
 		break;
 
 	case USB_RECIP_ENDPOINT: {
@@ -109,7 +109,7 @@ static int service_tx_status_request(
 
 		epnum = (u8) ctrlrequest->wIndex;
 		if (!epnum) {
-			bResult[0] = 0;
+			result[0] = 0;
 			break;
 		}
 
@@ -136,7 +136,7 @@ static int service_tx_status_request(
 						& MGC_M_RXCSR_P_SENDSTALL;
 		musb_ep_select(mbase, 0);
 
-		bResult[0] = tmp ? 1 : 0;
+		result[0] = tmp ? 1 : 0;
 		} break;
 
 	default:
@@ -151,7 +151,7 @@ static int service_tx_status_request(
 
 		if (len > 2)
 			len = 2;
-		musb_write_fifo(&musb->endpoints[0], len, bResult);
+		musb_write_fifo(&musb->endpoints[0], len, result);
 	}
 
 	return handled;
-- 
1.5.2.3
