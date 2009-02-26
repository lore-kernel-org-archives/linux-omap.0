From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: [PATCH 1/3] ASoC: Add GPIO support for jack reporting
	interface
Date: Thu, 26 Feb 2009 01:57:03 -0600
Message-ID: <2C7D3DF36ADFFC479B44490D912B616705EC8B1C03@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Add GPIO support for jack reporting framework in ASoC, by using
gpiolib calls. It's only required to append GPIO information (gpio
number, irq handler and flags) to standard jack_pin declaration.
GPIO request, data direction configuration and irq request are
handled by the utility.

The minimal GPIO information that can be provided is the gpio number,
in that case default handler/flags will be used. Default handler queues
a work that reads the current value in the gpio pin and informs to the
jack framework.

If the GPIO support is not required, the "gpio" field ot jack_pin
structure must be set to NO_JACK_PIN_GPIO.

Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>
---
 include/sound/soc.h  |   15 ++++++++++
 sound/soc/soc-jack.c |   70 ++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 83 insertions(+), 2 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 68d8149..846e2c1 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -16,6 +16,8 @@
 #include <linux/platform_device.h>
 #include <linux/types.h>
 #include <linux/workqueue.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/control.h>
@@ -254,14 +256,27 @@ int snd_soc_put_volsw_s8(struct snd_kcontrol *kcontrol,
  * @pin:    name of the pin to update
  * @mask:   bits to check for in reported jack status
  * @invert: if non-zero then pin is enabled when status is not reported
+ * @gpio:   gpio number associated to the pin (gpiolib calls will be used)
+ * @irqflags IRQ flags
+ * @handler: handler for servicing interrupt events on gpio pin
  */
 struct snd_soc_jack_pin {
+	struct snd_soc_jack *jack;
+	struct snd_soc_jack_gpio *gpio_pin;
 	struct list_head list;
 	const char *pin;
 	int mask;
 	bool invert;
+	/* GPIO */
+	unsigned int gpio;
+	unsigned int irq;
+	unsigned long irqflags;
+	irq_handler_t handler;
+	struct work_struct work;
 };
 
+#define NO_JACK_PIN_GPIO	UINT_MAX
+
 struct snd_soc_jack {
 	struct snd_jack *jack;
 	struct snd_soc_card *card;
diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index 8cc00c3..0d048b2 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -14,6 +14,9 @@
 #include <sound/jack.h>
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
+#include <linux/gpio.h>
+#include <linux/interrupt.h>
+#include <linux/workqueue.h>
 
 /**
  * snd_soc_jack_new - Create a new jack
@@ -96,6 +99,32 @@ out:
 }
 EXPORT_SYMBOL_GPL(snd_soc_jack_report);
 
+/* Default IRQ handler for a GPIO jack pin, it will queue a
+ * work that reads current value in GPIO pin and reports it
+ * to the jack framework.
+ */
+static irqreturn_t gpio_interrupt(int irq, void *data)
+{
+	struct snd_soc_jack_pin *pin = data;
+
+	return IRQ_RETVAL(schedule_work(&pin->work));
+}
+
+static void gpio_work(struct work_struct *work)
+{
+	struct snd_soc_jack_pin *pin;
+	int report;
+
+	pin = container_of(work, struct snd_soc_jack_pin, work);
+	report = pin->jack->status & pin->mask;
+	if (gpio_get_value(pin->gpio))
+		report |= pin->mask;
+	else
+		report &= ~pin->mask;
+
+	snd_soc_jack_report(pin->jack, report, pin->jack->jack->type);
+}
+
 /**
  * snd_soc_jack_add_pins - Associate DAPM pins with an ASoC jack
  *
@@ -106,11 +135,18 @@ EXPORT_SYMBOL_GPL(snd_soc_jack_report);
  * After this function has been called the DAPM pins specified in the
  * pins array will have their status updated to reflect the current
  * state of the jack whenever the jack status is updated.
+ *
+ * A GPIO pin (using gpiolib) can be used to detect events. It requieres
+ * an IRQ handler and flags to be set in jack_pin structure; if they are
+ * not provided, default handler/flags will be used instead. If this
+ * feature is not desired, "gpio" field of jack_pin structure must be
+ * set to NO_JACK_PIN_GPIO.
  */
 int snd_soc_jack_add_pins(struct snd_soc_jack *jack, int count,
 			  struct snd_soc_jack_pin *pins)
 {
-	int i;
+	unsigned int gpio = 0;
+	int i, ret = 0;
 
 	for (i = 0; i < count; i++) {
 		if (!pins[i].pin) {
@@ -123,6 +159,32 @@ int snd_soc_jack_add_pins(struct snd_soc_jack *jack, int count,
 			return -EINVAL;
 		}
 
+		if (pins[i].gpio != NO_JACK_PIN_GPIO) {
+			pins[i].jack = jack;
+			gpio = pins[i].gpio;
+			ret = gpio_request(gpio, pins[i].pin);
+			if (ret)
+				return ret;
+
+			ret = gpio_direction_input(gpio);
+			if (ret)
+				goto out;
+			pins[i].irq = gpio_to_irq(gpio);
+			/* If none set, use the default handler */
+			if (!pins[i].handler) {
+				pins[i].handler = gpio_interrupt;
+				pins[i].irqflags = IRQF_TRIGGER_RISING |
+						IRQF_TRIGGER_FALLING;
+				INIT_WORK(&pins[i].work, gpio_work);
+			}
+			ret = request_irq(pins[i].irq,
+					pins[i].handler,
+					pins[i].irqflags,
+					jack->card->dev->driver->name,
+					&pins[i]);
+			if (ret)
+				goto out;
+		}
 		INIT_LIST_HEAD(&pins[i].list);
 		list_add(&(pins[i].list), &jack->pins);
 	}
@@ -133,6 +195,10 @@ int snd_soc_jack_add_pins(struct snd_soc_jack *jack, int count,
 	 */
 	snd_soc_jack_report(jack, 0, 0);
 
-	return 0;
+out:
+	if (ret)
+		gpio_free(gpio);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(snd_soc_jack_add_pins);
-- 
1.5.4.3
