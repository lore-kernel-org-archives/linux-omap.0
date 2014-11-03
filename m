From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 3/4] extcon: gpio: Always use gpio_get_value_cansleep
Date: Mon, 3 Nov 2014 10:32:29 -0600
Message-ID: <1415032350-8459-4-git-send-email-balbi@ti.com>
References: <1415032350-8459-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1415032350-8459-1-git-send-email-balbi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, cw00.choi@samsung.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, nsekhar@ti.com, grant.likely@linaro.org, George Cherian <george.cherian@ti.com>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

From: George Cherian <george.cherian@ti.com>

Some gpio's can sleep while reading, so always use gpio_get_value_cansleep
to get data. This fixes warning from gpiolib due to wrong API usage.

Reviewed-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: George Cherian <george.cherian@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/extcon/extcon-gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon-gpio.c b/drivers/extcon/extcon-gpio.c
index 9571e1f..7191d28 100644
--- a/drivers/extcon/extcon-gpio.c
+++ b/drivers/extcon/extcon-gpio.c
@@ -51,7 +51,7 @@ static void gpio_extcon_work(struct work_struct *work)
 		container_of(to_delayed_work(work), struct gpio_extcon_data,
 			     work);
 
-	state = gpiod_get_value(data->gpiod);
+	state = gpiod_get_value_cansleep(data->gpiod);
 	extcon_set_state(data->edev, state);
 }
 
-- 
2.1.0.GIT
