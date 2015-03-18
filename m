From: Roger Quadros <rogerq@ti.com>
Subject: [RFC][PATCH 1/9] usb: hcd: Introduce usb_start/stop_hcd()
Date: Wed, 18 Mar 2015 15:55:55 +0200
Message-ID: <1426686963-11613-2-git-send-email-rogerq@ti.com>
References: <1426686963-11613-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426686963-11613-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, balbi@ti.com, stern@rowland.harvard.edu
Cc: dan.j.williams@intel.com, peter.chen@freescale.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

To support OTG we want a mechanism to start and stop
the HCD from the OTG state machine. Add usb_start_hcd()
and usb_stop_hcd().

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/core/hcd.c  | 147 ++++++++++++++++++++++++++++++++----------------
 include/linux/usb/hcd.h |   2 +
 2 files changed, 100 insertions(+), 49 deletions(-)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 45a915c..e28bd9d 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -2613,7 +2613,76 @@ static void usb_put_invalidate_rhdev(struct usb_hcd *hcd)
 }
 
 /**
- * usb_add_hcd - finish generic HCD structure initialization and register
+ * usb_start_hcd - start the HCD
+ * @hcd: the usb_hcd structure to initialize
+ *
+ * calls the drivers start() routine, registers the root hub
+ * and creates the USB sysfs attributes.
+ */
+int usb_start_hcd(struct usb_hcd *hcd)
+{
+	int retval;
+	struct usb_device *rhdev = hcd->self.root_hub;
+
+	if (hcd->state != HC_STATE_HALT) {
+		dev_err(hcd->self.controller, "not starting a running HCD\n");
+		return -EINVAL;
+	}
+
+	hcd->state = HC_STATE_RUNNING;
+	retval = hcd->driver->start(hcd);
+	if (retval < 0) {
+		dev_err(hcd->self.controller, "startup error %d\n", retval);
+		hcd->state = HC_STATE_HALT;
+		return retval;
+	}
+
+	/* starting here, usbcore will pay attention to this root hub */
+	if ((retval = register_root_hub(hcd)) != 0)
+		goto err_register_root_hub;
+
+	retval = sysfs_create_group(&rhdev->dev.kobj, &usb_bus_attr_group);
+	if (retval < 0) {
+		pr_err("Cannot register USB bus sysfs attributes: %d\n",
+		       retval);
+		goto error_create_attr_group;
+	}
+	if (hcd->uses_new_polling && HCD_POLL_RH(hcd))
+		usb_hcd_poll_rh_status(hcd);
+
+	return retval;
+
+error_create_attr_group:
+	clear_bit(HCD_FLAG_RH_RUNNING, &hcd->flags);
+	if (HC_IS_RUNNING(hcd->state))
+		hcd->state = HC_STATE_QUIESCING;
+	spin_lock_irq(&hcd_root_hub_lock);
+	hcd->rh_registered = 0;
+	spin_unlock_irq(&hcd_root_hub_lock);
+
+#ifdef CONFIG_PM
+	cancel_work_sync(&hcd->wakeup_work);
+#endif
+	mutex_lock(&usb_bus_list_lock);
+	usb_disconnect(&rhdev);		/* Sets rhdev to NULL */
+	mutex_unlock(&usb_bus_list_lock);
+err_register_root_hub:
+	hcd->rh_pollable = 0;
+	clear_bit(HCD_FLAG_POLL_RH, &hcd->flags);
+	del_timer_sync(&hcd->rh_timer);
+	hcd->driver->stop(hcd);
+	hcd->state = HC_STATE_HALT;
+
+	/* In case the HCD restarted the timer, stop it again. */
+	clear_bit(HCD_FLAG_POLL_RH, &hcd->flags);
+	del_timer_sync(&hcd->rh_timer);
+
+	return retval;
+}
+EXPORT_SYMBOL_GPL(usb_start_hcd);
+
+/**
+ * usb_add_hcd - finish generic HCD structure initialization and register.
  * @hcd: the usb_hcd structure to initialize
  * @irqnum: Interrupt line to allocate
  * @irqflags: Interrupt type flags
@@ -2757,50 +2826,12 @@ int usb_add_hcd(struct usb_hcd *hcd,
 			goto err_request_irq;
 	}
 
-	hcd->state = HC_STATE_RUNNING;
-	retval = hcd->driver->start(hcd);
-	if (retval < 0) {
-		dev_err(hcd->self.controller, "startup error %d\n", retval);
+	retval = usb_start_hcd(hcd);
+	if (retval)
 		goto err_hcd_driver_start;
-	}
-
-	/* starting here, usbcore will pay attention to this root hub */
-	if ((retval = register_root_hub(hcd)) != 0)
-		goto err_register_root_hub;
-
-	retval = sysfs_create_group(&rhdev->dev.kobj, &usb_bus_attr_group);
-	if (retval < 0) {
-		printk(KERN_ERR "Cannot register USB bus sysfs attributes: %d\n",
-		       retval);
-		goto error_create_attr_group;
-	}
-	if (hcd->uses_new_polling && HCD_POLL_RH(hcd))
-		usb_hcd_poll_rh_status(hcd);
-
-	return retval;
 
