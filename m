From: Roger Quadros <rogerq@ti.com>
Subject: [RFC PATCH 2/6] mfd: omap-usb-host: Put pins in IDLE state on suspend
Date: Wed, 19 Jun 2013 17:05:49 +0300
Message-ID: <1371650753-11452-3-git-send-email-rogerq@ti.com>
References: <1371650753-11452-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1371650753-11452-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: stern@rowland.harvard.edu, tony@atomide.com
Cc: balbi@ti.com, ruslan.bilovol@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

In order to support wake up from suspend use the pinctrl
framework to put the USB host pins in IDLE state during suspend.

CC: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/mfd/omap-usb-host.c |   46 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 6601a49..171cc3b 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -31,6 +31,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/err.h>
+#include <linux/pinctrl/consumer.h>
 
 #include "omap-usb.h"
 
@@ -111,6 +112,10 @@ struct usbhs_hcd_omap {
 	struct usbhs_omap_platform_data	*pdata;
 
 	u32				usbhs_rev;
+
+	struct pinctrl *pinctrl;
+	struct pinctrl_state *pins_default;
+	struct pinctrl_state *pins_idle;
 };
 /*-------------------------------------------------------------------------*/
 
@@ -325,6 +330,10 @@ static int usbhs_runtime_resume(struct device *dev)
 
 	dev_dbg(dev, "usbhs_runtime_resume\n");
 
+	if (!IS_ERR(omap->pins_default))
+		if (pinctrl_select_state(omap->pinctrl, omap->pins_default))
+			dev_err(dev, "Could not select DEFAULT pin state\n");
+
 	omap_tll_enable(pdata);
 
 	if (!IS_ERR(omap->ehci_logic_fck))
@@ -402,6 +411,10 @@ static int usbhs_runtime_suspend(struct device *dev)
 
 	omap_tll_disable(pdata);
 
+	if (!IS_ERR(omap->pins_idle))
+		if (pinctrl_select_state(omap->pinctrl, omap->pins_idle))
+			dev_err(dev, "Could not select IDLE pin state\n");
+
 	return 0;
 }
 
@@ -608,6 +621,30 @@ static int usbhs_omap_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	omap->pinctrl = devm_pinctrl_get(dev);
+	if (!IS_ERR(omap->pinctrl)) {
+		omap->pins_default = pinctrl_lookup_state(omap->pinctrl,
+							 PINCTRL_STATE_DEFAULT);
+		if (IS_ERR(omap->pins_default))
+			dev_err(dev, "Could not get DEFAULT state pins\n");
+
+		omap->pins_idle = pinctrl_lookup_state(omap->pinctrl,
+						      PINCTRL_STATE_IDLE);
+		if (IS_ERR(omap->pins_idle))
+			dev_err(dev, "Could not get IDLE state pins\n");
+
+	} else {
+		dev_info(dev, "pinctrl_get error\n");
+		if (PTR_ERR(omap->pinctrl) == -EPROBE_DEFER) {
+			dev_info(dev, "defer\n");
+			return -EPROBE_DEFER;
+		}
+
+		omap->pins_default = omap->pins_idle = ERR_PTR(-EINVAL);
+		dev_dbg(dev, "Proceeding without pinctrl: %ld\n",
+						PTR_ERR(omap->pinctrl));
+	}
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	omap->uhh_base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(omap->uhh_base))
@@ -796,6 +833,10 @@ static int usbhs_omap_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (!IS_ERR(omap->pins_default))
+		if (pinctrl_select_state(omap->pinctrl, omap->pins_default))
+			dev_err(dev, "Could not select DEFAULT pin state\n");
+
 	return 0;
 
 err_alloc:
@@ -872,6 +913,11 @@ static int usbhs_omap_remove(struct platform_device *pdev)
 
 	/* remove children */
 	device_for_each_child(&pdev->dev, NULL, usbhs_omap_remove_child);
+
+	if (!IS_ERR(omap->pins_idle))
+		if (pinctrl_select_state(omap->pinctrl, omap->pins_idle))
+			dev_err(&pdev->dev, "Could not select IDLE pin state\n");
+
 	return 0;
 }
 
-- 
1.7.4.1
