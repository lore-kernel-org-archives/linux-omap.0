From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v3 7/9] of: platform: Add a function to get platfrom data from device node
Date: Thu, 16 Nov 2017 09:53:40 +0530
Message-ID: <1510806222-22096-8-git-send-email-j-keerthy@ti.com>
References: <1510806222-22096-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <1510806222-22096-1-git-send-email-j-keerthy@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
To: tony@atomide.com, aaro.koskinen@iki.fi, thierry.reding@gmail.com
Cc: j-keerthy@ti.com, linux@armlinux.org.uk, daniel.lezcano@linaro.org, robh+dt@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, grygorii.strashko@ti.com, sebastian.reichel@collabora.co.uk, ladis@linux-mips.org
List-Id: linux-omap@vger.kernel.org

Add a function to get platfrom data from device node.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/of/platform.c       | 23 +++++++++++++++++++++++
 include/linux/of_platform.h |  6 ++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index b7cf84b..b9edfcf 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -60,6 +60,29 @@ struct platform_device *of_find_device_by_node(struct device_node *np)
 }
 EXPORT_SYMBOL(of_find_device_by_node);
 
+/**
+ * of_find_platdata_by_node - Find the platform_data associated with a node
+ * @np: Pointer to device tree node
+ *
+ * Fetches the platform device pointer of device tree node and in turn gets the
+ * associated platform data. 
+ *
+ * Returns platform_data pointer, or NULL if not found
+ */
+void *of_find_platdata_by_node(struct device_node *np)
+{
+	struct platform_device *pdev;
+
+	pdev = of_find_device_by_node(np);
+	if (!pdev) {
+		pr_err("Unable to find pdev\n");
+		return pdev;
+	}
+
+	return dev_get_platdata(&pdev->dev);
+}
+EXPORT_SYMBOL(of_find_platdata_by_node);
+
 #ifdef CONFIG_OF_ADDRESS
 /*
  * The following routines scan a subtree and registers a device for
diff --git a/include/linux/of_platform.h b/include/linux/of_platform.h
index fb908e5..77b770f 100644
--- a/include/linux/of_platform.h
+++ b/include/linux/of_platform.h
@@ -59,11 +59,17 @@ extern struct platform_device *of_device_alloc(struct device_node *np,
 					 struct device *parent);
 #ifdef CONFIG_OF
 extern struct platform_device *of_find_device_by_node(struct device_node *np);
+extern void *of_find_platdata_by_node(struct device_node *np);
 #else
 static inline struct platform_device *of_find_device_by_node(struct device_node *np)
 {
 	return NULL;
 }
+
+static void *of_find_platdata_by_node(struct device_node *np)
+{
+	return NULL;
+}
 #endif
 
 /* Platform devices and busses creation */
-- 
1.9.1
