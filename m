From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 19/36] musb_hdrc: Search and replace pFifoSource with
	fifo_src
Date: Thu, 16 Aug 2007 02:40:42 -0700
Message-ID: <1187257303715-git-send-email-tony@atomide.com>
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
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1187257301587-git-send-email-tony@atomide.com>
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

Search and replace pFifoSource with fifo_src

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/g_ep0.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/musb/g_ep0.c b/drivers/usb/musb/g_ep0.c
index 59cc790..b78b711 100644
--- a/drivers/usb/musb/g_ep0.c
+++ b/drivers/usb/musb/g_ep0.c
@@ -487,7 +487,7 @@ static void ep0_txstate(struct musb *musb)
 	void __iomem		*regs = musb->control_ep->regs;
 	struct usb_request	*request = next_ep0_request(musb);
 	u16			csr = MUSB_CSR0_TXPKTRDY;
-	u8			*pFifoSource;
+	u8			*fifo_src;
 	u8			fifo_count;
 
 	if (!request) {
@@ -497,10 +497,10 @@ static void ep0_txstate(struct musb *musb)
 	}
 
 	/* load the data */
-	pFifoSource = (u8 *) request->buf + request->actual;
+	fifo_src = (u8 *) request->buf + request->actual;
 	fifo_count = min((unsigned) MUSB_EP0_FIFOSIZE,
 		request->length - request->actual);
-	musb_write_fifo(&musb->endpoints[0], fifo_count, pFifoSource);
+	musb_write_fifo(&musb->endpoints[0], fifo_count, fifo_src);
 	request->actual += fifo_count;
 
 	/* update the flags */
-- 
1.5.2.3
