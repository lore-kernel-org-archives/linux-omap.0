From: Sebastian Reichel <sre@debian.org>
Subject: [PATCH 3/4] Input: twl4030-pwrbutton: simplify driver using devm_*
Date: Tue, 22 Oct 2013 14:55:03 +0200
Message-ID: <1382446504-27837-4-git-send-email-sre@debian.org>
References: <1382446504-27837-1-git-send-email-sre@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1382446504-27837-1-git-send-email-sre@debian.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sebastian Reichel <sre@ring0.de>, linux-input@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Russell King <linux@arm.linux.org.uk>, Rob Landley <rob@landley.net>, Pawel Moll <pawel.moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@debian.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, =?UTF-8?q?=27Beno=C3=AEt=20Cousson=27?= <bcousson@baylibre.com>, Grant Likely <grant.likely@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Use managed irq resource to simplify the driver.

Signed-off-by: Sebastian Reichel <sre@debian.org>
---
 drivers/input/misc/twl4030-pwrbutton.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/input/misc/twl4030-pwrbutton.c b/drivers/input/misc/twl4030-pwrbutton.c
index 4e7a810..4ab9243 100644
--- a/drivers/input/misc/twl4030-pwrbutton.c
+++ b/drivers/input/misc/twl4030-pwrbutton.c
@@ -70,7 +70,7 @@ static int twl4030_pwrbutton_probe(struct platform_device *pdev)
 	pwr->phys = "twl4030_pwrbutton/input0";
 	pwr->dev.parent = &pdev->dev;
 
-	err = request_threaded_irq(irq, NULL, powerbutton_irq,
+	err = devm_request_threaded_irq(&pwr->dev, irq, NULL, powerbutton_irq,
 			IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
 			"twl4030_pwrbutton", pwr);
 	if (err < 0) {
@@ -81,15 +81,13 @@ static int twl4030_pwrbutton_probe(struct platform_device *pdev)
 	err = input_register_device(pwr);
 	if (err) {
 		dev_err(&pdev->dev, "Can't register power button: %d\n", err);
-		goto free_irq;
+		goto free_input_dev;
 	}
 
 	platform_set_drvdata(pdev, pwr);
 
 	return 0;
 
-free_irq:
-	free_irq(irq, pwr);
 free_input_dev:
 	input_free_device(pwr);
 	return err;
@@ -98,9 +96,7 @@ free_input_dev:
 static int __exit twl4030_pwrbutton_remove(struct platform_device *pdev)
 {
 	struct input_dev *pwr = platform_get_drvdata(pdev);
-	int irq = platform_get_irq(pdev, 0);
 
-	free_irq(irq, pwr);
 	input_unregister_device(pwr);
 
 	return 0;
-- 
1.8.4.rc3
