From: Laurent Navet <laurent.navet@gmail.com>
Subject: [PATCH 01/10] gpio: gpiolib-of.c: fix checkpatch error
Date: Wed, 20 Mar 2013 13:15:55 +0100
Message-ID: <1363781764-17330-2-git-send-email-laurent.navet@gmail.com>
References: <1363781764-17330-1-git-send-email-laurent.navet@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1363781764-17330-1-git-send-email-laurent.navet@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: grant.likely@secretlab.ca, linus.walleij@linaro.org
Cc: santosh.shilimkar@ti.com, khilman@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Laurent Navet <laurent.navet@gmail.com>
List-Id: linux-omap@vger.kernel.org

Fix :
 gpio/gpiolib-of.c:64: ERROR: code indent should use tabs where possible

Signed-off-by: Laurent Navet <laurent.navet@gmail.com>
---
 drivers/gpio/gpiolib-of.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index a71a54a..8940793 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -61,7 +61,7 @@ static int of_gpiochip_find_and_xlate(struct gpio_chip *gc, void *data)
  * in flags for the GPIO.
  */
 int of_get_named_gpio_flags(struct device_node *np, const char *propname,
-                           int index, enum of_gpio_flags *flags)
+			   int index, enum of_gpio_flags *flags)
 {
 	/* Return -EPROBE_DEFER to support probe() functions to be called
 	 * later when the GPIO actually becomes available
-- 
1.7.10.4
