From: Gregoire Gentil <gregoire@gentil.com>
Subject: [PATCH 5/8] AI TB: HID file for Always Innovating OMAP3-based
 Touch Book keyboard
Date: Wed, 18 Nov 2009 18:57:54 -0800
Message-ID: <1258599474.8001.36.camel@gregoire-laptop>
References: <1258228079.16065.17.camel@runt>
	 <1258345850.9089.21.camel@gregoire-laptop>
Reply-To: gregoire@gentil.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-kay6tHXYGCxDdbxdzlz4"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f202.google.com ([209.85.211.202]:49092 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757990AbZKSC5v (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Nov 2009 21:57:51 -0500
In-Reply-To: <1258345850.9089.21.camel@gregoire-laptop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-input@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Tim Yamin <plasmaroo@gmail.com>


--=-kay6tHXYGCxDdbxdzlz4
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Signed-off-by: Gregoire Gentil <gregoire@gentil.com>
---
drivers/hid/hid-alwaysinnovating.c |  262
++++++++++++++++++++++++++++++++++++
1 files changed, 262 insertions(+), 0 deletions(-)
create mode 100644 drivers/hid/hid-alwaysinnovating.c

diff --git a/drivers/hid/hid-alwaysinnovating.c
b/drivers/hid/hid-alwaysinnovating.c
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
+ * This program is free software; you can redistribute it and/or modify
it
+ * under the terms of the GNU General Public License as published by
the Free
+ * Software Foundation; either version 2 of the License, or (at your
option)
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
+ unsigned long quirks;
+ unsigned int  fn_on;
+ DECLARE_BITMAP(pressed_fn, KEY_CNT);
+};
+
+struct touchbook_key_translation {
+ u16 from;
+ u16 to;
+ u8 flags;
+};
+
+static struct touchbook_key_translation touchbook_fn_keys[] = {
+ { KEY_F6, KEY_BRIGHTNESSDOWN },
+ { KEY_F7, KEY_BRIGHTNESSUP },
+
+ { KEY_F8, KEY_MUTE },
+ { KEY_F9, KEY_VOLUMEDOWN },
+ { KEY_F10, KEY_VOLUMEUP },
+
+ { KEY_UP, KEY_PAGEUP },
+ { KEY_DOWN, KEY_PAGEDOWN },
+ { }
+};
+
+extern unsigned long touchbook_revision;
+unsigned long swap_key;
+
+static struct touchbook_key_translation *touchbook_find_translation(
+ struct touchbook_key_translation *table, u16 from)
+{
+ struct touchbook_key_translation *trans;
+
+ /* Look for the translation */
+ for (trans = table; trans->from; trans++)
+ if (trans->from == from)
+ return trans;
+
+ return NULL;
+}
+
+static int touchbook_event(struct hid_device *hid, struct hid_field
*field,
+ struct hid_usage *usage, __s32 value)
+{
+ int do_translate;
+
+ struct input_dev *input = field->hidinput->input;
+ struct touchbook_sc *asc = hid_get_drvdata(hid);
+ struct touchbook_key_translation *trans;
+
+ if (swap_key && usage->code == KEY_RIGHTSHIFT) {
+ input_event(input, usage->type, KEY_END, value);
+ return 1;
+ }
+
+ if (swap_key && usage->code == KEY_END) {
+ input_event(input, usage->type, KEY_RIGHTSHIFT, value);
+ return 1;
+ }
+
+ if (usage->code == KEY_POWER) {
+ asc->fn_on = !!value;
+ input_event(input, usage->type, usage->code, value);
+ return 1;
+ }
+
+ trans = touchbook_find_translation(touchbook_fn_keys, usage->code);
+ if (trans) {
+ if (test_bit(usage->code, asc->pressed_fn))
+ do_translate = 1;
+ else
+ do_translate = asc->fn_on;
+
+ if (do_translate) {
+ if (value)
+ set_bit(usage->code, asc->pressed_fn);
+ else
+ clear_bit(usage->code, asc->pressed_fn);
+
+ input_event(input, usage->type, trans->to,
+ value);
+
+ return 1;
+ }
+ }
+
+ return 0;
+}
+
+static int touchbook_input_mapping(struct hid_device *hdev,
+ struct hid_input *hi,
+ struct hid_field *field, struct hid_usage *usage,
+ unsigned long **bit, int *max)
+{
+ struct touchbook_key_translation *trans;
+
+ /* Enable all other keys */
+ for (trans = touchbook_fn_keys; trans->from; trans++)
+ set_bit(trans->to, hi->input->keybit);
+
+ return 0;
+}
+
+static ssize_t show_swap_key(struct device *dev,
+ struct device_attribute *attr, char *buf)
+{
+ return snprintf(buf, PAGE_SIZE, "%lu\n", swap_key);
+}
+
+static ssize_t store_swap_key(struct device *dev,
+ struct device_attribute *attr,
+ const char *buf, size_t count)
+{
+ strict_strtoul(buf, 10, &swap_key);
+
+ if (swap_key != 0 && swap_key != 1) {
+ swap_key = 0;
+ return -EINVAL;
+ }
+
+ return count;
+}
+
+static struct device_attribute touchbook_hid_attrs[] = {
+ __ATTR(swap_key, S_IRUGO | S_IWUGO, show_swap_key, store_swap_key),
+};
+
+int touchbook_create_sysfs(struct hid_device *hdev)
+{
+ int i;
+ int r;
+
+ for (i = 0; i < ARRAY_SIZE(touchbook_hid_attrs); i++) {
+ r = device_create_file(&hdev->dev,
+ &touchbook_hid_attrs[i]);
+
+ if (r) {
+ dev_err(&hdev->dev, "failed to create sysfs file\n");
+ return r;
+ }
+ }
+
+ return 0;
+}
+
+void touchbook_remove_sysfs(struct hid_device *hdev)
+{
+ int i;
+
+ for (i = 0; i < ARRAY_SIZE(touchbook_hid_attrs); i++)
+ device_remove_file(&hdev->dev,
+ &touchbook_hid_attrs[i]);
+}
+
+static int touchbook_probe(struct hid_device *hdev,
+ const struct hid_device_id *id)
+{
+ unsigned long quirks = id->driver_data;
+ struct touchbook_sc *asc;
+ unsigned int connect_mask = HID_CONNECT_DEFAULT;
+ int ret;
+
+ asc = kzalloc(sizeof(*asc), GFP_KERNEL);
+ if (asc == NULL) {
+ dev_err(&hdev->dev, "can't alloc touchbook descriptor\n");
+ return -ENOMEM;
+ }
+
+ asc->quirks = quirks;
+ hid_set_drvdata(hdev, asc);
+
+ ret = hid_parse(hdev);
+ if (ret) {
+ dev_err(&hdev->dev, "parse failed\n");
+ goto err_free;
+ }
+
+ ret = touchbook_create_sysfs(hdev);
+ if (ret) {
+ dev_err(&hdev->dev, "failed to create sysfs entries\n");
+ goto err_free;
+ }
+
+ swap_key = (touchbook_revision >= 4) ? 1 : 0;
+
+ ret = hid_hw_start(hdev, connect_mask);
+ if (ret) {
+ dev_err(&hdev->dev, "hw start failed\n");
+ goto err_free;
+ }
+
+ return 0;
+err_free:
+ kfree(asc);
+ return ret;
+}
+
+static void touchbook_remove(struct hid_device *hdev)
+{
+ hid_hw_stop(hdev);
+ kfree(hid_get_drvdata(hdev));
+ touchbook_remove_sysfs(hdev);
+}
+
+static const struct hid_device_id touchbook_devices[] = {
+ { HID_USB_DEVICE(USB_VENDOR_ID_ALWAYSINNOVATING,
+ USB_DEVICE_ID_ALWAYSINNOVATING_TOUCH_BOOK) },
+ { }
+};
+
+MODULE_DEVICE_TABLE(hid, touchbook_devices);
+
+static struct hid_driver touchbook_driver = {
+ .name = "touchbook",
+ .id_table = touchbook_devices,
+ .probe = touchbook_probe,
+ .remove = touchbook_remove,
+ .event = touchbook_event,
+ .input_mapping = touchbook_input_mapping,
+};
+
+static int touchbook_init(void)
+{
+ int ret;
+
+ ret = hid_register_driver(&touchbook_driver);
+ if (ret)
+ printk(KERN_ERR "can't register touchbook driver\n");
+
+ return ret;
+}
+
+static void touchbook_exit(void)
+{
+ hid_unregister_driver(&touchbook_driver);
+}
+
+module_init(touchbook_init);
+module_exit(touchbook_exit);
+MODULE_LICENSE("GPL");
-- 
1.6.0.4



--=-kay6tHXYGCxDdbxdzlz4
Content-Disposition: attachment; filename*0=0005-HID-file-for-Always-Innovating-OMAP3-based-Touch-Boo.pat; filename*1=ch
Content-Type: text/x-patch; name="0005-HID-file-for-Always-Innovating-OMAP3-based-Touch-Boo.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From 436ef715c4c097b0a9577d3eddefeb6220ecebeb Mon Sep 17 00:00:00 2001
From: Gregoire Gentil <gregoire@gentil.com>
Date: Wed, 18 Nov 2009 18:33:15 -0800
Subject: [PATCH] HID file for Always Innovating OMAP3-based Touch Book keyboard


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


--=-kay6tHXYGCxDdbxdzlz4
Content-Disposition: attachment; filename*0=0005-HID-file-for-Always-Innovating-OMAP3-based-Touch-Boo.pat; filename*1=ch.zip
Content-Type: application/zip; name*0=0005-HID-file-for-Always-Innovating-OMAP3-based-Touch-Boo.patch.z; name*1=ip
Content-Transfer-Encoding: base64

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


--=-kay6tHXYGCxDdbxdzlz4--