-error_create_attr_group:
-	clear_bit(HCD_FLAG_RH_RUNNING, &hcd->flags);
-	if (HC_IS_RUNNING(hcd->state))
-		hcd->state = HC_STATE_QUIESCING;
-	spin_lock_irq(&hcd_root_hub_lock);
-	hcd->rh_registered = 0;
-	spin_unlock_irq(&hcd_root_hub_lock);
+	return 0;
 
-#ifdef CONFIG_PM
-	cancel_work_sync(&hcd->wakeup_work);
-#endif
-	mutex_lock(&usb_bus_list_lock);
-	usb_disconnect(&rhdev);		/* Sets rhdev to NULL */
-	mutex_unlock(&usb_bus_list_lock);
-err_register_root_hub:
-	hcd->rh_pollable = 0;
-	clear_bit(HCD_FLAG_POLL_RH, &hcd->flags);
-	del_timer_sync(&hcd->rh_timer);
-	hcd->driver->stop(hcd);
-	hcd->state = HC_STATE_HALT;
-	clear_bit(HCD_FLAG_POLL_RH, &hcd->flags);
-	del_timer_sync(&hcd->rh_timer);
 err_hcd_driver_start:
 	if (usb_hcd_is_primary_hcd(hcd) && hcd->irq > 0)
 		free_irq(irqnum, hcd);
@@ -2830,18 +2861,20 @@ err_phy:
 EXPORT_SYMBOL_GPL(usb_add_hcd);
 
 /**
- * usb_remove_hcd - shutdown processing for generic HCDs
- * @hcd: the usb_hcd structure to remove
- * Context: !in_interrupt()
+ * usb_stop_hcd - stop the HCD
+ * @hcd: the usb_hcd structure to initialize
  *
- * Disconnects the root hub, then reverses the effects of usb_add_hcd(),
- * invoking the HCD's stop() method.
+ * removes the USB sysfs attributes, disconnects the root hub
+ * and calls the driver's stop() routine.
  */
-void usb_remove_hcd(struct usb_hcd *hcd)
+void usb_stop_hcd(struct usb_hcd *hcd)
 {
 	struct usb_device *rhdev = hcd->self.root_hub;
 
-	dev_info(hcd->self.controller, "remove, state %x\n", hcd->state);
+	if (hcd->state == HC_STATE_HALT) {
+		dev_err(hcd->self.controller, "not stopping a halted HCD\n");
+		return;
+	}
 
 	usb_get_dev(rhdev);
 	sysfs_remove_group(&rhdev->dev.kobj, &usb_bus_attr_group);
@@ -2888,6 +2921,22 @@ void usb_remove_hcd(struct usb_hcd *hcd)
 	/* In case the HCD restarted the timer, stop it again. */
 	clear_bit(HCD_FLAG_POLL_RH, &hcd->flags);
 	del_timer_sync(&hcd->rh_timer);
+}
+EXPORT_SYMBOL_GPL(usb_stop_hcd);
+
+/**
+ * usb_remove_hcd - shutdown processing for generic HCDs
+ * @hcd: the usb_hcd structure to remove
+ * Context: !in_interrupt()
+ *
+ * Disconnects the root hub, then reverses the effects of usb_add_hcd(),
+ * invoking the HCD's stop() method.
+ */
+void usb_remove_hcd(struct usb_hcd *hcd)
+{
+	dev_info(hcd->self.controller, "remove, state %x\n", hcd->state);
+
+	usb_stop_hcd(hcd);
 
 	if (usb_hcd_is_primary_hcd(hcd)) {
 		if (hcd->irq > 0)
diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
index 68b1e83..12aaf4c 100644
--- a/include/linux/usb/hcd.h
+++ b/include/linux/usb/hcd.h
@@ -433,6 +433,8 @@ extern void usb_put_hcd(struct usb_hcd *hcd);
 extern int usb_hcd_is_primary_hcd(struct usb_hcd *hcd);
 extern int usb_add_hcd(struct usb_hcd *hcd,
 		unsigned int irqnum, unsigned long irqflags);
+extern int usb_start_hcd(struct usb_hcd *hcd);
+extern void usb_stop_hcd(struct usb_hcd *hcd);
 extern void usb_remove_hcd(struct usb_hcd *hcd);
 extern int usb_hcd_find_raw_port_number(struct usb_hcd *hcd, int port1);
 
-- 
2.1.0
