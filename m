From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 11/36] musb_hdrc: Search and replace wEndMask with epmask
Date: Thu, 16 Aug 2007 02:40:34 -0700
Message-ID: <11872572842479-git-send-email-tony@atomide.com>
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
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1187257282941-git-send-email-tony@atomide.com>
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

Search and replace wEndMask with epmask

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/davinci.c  |    4 ++--
 drivers/usb/musb/musbdefs.h |    2 +-
 drivers/usb/musb/plat_uds.c |   16 ++++++++--------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/musb/davinci.c b/drivers/usb/musb/davinci.c
index 315c06c..99ac042 100644
--- a/drivers/usb/musb/davinci.c
+++ b/drivers/usb/musb/davinci.c
@@ -77,11 +77,11 @@ void musb_platform_enable(struct musb *musb)
 	u32	tmp, old, val;
 
 	/* workaround:  setup irqs through both register sets */
-	tmp = (musb->wEndMask & DAVINCI_USB_TX_ENDPTS_MASK)
+	tmp = (musb->epmask & DAVINCI_USB_TX_ENDPTS_MASK)
 			<< DAVINCI_USB_TXINT_SHIFT;
 	musb_writel(musb->ctrl_base, DAVINCI_USB_INT_MASK_SET_REG, tmp);
 	old = tmp;
-	tmp = (musb->wEndMask & (0xfffe & DAVINCI_USB_RX_ENDPTS_MASK))
+	tmp = (musb->epmask & (0xfffe & DAVINCI_USB_RX_ENDPTS_MASK))
 			<< DAVINCI_USB_RXINT_SHIFT;
 	musb_writel(musb->ctrl_base, DAVINCI_USB_INT_MASK_SET_REG, tmp);
 	tmp |= old;
diff --git a/drivers/usb/musb/musbdefs.h b/drivers/usb/musb/musbdefs.h
index 31b81cc..5a16005 100644
--- a/drivers/usb/musb/musbdefs.h
+++ b/drivers/usb/musb/musbdefs.h
@@ -383,7 +383,7 @@ struct musb {
 
 #define VBUSERR_RETRY_COUNT	3
 	u16			vbuserr_retry;
-	u16 wEndMask;
+	u16 epmask;
 	u8 nr_endpoints;
 
 	u8 board_mode;		/* enum musb_mode */
diff --git a/drivers/usb/musb/plat_uds.c b/drivers/usb/musb/plat_uds.c
index 946ddbf..1ea7803 100644
--- a/drivers/usb/musb/plat_uds.c
+++ b/drivers/usb/musb/plat_uds.c
@@ -558,8 +558,8 @@ static irqreturn_t musb_stage0_irq(struct musb * musb, u8 int_usb,
 			// REVISIT HNP; just force disconnect
 		}
 		musb->delay_port_power_off = FALSE;
-		musb_writew(mbase, MUSB_INTRTXE, musb->wEndMask);
-		musb_writew(mbase, MUSB_INTRRXE, musb->wEndMask & 0xfffe);
+		musb_writew(mbase, MUSB_INTRTXE, musb->epmask);
+		musb_writew(mbase, MUSB_INTRRXE, musb->epmask & 0xfffe);
 		musb_writeb(mbase, MUSB_INTRUSBE, 0xf7);
 #endif
 		musb->port1_status &= ~(USB_PORT_STAT_LOW_SPEED
@@ -672,7 +672,7 @@ static irqreturn_t musb_stage2_irq(struct musb * musb, u8 int_usb,
 		wFrame = musb_readw(mbase, MUSB_FRAME);
 		ep = musb->endpoints;
 		for (epnum = 1; (epnum < musb->nr_endpoints)
-					&& (musb->wEndMask >= (1 << epnum));
+					&& (musb->epmask >= (1 << epnum));
 				epnum++, ep++) {
 			// FIXME handle framecounter wraps (12 bits)
 			// eliminate duplicated StartUrb logic
@@ -792,8 +792,8 @@ void musb_start(struct musb *musb)
 	DBG(2, "<== devctl %02x\n", devctl);
 
 	/*  Set INT enable registers, enable interrupts */
-	musb_writew(regs, MUSB_INTRTXE, musb->wEndMask);
-	musb_writew(regs, MUSB_INTRRXE, musb->wEndMask & 0xfffe);
+	musb_writew(regs, MUSB_INTRTXE, musb->epmask);
+	musb_writew(regs, MUSB_INTRRXE, musb->epmask & 0xfffe);
 	musb_writeb(regs, MUSB_INTRUSBE, 0xf7);
 
 	musb_writeb(regs, MUSB_TESTMODE, 0);
@@ -1086,7 +1086,7 @@ fifo_setup(struct musb *musb, struct musb_hw_ep  *hw_ep,
 	/* NOTE rx and tx endpoint irqs aren't managed separately,
 	 * which happens to be ok
 	 */
-	musb->wEndMask |= (1 << hw_ep->epnum);
+	musb->epmask |= (1 << hw_ep->epnum);
 
 	return offset + (maxpacket << ((c_size & MUSB_FIFOSZ_DPB) ? 1 : 0));
 }
@@ -1198,7 +1198,7 @@ static int __init ep_config_from_hw(struct musb *musb)
 			break;
 		}
 		musb->nr_endpoints++;
-		musb->wEndMask |= (1 << epnum);
+		musb->epmask |= (1 << epnum);
 
 		hw_ep->max_packet_sz_tx = 1 << (reg & 0x0f);
 
@@ -1340,7 +1340,7 @@ static int __init musb_core_init(u16 wType, struct musb *musb)
 
 	/* discover endpoint configuration */
 	musb->nr_endpoints = 1;
-	musb->wEndMask = 1;
+	musb->epmask = 1;
 
 	if (reg & MUSB_CONFIGDATA_DYNFIFO) {
 		if (can_dynfifo())
-- 
1.5.2.3
