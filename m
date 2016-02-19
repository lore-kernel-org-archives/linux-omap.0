From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v5 14/26] memory: omap-gpmc: Reserve WAITPIN if needed for
 WAIT monitoring
Date: Fri, 19 Feb 2016 23:15:36 +0200
Message-ID: <1455916548-3441-15-git-send-email-rogerq@ti.com>
References: <1455916548-3441-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1455916548-3441-1-git-send-email-rogerq@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: tony@atomide.com, computersforpeace@gmail.com
Cc: devicetree@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, ezequiel@vanguardiasur.com.ar, javier@dowhile0.org, linux-omap@vger.kernel.org, dwmw2@infradead.org, fcooper@ti.com, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

If the device attached to GPMC wants to use the WAIT pin
for WAIT monitoring then we reserve it internally for
exclusive use.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/memory/omap-gpmc.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index f67e5695..af2d57f 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -1881,6 +1881,8 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
 	const char *name;
 	int ret, cs;
 	u32 val;
+	struct gpio_desc *waitpin_desc = NULL;
+	struct gpmc_device *gpmc = platform_get_drvdata(pdev);
 
 	if (of_property_read_u32(child, "reg", &cs) < 0) {
 		dev_err(&pdev->dev, "%s has no 'reg' property\n",
@@ -1990,16 +1992,30 @@ static int gpmc_probe_generic_child(struct platform_device *pdev,
 			goto err;
 	}
 
+	/* Reserve wait pin if it is required and valid */
+	if (gpmc_s.wait_on_read || gpmc_s.wait_on_write) {
+		unsigned wait_pin = gpmc_s.wait_pin;
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
@@ -2030,6 +2046,10 @@ err_child_fail:
 	dev_err(&pdev->dev, "failed to create gpmc child %s\n", child->name);
 	ret = -ENODEV;
 
+err_cs:
+	if (waitpin_desc)
+		gpiochip_free_own_desc(waitpin_desc);
+
 err:
 	gpmc_cs_free(cs);
 
-- 
2.1.4


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
