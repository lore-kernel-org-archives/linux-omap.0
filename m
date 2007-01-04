From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Workqueue changes for tahvo-usb
Date: Thu, 04 Jan 2007 17:37:04 +0100
Message-ID: <459D2D30.7040206@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020504000903070400090200"
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
--------------020504000903070400090200
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


ARM: OMAP: Workqueue changes for tahvo-usb.c

Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>


--------------020504000903070400090200
Content-Type: text/plain;
 name="tahvo_usb_workqueue_fix.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tahvo_usb_workqueue_fix.txt"

Index: linux-osk/drivers/cbus/tahvo-usb.c
===================================================================
--- linux-osk.orig/drivers/cbus/tahvo-usb.c
+++ linux-osk/drivers/cbus/tahvo-usb.c
@@ -535,9 +535,9 @@ static int tahvo_usb_set_peripheral(stru
 	return 0;
 }
 
-static void tahvo_usb_irq_work(void *data)
+static void tahvo_usb_irq_work(struct work_struct *work)
 {
-	struct tahvo_usb *tu = (struct tahvo_usb *)data;
+	struct tahvo_usb *tu = container_of(work, struct tahvo_usb, irq_work);
 
 	mutex_lock(&tu->serialize);
 	check_vbus_state(tu);
@@ -631,7 +631,7 @@ static int tahvo_usb_probe(struct device
 #endif
 #endif
 
-	INIT_WORK(&tu->irq_work, tahvo_usb_irq_work, tu);
+	INIT_WORK(&tu->irq_work, tahvo_usb_irq_work);
 	mutex_init(&tu->serialize);
 
 	/* Set initial state, so that we generate kevents only on


--------------020504000903070400090200
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------020504000903070400090200--
