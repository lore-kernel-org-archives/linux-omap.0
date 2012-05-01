From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v4 27/39] ARM: OMAP2+: board cm-t35: gpmc driver adaptation
Date: Tue, 1 May 2012 17:52:40 +0530
Message-ID: <77708569b0268a243568039c69ec4ab95ad8dfcc.1335874494.git.afzal@ti.com>
References: <cover.1335874494.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33858 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754029Ab2EAMjz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 May 2012 08:39:55 -0400
In-Reply-To: <cover.1335874494.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux@arm.linux.org.uk, khilman@ti.com, balbi@ti.com, dwmw2@infradead.org, kyungmin.park@samsung.com, gregkh@linuxfoundation.org, nm@ti.com, grinberg@compulab.co.il, notasas@gmail.com, artem.bityutskiy@linux.intel.com, vimal.newwork@gmail.com, dbaryshkov@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, linux-mtd@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

gpmc code has been converted to driver. Modify the board
code to provide gpmc driver with required information.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/board-cm-t35.c |   21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 909a8b9..5b0b637 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -66,6 +66,13 @@
 #include <linux/smsc911x.h>
 #include <plat/gpmc-smsc911x.h>
 
+static struct gpmc_device_pdata *gpmc_device_data[2];
+static struct gpmc_device_pdata **gpmc_cur = gpmc_device_data;
+
+static struct gpmc_pdata gpmc_data = {
+	.device_pdata = gpmc_device_data,
+};
+
 static struct omap_smsc911x_platform_data cm_t35_smsc911x_cfg = {
 	.id		= 0,
 	.cs             = CM_T35_SMSC911X_CS,
@@ -99,8 +106,17 @@ static void __init cm_t35_init_ethernet(void)
 	regulator_register_fixed(1, sb_t35_smsc911x_supplies,
 				 ARRAY_SIZE(sb_t35_smsc911x_supplies));
 
-	gpmc_smsc911x_init(&cm_t35_smsc911x_cfg);
-	gpmc_smsc911x_init(&sb_t35_smsc911x_cfg);
+	*gpmc_cur = gpmc_smsc911x_init(&cm_t35_smsc911x_cfg);
+	if (*gpmc_cur)
+		gpmc_data.num_device++, gpmc_cur++;
+	else
+		pr_err("error: initilaizing gpmc smsc911x instance 1\n");
+
+	*gpmc_cur = gpmc_smsc911x_init(&sb_t35_smsc911x_cfg);
+	if (*gpmc_cur)
+		gpmc_data.num_device++, gpmc_cur++;
+	else
+		pr_err("error: initilaizing gpmc smsc911x instance 2\n");
 }
 #else
 static inline void __init cm_t35_init_ethernet(void) { return; }
@@ -658,6 +674,7 @@ static void __init cm_t3x_common_init(void)
 	cm_t35_init_i2c();
 	omap_ads7846_init(1, CM_T35_GPIO_PENDOWN, 0, NULL);
 	cm_t35_init_ethernet();
+	omap_init_gpmc(&gpmc_data);
 	cm_t35_init_led();
 	cm_t35_init_display();
 
-- 
1.7.10

