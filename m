From: Furquan Shaikh <furquan@chromium.org>
Subject: [PATCH 6/7] drivers/gpio: Add and export gpiod_lookup[_index]
Date: Tue, 24 Jan 2017 16:06:40 -0800
Message-ID: <20170125000641.25520-7-furquan@chromium.org>
References: <20170125000641.25520-1-furquan@chromium.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170125000641.25520-1-furquan@chromium.org>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Len Brown <lenb@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Will Deacon <will.deacon@arm.com>, Rob Herring <robh@kernel.org>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Furquan Shaikh <furquan@chromium.org>, Dmitry Torokhov <dtor@>
List-Id: linux-omap@vger.kernel.org

Sometimes (as the case with fixed regulator) we only want to look up,
but not necessarily reserve right away, GPIO. gpiod_lookup() and
gpiod_lookup_by_index() allow us doing just that.

Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
Signed-off-by: Furquan Shaikh <furquan@chromium.org>
---
 drivers/gpio/gpiolib.c        | 75 ++++++++++++++++++++++++++++++++++---------
 include/linux/gpio/consumer.h | 21 ++++++++++++
 2 files changed, 80 insertions(+), 16 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index a07ae9e37930..7f8ac6c229e8 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3165,6 +3165,22 @@ int gpiod_count(struct device *dev, const char *con_id)
 EXPORT_SYMBOL_GPL(gpiod_count);
 
 /**
+ * gpiod_lookup - look up a GPIO for a given GPIO function
+ * @dev:	GPIO consumer, can be NULL for system-global GPIOs
+ * @con_id:	function within the GPIO consumer
+ *
+ * Return the GPIO descriptor corresponding to the function con_id of device
+ * dev, -ENOENT if no GPIO has been assigned to the requested function, or
+ * another IS_ERR() code.
+ */
+struct gpio_desc *__must_check gpiod_lookup(struct device *dev,
+					    const char *con_id)
+{
+	return gpiod_lookup_index(dev, con_id, 0);
+}
+EXPORT_SYMBOL_GPL(gpiod_lookup);
+
+/**
  * gpiod_get - obtain a GPIO for a given GPIO function
  * @dev:	GPIO consumer, can be NULL for system-global GPIOs
  * @con_id:	function within the GPIO consumer
@@ -3241,26 +3257,19 @@ static int gpiod_configure_flags(struct gpio_desc *desc, const char *con_id,
 }
 
 /**
- * gpiod_get_index - obtain a GPIO from a multi-index GPIO function
+ * gpiod_lookup_index - look up a GPIO from a multi-index GPIO function
  * @dev:	GPIO consumer, can be NULL for system-global GPIOs
  * @con_id:	function within the GPIO consumer
  * @idx:	index of the GPIO to obtain in the consumer
- * @flags:	optional GPIO initialization flags
- *
- * This variant of gpiod_get() allows to access GPIOs other than the first
- * defined one for functions that define several GPIOs.
  *
- * Return a valid GPIO descriptor, -ENOENT if no GPIO has been assigned to the
- * requested function and/or index, or another IS_ERR() code if an error
- * occurred while trying to acquire the GPIO.
+ * Return a valid GPIO descriptor, or -ENOENT if no GPIO has been assigned to
+ * the requested function and/or index, or another IS_ERR() code.
  */
-struct gpio_desc *__must_check gpiod_get_index(struct device *dev,
-					       const char *con_id,
-					       unsigned int idx,
-					       enum gpiod_flags flags)
+struct gpio_desc *__must_check gpiod_lookup_index(struct device *dev,
+						  const char *con_id,
+						  unsigned int idx)
 {
 	struct gpio_desc *desc = NULL;
-	int status;
 	enum gpio_lookup_flags lookupflags = 0;
 
 	dev_dbg(dev, "GPIO lookup for consumer %s\n", con_id);
@@ -3285,16 +3294,50 @@ struct gpio_desc *__must_check gpiod_get_index(struct device *dev,
 		desc = gpiod_find(dev, con_id, idx, &lookupflags);
 	}
 
-	if (IS_ERR(desc)) {
+	if (IS_ERR(desc))
 		dev_dbg(dev, "lookup for GPIO %s failed\n", con_id);
+
+	/*
+	 * Configure static flags based on lookup data (such as
+	 * "active low", "open drain", etc.)
+	 */
+	gpiod_configure_flags(desc, con_id, lookupflags, 0);
+
+	return desc;
+}
+EXPORT_SYMBOL_GPL(gpiod_lookup_index);
+
+/**
+ * gpiod_get_index - obtain a GPIO from a multi-index GPIO function
+ * @dev:	GPIO consumer, can be NULL for system-global GPIOs
+ * @con_id:	function within the GPIO consumer
+ * @idx:	index of the GPIO to obtain in the consumer
+ * @flags:	optional GPIO initialization flags
+ *
+ * This variant of gpiod_get() allows to access GPIOs other than the first
+ * defined one for functions that define several GPIOs.
+ *
+ * Return a valid GPIO descriptor, -ENOENT if no GPIO has been assigned to the
+ * requested function and/or index, or another IS_ERR() code if an error
+ * occurred while trying to acquire the GPIO.
+ */
+struct gpio_desc *__must_check gpiod_get_index(struct device *dev,
+					       const char *con_id,
+					       unsigned int idx,
+					       enum gpiod_flags flags)
+{
+	struct gpio_desc *desc;
+	int status;
+
+	desc = gpiod_lookup_index(dev, con_id, idx);
+	if (IS_ERR(desc))
 		return desc;
-	}
 
 	status = gpiod_request(desc, con_id);
 	if (status < 0)
 		return ERR_PTR(status);
 
-	status = gpiod_configure_flags(desc, con_id, lookupflags, flags);
+	status = gpiod_configure_flags(desc, con_id, 0, flags);
 	if (status < 0) {
 		dev_dbg(dev, "setup of GPIO %s failed\n", con_id);
 		gpiod_put(desc);
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index fb0fde686cb1..8fcb638f5568 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -46,6 +46,13 @@ enum gpiod_flags {
 /* Return the number of GPIOs associated with a device / function */
 int gpiod_count(struct device *dev, const char *con_id);
 
+/* Look up GPIOs */
+struct gpio_desc *__must_check gpiod_lookup(struct device *dev,
+					    const char *con_id);
+struct gpio_desc *__must_check gpiod_lookup_index(struct device *dev,
+						  const char *con_id,
+						  unsigned int idx);
+
 /* Acquire and dispose GPIOs */
 struct gpio_desc *__must_check gpiod_get(struct device *dev,
 					 const char *con_id,
@@ -146,6 +153,20 @@ static inline int gpiod_count(struct device *dev, const char *con_id)
 	return 0;
 }
 
+static inline struct gpio_desc *__must_check gpiod_lookup(struct device *dev,
+							  const char *con_id)
+{
+	return ERR_PTR(-ENOSYS);
+}
+
+static inline struct gpio_desc *__must_check
+gpiod_lookup_index(struct device *dev,
+		   const char *con_id,
+		   unsigned int idx)
+{
+	return ERR_PTR(-ENOSYS);
+}
+
 static inline struct gpio_desc *__must_check gpiod_get(struct device *dev,
 						       const char *con_id,
 						       enum gpiod_flags flags)
-- 
2.11.0.483.g087da7b7c-goog

