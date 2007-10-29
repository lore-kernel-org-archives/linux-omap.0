From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Fix usb gadget related compile errors and typo
Date: Mon, 29 Oct 2007 20:55:54 +0100
Message-ID: <47263ACA.8010001@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090800050501080507060505"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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

This is a multi-part message in MIME format.
--------------090800050501080507060505
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


ARM: OMAP: Fix usb gadget related compile errors and typo

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>


--------------090800050501080507060505
Content-Type: text/plain;
 name="usbgadget_include.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="usbgadget_include.txt"

Index: linux-osk/drivers/i2c/chips/isp1301_omap.c
===================================================================
--- linux-osk.orig/drivers/i2c/chips/isp1301_omap.c
+++ linux-osk/drivers/i2c/chips/isp1301_omap.c
@@ -28,7 +28,7 @@
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/usb/ch9.h>
-#include <linux/usb_gadget.h>
+#include <linux/usb/gadget.h>
 #include <linux/usb.h>
 #include <linux/usb/otg.h>
 #include <linux/i2c.h>
Index: linux-osk/drivers/usb/gadget/omap_udc.c
===================================================================
--- linux-osk.orig/drivers/usb/gadget/omap_udc.c
+++ linux-osk/drivers/usb/gadget/omap_udc.c
@@ -1241,14 +1241,14 @@ static void pullup_enable(struct omap_ud
 	udc->gadget.dev.parent->power.power_state = PMSG_ON;
 	udc->gadget.dev.power.power_state = PMSG_ON;
 	UDC_SYSCON1_REG |= UDC_PULLUP_EN;
-	if (!gadget_is_otg(udc->gadget) && !cpu_is_omap15xx())
+	if (!gadget_is_otg(&(udc->gadget)) && !cpu_is_omap15xx())
 		OTG_CTRL_REG |= OTG_BSESSVLD;
 	UDC_IRQ_EN_REG = UDC_DS_CHG_IE;
 }
 
 static void pullup_disable(struct omap_udc *udc)
 {
-	if (!gadget_is_otg(udc->gadget) && !cpu_is_omap15xx())
+        if (!gadget_is_otg(&(udc->gadget)) && !cpu_is_omap15xx())
 		OTG_CTRL_REG &= ~OTG_BSESSVLD;
 	UDC_IRQ_EN_REG = UDC_DS_CHG_IE;
 	UDC_SYSCON1_REG &= ~UDC_PULLUP_EN;
@@ -1386,7 +1386,7 @@ static void update_otg(struct omap_udc *
 {
 	u16	devstat;
 
-	if (!gadget_is_otg(udc->gadget))
+	if (!gadget_is_otg(&(udc->gadget)))
 		return;
 
 	if (OTG_CTRL_REG & OTG_ID)
Index: linux-osk/include/linux/usb/gadget.h
===================================================================
--- linux-osk.orig/include/linux/usb/gadget.h
+++ linux-osk/include/linux/usb/gadget.h
@@ -480,7 +480,7 @@ static inline void *get_gadget_data (str
 
 
 /**
- * gadget_is_dualspeed - return true iff the hardware handles high speed
+ * gadget_is_dualspeed - return true if the hardware handles high speed
  * @g: controller that might support both high and full speeds
  */
 static inline int gadget_is_dualspeed(struct usb_gadget *g)
@@ -496,7 +496,7 @@ static inline int gadget_is_dualspeed(st
 }
 
 /**
- * gadget_is_otg - return true iff the hardware is OTG-ready
+ * gadget_is_otg - return true if the hardware is OTG-ready
  * @g: controller that might have a Mini-AB connector
  *
  * This is a runtime test, since kernels with a USB-OTG stack sometimes

--------------090800050501080507060505
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------090800050501080507060505--
