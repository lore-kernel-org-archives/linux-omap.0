From: David Brownell <david-b@pacbell.net>
Subject: [patch 4/4] twl: regulator debug aids (NOT FOR MERGING)
Date: Sat, 15 Nov 2008 12:42:49 -0800
Message-ID: <200811151242.49721.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:20770 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751854AbYKOUyJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 15 Nov 2008 15:54:09 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

The regulator code is a NOP until it's given initialization data;
and then isn't very usable until each regulator is hooked up to a
consumer device.

This patch is PURELY FOR EXPERIMENTATION with non-USB regulators
that aren't set up by board-*.c files:

  - regulator init data is provided, so regulators get created
    and published (read-only) in /sys/class/regulator

  - /sys/device/platform/reg-virtual-consumer.* devices for most
    regulators are created, with writable sysfs attributes

Using this with the other patches should give you a system which
lets you examine and modify regulator attributes.  Note that by
default, most of those attributes are irrelevant ... patches are
pending to fix that glitch in the regulator framework.

---
 drivers/mfd/twl4030-core.c |   71 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

--- a/drivers/mfd/twl4030-core.c
+++ b/drivers/mfd/twl4030-core.c
@@ -432,11 +432,82 @@ static inline struct device *add_child(u
 		can_wakeup, irq0, irq1);
 }
 
+static int reg_testobj(struct regulator_init_data *pdata)
+{
+	static int testnum			__initdata;
+	static const char			label[] = "supply";
+
+	struct platform_device			*pdev;
+	struct regulator_consumer_supply	*link;
+
+	/* NOTE name length problem:  only single digit numbers
+	 * avoid truncation.  "Succeed" anyway ... the regulator
+	 * will exist, we just can't use sysfs to test it.
+	 *
+	 * Also, IDs of these test devices are decoupled from the
+	 * regulator IDs to help minimize the hurt ...
+	 */
+	if (testnum > 10) {
+		printk("... regulator %d, no testdev, truncation bug\n", testnum);
+		return 0;
+	}
+
+	pdev = platform_device_register_data(NULL, "reg-virt-consumer", testnum,
+			label, sizeof label);
+	if (IS_ERR(pdev))
+		return PTR_ERR(pdev);
+
+	link = kzalloc(sizeof *link, GFP_KERNEL);
+	if (!link) {
+		platform_device_put(pdev);
+		return -ENOMEM;
+	}
+
+	link->dev = &pdev->dev;
+	link->supply = label;
+
+	pdata->num_consumer_supplies = 1;
+	pdata->consumer_supplies = link;
+
+	testnum++;
+
+	/* NOTE:  this registers *before* its driver.  That's
+	 * important, because virtual.probe() uses the regulator
+	 * that we haven't yet registered (using "pdata") ...
+	 */
+	return 0;
+}
+
 static struct device *
 add_regulator_linked(int num, struct regulator_init_data *pdata,
 		struct regulator_consumer_supply *consumers,
 		unsigned num_consumers)
 {
+#if 1
+	/* TEMPORARY -- for regulator debug/exploration only */
+	if (!pdata) {
+		int status;
+
+		pdata = kzalloc(sizeof *pdata, GFP_KERNEL);
+		if (!pdata)
+			return ERR_PTR(-ENOMEM);
+
+		pdata->constraints.valid_modes_mask = REGULATOR_MODE_NORMAL
+				| REGULATOR_MODE_STANDBY;
+		pdata->constraints.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE
+				| REGULATOR_CHANGE_MODE
+				| REGULATOR_CHANGE_STATUS;
+
+		/* test device will have writable sysfs attributes
+		 */
+		status = reg_testobj(pdata);
+		if (status < 0)
+			return ERR_PTR(status);
+
+		pr_warning("** TWL4030 REGULATOR %d -- FOR DEBUG ONLY!\n", num);
+	}
+#endif
+
 	/* regulator framework demands init_data ... */
 	if (!pdata)
 		return NULL;
