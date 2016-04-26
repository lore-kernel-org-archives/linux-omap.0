From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [PATCH v7 6/9] pwms: pwm-ti*: Get the clock from the PWMSS parent when using old bindings
Date: Tue, 26 Apr 2016 17:36:46 -0500
Message-ID: <1461710209-6563-7-git-send-email-fcooper@ti.com>
References: <1461710209-6563-1-git-send-email-fcooper@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461710209-6563-1-git-send-email-fcooper@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com, robh+dt@kernel.org, tony@atomide.com, paul@pwsan.com, t-kristo@ti.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, vigneshr@ti.com, nsekhar@ti.com
Cc: Franklin S Cooper Jr <fcooper@ti.com>
List-Id: linux-omap@vger.kernel.org

When using the old eCAP and ePWM bindings for AM335x and AM437x the clock
can be retrieved from the PWMSS parent. Newer bindings will insure that
this clock is provided via device tree.

Therefore, update this driver to support the newer and older bindings. In
the case of the older binding being used give a warning.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
 drivers/pwm/pwm-tiecap.c   | 7 +++++++
 drivers/pwm/pwm-tiehrpwm.c | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/pwm/pwm-tiecap.c b/drivers/pwm/pwm-tiecap.c
index 616af76..a0833c8 100644
--- a/drivers/pwm/pwm-tiecap.c
+++ b/drivers/pwm/pwm-tiecap.c
@@ -195,6 +195,7 @@ static const struct pwm_ops ecap_pwm_ops = {
 };
 
 static const struct of_device_id ecap_of_match[] = {
+	{ .compatible	= "ti,am3352-ecap" },
 	{ .compatible	= "ti,am33xx-ecap" },
 	{},
 };
@@ -213,6 +214,12 @@ static int ecap_pwm_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	clk = devm_clk_get(&pdev->dev, "fck");
+
+	if (IS_ERR(clk) && of_device_is_compatible(pdev->dev.of_node, "ti,am33xx-ecap")) {
+		dev_warn(&pdev->dev, "Binding is obsolete.\n");
+		clk = devm_clk_get(pdev->dev.parent, "fck");
+	}
+
 	if (IS_ERR(clk)) {
 		dev_err(&pdev->dev, "failed to get clock\n");
 		return PTR_ERR(clk);
diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index 6a41e66..cee29a2 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -426,6 +426,7 @@ static const struct pwm_ops ehrpwm_pwm_ops = {
 };
 
 static const struct of_device_id ehrpwm_of_match[] = {
+	{ .compatible	= "ti,am3352-ehrpwm" },
 	{ .compatible	= "ti,am33xx-ehrpwm" },
 	{},
 };
@@ -444,6 +445,12 @@ static int ehrpwm_pwm_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	clk = devm_clk_get(&pdev->dev, "fck");
+
+	if (IS_ERR(clk) && of_device_is_compatible(pdev->dev.of_node, "ti,am33xx-ecap")) {
+		dev_warn(&pdev->dev, "Binding is obsolete.\n");
+		clk = devm_clk_get(pdev->dev.parent, "fck");
+	}
+
 	if (IS_ERR(clk)) {
 		dev_err(&pdev->dev, "failed to get clock\n");
 		return PTR_ERR(clk);
-- 
2.7.0
