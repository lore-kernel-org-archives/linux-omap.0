From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] musb_hdrc: Fix musb_hnp_stop() to return to device mode
Date: Tue, 21 Aug 2007 05:41:17 -0700
Message-ID: <20070821124116.GL31816@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="HG+GLK89HZ1zG0kk"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
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


--HG+GLK89HZ1zG0kk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This one fixes some USB HS OPT test unreliability.

Tony

--HG+GLK89HZ1zG0kk
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="musb-fix-hnp.patch"

From: Tony Lindgren <tony@atomide.com>
Subject: musb_hdrc: Fix musb_hnp_stop() to return to device mode

Without this patch HNP does not return to device mode, which can
confuse OPT tests. Also change to b_host if SUSPEND and CONNECT
simultaneously as b_peripheral, and fix a comment.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -331,6 +331,7 @@ void musb_hnp_stop(struct musb *musb)
 		DBG(1, "HNP: Disabling HR\n");
 		hcd->self.is_b_host = 0;
 		musb->xceiv.state = OTG_STATE_B_PERIPHERAL;
+		MUSB_DEV_MODE(musb);
 		reg = musb_readb(mbase, MUSB_POWER);
 		reg |= MUSB_POWER_SUSPENDM;
 		musb_writeb(mbase, MUSB_POWER, reg);
@@ -579,6 +580,15 @@ static irqreturn_t musb_stage0_irq(struct musb * musb, u8 int_usb,
 
 		/* indicate new connection to OTG machine */
 		switch (musb->xceiv.state) {
+		case OTG_STATE_B_PERIPHERAL:
+			if (int_usb & MUSB_INTR_SUSPEND) {
+				DBG(1, "HNP: SUSPEND and CONNECT, now b_host\n");
+				musb->xceiv.state = OTG_STATE_B_HOST;
+				hcd->self.is_b_host = 1;
+				int_usb &= ~MUSB_INTR_SUSPEND;
+			} else
+				DBG(1, "CONNECT as b_peripheral???\n");
+			break;
 		case OTG_STATE_B_WAIT_ACON:
 			DBG(1, "HNP: Waiting to switch to b_host state\n");
 			musb->xceiv.state = OTG_STATE_B_HOST;
@@ -707,11 +717,11 @@ static irqreturn_t musb_stage2_irq(struct musb * musb, u8 int_usb,
 		case OTG_STATE_B_HOST:
 			musb_hnp_stop(musb);
 			break;
-			/* FALLTHROUGH */
 		case OTG_STATE_A_PERIPHERAL:
 			musb_root_disconnect(musb);
 			/* FALLTHROUGH */
 		case OTG_STATE_B_WAIT_ACON:
+			/* FALLTHROUGH */
 #endif	/* OTG */
 #ifdef CONFIG_USB_GADGET_MUSB_HDRC
 		case OTG_STATE_B_PERIPHERAL:

--HG+GLK89HZ1zG0kk
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--HG+GLK89HZ1zG0kk--
