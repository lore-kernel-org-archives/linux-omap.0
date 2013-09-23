From: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH 01/10] pwm-backlight: Refactor backlight power on/off
Date: Mon, 23 Sep 2013 23:40:58 +0200
Message-ID: <1379972467-11243-2-git-send-email-treding@nvidia.com>
References: <1379972467-11243-1-git-send-email-treding@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1379972467-11243-1-git-send-email-treding@nvidia.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Eric Miao <eric.y.miao@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Tony Lindgren <tony@atomide.com>, Stephen Warren <swarren@wwwdotorg.org>, Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org, Simon Horman <horms@verge.net.au>, linux-pwm@vger.kernel.org, Haojian Zhuang <haojian.zhuang@gmail.com>, Ben Dooks <ben-linux@fluff.org>, linux-sh@vger.kernel.org, openezx-devel@lists.openezx.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

In preparation for adding an optional regulator and enable GPIO to the
driver, split the power on and power off sequences into separate
functions to reduce code duplication at the multiple call sites.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/video/backlight/pwm_bl.c | 59 ++++++++++++++++++++++++----------------
 1 file changed, 36 insertions(+), 23 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 36db5d9..8a49b30 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -35,6 +35,30 @@ struct pwm_bl_data {
 	void			(*exit)(struct device *);
 };
 
+static void pwm_backlight_power_on(struct pwm_bl_data *pb, int brightness,
+				   int max)
+{
+	int duty_cycle, err;
+
+	if (pb->levels) {
+		duty_cycle = pb->levels[brightness];
+		max = pb->levels[max];
+	} else {
+		duty_cycle = brightness;
+	}
+
+	duty_cycle = (duty_cycle * (pb->period - pb->lth_brightness) / max) +
+		     pb->lth_brightness;
+
+	pwm_config(pb->pwm, duty_cycle, pb->period);
+	pwm_enable(pb->pwm);
+}
+
+static void pwm_backlight_power_off(struct pwm_bl_data *pb)
+{
+	pwm_disable(pb->pwm);
+}
+
 static int pwm_backlight_update_status(struct backlight_device *bl)
 {
 	struct pwm_bl_data *pb = bl_get_data(bl);
@@ -49,24 +73,10 @@ static int pwm_backlight_update_status(struct backlight_device *bl)
 	if (pb->notify)
 		brightness = pb->notify(pb->dev, brightness);
 
-	if (brightness == 0) {
-		pwm_config(pb->pwm, 0, pb->period);
-		pwm_disable(pb->pwm);
-	} else {
-		int duty_cycle;
-
-		if (pb->levels) {
-			duty_cycle = pb->levels[brightness];
-			max = pb->levels[max];
-		} else {
-			duty_cycle = brightness;
-		}
-
-		duty_cycle = pb->lth_brightness +
-		     (duty_cycle * (pb->period - pb->lth_brightness) / max);
-		pwm_config(pb->pwm, duty_cycle, pb->period);
-		pwm_enable(pb->pwm);
-	}
+	if (brightness > 0)
+		pwm_backlight_power_on(pb, brightness, max);
+	else
+		pwm_backlight_power_off(pb);
 
 	if (pb->notify_after)
 		pb->notify_after(pb->dev, brightness);
@@ -267,10 +277,11 @@ static int pwm_backlight_remove(struct platform_device *pdev)
 	struct pwm_bl_data *pb = bl_get_data(bl);
 
 	backlight_device_unregister(bl);
-	pwm_config(pb->pwm, 0, pb->period);
-	pwm_disable(pb->pwm);
+	pwm_backlight_power_off(pb);
+
 	if (pb->exit)
 		pb->exit(&pdev->dev);
+
 	return 0;
 }
 
@@ -282,10 +293,12 @@ static int pwm_backlight_suspend(struct device *dev)
 
 	if (pb->notify)
 		pb->notify(pb->dev, 0);
-	pwm_config(pb->pwm, 0, pb->period);
-	pwm_disable(pb->pwm);
+
+	pwm_backlight_power_off(pb);
+
 	if (pb->notify_after)
 		pb->notify_after(pb->dev, 0);
+
 	return 0;
 }
 
@@ -294,6 +307,7 @@ static int pwm_backlight_resume(struct device *dev)
 	struct backlight_device *bl = dev_get_drvdata(dev);
 
 	backlight_update_status(bl);
+
 	return 0;
 }
 #endif
@@ -317,4 +331,3 @@ module_platform_driver(pwm_backlight_driver);
 MODULE_DESCRIPTION("PWM based Backlight Driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:pwm-backlight");
-
-- 
1.8.4
