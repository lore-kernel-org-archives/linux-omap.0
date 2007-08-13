From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 14/52] musb_hdrc: Search and replace bEndCount with
	nr_endpoints
Date: Mon, 13 Aug 2007 06:48:49 -0700
Message-ID: <11870130023665-git-send-email-tony@atomide.com>
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
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1187013000811-git-send-email-tony@atomide.com>
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

Search and replace bEndCount with nr_endpoints

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/musb_gadget.c |    4 ++--
 drivers/usb/musb/musb_host.c   |    2 +-
 drivers/usb/musb/musb_procfs.c |    4 ++--
 drivers/usb/musb/musbdefs.h    |    2 +-
 drivers/usb/musb/plat_uds.c    |   10 +++++-----
 5 files changed, 11 insertions(+), 11 deletions(-)

--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1601,7 +1601,7 @@ static inline void __init musb_g_init_endpoints(struct musb *musb)
 	INIT_LIST_HEAD(&(musb->g.ep_list));
 
 	for (bEnd = 0, hw_ep = musb->endpoints;
-			bEnd < musb->bEndCount;
+			bEnd < musb->nr_endpoints;
 			bEnd++, hw_ep++) {
 		if (hw_ep->bIsSharedFifo /* || !bEnd */) {
 			init_peripheral_ep(musb, &hw_ep->ep_in, bEnd, 0);
@@ -1797,7 +1797,7 @@ stop_activity(struct musb *musb, struct usb_gadget_driver *driver)
 	 */
 	if (driver) {
 		for (i = 0, hw_ep = musb->endpoints;
-				i < musb->bEndCount;
+				i < musb->nr_endpoints;
 				i++, hw_ep++) {
 			MGC_SelectEnd(musb->mregs, i);
 			if (hw_ep->bIsSharedFifo /* || !bEnd */) {
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -1706,7 +1706,7 @@ static int musb_schedule(
 	wBestDiff = 4096;
 	nBestEnd = -1;
 
-	for (nEnd = 1; nEnd < musb->bEndCount; nEnd++) {
+	for (nEnd = 1; nEnd < musb->nr_endpoints; nEnd++) {
 		int	diff;
 
 		if (musb->periodic[nEnd])
--- a/drivers/usb/musb/musb_procfs.c
+++ b/drivers/usb/musb/musb_procfs.c
@@ -528,7 +528,7 @@ static int dump_header_stats(struct musb *musb, char *buffer)
 #endif
 			", debug=%d [eps=%d]\n",
 		debug,
-		musb->bEndCount);
+		musb->nr_endpoints);
 	if (code <= 0)
 		goto done;
 	count += code;
@@ -802,7 +802,7 @@ static int musb_proc_read(char *page, char **start,
 
 	/* generate the report for the end points */
 	// REVISIT ... not unless something's connected!
-	for (bEnd = 0; count >= 0 && bEnd < musb->bEndCount;
+	for (bEnd = 0; count >= 0 && bEnd < musb->nr_endpoints;
 			bEnd++) {
 		code = dump_end_info(musb, bEnd, buffer, count);
 		if (code > 0) {
--- a/drivers/usb/musb/musbdefs.h
+++ b/drivers/usb/musb/musbdefs.h
@@ -403,7 +403,7 @@ struct musb {
 #define VBUSERR_RETRY_COUNT	3
 	u16			vbuserr_retry;
 	u16 wEndMask;
-	u8 bEndCount;
+	u8 nr_endpoints;
 
 	u8 board_mode;		/* enum musb_mode */
 	int			(*board_set_power)(int state);
--- a/drivers/usb/musb/plat_uds.c
+++ b/drivers/usb/musb/plat_uds.c
@@ -671,7 +671,7 @@ static irqreturn_t musb_stage2_irq(struct musb * musb, u8 bIntrUSB,
 		/* start any periodic Tx transfers waiting for current frame */
 		wFrame = musb_readw(mbase, MGC_O_HDRC_FRAME);
 		ep = musb->endpoints;
-		for (bEnd = 1; (bEnd < musb->bEndCount)
+		for (bEnd = 1; (bEnd < musb->nr_endpoints)
 					&& (musb->wEndMask >= (1 << bEnd));
 				bEnd++, ep++) {
 			// FIXME handle framecounter wraps (12 bits)
@@ -1153,7 +1153,7 @@ static int __init ep_config_from_table(struct musb *musb)
 			return -EINVAL;
 		}
 		epn++;
-		musb->bEndCount = max(epn, musb->bEndCount);
+		musb->nr_endpoints = max(epn, musb->nr_endpoints);
 	}
 
 	printk(KERN_DEBUG "%s: %d/%d max ep, %d/%d memory\n",
@@ -1196,7 +1196,7 @@ static int __init ep_config_from_hw(struct musb *musb)
 			/* 0's returned when no more endpoints */
 			break;
 		}
-		musb->bEndCount++;
+		musb->nr_endpoints++;
 		musb->wEndMask |= (1 << bEnd);
 
 		hw_ep->wMaxPacketSizeTx = 1 << (reg & 0x0f);
@@ -1338,7 +1338,7 @@ static int __init musb_core_init(u16 wType, struct musb *musb)
 	musb->endpoints[0].wMaxPacketSizeRx = MGC_END0_FIFOSIZE;
 
 	/* discover endpoint configuration */
-	musb->bEndCount = 1;
+	musb->nr_endpoints = 1;
 	musb->wEndMask = 1;
 
 	if (reg & MGC_M_CONFIGDATA_DYNFIFO) {
@@ -1361,7 +1361,7 @@ static int __init musb_core_init(u16 wType, struct musb *musb)
 		return status;
 
 	/* finish init, and print endpoint config */
-	for (i = 0; i < musb->bEndCount; i++) {
+	for (i = 0; i < musb->nr_endpoints; i++) {
 		struct musb_hw_ep	*hw_ep = musb->endpoints + i;
 
 		hw_ep->fifo = MUSB_FIFO_OFFSET(i) + mbase;
-- 
1.5.2.3
