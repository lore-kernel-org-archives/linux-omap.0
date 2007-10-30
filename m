From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Fix usb gadget related compile errors, take #2
Date: Tue, 30 Oct 2007 19:48:07 +0100
Message-ID: <47277C67.7020501@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070104050609070404000309"
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
--------------070104050609070404000309
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


ARM: OMAP: Fix usb gadget related compile errors. Incorporated
comments from David Brownell <david-b@pacbell.net>.

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>


--------------070104050609070404000309
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
--- osk.orig/drivers/usb/gadget/omap_udc.c	2007-10-25 13:05:11.000000000 -0700
+++ osk/drivers/usb/gadget/omap_udc.c	2007-10-25 13:45:00.000000000 -0700
@@ -1241,14 +1241,14 @@ static void pullup_enable(struct omap_ud
 	udc->gadget.dev.parent->power.power_state = PMSG_ON;
 	udc->gadget.dev.power.power_state = PMSG_ON;
 	UDC_SYSCON1_REG |= UDC_PULLUP_EN;
-	if (!gadget_is_otg(udc->gadget) && !cpu_is_omap15xx())
+	if (!gadget_is_otg(&udc->gadget) && !cpu_is_omap15xx())
 		OTG_CTRL_REG |= OTG_BSESSVLD;
 	UDC_IRQ_EN_REG = UDC_DS_CHG_IE;
 }
 
 static void pullup_disable(struct omap_udc *udc)
 {
-	if (!gadget_is_otg(udc->gadget) && !cpu_is_omap15xx())
+	if (!gadget_is_otg(&udc->gadget) && !cpu_is_omap15xx())
 		OTG_CTRL_REG &= ~OTG_BSESSVLD;
 	UDC_IRQ_EN_REG = UDC_DS_CHG_IE;
 	UDC_SYSCON1_REG &= ~UDC_PULLUP_EN;
@@ -1386,7 +1386,7 @@ static void update_otg(struct omap_udc *
 {
 	u16	devstat;
 
-	if (!gadget_is_otg(udc->gadget))
+	if (!gadget_is_otg(&udc->gadget))
 		return;
 
 	if (OTG_CTRL_REG & OTG_ID)


--------------070104050609070404000309
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------070104050609070404000309--
