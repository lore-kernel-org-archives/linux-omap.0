From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCHv2 1/5] Input: add common DT binding for touchscreens
Date: Sun,  6 Apr 2014 00:26:57 +0200
Message-ID: <1396736821-14395-2-git-send-email-sre@kernel.org>
References: <1396736821-14395-1-git-send-email-sre@kernel.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1396736821-14395-1-git-send-email-sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-GFxCN5SEZAc@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dtor-JGs/UdohzUI@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add common DT binding documentation for touchscreen devices and
implement input_parse_touchscreen_of_params, which parses the common
properties and configures the input device accordingly.

Signed-off-by: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 .../bindings/input/touchscreen/touchscreen.txt     |  9 ++++++
 drivers/input/input.c                              | 34 ++++++++++++++++++++++
 include/linux/input.h                              |  8 +++++
 3 files changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
new file mode 100644
index 0000000..a2ff0a0
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
@@ -0,0 +1,9 @@
+General Touchscreen Properties:
+
+Optional properties for Touchscreens:
+ - touchscreen-size-x		: horizontal resolution of touchscreen
+ - touchscreen-size-y		: vertical resolution of touchscreen
+ - touchscreen-max-pressure	: maximum reported pressure
+ - touchscreen-fuzz-x		: horizontal noise value of the absolute input device
+ - touchscreen-fuzz-y		: vertical noise value of the absolute input device
+ - touchscreen-fuzz-pressure	: pressure noise value of the absolute input device
diff --git a/drivers/input/input.c b/drivers/input/input.c
index 1c4c0db..97966d93 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -27,6 +27,7 @@
 #include <linux/device.h>
 #include <linux/mutex.h>
 #include <linux/rcupdate.h>
+#include <linux/of.h>
 #include "input-compat.h"
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech-AlSwsSmVLrQ@public.gmane.org>");
@@ -2398,6 +2399,39 @@ void input_free_minor(unsigned int minor)
 }
 EXPORT_SYMBOL(input_free_minor);
 
+#if defined(CONFIG_OF)
+/**
+ * input_parse_touchscreen_of_params - parse common touchscreen DT properties
+ * @dev: device that should be parsed
+ *
+ * This function parses common DT properties for touchscreens and setups the
+ * input device accordingly. The function keeps previously setuped default
+ * values if no value is specified via DT.
+ */
+void input_parse_touchscreen_of_params(struct input_dev *dev)
+{
+	struct device_node *np = dev->dev.parent->of_node;
+	struct input_absinfo *absinfo;
+
+	input_alloc_absinfo(dev);
+	if (!dev->absinfo)
+		return;
+
+	absinfo = &dev->absinfo[ABS_X];
+	of_property_read_u32(np, "touchscreen-size-x", &absinfo->maximum);
+	of_property_read_u32(np, "touchscreen-fuzz-x", &absinfo->fuzz);
+
+	absinfo = &dev->absinfo[ABS_Y];
+	of_property_read_u32(np, "touchscreen-size-y", &absinfo->maximum);
+	of_property_read_u32(np, "touchscreen-fuzz-y", &absinfo->fuzz);
+
+	absinfo = &dev->absinfo[ABS_PRESSURE];
+	of_property_read_u32(np, "touchscreen-max-pressure", &absinfo->maximum);
+	of_property_read_u32(np, "touchscreen-fuzz-pressure", &absinfo->fuzz);
+}
+EXPORT_SYMBOL(input_parse_touchscreen_of_params);
+#endif
+
 static int __init input_init(void)
 {
 	int err;
diff --git a/include/linux/input.h b/include/linux/input.h
index 82ce323..3dc3b1e 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -531,4 +531,12 @@ int input_ff_erase(struct input_dev *dev, int effect_id, struct file *file);
 int input_ff_create_memless(struct input_dev *dev, void *data,
 		int (*play_effect)(struct input_dev *, void *, struct ff_effect *));
 
+#if defined(CONFIG_OF)
+void input_parse_touchscreen_of_params(struct input_dev *dev);
+#else
+static inline void input_parse_touchscreen_of_params(struct input_dev *dev) {
+	return;
+}
+#endif
+
 #endif
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
