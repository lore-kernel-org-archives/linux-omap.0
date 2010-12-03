From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/6] omap2+: Add struct omap_device_board_data and allow
	omap_device_build initialize pads to mux
Date: Thu, 02 Dec 2010 16:45:26 -0800
Message-ID: <20101203004526.31687.72682.stgit@baageli.muru.com>
References: <20101203004040.31687.9476.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:33916 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932080Ab0LCApe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Dec 2010 19:45:34 -0500
In-Reply-To: <20101203004040.31687.9476.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

This way board specific pads can be initialized automatically.
Note that this does not currently handle the multiple hwmod case.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/devices.c                 |    2 +-
 arch/arm/mach-omap2/gpio.c                    |    2 +-
 arch/arm/mach-omap2/pm.c                      |    3 ++-
 arch/arm/mach-omap2/serial.c                  |    4 ++--
 arch/arm/plat-omap/i2c.c                      |    4 ++--
 arch/arm/plat-omap/include/plat/omap_device.h |   19 +++++++++++++++++--
 arch/arm/plat-omap/omap_device.c              |   14 ++++++++++++--
 7 files changed, 37 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 5a0c148..389337c 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -1059,7 +1059,7 @@ static int __init omap_init_wdt(void)
 		return -EINVAL;
 	}
 
-	od = omap_device_build(dev_name, id, oh, NULL, 0,
+	od = omap_device_build(dev_name, id, oh, NULL, NULL, 0,
 				omap_wdt_latency,
 				ARRAY_SIZE(omap_wdt_latency), 0);
 	WARN(IS_ERR(od), "Cant build omap_device for %s:%s.\n",
diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
index 413de18..488b769 100644
--- a/arch/arm/mach-omap2/gpio.c
+++ b/arch/arm/mach-omap2/gpio.c
@@ -75,7 +75,7 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 		return -EINVAL;
 	}
 
-	od = omap_device_build(name, id - 1, oh, pdata,
+	od = omap_device_build(name, id - 1, oh, NULL, pdata,
 				sizeof(*pdata),	omap_gpio_latency,
 				ARRAY_SIZE(omap_gpio_latency),
 				false);
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 59ca03b..574b004 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -64,7 +64,8 @@ static int _init_omap_device(char *name, struct device **new_dev)
 		 __func__, name))
 		return -ENODEV;
 
-	od = omap_device_build(oh->name, 0, oh, NULL, 0, pm_lats, 0, false);
+	od = omap_device_build(oh->name, 0, oh, NULL, NULL, 0,
+			       pm_lats, 0, false);
 	if (WARN(IS_ERR(od), "%s: could not build omap_device for %s\n",
 		 __func__, name))
 		return -ENODEV;
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 9dc077e..905626e 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -797,8 +797,8 @@ void __init omap_serial_init_port(int port)
 	if (WARN_ON(!oh))
 		return;
 
-	od = omap_device_build(name, uart->num, oh, pdata, pdata_size,
-			       omap_uart_latency,
+	od = omap_device_build(name, uart->num, oh, NULL,
+			       pdata, pdata_size, omap_uart_latency,
 			       ARRAY_SIZE(omap_uart_latency), false);
 	WARN(IS_ERR(od), "Could not build omap_device for %s: %s.\n",
 	     name, oh->name);
diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index a5bff9c..8275e41 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -154,8 +154,8 @@ static inline int omap2_i2c_add_bus(int bus_id)
 	 */
 	if (cpu_is_omap34xx())
 		pdata->set_mpu_wkup_lat = omap_pm_set_max_mpu_wakeup_lat_compat;
-	od = omap_device_build(name, bus_id, oh, pdata,
-			sizeof(struct omap_i2c_bus_platform_data),
+	od = omap_device_build(name, bus_id, oh, NULL,
+			pdata, sizeof(struct omap_i2c_bus_platform_data),
 			omap_i2c_latency, ARRAY_SIZE(omap_i2c_latency), 0);
 	WARN(IS_ERR(od), "Could not build omap_device for %s\n", name);
 
diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
index 28e2d1a..9d179d7 100644
--- a/arch/arm/plat-omap/include/plat/omap_device.h
+++ b/arch/arm/plat-omap/include/plat/omap_device.h
@@ -45,6 +45,20 @@ extern struct device omap_device_parent;
 #define OMAP_DEVICE_STATE_SHUTDOWN	3
 
 /**
+ * struct omap_device_board_data - board specific device data
+ * @id: instance id
+ * @flags: additional flags for platform init code
+ * @pads: array of device specific pads
+ * @pads_cnt: ARRAY_SIZE() of pads
+ */
+struct omap_device_board_data {
+	int			id;
+	u32			flags;
+	struct omap_device_pad	*pads;
+	int			pads_cnt;
+};
+
+/**
  * struct omap_device - omap_device wrapper for platform_devices
  * @pdev: platform_device
  * @hwmods: (one .. many per omap_device)
@@ -87,8 +101,9 @@ int omap_device_count_resources(struct omap_device *od);
 int omap_device_fill_resources(struct omap_device *od, struct resource *res);
 
 struct omap_device *omap_device_build(const char *pdev_name, int pdev_id,
-				      struct omap_hwmod *oh, void *pdata,
-				      int pdata_len,
+				      struct omap_hwmod *oh,
+				      struct omap_device_board_data *bdata,
+				      void *pdata, int pdata_len,
 				      struct omap_device_pm_latency *pm_lats,
 				      int pm_lats_cnt, int is_early_device);
 
diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index abe933c..a9a57ba 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -338,6 +338,7 @@ int omap_device_fill_resources(struct omap_device *od, struct resource *res)
  * @pdev_name: name of the platform_device driver to use
  * @pdev_id: this platform_device's connection ID
  * @oh: ptr to the single omap_hwmod that backs this omap_device
+ * @bdata: board specific device data
  * @pdata: platform_data ptr to associate with the platform_device
  * @pdata_len: amount of memory pointed to by @pdata
  * @pm_lats: pointer to a omap_device_pm_latency array for this device
@@ -351,8 +352,9 @@ int omap_device_fill_resources(struct omap_device *od, struct resource *res)
  * passes along the return value of omap_device_build_ss().
  */
 struct omap_device *omap_device_build(const char *pdev_name, int pdev_id,
-				      struct omap_hwmod *oh, void *pdata,
-				      int pdata_len,
+				      struct omap_hwmod *oh,
+				      struct omap_device_board_data *bdata,
+				      void *pdata, int pdata_len,
 				      struct omap_device_pm_latency *pm_lats,
 				      int pm_lats_cnt, int is_early_device)
 {
@@ -361,6 +363,14 @@ struct omap_device *omap_device_build(const char *pdev_name, int pdev_id,
 	if (!oh)
 		return ERR_PTR(-EINVAL);
 
+	if (bdata && bdata->pads && bdata->pads_cnt) {
+		struct omap_hwmod_mux_info *hmux;
+
+		hmux = omap_hwmod_mux_init(bdata->pads, bdata->pads_cnt);
+		if (hmux)
+			oh->mux = hmux;
+	}
+
 	return omap_device_build_ss(pdev_name, pdev_id, ohs, 1, pdata,
 				    pdata_len, pm_lats, pm_lats_cnt,
 				    is_early_device);

