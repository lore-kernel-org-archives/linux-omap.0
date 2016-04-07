From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v6 14/17] memory: omap-gpmc: Reserve WAITPIN if needed for WAIT monitoring
Date: Thu, 7 Apr 2016 13:08:32 +0300
Message-ID: <1460023715-19332-15-git-send-email-rogerq@ti.com>
References: <1460023715-19332-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460023715-19332-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, computersforpeace@gmail.com, boris.brezillon@free-electrons.com
Cc: dwmw2@infradead.org, ezequiel@vanguardiasur.com.ar, javier@dowhile0.org, fcooper@ti.com, nsekhar@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

If the device attached to GPMC wants to use the WAIT pin
for WAIT monitoring then we reserve it internally for
exclusive use.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/memory/omap-gpmc.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index 4dd1c65..784a64f 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -1911,6 +1911,8 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
 	const char *name;
 	int ret, cs;
 	u32 val;
+	struct gpio_desc *waitpin_desc = NULL;
+	struct gpmc_device *gpmc = platform_get_drvdata(pdev);
 
 	if (of_property_read_u32(child, "reg", &cs) < 0) {
 		dev_err(&pdev->dev, "%s has no 'reg' property\n",
@@ -2020,16 +2022,30 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
 			goto err;
 	}
 
+	/* Reserve wait pin if it is required and valid */
+	if (gpmc_s.wait_on_read || gpmc_s.wait_on_write) {
+		unsigned int wait_pin = gpmc_s.wait_pin;
+
+		waitpin_desc = gpiochip_request_own_desc(&gpmc->gpio_chip,
+							 wait_pin, "WAITPIN");
+		if (IS_ERR(waitpin_desc)) {
+			dev_err(&pdev->dev, "invalid wait-pin: %d\n", wait_pin);
+			ret = PTR_ERR(waitpin_desc);
+			goto err;
+		}
+	}
+
 	gpmc_cs_show_timings(cs, "before gpmc_cs_program_settings");
+
 	ret = gpmc_cs_program_settings(cs, &gpmc_s);
 	if (ret < 0)
-		goto err;
+		goto err_cs;
 
 	ret = gpmc_cs_set_timings(cs, &gpmc_t, &gpmc_s);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to set gpmc timings for: %s\n",
 			child->name);
-		goto err;
+		goto err_cs;
 	}
 
 	/* Clear limited address i.e. enable A26-A11 */
@@ -2060,6 +2076,10 @@ err_child_fail:
 	dev_err(&pdev->dev, "failed to create gpmc child %s\n", child->name);
 	ret = -ENODEV;
 
+err_cs:
+	if (waitpin_desc)
+		gpiochip_free_own_desc(waitpin_desc);
+
 err:
 	gpmc_cs_free(cs);
 
-- 
2.5.0
