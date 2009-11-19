From: Gregoire Gentil <gregoire@gentil.com>
Subject: [PATCH 5/8] HID file for Always Innovating OMAP3-based Touch Book keyboard
Date: Thu, 19 Nov 2009 09:18:08 -0800
Message-ID: <1258651091-31727-6-git-send-email-gregoire@gentil.com>
References: <1258651091-31727-1-git-send-email-gregoire@gentil.com>
 <1258651091-31727-2-git-send-email-gregoire@gentil.com>
 <1258651091-31727-3-git-send-email-gregoire@gentil.com>
 <1258651091-31727-4-git-send-email-gregoire@gentil.com>
 <1258651091-31727-5-git-send-email-gregoire@gentil.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:7967 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753461AbZKSRSi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Nov 2009 12:18:38 -0500
In-Reply-To: <1258651091-31727-5-git-send-email-gregoire@gentil.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Gregoire Gentil <gregoire@gentil.com>, Tony Lindgren <tony@atomide.com>, Tim Yamin <plasmaroo@gmail.com>, linux-input@vger.kernel.org


Signed-off-by: Gregoire Gentil <gregoire@gentil.com>
---
 drivers/hid/hid-alwaysinnovating.c |  262 ++++++++++++++++++++++++++++++++++++
 1 files changed, 262 insertions(+), 0 deletions(-)
 create mode 100644 drivers/hid/hid-alwaysinnovating.c

