From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/8] musb_hdrc: Search and replace MGC_END0_FIFOSIZE with
	MUSB_EP0_FIFOSIZE, remove MGC_MAX_USB_ENDS
Date: Wed, 15 Aug 2007 07:21:41 -0700
Message-ID: <11871877193281-git-send-email-tony@atomide.com>
References: <11871877051923-git-send-email-tony@atomide.com>
	<11871877071348-git-send-email-tony@atomide.com>
	<1187187711983-git-send-email-tony@atomide.com>
	<1187187715940-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1187187715940-git-send-email-tony@atomide.com>
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

Search and replace MGC_END0_FIFOSIZE with MUSB_EP0_FIFOSIZE, remove MGC_MAX_USB_ENDS

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/g_ep0.c    |    2 +-
 drivers/usb/musb/musbdefs.h |    2 +-
 drivers/usb/musb/musbhdrc.h |    4 +---
 drivers/usb/musb/plat_uds.c |    4 ++--
 4 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/musb/g_ep0.c b/drivers/usb/musb/g_ep0.c
index 1fa0cad..9585d00 100644
--- a/drivers/usb/musb/g_ep0.c
+++ b/drivers/usb/musb/g_ep0.c
@@ -497,7 +497,7 @@ static void ep0_txstate(struct musb *musb)
 
 	/* load the data */
 	pFifoSource = (u8 *) request->buf + request->actual;
-	fifo_count = min((unsigned) MGC_END0_FIFOSIZE,
+	fifo_count = min((unsigned) MUSB_EP0_FIFOSIZE,
 		request->length - request->actual);
 	musb_write_fifo(&musb->endpoints[0], fifo_count, pFifoSource);
 	request->actual += fifo_count;
diff --git a/drivers/usb/musb/musbdefs.h b/drivers/usb/musb/musbdefs.h
index 25dce14..5ce0505 100644
--- a/drivers/usb/musb/musbdefs.h
+++ b/drivers/usb/musb/musbdefs.h
@@ -175,7 +175,7 @@ static inline void musb_host_rx(struct musb *m, u8 e) {}
 #endif
 
 #ifndef MUSB_MAX_END0_PACKET
-#define MUSB_MAX_END0_PACKET ((u16)MGC_END0_FIFOSIZE)
+#define MUSB_MAX_END0_PACKET ((u16)MUSB_EP0_FIFOSIZE)
 #endif
 
 /* host side ep0 states */
diff --git a/drivers/usb/musb/musbhdrc.h b/drivers/usb/musb/musbhdrc.h
index d26910f..225fac9 100644
--- a/drivers/usb/musb/musbhdrc.h
+++ b/drivers/usb/musb/musbhdrc.h
@@ -38,9 +38,7 @@
  * HDRC-specific definitions
  */
 
-#define MGC_MAX_USB_ENDS       16
-
-#define MGC_END0_FIFOSIZE      64	/* this is non-configurable */
+#define MUSB_EP0_FIFOSIZE      64	/* this is non-configurable */
 
 /*
  *     MUSBMHDRC Register map
diff --git a/drivers/usb/musb/plat_uds.c b/drivers/usb/musb/plat_uds.c
index 7b516ad..71e89d8 100644
--- a/drivers/usb/musb/plat_uds.c
+++ b/drivers/usb/musb/plat_uds.c
@@ -1335,8 +1335,8 @@ static int __init musb_core_init(u16 wType, struct musb *musb)
 			musb_driver_name, type, aRevision, aDate);
 
 	/* configure ep0 */
-	musb->endpoints[0].max_packet_sz_tx = MGC_END0_FIFOSIZE;
-	musb->endpoints[0].max_packet_sz_rx = MGC_END0_FIFOSIZE;
+	musb->endpoints[0].max_packet_sz_tx = MUSB_EP0_FIFOSIZE;
+	musb->endpoints[0].max_packet_sz_rx = MUSB_EP0_FIFOSIZE;
 
 	/* discover endpoint configuration */
 	musb->nr_endpoints = 1;
-- 
1.5.2.3
