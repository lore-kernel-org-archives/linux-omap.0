From: Komal Shah <komal_shah802003@yahoo.com>
Subject: [PATCH] OMAP: tahvo usb: sem2mutex conversion
Date: Fri, 24 Mar 2006 05:43:54 -0800 (PST)
Message-ID: <20060324134354.37509.qmail@web32912.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1936928336-1143207834=:31065"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
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

--0-1936928336-1143207834=:31065
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

 
 

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-1936928336-1143207834=:31065
Content-Type: text/plain; name="0006-OMAP-tahvo_usb-sem2mutex-conversion.txt"
Content-Description: 3685493629-0006-OMAP-tahvo_usb-sem2mutex-conversion.txt
Content-Disposition: inline;
	filename="0006-OMAP-tahvo_usb-sem2mutex-conversion.txt"

Subject: [PATCH] OMAP: tahvo_usb: sem2mutex conversion

Signed-off-by: Komal Shah <komal_shah802003@yahoo.com>

---

 drivers/cbus/tahvo-usb.c |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)

eb39296a1857ecc80ade52cab9f90f652c1c63a1
diff --git a/drivers/cbus/tahvo-usb.c b/drivers/cbus/tahvo-usb.c
index e7f4b88..aef8481 100644
--- a/drivers/cbus/tahvo-usb.c
+++ b/drivers/cbus/tahvo-usb.c
@@ -38,9 +38,9 @@
 #include <linux/workqueue.h>
 #include <linux/kobject.h>
 #include <linux/clk.h>
+#include <linux/mutex.h>
 
 #include <asm/irq.h>
-#include <asm/semaphore.h>
 #include <asm/arch/usb.h>
 
 #include "cbus.h"
@@ -92,7 +92,7 @@ struct tahvo_usb {
 	struct otg_transceiver otg;
 	int vbus_state;
 	struct work_struct irq_work;
-	struct semaphore serialize;
+	struct mutex serialize;
 #ifdef CONFIG_USB_OTG
 	int tahvo_mode;
 #endif
@@ -414,13 +414,13 @@ static int tahvo_usb_set_host(struct otg
 
 #if defined(CONFIG_USB_OTG) || !defined(CONFIG_USB_GADGET_OMAP)
 
-	down(&tu->serialize);
+	mutex_lock(&tu->serialize);
 
 	if (!host) {
 		if (TAHVO_MODE(tu) == TAHVO_MODE_HOST)
 			tahvo_usb_power_off(tu);
 		tu->otg.host = 0;
-		up(&tu->serialize);
+		mutex_unlock(&tu->serialize);
 		return 0;
 	}
 
@@ -432,7 +432,7 @@ static int tahvo_usb_set_host(struct otg
 
 	tu->otg.host = host;
 
-	up(&tu->serialize);
+	mutex_unlock(&tu->serialize);
 #else
 	/* No host mode configured, so do not allow host controlled to be set */
 	return -EINVAL;
@@ -450,13 +450,13 @@ static int tahvo_usb_set_peripheral(stru
 
 #if defined(CONFIG_USB_OTG) || defined(CONFIG_USB_GADGET_OMAP)
 
-	down(&tu->serialize);
+	mutex_lock(&tu->serialize);
 
 	if (!gadget) {
 		if (TAHVO_MODE(tu) == TAHVO_MODE_PERIPHERAL)
 			tahvo_usb_power_off(tu);
 		tu->otg.gadget = 0;
-		up(&tu->serialize);
+		mutex_unlock(&tu->serialize);
 		return 0;
 	}
 
@@ -464,7 +464,7 @@ static int tahvo_usb_set_peripheral(stru
 	if (TAHVO_MODE(tu) == TAHVO_MODE_PERIPHERAL)
 		tahvo_usb_become_peripheral(tu);
 
-	up(&tu->serialize);
+	mutex_unlock(&tu->serialize);
 #else
 	/* No gadget mode configured, so do not allow host controlled to be set */
 	return -EINVAL;
@@ -477,9 +477,9 @@ static void tahvo_usb_irq_work(void *dat
 {
 	struct tahvo_usb *tu = (struct tahvo_usb *)data;
 
-	down(&tu->serialize);
+	mutex_lock(&tu->serialize);
 	check_vbus_state(tu);
-	up(&tu->serialize);
+	mutex_unlock(&tu->serialize);
 }
 
 static void tahvo_usb_vbus_interrupt(unsigned long arg)
@@ -514,7 +514,7 @@ static ssize_t otg_mode_store(struct dev
 	int r;
 
 	r = strlen(buf);
-	down(&tu->serialize);
+	mutex_lock(&tu->serialize);
 	if (strncmp(buf, "host", 4) == 0) {
 		if (tu->tahvo_mode == TAHVO_MODE_PERIPHERAL)
 			tahvo_usb_stop_peripheral(tu);
@@ -540,7 +540,7 @@ static ssize_t otg_mode_store(struct dev
 	} else
 		r = -EINVAL;
 
-	up(&tu->serialize);
+	mutex_unlock(&tu->serialize);
 	return r;
 }
 
@@ -568,7 +568,7 @@ static int tahvo_usb_probe(struct device
 #endif
 
 	INIT_WORK(&tu->irq_work, tahvo_usb_irq_work, tu);
-	init_MUTEX(&tu->serialize);
+	mutex_init(&tu->serialize);
 
 	/* Set initial state, so that we generate kevents only on
 	 * state changes */
-- 
1.1.6

--0-1936928336-1143207834=:31065
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0-1936928336-1143207834=:31065--
