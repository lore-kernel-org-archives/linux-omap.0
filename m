From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 34/52] musb_hdrc: Search and replace pGadgetDriver with
	gadget_driver
Date: Mon, 13 Aug 2007 06:49:09 -0700
Message-ID: <1187013062890-git-send-email-tony@atomide.com>
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
	<11870130543254-git-send-email-tony@atomide.com>
	<11870130573814-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11870130573814-git-send-email-tony@atomide.com>
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

Search and replace pGadgetDriver with gadget_driver

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/g_ep0.c       |    4 ++--
 drivers/usb/musb/musb_gadget.c |   32 ++++++++++++++++----------------
 drivers/usb/musb/musb_procfs.c |    4 ++--
 drivers/usb/musb/musbdefs.h    |    2 +-
 drivers/usb/musb/tusb6010.c    |    2 +-
 5 files changed, 22 insertions(+), 22 deletions(-)

--- a/drivers/usb/musb/g_ep0.c
+++ b/drivers/usb/musb/g_ep0.c
@@ -583,10 +583,10 @@ __releases(musb->lock)
 __acquires(musb->lock)
 {
 	int retval;
-	if (!musb->pGadgetDriver)
+	if (!musb->gadget_driver)
 		return -EOPNOTSUPP;
 	spin_unlock(&musb->lock);
-	retval = musb->pGadgetDriver->setup(&musb->g, pControlRequest);
+	retval = musb->gadget_driver->setup(&musb->g, pControlRequest);
 	spin_lock(&musb->lock);
 	return retval;
 }
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1476,7 +1476,7 @@ static void musb_pullup(struct musb *musb, int is_on)
 	/* FIXME if on, HdrcStart; if off, HdrcStop */
 
 	DBG(3, "gadget %s D+ pullup %s\n",
-		musb->pGadgetDriver->function, is_on ? "on" : "off");
+		musb->gadget_driver->function, is_on ? "on" : "off");
 	musb_writeb(musb->mregs, MGC_O_HDRC_POWER, power);
 }
 
@@ -1703,13 +1703,13 @@ int usb_gadget_register_driver(struct usb_gadget_driver *driver)
 	DBG(3, "registering driver %s\n", driver->function);
 	spin_lock_irqsave(&musb->lock, flags);
 
-	if (musb->pGadgetDriver) {
+	if (musb->gadget_driver) {
 		DBG(1, "%s is already bound to %s\n",
 				musb_driver_name,
-				musb->pGadgetDriver->driver.name);
+				musb->gadget_driver->driver.name);
 		retval = -EBUSY;
 	} else {
-		musb->pGadgetDriver = driver;
+		musb->gadget_driver = driver;
 		musb->g.dev.driver = &driver->driver;
 		driver->driver.bus = NULL;
 		musb->softconnect = 1;
@@ -1723,7 +1723,7 @@ int usb_gadget_register_driver(struct usb_gadget_driver *driver)
 	if (retval != 0) {
 		DBG(3, "bind to driver %s failed --> %d\n",
 			driver->driver.name, retval);
-		musb->pGadgetDriver = NULL;
+		musb->gadget_driver = NULL;
 		musb->g.dev.driver = NULL;
 	}
 
@@ -1762,7 +1762,7 @@ int usb_gadget_register_driver(struct usb_gadget_driver *driver)
 				spin_lock_irqsave(&musb->lock, flags);
 				musb->xceiv.gadget = NULL;
 				musb->xceiv.state = OTG_STATE_UNDEFINED;
-				musb->pGadgetDriver = NULL;
+				musb->gadget_driver = NULL;
 				musb->g.dev.driver = NULL;
 				spin_unlock_irqrestore(&musb->lock, flags);
 			}
@@ -1841,7 +1841,7 @@ int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
 	musb_hnp_stop(musb);
 #endif
 
