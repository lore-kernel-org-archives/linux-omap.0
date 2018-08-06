From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [RFC PATCH v2 12/12] gpiolib: Add fast processing path to bitmap API functions
Date: Tue,  7 Aug 2018 00:29:18 +0200
Message-ID: <20180806222918.12644-13-jmkrzyszt@gmail.com>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
 <20180806222918.12644-1-jmkrzyszt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180806222918.12644-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, linux-doc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>
List-Id: linux-omap@vger.kernel.org

Certain GPIO descriptor arrays returned by gpio_get_array() may contain
information on a single GPIO chip driving array member pins in hardware
order.  In such cases, bitmaps of values can be passed directly to the
chip callback functions without wasting time on iterations.

Add respective code to gpiod_get/set_array_bitmap_complex() functions.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 Documentation/driver-api/gpio/consumer.rst |  6 ++++++
 drivers/gpio/gpiolib.c                     | 14 ++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/Documentation/driver-api/gpio/consumer.rst b/Documentation/driver-api/gpio/consumer.rst
index bec4eab3b87c..b82f134dc352 100644
--- a/Documentation/driver-api/gpio/consumer.rst
+++ b/Documentation/driver-api/gpio/consumer.rst
@@ -409,6 +409,12 @@ descriptor arrays, only those of type struct gpio_descs returned by
 gpiod_get_array() and its variants.  Supported array size is limited to the size
 of the bitmap, i.e., sizeof(unsigned long).
 
+If the .chip member of the array structure, filled in by gpiod_get_array() in
+certain circumstances, contains a valid GPIO chip descriptor, the raw variants
+of the functions can take fast processing paths, passing bitmap arguments
+directly to the chip callback functions.  That allows for utilization of GPIO
+banks as data I/O ports without much loss of performance.
+
 
 GPIOs mapped to IRQs
 --------------------
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 5b541364dee0..bf95f2964bc5 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2846,6 +2846,12 @@ int gpiod_get_array_bitmap_complex(bool raw, bool can_sleep,
 	if (array->ndescs > sizeof(*bits))
 		return -EINVAL;
 
+	if (raw && !IS_ERR_OR_NULL(array->chip)) {
+		unsigned long mask = (1ULL << array->ndescs) - 1;
+
+		return gpio_chip_get_multiple(array->chip, &mask, bits);
+	}
+
 	i = gpiod_get_array_value_complex(raw, can_sleep, array->ndescs,
 					  array->desc, value_array);
 	if (i)
@@ -3156,6 +3162,14 @@ int gpiod_set_array_bitmap_complex(bool raw, bool can_sleep,
 	if (array->ndescs > sizeof(*bits))
 		return -EINVAL;
 
+	if (raw && !IS_ERR_OR_NULL(array->chip)) {
+		unsigned long mask = (1ULL << array->ndescs) - 1;
+
+		gpio_chip_set_multiple(array->chip, &mask, bits);
+
+		return 0;
+	}
+
 	for (i = 0; i < array->ndescs; i++)
 		value_array[i] = test_bit(i, bits);
 
-- 
2.16.4
