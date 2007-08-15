From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/8] musb_hdrc: Search and replace MGC_S_XXX with
	MUSB_XXX_SHIFT
Date: Wed, 15 Aug 2007 07:21:40 -0700
Message-ID: <1187187715940-git-send-email-tony@atomide.com>
References: <11871877051923-git-send-email-tony@atomide.com>
	<11871877071348-git-send-email-tony@atomide.com>
	<1187187711983-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <1187187711983-git-send-email-tony@atomide.com>
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

Search and replace MGC_S_XXX with MUSB_XXX_SHIFT

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/davinci.c   |    2 +-
 drivers/usb/musb/musbhdrc.h  |    6 +++---
 drivers/usb/musb/musbhsdma.c |   34 +++++++++++++++++-----------------
 drivers/usb/musb/plat_uds.c  |   12 ++++++------
 4 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/usb/musb/davinci.c b/drivers/usb/musb/davinci.c
index a7f04a7..315c06c 100644
--- a/drivers/usb/musb/davinci.c
+++ b/drivers/usb/musb/davinci.c
@@ -445,7 +445,7 @@ int musb_platform_exit(struct musb *musb)
 				break;
 			if ((devctl & MUSB_DEVCTL_VBUS) != warn) {
 				warn = devctl & MUSB_DEVCTL_VBUS;
-				DBG(1, "VBUS %d\n", warn >> MGC_S_DEVCTL_VBUS);
+				DBG(1, "VBUS %d\n", warn >> MUSB_DEVCTL_VBUS_SHIFT);
 			}
 			msleep(1000);
 			maxdelay--;
diff --git a/drivers/usb/musb/musbhdrc.h b/drivers/usb/musb/musbhdrc.h
index b1601a8..d26910f 100644
--- a/drivers/usb/musb/musbhdrc.h
+++ b/drivers/usb/musb/musbhdrc.h
@@ -164,7 +164,7 @@
 #define MUSB_DEVCTL_FSDEV      0x40
 #define MUSB_DEVCTL_LSDEV      0x20
 #define MUSB_DEVCTL_VBUS       0x18
-#define MGC_S_DEVCTL_VBUS       3
+#define MUSB_DEVCTL_VBUS_SHIFT	3
 #define MUSB_DEVCTL_HM         0x04
 #define MUSB_DEVCTL_HR         0x02
 #define MUSB_DEVCTL_SESSION    0x01
@@ -219,12 +219,12 @@
 
 /* TxType/RxType */
 #define MUSB_TYPE_SPEED	0xc0
-#define MGC_S_TYPE_SPEED	6
+#define MUSB_TYPE_SPEED_SHIFT	6
 #define MGC_TYPE_SPEED_HIGH	1
 #define MGC_TYPE_SPEED_FULL	2
 #define MGC_TYPE_SPEED_LOW	3
 #define MUSB_TYPE_PROTO	0x30	/* implicitly zero for ep0 */
-#define MGC_S_TYPE_PROTO	4
+#define MUSB_TYPE_PROTO_SHIFT	4
 #define MUSB_TYPE_REMOTE_END	0xf	/* implicitly zero for ep0 */
 
 /* CONFIGDATA */
diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
index d25ae87..5292e2d 100644
--- a/drivers/usb/musb/musbhsdma.c
+++ b/drivers/usb/musb/musbhsdma.c
@@ -54,14 +54,14 @@
 		(MGC_O_HSDMA_BASE + (_bChannel << 4) + _bOffset)
 
 /* control register (16-bit): */
-#define MGC_S_HSDMA_ENABLE		0
-#define MGC_S_HSDMA_TRANSMIT		1
-#define MGC_S_HSDMA_MODE1		2
-#define MGC_S_HSDMA_IRQENABLE		3
-#define MGC_S_HSDMA_ENDPOINT		4
-#define MGC_S_HSDMA_BUSERROR		8
-#define MGC_S_HSDMA_BURSTMODE		9
-#define MUSB_HSDMA_BURSTMODE		(3 << MGC_S_HSDMA_BURSTMODE)
+#define MUSB_HSDMA_ENABLE_SHIFT		0
+#define MUSB_HSDMA_TRANSMIT_SHIFT		1
+#define MUSB_HSDMA_MODE1_SHIFT		2
+#define MUSB_HSDMA_IRQENABLE_SHIFT		3
+#define MUSB_HSDMA_ENDPOINT_SHIFT		4
+#define MUSB_HSDMA_BUSERROR_SHIFT		8
+#define MUSB_HSDMA_BURSTMODE_SHIFT		9
+#define MUSB_HSDMA_BURSTMODE		(3 << MUSB_HSDMA_BURSTMODE_SHIFT)
 #define MGC_HSDMA_BURSTMODE_UNSPEC	0
 #define MGC_HSDMA_BURSTMODE_INCR4	1
 #define MGC_HSDMA_BURSTMODE_INCR8	2
