From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 15/36] musb_hdrc: Search and replace nPipe with pipe
Date: Thu, 16 Aug 2007 02:40:38 -0700
Message-ID: <1187257294890-git-send-email-tony@atomide.com>
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
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1187257291525-git-send-email-tony@atomide.com>
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

Search and replace nPipe with pipe

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/musb_host.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index e821831..093edc1 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -175,8 +175,8 @@ musb_start_urb(struct musb *musb, int is_in, struct musb_qh *qh)
 	void __iomem		*mbase =  musb->mregs;
 	struct urb		*urb = next_urb(qh);
 	struct musb_hw_ep	*hw_ep = qh->hw_ep;
-	unsigned		nPipe = urb->pipe;
-	u8			address = usb_pipedevice(nPipe);
+	unsigned		pipe = urb->pipe;
+	u8			address = usb_pipedevice(pipe);
 	int			epnum = hw_ep->epnum;
 
 	/* initialize software qh state */
@@ -478,7 +478,7 @@ static u8 musb_host_packet_rx(struct musb *musb, struct urb *urb,
 	struct musb_hw_ep	*hw_ep = musb->endpoints + epnum;
 	void __iomem		*epio = hw_ep->regs;
 	struct musb_qh		*qh = hw_ep->in_qh;
-	int			nPipe = urb->pipe;
+	int			pipe = urb->pipe;
 	void			*buffer = urb->transfer_buffer;
 
 	// musb_ep_select(mbase, epnum);
@@ -488,7 +488,7 @@ static u8 musb_host_packet_rx(struct musb *musb, struct urb *urb,
 			urb->transfer_buffer_length);
 
 	/* unload FIFO */
-	if (usb_pipeisoc(nPipe)) {
+	if (usb_pipeisoc(pipe)) {
 		int					status = 0;
 		struct usb_iso_packet_descriptor	*d;
 
@@ -1164,7 +1164,7 @@ done:
 /* Service a Tx-Available or dma completion irq for the endpoint */
 void musb_host_tx(struct musb *musb, u8 epnum)
 {
-	int			nPipe;
+	int			pipe;
 	u8			done = FALSE;
 	u16			tx_csr;
 	size_t			wLength = 0;
@@ -1188,7 +1188,7 @@ void musb_host_tx(struct musb *musb, u8 epnum)
 		goto finish;
 	}
 
-	nPipe = urb->pipe;
+	pipe = urb->pipe;
 	dma = is_dma_capable() ? hw_ep->tx_channel : NULL;
 	DBG(4, "OUT/TX%d end, csr %04x%s\n", epnum, tx_csr,
 			dma ? ", dma" : "");
@@ -1258,14 +1258,14 @@ void musb_host_tx(struct musb *musb, u8 epnum)
 	}
 
 	/* REVISIT this looks wrong... */
-	if (!status || dma || usb_pipeisoc(nPipe)) {
+	if (!status || dma || usb_pipeisoc(pipe)) {
 		if (dma)
 			wLength = dma->actual_len;
 		else
 			wLength = qh->segsize;
 		qh->offset += wLength;
 
-		if (usb_pipeisoc(nPipe)) {
+		if (usb_pipeisoc(pipe)) {
 			struct usb_iso_packet_descriptor	*d;
 
 			d = urb->iso_frame_desc + qh->iso_idx;
@@ -1385,7 +1385,7 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 	struct musb_qh		*qh = hw_ep->in_qh;
 	size_t			xfer_len;
 	void __iomem		*mbase = musb->mregs;
-	int			nPipe;
+	int			pipe;
 	u16			rx_csr, wVal;
 	u8			bIsochError = FALSE;
 	u8			done = FALSE;
@@ -1412,7 +1412,7 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 		return;
 	}
 
-	nPipe = urb->pipe;
+	pipe = urb->pipe;
 
 	DBG(5, "<== hw %d rxcsr %04x, urb actual %d (+dma %zd)\n",
 		epnum, rx_csr, urb->actual_length,
-- 
1.5.2.3
