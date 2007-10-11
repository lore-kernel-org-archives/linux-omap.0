From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/12] musb_hdrc: Remove non-debug otg_state_string
Date: Thu, 11 Oct 2007 10:05:17 -0700
Message-ID: <11921223301447-git-send-email-tony@atomide.com>
References: <1192122325531-git-send-email-tony@atomide.com>
	<11921223262203-git-send-email-tony@atomide.com>
	<11921223272557-git-send-email-tony@atomide.com>
	<11921223283749-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11921223283749-git-send-email-tony@atomide.com>
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

The right state information via sys is good to know, don't try to optimize
it away.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 82bf57a..b438036 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -121,15 +121,6 @@ module_param(debug, uint, 0);
 MODULE_PARM_DESC(debug, "initial debug message level");
 
 #define MUSB_VERSION_SUFFIX	"/dbg"
-#else
-
-const char *otg_state_string(struct musb *musb)
-{
-	static char buf[8];
-
-	snprintf(buf, sizeof buf, "otg-%d", musb->xceiv.state);
-	return buf;
-}
 #endif
 
 #define DRIVER_AUTHOR "Mentor Graphics, Texas Instruments, Nokia"
@@ -281,6 +272,26 @@ void musb_load_testpacket(struct musb *musb)
 
 /*-------------------------------------------------------------------------*/
 
+const char *otg_state_string(struct musb *musb)
+{
+	switch (musb->xceiv.state) {
+	case OTG_STATE_A_IDLE:		return "a_idle";
+	case OTG_STATE_A_WAIT_VRISE:	return "a_wait_vrise";
+	case OTG_STATE_A_WAIT_BCON:	return "a_wait_bcon";
+	case OTG_STATE_A_HOST:		return "a_host";
+	case OTG_STATE_A_SUSPEND:	return "a_suspend";
+	case OTG_STATE_A_PERIPHERAL:	return "a_peripheral";
+	case OTG_STATE_A_WAIT_VFALL:	return "a_wait_vfall";
+	case OTG_STATE_A_VBUS_ERR:	return "a_vbus_err";
+	case OTG_STATE_B_IDLE:		return "b_idle";
+	case OTG_STATE_B_SRP_INIT:	return "b_srp_init";
+	case OTG_STATE_B_PERIPHERAL:	return "b_peripheral";
+	case OTG_STATE_B_WAIT_ACON:	return "b_wait_acon";
+	case OTG_STATE_B_HOST:		return "b_host";
+	default:			return "UNDEFINED";
+	}
+}
+
 #ifdef	CONFIG_USB_MUSB_OTG
 
 /*
diff --git a/drivers/usb/musb/musb_procfs.c b/drivers/usb/musb/musb_procfs.c
index ca53d13..bd282da 100644
--- a/drivers/usb/musb/musb_procfs.c
+++ b/drivers/usb/musb/musb_procfs.c
@@ -42,27 +42,6 @@
 
 #include "davinci.h"
 
-
-const char *otg_state_string(struct musb *musb)
-{
-	switch (musb->xceiv.state) {
-	case OTG_STATE_A_IDLE:		return "a_idle";
-	case OTG_STATE_A_WAIT_VRISE:	return "a_wait_vrise";
-	case OTG_STATE_A_WAIT_BCON:	return "a_wait_bcon";
-	case OTG_STATE_A_HOST:		return "a_host";
-	case OTG_STATE_A_SUSPEND:	return "a_suspend";
-	case OTG_STATE_A_PERIPHERAL:	return "a_peripheral";
-	case OTG_STATE_A_WAIT_VFALL:	return "a_wait_vfall";
-	case OTG_STATE_A_VBUS_ERR:	return "a_vbus_err";
-	case OTG_STATE_B_IDLE:		return "b_idle";
-	case OTG_STATE_B_SRP_INIT:	return "b_srp_init";
-	case OTG_STATE_B_PERIPHERAL:	return "b_peripheral";
-	case OTG_STATE_B_WAIT_ACON:	return "b_wait_acon";
-	case OTG_STATE_B_HOST:		return "b_host";
-	default:			return "UNDEFINED";
-	}
-}
-
 #ifdef CONFIG_USB_MUSB_HDRC_HCD
 
 static int dump_qh(struct musb_qh *qh, char *buf, unsigned max)
-- 
1.5.2.5
