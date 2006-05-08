From: Hiroshi.DOYU@nokia.com
Subject: [PATCH 2/2] ARM: OMAP: USB: remove ohci_omap_host_enable
Date: Mon, 08 May 2006 12:11:22 +0300
Message-ID: <26781.2556507581$1147079728@news.gmane.org>
References: <11470794823893-git-send-email-1>
Reply-To: Hiroshi.DOYU@nokia.com
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11470794823893-git-send-email-1>
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

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

A usb external transceiver mode is set when a kernel module(usb host/usb
gadget) is loaded. "ohci_omap_host_enable()" is not used anymore.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>


---

 drivers/cbus/tahvo-usb.c     |   83 ++++++++----------------------------------
 drivers/usb/host/ohci-omap.c |   41 ---------------------
 2 files changed, 16 insertions(+), 108 deletions(-)

52a44544889a16f86b6a57d03540660507d86399
diff --git a/drivers/cbus/tahvo-usb.c b/drivers/cbus/tahvo-usb.c
index aef8481..f51151f 100644
--- a/drivers/cbus/tahvo-usb.c
+++ b/drivers/cbus/tahvo-usb.c
@@ -85,8 +85,6 @@ #else
 #define TAHVO_MODE(tu)		TAHVO_MODE_HOST
 #endif
 
