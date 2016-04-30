From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 5/6] HSI: omap_ssi: built omap_ssi and omap_ssi_port into one module
Date: Sat, 30 Apr 2016 04:09:12 +0200
Message-ID: <1461982153-19139-6-git-send-email-sre@kernel.org>
References: <1461982153-19139-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461982153-19139-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: linux-omap@vger.kernel.org

Merge omap_ssi and omap_ssi_port into one module. This
fixes problems with module cycle dependencies introduced
by future patches.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/hsi/controllers/Kconfig                         |  5 -----
 drivers/hsi/controllers/Makefile                        |  4 ++--
 drivers/hsi/controllers/omap_ssi.h                      |  2 ++
 drivers/hsi/controllers/{omap_ssi.c => omap_ssi_core.c} | 17 ++++++++++++++++-
 drivers/hsi/controllers/omap_ssi_port.c                 | 16 +---------------
 5 files changed, 21 insertions(+), 23 deletions(-)
 rename drivers/hsi/controllers/{omap_ssi.c => omap_ssi_core.c} (97%)

diff --git a/drivers/hsi/controllers/Kconfig b/drivers/hsi/controllers/Kconfig
index 6aba27808172..084ec97eec64 100644
--- a/drivers/hsi/controllers/Kconfig
+++ b/drivers/hsi/controllers/Kconfig
@@ -12,8 +12,3 @@ config OMAP_SSI
 	  If you say Y here, you will enable the OMAP SSI hardware driver.
 
 	  If unsure, say N.
-
-config OMAP_SSI_PORT
-	tristate
-	default m if OMAP_SSI=m
-	default y if OMAP_SSI=y
diff --git a/drivers/hsi/controllers/Makefile b/drivers/hsi/controllers/Makefile
index d2665cf9c545..7aba9c7f71bb 100644
--- a/drivers/hsi/controllers/Makefile
+++ b/drivers/hsi/controllers/Makefile
@@ -2,5 +2,5 @@
 # Makefile for HSI controllers drivers
 #
 
-obj-$(CONFIG_OMAP_SSI)		+= omap_ssi.o
-obj-$(CONFIG_OMAP_SSI_PORT)	+= omap_ssi_port.o
+omap_ssi-objs		+= omap_ssi_core.o omap_ssi_port.o
+obj-$(CONFIG_OMAP_SSI)	+= omap_ssi.o
diff --git a/drivers/hsi/controllers/omap_ssi.h b/drivers/hsi/controllers/omap_ssi.h
index 1fa028078a3c..e493321cb0c3 100644
--- a/drivers/hsi/controllers/omap_ssi.h
+++ b/drivers/hsi/controllers/omap_ssi.h
@@ -164,4 +164,6 @@ struct omap_ssi_controller {
 #endif
 };
 
+extern struct platform_driver ssi_port_pdriver;
+
 #endif /* __LINUX_HSI_OMAP_SSI_H__ */
diff --git a/drivers/hsi/controllers/omap_ssi.c b/drivers/hsi/controllers/omap_ssi_core.c
similarity index 97%
rename from drivers/hsi/controllers/omap_ssi.c
rename to drivers/hsi/controllers/omap_ssi_core.c
index 68dfdaa19938..535c76038288 100644
--- a/drivers/hsi/controllers/omap_ssi.c
+++ b/drivers/hsi/controllers/omap_ssi_core.c
@@ -605,7 +605,22 @@ static struct platform_driver ssi_pdriver = {
 	},
 };
 
-module_platform_driver(ssi_pdriver);
+static int __init ssi_init(void) {
+	int ret;
+
+	ret = platform_driver_register(&ssi_pdriver);
+	if (ret)
+		return ret;
+
+	return platform_driver_register(&ssi_port_pdriver);
+}
+module_init(ssi_init);
+
+static void __exit ssi_exit(void) {
+	platform_driver_unregister(&ssi_port_pdriver);
+	platform_driver_unregister(&ssi_pdriver);
+}
+module_exit(ssi_exit);
 
 MODULE_ALIAS("platform:omap_ssi");
 MODULE_AUTHOR("Carlos Chinea <carlos.chinea@nokia.com>");
diff --git a/drivers/hsi/controllers/omap_ssi_port.c b/drivers/hsi/controllers/omap_ssi_port.c
index 530095ed39e7..1569bbb53ee8 100644
--- a/drivers/hsi/controllers/omap_ssi_port.c
+++ b/drivers/hsi/controllers/omap_ssi_port.c
@@ -1117,11 +1117,6 @@ static int ssi_port_probe(struct platform_device *pd)
 
 	dev_dbg(&pd->dev, "init ssi port...\n");
 
-	if (!try_module_get(ssi->owner)) {
-		dev_err(&pd->dev, "could not increment parent module refcount\n");
-		return -ENODEV;
-	}
-
 	if (!ssi->port || !omap_ssi->port) {
 		dev_err(&pd->dev, "ssi controller not initialized!\n");
 		err = -ENODEV;
@@ -1242,7 +1237,6 @@ static int ssi_port_remove(struct platform_device *pd)
 
 	omap_ssi->port[omap_port->port_id] = NULL;
 	platform_set_drvdata(pd, NULL);
-	module_put(ssi->owner);
 	pm_runtime_disable(&pd->dev);
 
 	return 0;
@@ -1369,7 +1363,7 @@ MODULE_DEVICE_TABLE(of, omap_ssi_port_of_match);
 #define omap_ssi_port_of_match NULL
 #endif
 
-static struct platform_driver ssi_port_pdriver = {
+struct platform_driver ssi_port_pdriver = {
 	.probe = ssi_port_probe,
 	.remove	= ssi_port_remove,
 	.driver	= {
@@ -1378,11 +1372,3 @@ static struct platform_driver ssi_port_pdriver = {
 		.pm	= DEV_PM_OPS,
 	},
 };
-
-module_platform_driver(ssi_port_pdriver);
-
-MODULE_ALIAS("platform:omap_ssi_port");
-MODULE_AUTHOR("Carlos Chinea <carlos.chinea@nokia.com>");
-MODULE_AUTHOR("Sebastian Reichel <sre@kernel.org>");
-MODULE_DESCRIPTION("Synchronous Serial Interface Port Driver");
-MODULE_LICENSE("GPL v2");
-- 
2.8.1
