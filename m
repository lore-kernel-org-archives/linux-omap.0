From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5/36] musb_hdrc: Search and replace bIntrUSB with int_usb
Date: Thu, 16 Aug 2007 02:40:28 -0700
Message-ID: <11872572713057-git-send-email-tony@atomide.com>
References: <11872572591844-git-send-email-tony@atomide.com>
	<11872572612810-git-send-email-tony@atomide.com>
	<11872572643880-git-send-email-tony@atomide.com>
	<11872572672740-git-send-email-tony@atomide.com>
	<11872572693807-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11872572693807-git-send-email-tony@atomide.com>
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

Search and replace bIntrUSB with int_usb

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/plat_uds.c |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/musb/plat_uds.c b/drivers/usb/musb/plat_uds.c
index 94f451e..73a72c9 100644
--- a/drivers/usb/musb/plat_uds.c
+++ b/drivers/usb/musb/plat_uds.c
@@ -351,7 +351,7 @@ void musb_hnp_stop(struct musb *musb)
  * the order of the tests is specified in the manual
  *
  * @param musb instance pointer
- * @param bIntrUSB register contents
+ * @param int_usb register contents
  * @param devctl
  * @param power
  */
@@ -360,7 +360,7 @@ void musb_hnp_stop(struct musb *musb)
 		| MUSB_INTR_VBUSERROR | MUSB_INTR_CONNECT \
 		| MUSB_INTR_RESET )
 
-static irqreturn_t musb_stage0_irq(struct musb * musb, u8 bIntrUSB,
+static irqreturn_t musb_stage0_irq(struct musb * musb, u8 int_usb,
 				u8 devctl, u8 power)
 {
 	irqreturn_t handled = IRQ_NONE;
@@ -368,14 +368,14 @@ static irqreturn_t musb_stage0_irq(struct musb * musb, u8 bIntrUSB,
 	void __iomem *mbase = musb->mregs;
 #endif
 
-	DBG(3, "<== Power=%02x, DevCtl=%02x, bIntrUSB=0x%x\n", power, devctl,
-		bIntrUSB);
+	DBG(3, "<== Power=%02x, DevCtl=%02x, int_usb=0x%x\n", power, devctl,
+		int_usb);
 
 	/* in host mode, the peripheral may issue remote wakeup.
 	 * in peripheral mode, the host may resume the link.
 	 * spurious RESUME irqs happen too, paired with SUSPEND.
 	 */
-	if (bIntrUSB & MUSB_INTR_RESUME) {
+	if (int_usb & MUSB_INTR_RESUME) {
 		handled = IRQ_HANDLED;
 		DBG(3, "RESUME (%s)\n", otg_state_string(musb));
 
@@ -456,7 +456,7 @@ static irqreturn_t musb_stage0_irq(struct musb * musb, u8 bIntrUSB,
 
 #ifdef CONFIG_USB_MUSB_HDRC_HCD
 	/* see manual for the order of the tests */
-	if (bIntrUSB & MUSB_INTR_SESSREQ) {
+	if (int_usb & MUSB_INTR_SESSREQ) {
 		DBG(1, "SESSION_REQUEST (%s)\n", otg_state_string(musb));
 
 		/* IRQ arrives from ID pin sense or (later, if VBUS power
@@ -475,7 +475,7 @@ static irqreturn_t musb_stage0_irq(struct musb * musb, u8 bIntrUSB,
 		handled = IRQ_HANDLED;
 	}
 
-	if (bIntrUSB & MUSB_INTR_VBUSERROR) {
+	if (int_usb & MUSB_INTR_VBUSERROR) {
 		int	ignore = 0;
 
 		/* During connection as an A-Device, we may see a short
@@ -543,7 +543,7 @@ static irqreturn_t musb_stage0_irq(struct musb * musb, u8 bIntrUSB,
 		handled = IRQ_HANDLED;
 	}
 
-	if (bIntrUSB & MUSB_INTR_CONNECT) {
+	if (int_usb & MUSB_INTR_CONNECT) {
 		struct usb_hcd *hcd = musb_to_hcd(musb);
 
 		handled = IRQ_HANDLED;
@@ -603,7 +603,7 @@ static irqreturn_t musb_stage0_irq(struct musb * musb, u8 bIntrUSB,
 	/* mentor saves a bit: bus reset and babble share the same irq.
 	 * only host sees babble; only peripheral sees bus reset.
 	 */
-	if (bIntrUSB & MUSB_INTR_RESET) {
+	if (int_usb & MUSB_INTR_RESET) {
 		if (devctl & MUSB_DEVCTL_HM) {
 			/*
 			 * Looks like non-HS BABBLE can be ignored, but
@@ -638,11 +638,11 @@ static irqreturn_t musb_stage0_irq(struct musb * musb, u8 bIntrUSB,
  * the order of the tests is specified in the manual
  *
  * @param musb instance pointer
- * @param bIntrUSB register contents
+ * @param int_usb register contents
  * @param devctl
  * @param power
  */
-static irqreturn_t musb_stage2_irq(struct musb * musb, u8 bIntrUSB,
+static irqreturn_t musb_stage2_irq(struct musb * musb, u8 int_usb,
 				u8 devctl, u8 power)
 {
 	irqreturn_t handled = IRQ_NONE;
@@ -659,7 +659,7 @@ static irqreturn_t musb_stage2_irq(struct musb * musb, u8 bIntrUSB,
  * endpoints, relies on TX/RX interval registers, and isn't claimed
  * to support ISO transfers yet.
  */
-	if (bIntrUSB & MUSB_INTR_SOF) {
+	if (int_usb & MUSB_INTR_SOF) {
 		void __iomem *mbase = musb->mregs;
 		struct musb_hw_ep	*ep;
 		u8 epnum;
@@ -690,7 +690,7 @@ static irqreturn_t musb_stage2_irq(struct musb * musb, u8 bIntrUSB,
 	}
 #endif
 
-	if ((bIntrUSB & MUSB_INTR_DISCONNECT) && !musb->ignore_disconnect) {
+	if ((int_usb & MUSB_INTR_DISCONNECT) && !musb->ignore_disconnect) {
 		DBG(1, "DISCONNECT (%s) as %s, devctl %02x\n",
 				otg_state_string(musb),
 				MUSB_MODE(musb), devctl);
@@ -731,7 +731,7 @@ static irqreturn_t musb_stage2_irq(struct musb * musb, u8 bIntrUSB,
 		schedule_work(&musb->irq_work);
 	}
 
-	if (bIntrUSB & MUSB_INTR_SUSPEND) {
+	if (int_usb & MUSB_INTR_SUSPEND) {
 		DBG(1, "SUSPEND (%s) devctl %02x power %02x\n",
 				otg_state_string(musb), devctl, power);
 		handled = IRQ_HANDLED;
-- 
1.5.2.3
