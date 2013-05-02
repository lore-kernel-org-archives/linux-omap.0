From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH] ARM: OMAP-USB: Fix possible memory leak
Date: Thu,  2 May 2013 20:03:16 +0400
Message-ID: <1367510596-27780-1-git-send-email-shc_work@mail.ru>
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
To: linux-arm-kernel@lists.infradead.org
Cc: Alexander Shiyan <shc_work@mail.ru>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, linux-usb@vger.kernel.org, Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-omap2/usb-host.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-host.c b/arch/arm/mach-omap2/usb-host.c
index aa27d7f..8d17a0d 100644
--- a/arch/arm/mach-omap2/usb-host.c
+++ b/arch/arm/mach-omap2/usb-host.c
@@ -570,8 +570,10 @@ static int usbhs_add_regulator(char *name, char *dev_id, char *dev_supply,
 	supplies->dev_name = dev_id;
 
 	reg_data = kzalloc(sizeof(*reg_data), GFP_KERNEL);
-	if (!reg_data)
+	if (!reg_data) {
+		kfree(supplies);
 		return -ENOMEM;
+	}
 
 	reg_data->constraints.valid_ops_mask = REGULATOR_CHANGE_STATUS;
 	reg_data->consumer_supplies = supplies;
@@ -579,8 +581,11 @@ static int usbhs_add_regulator(char *name, char *dev_id, char *dev_supply,
 
 	config = kmemdup(&hsusb_reg_config, sizeof(hsusb_reg_config),
 			GFP_KERNEL);
-	if (!config)
+	if (!config) {
+		kfree(supplies);
+		kfree(reg_data);
 		return -ENOMEM;
+	}
 
 	config->supply_name = name;
 	config->gpio = gpio;
@@ -589,17 +594,25 @@ static int usbhs_add_regulator(char *name, char *dev_id, char *dev_supply,
 
 	/* create a regulator device */
 	pdev = kzalloc(sizeof(*pdev), GFP_KERNEL);
-	if (!pdev)
+	if (!pdev) {
+		kfree(supplies);
+		kfree(reg_data);
+		kfree(config);
 		return -ENOMEM;
+	}
 
 	pdev->id = PLATFORM_DEVID_AUTO;
 	pdev->name = reg_name;
 	pdev->dev.platform_data = config;
 
 	ret = platform_device_register(pdev);
-	if (ret)
+	if (ret) {
 		pr_err("%s: Failed registering regulator %s for %s\n",
 				__func__, name, dev_id);
+		kfree(supplies);
+		kfree(reg_data);
+		kfree(config);
+	}
 
 	return ret;
 }
-- 
1.8.1.5
