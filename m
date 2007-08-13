From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 32/52] musb_hdrc: Search and replace bTestModeValue with
	test_mode_nr
Date: Mon, 13 Aug 2007 06:49:07 -0700
Message-ID: <11870130543254-git-send-email-tony@atomide.com>
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
	<11870130023665-git-send-email-tony@atomide.com>
	<11870130052666-git-send-email-tony@atomide.com>
	<1187013007355-git-send-email-tony@atomide.com>
	<11870130103320-git-send-email-tony@atomide.com>
	<11870130122117-git-send-email-tony@atomide.com>
	<11870130153038-git-send-email-tony@atomide.com>
	<11870130183634-git-send-email-tony@atomide.com>
	<11870130203742-git-send-email-tony@atomide.com>
	<1187013022688-git-send-email-tony@atomide.com>
	<1187013024836-git-send-email-tony@atomide.com>
	<11870130272865-git-send-email-tony@atomide.com>
	<1187013029823-git-send-email-tony@atomide.com>
	<11870130314189-git-send-email-tony@atomide.com>
	<11870130343298-git-send-email-tony@atomide.com>
	<11870130371106-git-send-email-tony@atomide.com>
	<11870130411622-git-send-email-tony@atomide.com>
	<1187013048432-git-send-email-tony@atomide.com>
	<11870130521115-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11870130521115-git-send-email-tony@atomide.com>
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

Search and replace bTestModeValue with test_mode_nr

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/g_ep0.c    |   12 ++++++------
 drivers/usb/musb/musbdefs.h |    2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

--- a/drivers/usb/musb/g_ep0.c
+++ b/drivers/usb/musb/g_ep0.c
@@ -306,25 +306,25 @@ __acquires(musb->lock)
 					case 1:
 						pr_debug("TEST_J\n");
 						/* TEST_J */
-						musb->bTestModeValue =
+						musb->test_mode_nr =
 							MGC_M_TEST_J;
 						break;
 					case 2:
 						/* TEST_K */
 						pr_debug("TEST_K\n");
-						musb->bTestModeValue =
+						musb->test_mode_nr =
 							MGC_M_TEST_K;
 						break;
 					case 3:
 						/* TEST_SE0_NAK */
 						pr_debug("TEST_SE0_NAK\n");
-						musb->bTestModeValue =
+						musb->test_mode_nr =
 							MGC_M_TEST_SE0_NAK;
 						break;
 					case 4:
 						/* TEST_PACKET */
 						pr_debug("TEST_PACKET\n");
-						musb->bTestModeValue =
+						musb->test_mode_nr =
 							MGC_M_TEST_PACKET;
 						break;
 					default:
@@ -670,11 +670,11 @@ irqreturn_t musb_g_ep0_irq(struct musb *musb)
 		else if (musb->bTestMode) {
 			DBG(1, "entering TESTMODE\n");
 
-			if (MGC_M_TEST_PACKET == musb->bTestModeValue)
+			if (MGC_M_TEST_PACKET == musb->test_mode_nr)
 				musb_load_testpacket(musb);
 
 			musb_writeb(mbase, MGC_O_HDRC_TESTMODE,
-					musb->bTestModeValue);
+					musb->test_mode_nr);
 		}
 		/* FALLTHROUGH */
 
--- a/drivers/usb/musb/musbdefs.h
+++ b/drivers/usb/musb/musbdefs.h
@@ -443,7 +443,7 @@ struct musb {
 
 	enum musb_g_ep0_state	ep0_state;
 	u8			address;
-	u8			bTestModeValue;
+	u8			test_mode_nr;
 	u16			ackpend;		/* ep0 */
 	struct usb_gadget	g;			/* the gadget */
 	struct usb_gadget_driver *pGadgetDriver;	/* its driver */
-- 
1.5.2.3
