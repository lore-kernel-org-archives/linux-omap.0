From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.28-rc3-omap 4/4] twl4030: regulator testing hax
Date: Tue, 11 Nov 2008 18:06:00 -0800
Message-ID: <200811111806.00498.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp109.sbc.mail.mud.yahoo.com ([68.142.198.208]:48678 "HELO
	smtp109.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751541AbYKLCKY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Nov 2008 21:10:24 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

The regulator code is a NOP until it's given initialization data;
and then isn't very usable until the regulator is hooked up to a
consumer device.

This patch is PURELY FOR EXPERIMENTATION:

  - regulator init data is provided, so regulators get created
    and published (read-only) in /sys/class/regulator

  - /sys/device/platform/reg-virtual-consumer.* devices for most
    regulators are created, with writable sysfs attributes

Using this with the other patches should give you a system which
lets you examine and modify regulator attributes.  Note that by
default, most of those attributes are irrelevant ... patches are
pending to fix that glitch in the regulator framework.


It should be obvious, but:  be careful if you change a voltage
that's hooked up to more than a voltmeter, you probably don't
want to damage things.  (The regulator init data includes things
like board-specific constraints, which let you do things like
insist a given supply is always on at 1.8V ...)


---
 drivers/mfd/twl4030-core.c |   69 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

--- a/drivers/mfd/twl4030-core.c
+++ b/drivers/mfd/twl4030-core.c
@@ -432,11 +432,80 @@ static inline struct device *add_child(u
 		can_wakeup, irq0, irq1);
 }
 
+static int reg_testobj(int num, struct regulator_init_data *pdata)
+{
+	static const char			label[] = "supply";
+	struct platform_device			*pdev;
+	struct regulator_consumer_supply	*link;
+
+	/* NOTE name length problem:  only single digit numbers
+	 * avoid truncation.  "Succeed" anyway ... the regulator
+	 * will exist, we just can't use sysfs to test it.
+	 */
+	if (num > 10) {
+		printk("... regulator %d, no testdev, truncation bug\n", num);
+		return 0;
+	}
+
+	pdev = platform_device_register_data(NULL, "reg-virt-consumer", num,
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
+	/* NOTE:  this registers *before* its driver.  That's
+	 * important, because its probe() uses the regulator
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
+
+#ifndef REGULATOR_MODE_OFF
+#define REGULATOR_MODE_OFF 0
+#endif
+
+	/* TEMPORARY -- for regulator debug/exploration only */
+	if (!pdata) {
+		int status;
+
+		pdata = kzalloc(sizeof *pdata, GFP_KERNEL);
+		if (!pdata)
+			return ERR_PTR(-ENOMEM);
+
+		pdata->constraints.valid_modes_mask = REGULATOR_MODE_NORMAL
+				| REGULATOR_MODE_STANDBY
+				| REGULATOR_MODE_OFF;
+		pdata->constraints.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE
+				| REGULATOR_CHANGE_MODE
+				| REGULATOR_CHANGE_STATUS;
+
+		/* test device will have writable sysfs attributes */
+		status = reg_testobj(num, pdata);
+		if (status < 0)
+			return ERR_PTR(status);
+
+		pr_warning("** TWL4030 REGULATOR %d -- FOR DEBUG ONLY!\n", num);
+	}
+#endif
+
 	/* REVISIT:  name "twl4030_regulator.12" gets truncated
 	 * to "twl4030_regulator.1", BIG LOSE ... so hack around
 	 * it by removing "ulator".
