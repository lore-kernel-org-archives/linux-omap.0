From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH] ARM: OMAP2+: omap-usb-host: Fix memory leaks
Date: Fri, 24 May 2013 16:06:58 +0300
Message-ID: <1369400818-31625-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tony@atomide.com
Cc: linux@arm.linux.org.uk, shc_work@mail.ru, linux-kernel@vger.kernel.org, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Fix memory leaks in the error path.
Also, use platform_device_register_full() to allocate
the platform devices and set platform data.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/mach-omap2/usb-host.c |  106 +++++++++++++++++++++-------------------
 1 files changed, 56 insertions(+), 50 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-host.c b/arch/arm/mach-omap2/usb-host.c
index aa27d7f..609b330 100644
--- a/arch/arm/mach-omap2/usb-host.c
+++ b/arch/arm/mach-omap2/usb-host.c
@@ -28,6 +28,7 @@
 #include <linux/io.h>
 #include <linux/gpio.h>
 #include <linux/usb/phy.h>
+#include <linux/usb/nop-usb-xceiv.h>
 
 #include "soc.h"
 #include "omap_device.h"
@@ -560,7 +561,8 @@ static int usbhs_add_regulator(char *name, char *dev_id, char *dev_supply,
 	struct regulator_init_data *reg_data;
 	struct fixed_voltage_config *config;
 	struct platform_device *pdev;
-	int ret;
+	struct platform_device_info pdevinfo;
+	int ret = -ENOMEM;
 
 	supplies = kzalloc(sizeof(*supplies), GFP_KERNEL);
 	if (!supplies)
@@ -571,7 +573,7 @@ static int usbhs_add_regulator(char *name, char *dev_id, char *dev_supply,
 
 	reg_data = kzalloc(sizeof(*reg_data), GFP_KERNEL);
 	if (!reg_data)
-		return -ENOMEM;
+		goto err_data;
 
 	reg_data->constraints.valid_ops_mask = REGULATOR_CHANGE_STATUS;
 	reg_data->consumer_supplies = supplies;
@@ -580,39 +582,53 @@ static int usbhs_add_regulator(char *name, char *dev_id, char *dev_supply,
 	config = kmemdup(&hsusb_reg_config, sizeof(hsusb_reg_config),
 			GFP_KERNEL);
 	if (!config)
-		return -ENOMEM;
+		goto err_config;
+
+	config->supply_name = kstrdup(name, GFP_KERNEL);
+	if (!config->supply_name)
+		goto err_supplyname;
 
-	config->supply_name = name;
 	config->gpio = gpio;
 	config->enable_high = polarity;
 	config->init_data = reg_data;
 
 	/* create a regulator device */
-	pdev = kzalloc(sizeof(*pdev), GFP_KERNEL);
-	if (!pdev)
-		return -ENOMEM;
+	memset(&pdevinfo, 0, sizeof(pdevinfo));
+	pdevinfo.name = reg_name;
+	pdevinfo.id = PLATFORM_DEVID_AUTO;
+	pdevinfo.data = config;
+	pdevinfo.size_data = sizeof(*config);
 
-	pdev->id = PLATFORM_DEVID_AUTO;
-	pdev->name = reg_name;
-	pdev->dev.platform_data = config;
+	pdev = platform_device_register_full(&pdevinfo);
+	if (IS_ERR(pdev)) {
+		ret = PTR_ERR(pdev);
+		pr_err("%s: Failed registering regulator %s for %s : %d\n",
+				__func__, name, dev_id, ret);
+		goto err_register;
+	}
 
-	ret = platform_device_register(pdev);
-	if (ret)
-		pr_err("%s: Failed registering regulator %s for %s\n",
-				__func__, name, dev_id);
+	return 0;
 
+err_register:
+	kfree(config->supply_name);
+err_supplyname:
+	kfree(config);
+err_config:
+	kfree(reg_data);
+err_data:
+	kfree(supplies);
 	return ret;
 }
 
+#define MAX_STR 20
+
 int usbhs_init_phys(struct usbhs_phy_data *phy, int num_phys)
 {
-	char *rail_name;
-	int i, len;
+	char rail_name[MAX_STR];
+	int i;
 	struct platform_device *pdev;
 	char *phy_id;
-
-	/* the phy_id will be something like "nop_usb_xceiv.1" */
-	len = strlen(nop_name) + 3; /* 3 -> ".1" and NULL terminator */
+	struct platform_device_info pdevinfo;
 
 	for (i = 0; i < num_phys; i++) {
 
@@ -627,25 +643,26 @@ int usbhs_init_phys(struct usbhs_phy_data *phy, int num_phys)
 			!gpio_is_valid(phy->vcc_gpio))
 			continue;
 
-		/* create a NOP PHY device */
-		pdev = kzalloc(sizeof(*pdev), GFP_KERNEL);
-		if (!pdev)
-			return -ENOMEM;
-
-		pdev->id = phy->port;
-		pdev->name = nop_name;
-		pdev->dev.platform_data = phy->platform_data;
-
-		phy_id = kmalloc(len, GFP_KERNEL);
-		if (!phy_id)
+		phy_id = kmalloc(MAX_STR, GFP_KERNEL);
+		if (!phy_id) {
+			pr_err("%s: kmalloc() failed\n", __func__);
 			return -ENOMEM;
+		}
 
-		scnprintf(phy_id, len, "nop_usb_xceiv.%d\n",
-					pdev->id);
-
-		if (platform_device_register(pdev)) {
-			pr_err("%s: Failed to register device %s\n",
-				__func__,  phy_id);
+		/* create a NOP PHY device */
+		memset(&pdevinfo, 0, sizeof(pdevinfo));
+		pdevinfo.name = nop_name;
+		pdevinfo.id = phy->port;
+		pdevinfo.data = phy->platform_data;
+		pdevinfo.size_data = sizeof(struct nop_usb_xceiv_platform_data);
+
+		scnprintf(phy_id, MAX_STR, "nop_usb_xceiv.%d",
+					phy->port);
+		pdev = platform_device_register_full(&pdevinfo);
+		if (IS_ERR(pdev)) {
+			pr_err("%s: Failed to register device %s : %ld\n",
+				__func__,  phy_id, PTR_ERR(pdev));
+			kfree(phy_id);
 			continue;
 		}
 
@@ -653,26 +670,15 @@ int usbhs_init_phys(struct usbhs_phy_data *phy, int num_phys)
 
 		/* Do we need RESET regulator ? */
 		if (gpio_is_valid(phy->reset_gpio)) {
-
-			rail_name = kmalloc(13, GFP_KERNEL);
-			if (!rail_name)
-				return -ENOMEM;
-
-			scnprintf(rail_name, 13, "hsusb%d_reset", phy->port);
-
+			scnprintf(rail_name, MAX_STR,
+					"hsusb%d_reset", phy->port);
 			usbhs_add_regulator(rail_name, phy_id, "reset",
 						phy->reset_gpio, 1);
 		}
 
 		/* Do we need VCC regulator ? */
 		if (gpio_is_valid(phy->vcc_gpio)) {
-
-			rail_name = kmalloc(13, GFP_KERNEL);
-			if (!rail_name)
-				return -ENOMEM;
-
-			scnprintf(rail_name, 13, "hsusb%d_vcc", phy->port);
-
+			scnprintf(rail_name, MAX_STR, "hsusb%d_vcc", phy->port);
 			usbhs_add_regulator(rail_name, phy_id, "vcc",
 					phy->vcc_gpio, phy->vcc_polarity);
 		}
-- 
1.7.4.1
