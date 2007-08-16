From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 24/36] musb_hdrc: Search and replace nEnd with epnum
Date: Thu, 16 Aug 2007 02:40:47 -0700
Message-ID: <11872573161558-git-send-email-tony@atomide.com>
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
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11872573133142-git-send-email-tony@atomide.com>
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

Search and replace nEnd with epnum

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/musb_gadget.c |    8 ++++----
 drivers/usb/musb/musb_host.c   |   10 +++++-----
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 5d15234..4d90717 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1331,8 +1331,8 @@ static void musb_gadget_fifo_flush(struct usb_ep *ep)
 {
 	struct musb_ep	*musb_ep = to_musb_ep(ep);
 	struct musb	*musb = musb_ep->musb;
-	u8		nEnd = musb_ep->current_epnum;
-	void __iomem	*epio = musb->endpoints[nEnd].regs;
+	u8		epnum = musb_ep->current_epnum;
+	void __iomem	*epio = musb->endpoints[epnum].regs;
 	void __iomem	*mbase;
 	unsigned long	flags;
 	u16		csr, int_txe;
@@ -1340,11 +1340,11 @@ static void musb_gadget_fifo_flush(struct usb_ep *ep)
 	mbase = musb->mregs;
 
 	spin_lock_irqsave(&musb->lock, flags);
-	musb_ep_select(mbase, (u8) nEnd);
+	musb_ep_select(mbase, (u8) epnum);
 
 	/* disable interrupts */
 	int_txe = musb_readw(mbase, MUSB_INTRTXE);
-	musb_writew(mbase, MUSB_INTRTXE, int_txe & ~(1 << nEnd));
+	musb_writew(mbase, MUSB_INTRTXE, int_txe & ~(1 << epnum));
 
 	if (musb_ep->is_in) {
 		csr = musb_readw(epio, MUSB_TXCSR);
diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 743284d..1f3ef7b 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -1661,7 +1661,7 @@ static int musb_schedule(
 {
 	int			idle;
 	int			best_diff;
-	int			best_end, nEnd;
+	int			best_end, epnum;
 	struct musb_hw_ep	*hw_ep = NULL;
 	struct list_head	*head = NULL;
 
@@ -1706,12 +1706,12 @@ static int musb_schedule(
 	best_diff = 4096;
 	best_end = -1;
 
-	for (nEnd = 1; nEnd < musb->nr_endpoints; nEnd++) {
+	for (epnum = 1; epnum < musb->nr_endpoints; epnum++) {
 		int	diff;
 
-		if (musb->periodic[nEnd])
+		if (musb->periodic[epnum])
 			continue;
-		hw_ep = &musb->endpoints[nEnd];
+		hw_ep = &musb->endpoints[epnum];
 		if (hw_ep == musb->bulk_ep)
 			continue;
 
@@ -1722,7 +1722,7 @@ static int musb_schedule(
 
 		if (diff > 0 && best_diff > diff) {
 			best_diff = diff;
-			best_end = nEnd;
+			best_end = epnum;
 		}
 	}
 	if (best_end < 0)
-- 
1.5.2.3
