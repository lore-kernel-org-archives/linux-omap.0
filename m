From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCHv2 10/11] leds: leds-pwm: retrieve configured pwm period
Date: Mon, 14 Apr 2014 23:59:52 +0200
Message-ID: <1397512793-10325-11-git-send-email-alexandre.belloni@free-electrons.com>
References: <1397512793-10325-1-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1397512793-10325-1-git-send-email-alexandre.belloni@free-electrons.com>
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
Cc: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>, Eric Miao <eric.y.miao@gmail.com>, linux-sh@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Bryan Wu <cooloney@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, Haojian Zhuang <haojian.zhuang@gmail.com>, Simon Horman <horms@verge.net.au>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-leds@vger.kernel.org, Philipp Zabel <philipp.zabel@gmail.com>, Paul Parsons <lost.distance@yahoo.com>, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The PWM core is now able to initialize the PWM period. Use it and if it is not
configured, use the supplied pwm_period_ns.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/leds/leds-pwm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
index 7d0aaed1e23a..aa770ec1e892 100644
--- a/drivers/leds/leds-pwm.c
+++ b/drivers/leds/leds-pwm.c
@@ -181,7 +181,6 @@ static int led_pwm_probe(struct platform_device *pdev)
 			led_dat->cdev.name = cur_led->name;
 			led_dat->cdev.default_trigger = cur_led->default_trigger;
 			led_dat->active_low = cur_led->active_low;
-			led_dat->period = cur_led->pwm_period_ns;
 			led_dat->cdev.brightness_set = led_pwm_set;
 			led_dat->cdev.brightness = LED_OFF;
 			led_dat->cdev.max_brightness = cur_led->max_brightness;
@@ -191,6 +190,10 @@ static int led_pwm_probe(struct platform_device *pdev)
 			if (led_dat->can_sleep)
 				INIT_WORK(&led_dat->work, led_pwm_work);
 
+			led_dat->period = pwm_get_period(led_dat->pwm);
+			if (!led_dat->period && (cur_led->pwm_period_ns > 0))
+				led_dat->period = cur_led->pwm_period_ns;
+
 			ret = led_classdev_register(&pdev->dev, &led_dat->cdev);
 			if (ret < 0)
 				goto err;
-- 
1.8.3.2
