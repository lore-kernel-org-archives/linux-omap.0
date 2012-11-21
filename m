From: "Philip, Avinash" <avinashphilip-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v4 04/11] pwm: pwm-tiecap: Add device-tree binding support for
 APWM driver
Date: Wed, 21 Nov 2012 18:41:01 +0530
Message-ID: <1353503469-18634-5-git-send-email-avinashphilip@ti.com>
References: <1353503469-18634-1-git-send-email-avinashphilip@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1353503469-18634-1-git-send-email-avinashphilip-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gururaja.hebbar-l0cyMroinI0@public.gmane.org, "Philip,
 Avinash" <avinashphilip-l0cyMroinI0@public.gmane.org>, vaibhav.bedia-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This patch
1. Add support for device-tree binding for ECAP APWM driver.
2. Set size of pwm-cells set to 3 to support PWM channel number, PWM
   period & polarity configuration from device tree.
3. Add enable/disable clock gating in PWM subsystem common config space.
4. When here set .owner member in platform_driver structure to
   THIS_MODULE.

Signed-off-by: Philip, Avinash <avinashphilip-l0cyMroinI0@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Cc: Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>
---
Changes since v3:
	- Replace pwmss.h with pwm-tipwmss.h

Changes since v2:
	- Add of_pwm_xlate_with_flags function support

Changes since v1:
	- Add separate patch for pinctrl support
	- Add conditional check for PWM subsystem clock enable.
	- Combined with HWMOD changes & DT bindings.
	- Remove the custom of_xlate support.

:000000 100644 0000000... 131e8c1... A	Documentation/devicetree/bindings/pwm/pwm-tiecap.txt
:100644 100644 d6d4cf0... e0bcc85... M	drivers/pwm/pwm-tiecap.c
 .../devicetree/bindings/pwm/pwm-tiecap.txt         |   23 ++++++++++
 drivers/pwm/pwm-tiecap.c                           |   44 +++++++++++++++++++-
 2 files changed, 66 insertions(+), 1 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt b/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt
new file mode 100644
index 0000000..131e8c1
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-tiecap.txt
@@ -0,0 +1,23 @@
+TI SOC ECAP based APWM controller
+
+Required properties:
+- compatible: Must be "ti,am33xx-ecap"
+- #pwm-cells: Should be 3. Number of cells being used to specify PWM property.
+  First cell specifies the per-chip index of the PWM to use, the second
+  cell is the period in nanoseconds and bit 0 in the third cell is used to
+  encode the polarity of PWM output. Set bit 0 of the third in PWM specifier
+  to 1 for inverse polarity & set to 0 for normal polarity.
+- reg: physical base address and size of the registers map.
+
+Optional properties:
+- ti,hwmods: Name of the hwmod associated to the ECAP:
+  "ecap<x>", <x> being the 0-based instance number from the HW spec
+
+Example:
+
+ecap0: ecap@0 {
+	compatible = "ti,am33xx-ecap";
+	#pwm-cells = <3>;
+	reg = <0x48300100 0x80>;
+	ti,hwmods = "ecap0";
+};
diff --git a/drivers/pwm/pwm-tiecap.c b/drivers/pwm/pwm-tiecap.c
index d6d4cf0..e0bcc85 100644
--- a/drivers/pwm/pwm-tiecap.c
+++ b/drivers/pwm/pwm-tiecap.c
@@ -25,6 +25,9 @@
 #include <linux/clk.h>
 #include <linux/pm_runtime.h>
 #include <linux/pwm.h>
+#include <linux/of_device.h>
+
+#include "pwm-tipwmss.h"
 
 /* ECAP registers and bits definitions */
 #define CAP1			0x08
@@ -184,12 +187,21 @@ static const struct pwm_ops ecap_pwm_ops = {
 	.owner		= THIS_MODULE,
 };
 
+static const struct of_device_id ecap_of_match[] = {
+	{
+		.compatible	= "ti,am33xx-ecap",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, ecap_of_match);
+
 static int __devinit ecap_pwm_probe(struct platform_device *pdev)
 {
 	int ret;
 	struct resource *r;
 	struct clk *clk;
 	struct ecap_pwm_chip *pc;
+	u16 status;
 
 	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
 	if (!pc) {
@@ -211,6 +223,8 @@ static int __devinit ecap_pwm_probe(struct platform_device *pdev)
 
 	pc->chip.dev = &pdev->dev;
 	pc->chip.ops = &ecap_pwm_ops;
+	pc->chip.of_xlate = of_pwm_xlate_with_flags;
+	pc->chip.of_pwm_n_cells = 3;
 	pc->chip.base = -1;
 	pc->chip.npwm = 1;
 
@@ -231,14 +245,40 @@ static int __devinit ecap_pwm_probe(struct platform_device *pdev)
 	}
 
 	pm_runtime_enable(&pdev->dev);
+	pm_runtime_get_sync(&pdev->dev);
+
+	status = pwmss_submodule_state_change(pdev->dev.parent,
+			PWMSS_ECAPCLK_EN);
+	if (!(status & PWMSS_ECAPCLK_EN_ACK)) {
+		dev_err(&pdev->dev, "PWMSS config space clock enable failed\n");
+		ret = -EINVAL;
+		goto pwmss_clk_failure;
+	}
+
+	pm_runtime_put_sync(&pdev->dev);
+
 	platform_set_drvdata(pdev, pc);
 	return 0;
+
+pwmss_clk_failure:
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	pwmchip_remove(&pc->chip);
+	return ret;
 }
 
 static int __devexit ecap_pwm_remove(struct platform_device *pdev)
 {
 	struct ecap_pwm_chip *pc = platform_get_drvdata(pdev);
 
+	pm_runtime_get_sync(&pdev->dev);
+	/*
+	 * Due to hardware misbehaviour, acknowledge of the stop_req
+	 * is missing. Hence checking of the status bit skipped.
+	 */
+	pwmss_submodule_state_change(pdev->dev.parent, PWMSS_ECAPCLK_STOP_REQ);
+	pm_runtime_put_sync(&pdev->dev);
+
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	return pwmchip_remove(&pc->chip);
@@ -246,7 +286,9 @@ static int __devexit ecap_pwm_remove(struct platform_device *pdev)
 
 static struct platform_driver ecap_pwm_driver = {
 	.driver = {
-		.name = "ecap",
+		.name	= "ecap",
+		.owner	= THIS_MODULE,
+		.of_match_table = ecap_of_match,
 	},
 	.probe = ecap_pwm_probe,
 	.remove = __devexit_p(ecap_pwm_remove),
-- 
1.7.0.4