diff --git a/drivers/hid/hid-alwaysinnovating.c b/drivers/hid/hid-alwaysinnovating.c
new file mode 100644
index 0000000..a7bb0fd
--- /dev/null
+++ b/drivers/hid/hid-alwaysinnovating.c
@@ -0,0 +1,262 @@
+/*
+ *  USB HID quirks support for the Always Innovating Touch Book
+ *  Code borrowed from hid-apple.c
+ *
+ *  Copyright (c) 2009 Gregoire Gentil <gregoire@gentil.com>
+ *  Copyright (c) 2009 Tim Yamin <plasm@roo.me.uk>
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ */
+
+#include <linux/device.h>
+#include <linux/hid.h>
+#include <linux/module.h>
+#include <linux/usb.h>
+
+#include "hid-ids.h"
+
+struct touchbook_sc {
+	unsigned long quirks;
+	unsigned int  fn_on;
+	DECLARE_BITMAP(pressed_fn, KEY_CNT);
+};
+
+struct touchbook_key_translation {
+	u16 from;
+	u16 to;
+	u8 flags;
+};
+
+static struct touchbook_key_translation touchbook_fn_keys[] = {
+	{ KEY_F6,	KEY_BRIGHTNESSDOWN },
+	{ KEY_F7,	KEY_BRIGHTNESSUP },
+
+	{ KEY_F8,	KEY_MUTE },
+	{ KEY_F9,	KEY_VOLUMEDOWN },
+	{ KEY_F10,	KEY_VOLUMEUP },
+
+	{ KEY_UP,	KEY_PAGEUP },
+	{ KEY_DOWN,	KEY_PAGEDOWN },
+	{ }
+};
+
+extern unsigned long touchbook_revision;
+unsigned long swap_key;
+
+static struct touchbook_key_translation *touchbook_find_translation(
+		struct touchbook_key_translation *table, u16 from)
+{
+	struct touchbook_key_translation *trans;
+
+	/* Look for the translation */
+	for (trans = table; trans->from; trans++)
+		if (trans->from == from)
+			return trans;
+
+	return NULL;
+}
+
+static int touchbook_event(struct hid_device *hid, struct hid_field *field,
+		struct hid_usage *usage, __s32 value)
+{
+	int do_translate;
+
+	struct input_dev *input = field->hidinput->input;
+	struct touchbook_sc *asc = hid_get_drvdata(hid);
+	struct touchbook_key_translation *trans;
+
+	if (swap_key && usage->code == KEY_RIGHTSHIFT) {
+		input_event(input, usage->type, KEY_END, value);
+		return 1;
+	}
+
+	if (swap_key && usage->code == KEY_END) {
+		input_event(input, usage->type, KEY_RIGHTSHIFT, value);
+		return 1;
+	}
+
+	if (usage->code == KEY_POWER) {
+		asc->fn_on = !!value;
+		input_event(input, usage->type, usage->code, value);
+		return 1;
+	}
+
+	trans = touchbook_find_translation(touchbook_fn_keys, usage->code);
+	if (trans) {
+		if (test_bit(usage->code, asc->pressed_fn))
+			do_translate = 1;
+		else
+			do_translate = asc->fn_on;
+
+		if (do_translate) {
+			if (value)
+				set_bit(usage->code, asc->pressed_fn);
+			else
+				clear_bit(usage->code, asc->pressed_fn);
+
+			input_event(input, usage->type, trans->to,
+					value);
+
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
+static int touchbook_input_mapping(struct hid_device *hdev,
+		struct hid_input *hi,
+		struct hid_field *field, struct hid_usage *usage,
+		unsigned long **bit, int *max)
+{
+	struct touchbook_key_translation *trans;
+
+	/* Enable all other keys */
+	for (trans = touchbook_fn_keys; trans->from; trans++)
+		set_bit(trans->to, hi->input->keybit);
+
+	return 0;
+}
+
+static ssize_t show_swap_key(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%lu\n", swap_key);
+}
+
+static ssize_t store_swap_key(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	 strict_strtoul(buf, 10, &swap_key);
+
+	if (swap_key != 0 && swap_key != 1) {
+		swap_key = 0;
+		return -EINVAL;
+	}
+
+	return count;
+}
+
+static struct device_attribute touchbook_hid_attrs[] = {
+	__ATTR(swap_key, S_IRUGO | S_IWUGO, show_swap_key, store_swap_key),
+};
+
+int touchbook_create_sysfs(struct hid_device *hdev)
+{
+	int i;
+	int r;
+
+	for (i = 0; i < ARRAY_SIZE(touchbook_hid_attrs); i++) {
+		r = device_create_file(&hdev->dev,
+				&touchbook_hid_attrs[i]);
+
+		if (r) {
+			dev_err(&hdev->dev, "failed to create sysfs file\n");
+			return r;
+		}
+	}
+
+	return 0;
+}
+
+void touchbook_remove_sysfs(struct hid_device *hdev)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(touchbook_hid_attrs); i++)
+		device_remove_file(&hdev->dev,
+					&touchbook_hid_attrs[i]);
+}
+
+static int touchbook_probe(struct hid_device *hdev,
+		const struct hid_device_id *id)
+{
+	unsigned long quirks = id->driver_data;
+	struct touchbook_sc *asc;
+	unsigned int connect_mask = HID_CONNECT_DEFAULT;
+	int ret;
+
+	asc = kzalloc(sizeof(*asc), GFP_KERNEL);
+	if (asc == NULL) {
+		dev_err(&hdev->dev, "can't alloc touchbook descriptor\n");
+		return -ENOMEM;
+	}
+
+	asc->quirks = quirks;
+	hid_set_drvdata(hdev, asc);
+
+	ret = hid_parse(hdev);
+	if (ret) {
+		dev_err(&hdev->dev, "parse failed\n");
+		goto err_free;
+	}
+
+	ret = touchbook_create_sysfs(hdev);
+	if (ret) {
+		dev_err(&hdev->dev, "failed to create sysfs entries\n");
+		goto err_free;
+	}
+
+	swap_key = (touchbook_revision >= 4) ? 1 : 0;
+
+	ret = hid_hw_start(hdev, connect_mask);
+	if (ret) {
+		dev_err(&hdev->dev, "hw start failed\n");
+		goto err_free;
+	}
+
+	return 0;
+err_free:
+	kfree(asc);
+	return ret;
+}
+
+static void touchbook_remove(struct hid_device *hdev)
+{
+	hid_hw_stop(hdev);
+	kfree(hid_get_drvdata(hdev));
+	touchbook_remove_sysfs(hdev);
+}
+
+static const struct hid_device_id touchbook_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ALWAYSINNOVATING,
+		USB_DEVICE_ID_ALWAYSINNOVATING_TOUCH_BOOK) },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(hid, touchbook_devices);
+
+static struct hid_driver touchbook_driver = {
+	.name = "touchbook",
+	.id_table = touchbook_devices,
+	.probe = touchbook_probe,
+	.remove = touchbook_remove,
+	.event = touchbook_event,
+	.input_mapping = touchbook_input_mapping,
+};
+
+static int touchbook_init(void)
+{
+	int ret;
+
+	ret = hid_register_driver(&touchbook_driver);
+	if (ret)
+		printk(KERN_ERR "can't register touchbook driver\n");
+
+	return ret;
+}
+
+static void touchbook_exit(void)
+{
+	hid_unregister_driver(&touchbook_driver);
+}
+
+module_init(touchbook_init);
+module_exit(touchbook_exit);
+MODULE_LICENSE("GPL");
-- 
1.6.0.4