-extern int ohci_omap_host_enable(struct usb_bus *host, int enable);
-
 struct tahvo_usb {
 	struct platform_device *pt_dev;
 	struct otg_transceiver otg;
@@ -132,8 +130,10 @@ static irqreturn_t omap_otg_irq(int irq,
 	} else if (otg_irq & DRIVER_SWITCH) {
 
 		if ((!(OTG_CTRL_REG & OTG_DRIVER_SEL)) &&
-		   tu->otg.host && tu->otg.state == OTG_STATE_A_HOST) {
+		   tu->otg.host && tu->otg.state == OTG_STATE_A_HOST
+		    && tu->otg.host->root_hub) {
 			/* role is host */
+
 			usb_bus_start_enum(tu->otg.host,
 					   tu->otg.host->otg_port);
 		}
@@ -244,8 +244,6 @@ static void check_vbus_state(struct tahv
 		case OTG_STATE_A_IDLE:
 			/* Session is now valid assuming the USB hub is driving Vbus */
 			tu->otg.state = OTG_STATE_A_HOST;
-			if (tu->otg.host)
-				ohci_omap_host_enable(tu->otg.host, 1);
 			break;
 		default:
 			break;
@@ -262,9 +260,6 @@ static void check_vbus_state(struct tahv
 			break;
 		case OTG_STATE_A_HOST:
 			tu->otg.state = OTG_STATE_A_IDLE;
-			if (tu->otg.host)
-				ohci_omap_host_enable(tu->otg.host, 0);
-
 			break;
 		default:
 			break;
@@ -296,8 +291,6 @@ static void tahvo_usb_become_host(struct
 
 static void tahvo_usb_stop_host(struct tahvo_usb *tu)
 {
-	if (tu->otg.host)
-		ohci_omap_host_enable(tu->otg.host, 0);
 	tu->otg.state = OTG_STATE_A_IDLE;
 }
 
@@ -334,9 +327,6 @@ static void tahvo_usb_power_off(struct t
 	if (tu->otg.gadget)
 		usb_gadget_vbus_disconnect(tu->otg.gadget);
 
-	if (tu->otg.host)
-		ohci_omap_host_enable(tu->otg.host, 0);
-
 	/* Disable OTG and interrupts */
 	if (TAHVO_MODE(tu) == TAHVO_MODE_PERIPHERAL)
 		id = OTG_ID;
@@ -413,24 +403,21 @@ static int tahvo_usb_set_host(struct otg
 		return -ENODEV;
 
 #if defined(CONFIG_USB_OTG) || !defined(CONFIG_USB_GADGET_OMAP)
-
 	mutex_lock(&tu->serialize);
 
+	if (tu->tahvo_mode == TAHVO_MODE_PERIPHERAL)
+		tahvo_usb_stop_peripheral(tu);
+	tu->tahvo_mode = TAHVO_MODE_HOST;
+	
 	if (!host) {
-		if (TAHVO_MODE(tu) == TAHVO_MODE_HOST)
-			tahvo_usb_power_off(tu);
+		tahvo_usb_power_off(tu);
 		tu->otg.host = 0;
 		mutex_unlock(&tu->serialize);
 		return 0;
 	}
 
-	if (TAHVO_MODE(tu) == TAHVO_MODE_HOST) {
-		tu->otg.host = 0;
-		tahvo_usb_become_host(tu);
-	} else
-		ohci_omap_host_enable(host, 0);
-
 	tu->otg.host = host;
+	tahvo_usb_become_host(tu);
 
 	mutex_unlock(&tu->serialize);
 #else
@@ -449,20 +436,21 @@ static int tahvo_usb_set_peripheral(stru
 		return -ENODEV;
 
 #if defined(CONFIG_USB_OTG) || defined(CONFIG_USB_GADGET_OMAP)
-
 	mutex_lock(&tu->serialize);
 
+	if (tu->tahvo_mode == TAHVO_MODE_HOST)
+		tahvo_usb_stop_host(tu);
+	tu->tahvo_mode = TAHVO_MODE_PERIPHERAL;
+
 	if (!gadget) {
-		if (TAHVO_MODE(tu) == TAHVO_MODE_PERIPHERAL)
-			tahvo_usb_power_off(tu);
+		tahvo_usb_power_off(tu);
 		tu->otg.gadget = 0;
 		mutex_unlock(&tu->serialize);
 		return 0;
 	}
 
 	tu->otg.gadget = gadget;
-	if (TAHVO_MODE(tu) == TAHVO_MODE_PERIPHERAL)
-		tahvo_usb_become_peripheral(tu);
+	tahvo_usb_become_peripheral(tu);
 
 	mutex_unlock(&tu->serialize);
 #else
@@ -505,46 +493,7 @@ static ssize_t otg_mode_show(struct devi
 	}
 	return sprintf(buf, "unknown\n");
 }
-
-static ssize_t otg_mode_store(struct device *device,
-			      struct device_attribute *attr,
-			      const char *buf, size_t count)
-{
-	struct tahvo_usb *tu = (struct tahvo_usb*) device->driver_data;
-	int r;
-
-	r = strlen(buf);
-	mutex_lock(&tu->serialize);
-	if (strncmp(buf, "host", 4) == 0) {
-		if (tu->tahvo_mode == TAHVO_MODE_PERIPHERAL)
-			tahvo_usb_stop_peripheral(tu);
-		tu->tahvo_mode = TAHVO_MODE_HOST;
-		if (tu->otg.host) {
-			printk(KERN_INFO "Selected HOST mode: host controller present.\n");
-			tahvo_usb_become_host(tu);
-		} else {
-			printk(KERN_INFO "Selected HOST mode: no host controller, powering off.\n");
-			tahvo_usb_power_off(tu);
-		}
-	} else if (strncmp(buf, "peripheral", 10) == 0) {
-		if (tu->tahvo_mode == TAHVO_MODE_HOST)
-			tahvo_usb_stop_host(tu);
-		tu->tahvo_mode = TAHVO_MODE_PERIPHERAL;
-		if (tu->otg.gadget) {
-			printk(KERN_INFO "Selected PERIPHERAL mode: gadget driver present.\n");
-			tahvo_usb_become_peripheral(tu);
-		} else {
-			printk(KERN_INFO "Selected PERIPHERAL mode: no gadget driver, powering off.\n");
-			tahvo_usb_power_off(tu);
-		}
-	} else
-		r = -EINVAL;
-
-	mutex_unlock(&tu->serialize);
-	return r;
-}
-
-static DEVICE_ATTR(otg_mode, 0644, otg_mode_show, otg_mode_store);
+static DEVICE_ATTR_RO(otg_mode);
 #endif
 
 static int tahvo_usb_probe(struct device *dev)
diff --git a/drivers/usb/host/ohci-omap.c b/drivers/usb/host/ohci-omap.c
index 1401844..e129a4f 100644
--- a/drivers/usb/host/ohci-omap.c
+++ b/drivers/usb/host/ohci-omap.c
@@ -281,47 +281,6 @@ static void omap_stop_hc(struct platform
 
 void usb_hcd_omap_remove (struct usb_hcd *, struct platform_device *);
 
-/* configure so an HC device and id are always provided */
-/* always called with process context; sleeping is OK */
-
-
-int ohci_omap_host_enable(struct usb_bus *host, int enable)
-{
-	struct usb_hcd *hcd;
-	struct ohci_hcd *ohci;
-	int retval;
-
-	if (host_enabled == enable)
-		return 0;
-
-	host_enabled = enable;
-
-	if (!host_initialized)
-		return 0;
-
-	hcd = (struct usb_hcd *)host->hcpriv;
-	ohci = hcd_to_ohci(hcd);
-	if (enable) {
-		omap_ohci_clock_power(1);
-		if ((retval = ohci_init(ohci)) < 0) {
-			dev_err(hcd->self.controller, "init error %d\n",
-				retval);
-			return retval;
-		}
-		if ((retval = hcd->driver->start(hcd)) < 0) {
-			dev_err(hcd->self.controller, "startup error %d\n",
-				retval);
-			return retval;
-		}
-	} else {
-		usb_disconnect(&hcd->self.root_hub);
-		hcd->driver->stop(hcd);
-		omap_ohci_clock_power(0);
-	}
-
-	return 0;
-}
-
 /**
  * usb_hcd_omap_probe - initialize OMAP-based HCDs
  * Context: !in_interrupt()
-- 
1.3.2.g8611
