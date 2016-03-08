From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [PATCH v5 1/6] pwms: pwm-ti*: Get the clock from the PWMSS (parent)
Date: Mon,  7 Mar 2016 19:23:39 -0600
Message-ID: <1457400224-24797-2-git-send-email-fcooper@ti.com>
References: <1457400224-24797-1-git-send-email-fcooper@ti.com>
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <1457400224-24797-1-git-send-email-fcooper@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
To: thierry.reding@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, bcousson@baylibre.com, tony@atomide.com, linux@arm.linux.org.uk, paul@pwsan.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, vigneshr@ti.com
Cc: Franklin S Cooper Jr <fcooper@ti.com>
List-Id: linux-omap@vger.kernel.org

The eCAP and ePWM doesn't have their own separate clocks. They simply
utilize the clock provided directly by the PWMSS. Therefore, they simply
need to grab a reference to their parent's clock.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
 drivers/pwm/pwm-tiecap.c   | 2 +-
 drivers/pwm/pwm-tiehrpwm.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-tiecap.c b/drivers/pwm/pwm-tiecap.c
index 616af76..9418159 100644
--- a/drivers/pwm/pwm-tiecap.c
+++ b/drivers/pwm/pwm-tiecap.c
@@ -212,7 +212,7 @@ static int ecap_pwm_probe(struct platform_device *pdev)
 	if (!pc)
 		return -ENOMEM;
 
-	clk = devm_clk_get(&pdev->dev, "fck");
+	clk = devm_clk_get(pdev->dev.parent, "fck");
 	if (IS_ERR(clk)) {
 		dev_err(&pdev->dev, "failed to get clock\n");
 		return PTR_ERR(clk);
diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index 6a41e66..09dc1bc 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -443,7 +443,7 @@ static int ehrpwm_pwm_probe(struct platform_device *pdev)
 	if (!pc)
 		return -ENOMEM;
 
-	clk = devm_clk_get(&pdev->dev, "fck");
+	clk = devm_clk_get(pdev->dev.parent, "fck");
 	if (IS_ERR(clk)) {
 		dev_err(&pdev->dev, "failed to get clock\n");
 		return PTR_ERR(clk);
-- 
2.7.0
