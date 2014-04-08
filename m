From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [RFC PATCH 2/5] gpiolib: set gpio_chip operations on add using a gpio_chip_ops
Date: Tue,  8 Apr 2014 20:20:12 +0200
Message-ID: <1396981215-24888-3-git-send-email-javier.martinez@collabora.co.uk>
References: <1396981215-24888-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1396981215-24888-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>
List-Id: linux-omap@vger.kernel.org

This is a transitional change to avoid breaking git bisect-ability
while converting GPIO controller drivers to set their operations by
using the newly introduced struct gpio_chip_ops virtual function table.

It should be removed once all GPIO chip drivers have been converted.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 drivers/gpio/gpiolib.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 761013f..f0cc93a 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1188,6 +1188,25 @@ int gpiochip_add(struct gpio_chip *chip)
 		goto fail;
 	}
 
+	/*
+	 * REVISIT: this is a workaround to not break git bisectability by
+	 * allowing GPIO controller drivers to set either either the function
+	 * pointers embedded in struct gpio_chip or by using a gpio_chip_ops.
+	 *
+	 * Should be removed once all drivers are converted to set chip->ops.
+	 */
+	if (chip->ops) {
+		chip->request          = chip->ops->request;
+		chip->free             = chip->ops->free;
+		chip->get_direction    = chip->ops->get_direction;
+		chip->direction_input  = chip->ops->direction_input;
+		chip->direction_output = chip->ops->direction_output;
+		chip->get              = chip->ops->get;
+		chip->set              = chip->ops->set;
+		chip->set_debounce     = chip->ops->set_debounce;
+		chip->dbg_show         = chip->ops->dbg_show;
+	}
+
 	spin_lock_irqsave(&gpio_lock, flags);
 
 	if (base < 0) {
-- 
1.9.0