@@ -185,26 +185,26 @@ static void configure_channel(struct dma_channel *pChannel,
 	    pChannel, packet_sz, dma_addr, dwLength, mode);
 
 	if (mode) {
-		wCsr |= 1 << MGC_S_HSDMA_MODE1;
+		wCsr |= 1 << MUSB_HSDMA_MODE1_SHIFT;
 		if (dwLength < packet_sz) {
 			return FALSE;
 		}
 		if (packet_sz >= 64) {
 			wCsr |=
-			    MGC_HSDMA_BURSTMODE_INCR16 << MGC_S_HSDMA_BURSTMODE;
+			    MGC_HSDMA_BURSTMODE_INCR16 << MUSB_HSDMA_BURSTMODE_SHIFT;
 		} else if (packet_sz >= 32) {
 			wCsr |=
-			    MGC_HSDMA_BURSTMODE_INCR8 << MGC_S_HSDMA_BURSTMODE;
+			    MGC_HSDMA_BURSTMODE_INCR8 << MUSB_HSDMA_BURSTMODE_SHIFT;
 		} else if (packet_sz >= 16) {
 			wCsr |=
-			    MGC_HSDMA_BURSTMODE_INCR4 << MGC_S_HSDMA_BURSTMODE;
+			    MGC_HSDMA_BURSTMODE_INCR4 << MUSB_HSDMA_BURSTMODE_SHIFT;
 		}
 	}
 
-	wCsr |= (pImplChannel->epnum << MGC_S_HSDMA_ENDPOINT)
-		| (1 << MGC_S_HSDMA_ENABLE)
-		| (1 << MGC_S_HSDMA_IRQENABLE)
-		| (pImplChannel->bTransmit ? (1 << MGC_S_HSDMA_TRANSMIT) : 0);
+	wCsr |= (pImplChannel->epnum << MUSB_HSDMA_ENDPOINT_SHIFT)
+		| (1 << MUSB_HSDMA_ENABLE_SHIFT)
+		| (1 << MUSB_HSDMA_IRQENABLE_SHIFT)
+		| (pImplChannel->bTransmit ? (1 << MUSB_HSDMA_TRANSMIT_SHIFT) : 0);
 
 	/* address/count */
 	musb_writel(mbase,
@@ -321,7 +321,7 @@ static irqreturn_t dma_controller_irq(int irq, void *private_data)
 				       MGC_HSDMA_CHANNEL_OFFSET(bChannel,
 							MGC_O_HSDMA_CONTROL));
 
-			if (wCsr & (1 << MGC_S_HSDMA_BUSERROR)) {
+			if (wCsr & (1 << MUSB_HSDMA_BUSERROR_SHIFT)) {
 				pImplChannel->Channel.status =
 				    MGC_DMA_STATUS_BUS_ABORT;
 			} else {
diff --git a/drivers/usb/musb/plat_uds.c b/drivers/usb/musb/plat_uds.c
index 6e44909..7b516ad 100644
--- a/drivers/usb/musb/plat_uds.c
+++ b/drivers/usb/musb/plat_uds.c
@@ -435,7 +435,7 @@ static irqreturn_t musb_stage0_irq(struct musb * musb, u8 bIntrUSB,
 				 * not get a disconnect irq...
 				 */
 				if ((devctl & MUSB_DEVCTL_VBUS)
-						!= (3 << MGC_S_DEVCTL_VBUS)) {
+						!= (3 << MUSB_DEVCTL_VBUS_SHIFT)) {
 					musb->int_usb |= MUSB_INTR_DISCONNECT;
 					musb->int_usb &= ~MUSB_INTR_SUSPEND;
 					break;
@@ -524,13 +524,13 @@ static irqreturn_t musb_stage0_irq(struct musb * musb, u8 bIntrUSB,
 				devctl,
 				({ char *s;
 				switch (devctl & MUSB_DEVCTL_VBUS) {
-				case 0 << MGC_S_DEVCTL_VBUS:
+				case 0 << MUSB_DEVCTL_VBUS_SHIFT:
 					s = "<SessEnd"; break;
-				case 1 << MGC_S_DEVCTL_VBUS:
+				case 1 << MUSB_DEVCTL_VBUS_SHIFT:
 					s = "<AValid"; break;
-				case 2 << MGC_S_DEVCTL_VBUS:
+				case 2 << MUSB_DEVCTL_VBUS_SHIFT:
 					s = "<VBusValid"; break;
-				//case 3 << MGC_S_DEVCTL_VBUS:
+				//case 3 << MUSB_DEVCTL_VBUS_SHIFT:
 				default:
 					s = "VALID"; break;
 				}; s; }),
@@ -589,7 +589,7 @@ static irqreturn_t musb_stage0_irq(struct musb * musb, u8 bIntrUSB,
 			break;
 		default:
 			if ((devctl & MUSB_DEVCTL_VBUS)
-					== (3 << MGC_S_DEVCTL_VBUS)) {
+					== (3 << MUSB_DEVCTL_VBUS_SHIFT)) {
 				musb->xceiv.state = OTG_STATE_A_HOST;
 				hcd->self.is_b_host = 0;
 			}
-- 
1.5.2.3
