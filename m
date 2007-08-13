From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 27/52] musb_hdrc: Search and replace bIsMultipoint with
	is_multipoint
Date: Mon, 13 Aug 2007 06:49:02 -0700
Message-ID: <11870130343298-git-send-email-tony@atomide.com>
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
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11870130314189-git-send-email-tony@atomide.com>
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

Search and replace bIsMultipoint with is_multipoint

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/musb_host.c   |    8 ++++----
 drivers/usb/musb/musb_procfs.c |    2 +-
 drivers/usb/musb/musbdefs.h    |    2 +-
 drivers/usb/musb/plat_uds.c    |    4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -599,7 +599,7 @@ musb_rx_reinit(struct musb *musb, struct musb_qh *qh, struct musb_hw_ep *ep)
 	}
 
 	/* target addr and (for multipoint) hub addr/port */
-	if (musb->bIsMultipoint) {
+	if (musb->is_multipoint) {
 		musb_writeb(ep->target_regs, MGC_O_HDRC_RXFUNCADDR,
 			qh->addr_reg);
 		musb_writeb(ep->target_regs, MGC_O_HDRC_RXHUBADDR,
@@ -720,7 +720,7 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 		}
 
 		/* target addr and (for multipoint) hub addr/port */
-		if (musb->bIsMultipoint) {
+		if (musb->is_multipoint) {
 			musb_writeb(mbase,
 				MGC_BUSCTL_OFFSET(epnum, MGC_O_HDRC_TXFUNCADDR),
 				qh->addr_reg);
@@ -748,7 +748,7 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 			musb_writeb(epio, MGC_O_HDRC_TXINTERVAL, qh->intv_reg);
 		} else {
 			musb_writeb(epio, MGC_O_HDRC_NAKLIMIT0, qh->intv_reg);
-			if (musb->bIsMultipoint)
+			if (musb->is_multipoint)
 				musb_writeb(epio, MGC_O_HDRC_TYPE0,
 						qh->type_reg);
 		}
@@ -1850,7 +1850,7 @@ static int musb_urb_enqueue(
 	qh->intv_reg = interval;
 
 	/* precompute addressing for external hub/tt ports */
-	if (musb->bIsMultipoint) {
+	if (musb->is_multipoint) {
 		struct usb_device	*parent = urb->dev->parent;
 
 		if (parent != hcd->self.root_hub) {
--- a/drivers/usb/musb/musb_procfs.c
+++ b/drivers/usb/musb/musb_procfs.c
@@ -490,7 +490,7 @@ static int dump_header_stats(struct musb *musb, char *buffer)
 	*buffer = 0;
 	count = sprintf(buffer, "Status: %sHDRC, Mode=%s "
 				"(Power=%02x, DevCtl=%02x)\n",
-			(musb->bIsMultipoint ? "M" : ""), MUSB_MODE(musb),
+			(musb->is_multipoint ? "M" : ""), MUSB_MODE(musb),
 			musb_readb(mbase, MGC_O_HDRC_POWER),
 			musb_readb(mbase, MGC_O_HDRC_DEVCTL));
 	if (count <= 0)
--- a/drivers/usb/musb/musbdefs.h
+++ b/drivers/usb/musb/musbdefs.h
@@ -395,7 +395,7 @@ struct musb {
 	/* active means connected and not suspended */
 	unsigned		is_active:1;
 
-	unsigned bIsMultipoint:1;
+	unsigned is_multipoint:1;
 	unsigned is_host:1;
 	unsigned bIgnoreDisconnect:1;	/* during bus resets */
 
--- a/drivers/usb/musb/plat_uds.c
+++ b/drivers/usb/musb/plat_uds.c
@@ -1310,10 +1310,10 @@ static int __init musb_core_init(u16 wType, struct musb *musb)
 	aDate[0] = 0;
 #endif
 	if (MUSB_CONTROLLER_MHDRC == wType) {
-		musb->bIsMultipoint = 1;
+		musb->is_multipoint = 1;
 		type = "M";
 	} else {
-		musb->bIsMultipoint = 0;
+		musb->is_multipoint = 0;
 		type = "";
 #ifdef CONFIG_USB_MUSB_HDRC_HCD
 #ifndef	CONFIG_USB_OTG_BLACKLIST_HUB
-- 
1.5.2.3
