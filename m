From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 20/36] musb_hdrc: Search and replace bIsochError with iso_err
Date: Thu, 16 Aug 2007 02:40:43 -0700
Message-ID: <11872573062287-git-send-email-tony@atomide.com>
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
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1187257303715-git-send-email-tony@atomide.com>
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

Search and replace bIsochError with iso_err

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/musb_host.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 2607860..58499ee 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -467,7 +467,7 @@ static inline u16 musb_h_flush_rxfifo(struct musb_hw_ep *hw_ep, u16 csr)
  * PIO RX for a packet (or part of it).
  */
 static u8 musb_host_packet_rx(struct musb *musb, struct urb *urb,
-		u8 epnum, u8 bIsochError)
+		u8 epnum, u8 iso_err)
 {
 	u16 rx_count;
 	u8 *buf;
@@ -492,7 +492,7 @@ static u8 musb_host_packet_rx(struct musb *musb, struct urb *urb,
 		int					status = 0;
 		struct usb_iso_packet_descriptor	*d;
 
-		if (bIsochError) {
+		if (iso_err) {
 			status = -EILSEQ;
 			urb->error_count++;
 		}
@@ -1387,7 +1387,7 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 	void __iomem		*mbase = musb->mregs;
 	int			pipe;
 	u16			rx_csr, wVal;
-	u8			bIsochError = FALSE;
+	u8			iso_err = FALSE;
 	u8			done = FALSE;
 	u32			status;
 	struct dma_channel	*dma;
@@ -1452,7 +1452,7 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 		} else {
 			DBG(4, "RX end %d ISO data error\n", epnum);
 			/* packet error reported later */
-			bIsochError = TRUE;
+			iso_err = TRUE;
 		}
 	}
 
@@ -1634,7 +1634,7 @@ void musb_host_rx(struct musb *musb, u8 epnum)
 
 		if (!dma) {
 			done = musb_host_packet_rx(musb, urb,
-					epnum, bIsochError);
+					epnum, iso_err);
 			DBG(6, "read %spacket\n", done ? "last " : "");
 		}
 	}
-- 
1.5.2.3
