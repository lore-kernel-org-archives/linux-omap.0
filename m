From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 1/4] OMAP2: Fix compile breaks
Date: Mon, 14 Dec 2009 14:42:36 +0530
Message-ID: <1260781959-28050-1-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37240 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752413AbZLNJMo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Dec 2009 04:12:44 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id nBE9CekE026343
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 14 Dec 2009 03:12:43 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>

Fixes a couple of implicit function definition errors
for functions defined only for omap3 and called in omap2/3
common code, and one function argument mismatch.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/board-2430sdp.c |    2 +-
 arch/arm/mach-omap2/serial.c        |    1 +
 arch/arm/plat-omap/i2c.c            |    2 ++
 3 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index db9374b..dea1425 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -147,7 +147,7 @@ static void __init omap_2430sdp_init_irq(void)
 {
 	omap_board_config = sdp2430_config;
 	omap_board_config_size = ARRAY_SIZE(sdp2430_config);
-	omap2_init_common_hw(NULL, NULL);
+	omap2_init_common_hw(NULL, NULL, NULL, NULL, NULL);
 	omap_init_irq();
 	omap_gpio_init();
 }
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index c067416..5c65d2d 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -500,6 +500,7 @@ DEVICE_ATTR(sleep_timeout, 0644, sleep_timeout_show, sleep_timeout_store);
 #define DEV_CREATE_FILE(dev, attr) WARN_ON(device_create_file(dev, attr))
 #else
 static inline void omap_uart_idle_init(struct omap_uart_state *uart) {}
+static inline void omap_uart_block_sleep(struct omap_uart_state *uart){}
 #define DEV_CREATE_FILE(dev, attr)
 #endif /* CONFIG_PM */
 
diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index fb447c1..f8eb3a0 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -117,6 +117,8 @@ static void omap_i2c_set_wfc_mpu_wkup_lat(struct device *dev, int val)
 {
 	omap_pm_set_max_mpu_wakeup_lat(dev, val);
 }
+#else
+static inline void omap_i2c_set_wfc_mpu_wkup_lat(struct device *dev, int val){}
 #endif
 
 static void __init omap_set_i2c_constraint_func(
-- 
1.5.4.7

