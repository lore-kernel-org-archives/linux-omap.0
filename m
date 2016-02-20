From: Nishanth Menon <nm@ti.com>
Subject: [PATCH] hwmon: (gpio-fan) Remove un-necessary speed_index lookup for
 thermal hook
Date: Fri, 19 Feb 2016 18:09:51 -0600
Message-ID: <1455926991-15189-1-git-send-email-nm@ti.com>
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
To: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>
Cc: Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Eduardo Valentin <edubezval@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Thermal hook gpio_fan_get_cur_state is only interested in knowing
the current speed index that was setup in the system, this is
already available as part of fan_data->speed_index which is always
set by set_fan_speed. Using get_fan_speed_index is useful when we
have no idea about the fan speed configuration (for example during
fan_ctrl_init).

When thermal framework invokes
gpio_fan_get_cur_state=>get_fan_speed_index via gpio_fan_get_cur_state
especially in a polled configuration for thermal governor, we
basically hog the i2c interface to the extent that other functions
fail to get any traffic out :(.

Instead, just provide the last state set in the driver - since the gpio
fan driver is responsible for the fan state immaterial of override, the
fan_data->speed_index should accurately reflect the state.

Fixes: b5cf88e46bad ("(gpio-fan): Add thermal control hooks")

Reported-by: Tony Lindgren <tony@atomide.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
Test logs from linus master  v4.5-rc4-137-g23300f657594 
Without fix: http://paste.ubuntu.org.cn/3948618
With Fix: http://paste.ubuntu.org.cn/3948617

 drivers/hwmon/gpio-fan.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/hwmon/gpio-fan.c b/drivers/hwmon/gpio-fan.c
index 82de3deeb18a..685568b1236d 100644
--- a/drivers/hwmon/gpio-fan.c
+++ b/drivers/hwmon/gpio-fan.c
@@ -406,16 +406,11 @@ static int gpio_fan_get_cur_state(struct thermal_cooling_device *cdev,
 				  unsigned long *state)
 {
 	struct gpio_fan_data *fan_data = cdev->devdata;
-	int r;
 
 	if (!fan_data)
 		return -EINVAL;
 
-	r = get_fan_speed_index(fan_data);
-	if (r < 0)
-		return r;
-
-	*state = r;
+	*state = fan_data->speed_index;
 	return 0;
 }
 
-- 
2.7.0