-	if (musb->pGadgetDriver == driver) {
+	if (musb->gadget_driver == driver) {
 		musb->xceiv.state = OTG_STATE_UNDEFINED;
 		stop_activity(musb, driver);
 
@@ -1850,7 +1850,7 @@ int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
 		driver->unbind(&musb->g);
 		spin_lock_irqsave(&musb->lock, flags);
 
-		musb->pGadgetDriver = NULL;
+		musb->gadget_driver = NULL;
 		musb->g.dev.driver = NULL;
 
 		musb->is_active = 0;
@@ -1885,9 +1885,9 @@ void musb_g_resume(struct musb *musb)
 	case OTG_STATE_B_WAIT_ACON:
 	case OTG_STATE_B_PERIPHERAL:
 		musb->is_active = 1;
-		if (musb->pGadgetDriver && musb->pGadgetDriver->resume) {
+		if (musb->gadget_driver && musb->gadget_driver->resume) {
 			spin_unlock(&musb->lock);
-			musb->pGadgetDriver->resume(&musb->g);
+			musb->gadget_driver->resume(&musb->g);
 			spin_lock(&musb->lock);
 		}
 		break;
@@ -1912,9 +1912,9 @@ void musb_g_suspend(struct musb *musb)
 		break;
 	case OTG_STATE_B_PERIPHERAL:
 		musb->is_suspended = 1;
-		if (musb->pGadgetDriver && musb->pGadgetDriver->suspend) {
+		if (musb->gadget_driver && musb->gadget_driver->suspend) {
 			spin_unlock(&musb->lock);
-			musb->pGadgetDriver->suspend(&musb->g);
+			musb->gadget_driver->suspend(&musb->g);
 			spin_lock(&musb->lock);
 		}
 		break;
@@ -1948,9 +1948,9 @@ void musb_g_disconnect(struct musb *musb)
 	(void) musb_gadget_vbus_draw(&musb->g, 0);
 
 	musb->g.speed = USB_SPEED_UNKNOWN;
-	if (musb->pGadgetDriver && musb->pGadgetDriver->disconnect) {
+	if (musb->gadget_driver && musb->gadget_driver->disconnect) {
 		spin_unlock(&musb->lock);
-		musb->pGadgetDriver->disconnect(&musb->g);
+		musb->gadget_driver->disconnect(&musb->g);
 		spin_lock(&musb->lock);
 	}
 
@@ -1987,8 +1987,8 @@ __acquires(musb->lock)
 			(devctl & MGC_M_DEVCTL_BDEVICE)
 				? "B-Device" : "A-Device",
 			musb_readb(mbase, MGC_O_HDRC_FADDR),
-			musb->pGadgetDriver
-				? musb->pGadgetDriver->driver.name
+			musb->gadget_driver
+				? musb->gadget_driver->driver.name
 				: NULL
 			);
 
--- a/drivers/usb/musb/musb_procfs.c
+++ b/drivers/usb/musb/musb_procfs.c
@@ -619,8 +619,8 @@ static int dump_header_stats(struct musb *musb, char *buffer)
 #ifdef CONFIG_USB_GADGET_MUSB_HDRC
 	if (is_peripheral_enabled(musb)) {
 		code = sprintf(buffer, "Gadget driver: %s\n",
-				musb->pGadgetDriver
-					? musb->pGadgetDriver->driver.name
+				musb->gadget_driver
+					? musb->gadget_driver->driver.name
 					: "(none)");
 		if (code <= 0)
 			goto done;
--- a/drivers/usb/musb/musbdefs.h
+++ b/drivers/usb/musb/musbdefs.h
@@ -446,7 +446,7 @@ struct musb {
 	u8			test_mode_nr;
 	u16			ackpend;		/* ep0 */
 	struct usb_gadget	g;			/* the gadget */
-	struct usb_gadget_driver *pGadgetDriver;	/* its driver */
+	struct usb_gadget_driver *gadget_driver;	/* its driver */
 #endif
 
 #ifdef CONFIG_USB_MUSB_OTG
--- a/drivers/usb/musb/tusb6010.c
+++ b/drivers/usb/musb/tusb6010.c
@@ -422,7 +422,7 @@ static void musb_do_idle(unsigned long _musb)
 #endif
 
 #ifdef CONFIG_USB_GADGET_MUSB_HDRC
-		if (is_peripheral_enabled(musb) && !musb->pGadgetDriver)
+		if (is_peripheral_enabled(musb) && !musb->gadget_driver)
 			wakeups = 0;
 		else {
 			wakeups = TUSB_PRCM_WHOSTDISCON
-- 
1.5.2.3
