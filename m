From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 01/30] include: linux: platform_device: more helpers for declaring platform drivers
Date: Mon, 17 Jun 2019 20:40:42 +0200
Message-ID: <1560796871-18560-1-git-send-email-info@metux.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: thloh@altera.com, linus.walleij@linaro.org, bgolaszewski@baylibre.com, andriy.shevchenko@linux.intel.com, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, grygorii.strashko@ti.com, ssantosh@kernel.org, khilman@kernel.org, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org, patches@opensource.cirrus.com
List-Id: linux-omap@vger.kernel.org

From: Enrico Weigelt <info@metux.net>

Add more helper macros for trivial driver init cases, similar to the
already existing module_platform_driver()+friends - now for those which
are initialized at other stages. Lots of drivers couldn't use the existing
macros, as they need to be called at different init stages, eg. subsys,
postcore, arch.

This helps to further reduce driver init boilerplate.

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 include/linux/platform_device.h | 51 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index beb25f2..5f3a967 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -259,6 +259,57 @@ static inline void platform_set_drvdata(struct platform_device *pdev,
 } \
 module_exit(__platform_driver##_exit);
 
+/* postcore_platform_driver() - Helper macro for drivers that don't do
+ * anything special in module init/exit.  This eliminates a lot of
+ * boilerplate.  Each module may only use this macro once, and
+ * calling it replaces postcore_initcall() and module_exit()
+ */
+#define postcore_platform_driver(__platform_driver) \
+static int __init __platform_driver##_init(void) \
+{ \
+	return platform_driver_register(&(__platform_driver)); \
+} \
+postcore_initcall(__platform_driver##_init); \
+static void __exit __platform_driver##_exit(void) \
+{ \
+	platform_driver_unregister(&(__platform_driver)); \
+} \
+module_exit(__platform_driver##_exit);
+
+/* subsys_platform_driver() - Helper macro for drivers that don't do
+ * anything special in module init/exit.  This eliminates a lot of
+ * boilerplate.  Each module may only use this macro once, and
+ * calling it replaces subsys_initcall() and module_exit()
+ */
+#define subsys_platform_driver(__platform_driver) \
+static int __init __platform_driver##_init(void) \
+{ \
+	return platform_driver_register(&(__platform_driver)); \
+} \
+subsys_initcall(__platform_driver##_init); \
+static void __exit __platform_driver##_exit(void) \
+{ \
+	platform_driver_unregister(&(__platform_driver)); \
+} \
+module_exit(__platform_driver##_exit);
+
+/* arch_platform_driver() - Helper macro for drivers that don't do
+ * anything special in module init/exit.  This eliminates a lot of
+ * boilerplate.  Each module may only use this macro once, and
+ * calling it replaces arch_initcall() and module_exit()
+ */
+#define arch_platform_driver(__platform_driver) \
+static int __init __platform_driver##_init(void) \
+{ \
+	return platform_driver_register(&(__platform_driver)); \
+} \
+arch_initcall(__platform_driver##_init); \
+static void __exit __platform_driver##_exit(void) \
+{ \
+	platform_driver_unregister(&(__platform_driver)); \
+} \
+module_exit(__platform_driver##_exit);
+
 /* builtin_platform_driver_probe() - Helper macro for drivers that don't do
  * anything special in device init.  This eliminates some boilerplate.  Each
  * driver may only use this macro once, and using it replaces device_initcall.
-- 
1.9.1
