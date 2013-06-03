From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/5] extcon: Add an API to get extcon device from dt node
Date: Mon, 3 Jun 2013 21:43:36 +0530
Message-ID: <1370276020-17446-2-git-send-email-kishon@ti.com>
References: <1370276020-17446-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1370276020-17446-1-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, anish198519851985-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, benoit.cousson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Added an API of_extcon_get_extcon_dev() to be used by drivers to get
extcon device in the case of dt boot (this can be used instead of
extcon_get_extcon_dev()).

Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
---
 drivers/extcon/extcon-class.c |   40 ++++++++++++++++++++++++++++++++++++++++
 include/linux/extcon.h        |    8 ++++++++
 2 files changed, 48 insertions(+)

diff --git a/drivers/extcon/extcon-class.c b/drivers/extcon/extcon-class.c
index 60adc04..265d549 100644
--- a/drivers/extcon/extcon-class.c
+++ b/drivers/extcon/extcon-class.c
@@ -31,6 +31,7 @@
 #include <linux/extcon.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
+#include <linux/of_platform.h>
 
 /*
  * extcon_cable_name suggests the standard cable names for commonly used
@@ -392,6 +393,45 @@ int extcon_set_cable_state(struct extcon_dev *edev,
 }
 EXPORT_SYMBOL_GPL(extcon_set_cable_state);
 
+struct extcon_dev *of_extcon_get_extcon_dev(struct device *dev, int index)
+{
+	struct class_dev_iter iter;
+	struct device *extcon_dev;
+	struct device_node *node;
+	struct platform_device *extcon_parent_dev;
+
+	if (!dev->of_node) {
+		dev_dbg(dev, "device does not have a device node entry\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	node = of_parse_phandle(dev->of_node, "extcon", index);
+	if (!node) {
+		dev_dbg(dev, "failed to get phandle in %s node\n",
+			dev->of_node->full_name);
+		return ERR_PTR(-ENODEV);
+	}
+
+	extcon_parent_dev = of_find_device_by_node(node);
+	if (!extcon_parent_dev) {
+		dev_dbg(dev, "unable to find device by node\n");
+		return ERR_PTR(-EPROBE_DEFER);
+	}
+
+	class_dev_iter_init(&iter, extcon_class, NULL, NULL);
+	while ((extcon_dev = class_dev_iter_next(&iter))) {
+		if (extcon_dev->parent != &extcon_parent_dev->dev)
+			continue;
+
+		class_dev_iter_exit(&iter);
+		return dev_get_drvdata(extcon_dev);
+	}
+
+	class_dev_iter_exit(&iter);
+	return ERR_PTR(-ENODEV);
+}
+EXPORT_SYMBOL_GPL(of_extcon_get_extcon_dev);
+
 /**
  * extcon_get_extcon_dev() - Get the extcon device instance from the name
  * @extcon_name:	The extcon name provided with extcon_dev_register()
diff --git a/include/linux/extcon.h b/include/linux/extcon.h
index fcb51c8..3858bb9 100644
--- a/include/linux/extcon.h
+++ b/include/linux/extcon.h
@@ -182,6 +182,8 @@ struct extcon_specific_cable_nb {
  */
 extern int extcon_dev_register(struct extcon_dev *edev, struct device *dev);
 extern void extcon_dev_unregister(struct extcon_dev *edev);
+extern struct extcon_dev *of_extcon_get_extcon_dev(struct device *dev,
+	int index);
 extern struct extcon_dev *extcon_get_extcon_dev(const char *extcon_name);
 
 /*
@@ -292,6 +294,12 @@ static inline int extcon_set_cable_state(struct extcon_dev *edev,
 	return 0;
 }
 
+static inline struct extcon_dev *of_extcon_get_extcon_dev(struct device *dev,
+	int index)
+{
+	return NULL;
+}
+
 static inline struct extcon_dev *extcon_get_extcon_dev(const char *extcon_name)
 {
 	return NULL;
-- 
1.7.10.4
