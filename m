From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/4] regmap: irq: Fix lost interrupts by introducing
 handle_reread
Date: Mon, 27 Mar 2017 17:36:48 -0700
Message-ID: <20170328003648.GS10760@atomide.com>
References: <20170322171052.7006-1-tony@atomide.com>
 <20170322171052.7006-2-tony@atomide.com>
 <20170327174952.jsfleql654m2h45i@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170327174952.jsfleql654m2h45i@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Lee Jones <lee.jones@linaro.org>, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>
List-Id: linux-omap@vger.kernel.org

* Mark Brown <broonie@kernel.org> [170327 10:52]:
> On Wed, Mar 22, 2017 at 10:10:49AM -0700, Tony Lindgren wrote:
> > At least Motorola CPCAP PMIC needs it's device interrupts re-read
> > until there are no more interrupts. Otherwise the PMIC interrupt to
> > the SoC will eventually stop toggling. This seems to be a bug in the
> > CPCAP PMIC where it can stop driving the GPIO interrupt to the SoC
> > with pending CPCAP interrupts.
> 
> > Let's allow handling issues like this by introducing a flag for
> > handle_reread and by splitting regmap_irq_thread() into two separate
> > functions for regmap_read_irq_status() and regmap_irq_handle_pending().
> 
> So, I see your use case but the fact is that as Charles observed this is
> exactly the code used for emulating level triggered IRQs with edge
> triggered interrupt controllers.  This means someone is doubtless going
> to end up using it for precisely that.  This makes me uncomfortable, we
> do have this open coded into various drivers already but this is more of
> a core thing and it feels like this should be in genirq rather than
> here...  that said, looking at the code:

Yes.. But then again we might avoid piling up yet more driver
specific hacks. I don't know what the genirq solution would look
like, handle until we get IRQ_NONE? :)

> > +	do {
> > +		ret = regmap_read_irq_status(data);
> > +		if (ret)
> > +			goto out_runtime_put;
> > +
> > +		ret = regmap_irq_handle_pending(data);
> > +		if (ret < 0)
> > +			goto out_runtime_put;
> > +
> > +		if (!ret)
> > +			break;
> > +
> > +		handled += ret;
> > +	} while (chip->handle_reread);
> 
> There's no protection against screaming interrupts here, I'd really like
> to see that.  Also some tracing of the number of times we spin.

Good idea. How about something like below where handle_reread checks
for the total time spent in the thread loop with a large enough
timeout? Or do you have some better ideas in mind?

I tested I can hit that warning with timeout set to much lower
10 ms with retries being 1 or 2 at that point.

Regards,

Tony

8< -------------------------------
>From tony Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Mon, 27 Mar 2017 08:09:36 -0700
Subject: [PATCH] regmap: irq: Fix lost interrupts by introducing
 handle_reread

At least Motorola CPCAP PMIC needs it's device interrupts re-read
until there are no more interrupts. Otherwise the PMIC interrupt to
the SoC will eventually stop toggling. This seems to be a bug in the
CPCAP PMIC where it can stop driving the GPIO interrupt to the SoC
with pending CPCAP interrupts.

Let's allow handling issues like this by introducing a flag for
handle_reread and by splitting regmap_irq_thread() into two separate
functions for regmap_read_irq_status() and regmap_irq_handle_pending().

Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Marcel Partap <mpartap@gmx.net>
Cc: Michael Scott <michael.scott@linaro.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/base/regmap/regmap-irq.c | 97 ++++++++++++++++++++++++++++++----------
 include/linux/regmap.h           |  2 +
 2 files changed, 75 insertions(+), 24 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -21,6 +21,8 @@
 
 #include "internal.h"
 
+#define REGMAP_IRQ_THREAD_MAX_MSECS	3000
+
 struct regmap_irq_chip_data {
 	struct mutex lock;
 	struct irq_chip irq_chip;
@@ -259,27 +261,11 @@ static const struct irq_chip regmap_irq_chip = {
 	.irq_set_wake		= regmap_irq_set_wake,
 };
 
-static irqreturn_t regmap_irq_thread(int irq, void *d)
+static int regmap_read_irq_status(struct regmap_irq_chip_data *data)
 {
-	struct regmap_irq_chip_data *data = d;
 	const struct regmap_irq_chip *chip = data->chip;
 	struct regmap *map = data->map;
 	int ret, i;
-	bool handled = false;
-	u32 reg;
-
-	if (chip->handle_pre_irq)
-		chip->handle_pre_irq(chip->irq_drv_data);
-
-	if (chip->runtime_pm) {
-		ret = pm_runtime_get_sync(map->dev);
-		if (ret < 0) {
-			dev_err(map->dev, "IRQ thread failed to resume: %d\n",
-				ret);
-			pm_runtime_put(map->dev);
-			goto exit;
-		}
-	}
 
 	/*
 	 * Read in the statuses, using a single bulk read if possible
@@ -299,7 +285,7 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
 		if (ret != 0) {
 			dev_err(map->dev, "Failed to read IRQ status: %d\n",
 				ret);
-			goto exit;
+			return ret;
 		}
 
 		for (i = 0; i < data->chip->num_regs; i++) {
@@ -315,7 +301,7 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
 				break;
 			default:
 				BUG();
-				goto exit;
+				return ret;
 			}
 		}
 
@@ -330,13 +316,21 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
 				dev_err(map->dev,
 					"Failed to read IRQ status: %d\n",
 					ret);
-				if (chip->runtime_pm)
-					pm_runtime_put(map->dev);
-				goto exit;
+				return ret;
 			}
 		}
 	}
 
+	return 0;
+}
+
+static int regmap_irq_handle_pending(struct regmap_irq_chip_data *data)
+{
+	const struct regmap_irq_chip *chip = data->chip;
+	struct regmap *map = data->map;
+	int ret, i, handled = 0;
+	u32 reg;
+
 	/*
 	 * Ignore masked IRQs and ack if we need to; we ack early so
 	 * there is no race between handling and acknowleding the
@@ -361,14 +355,69 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
 		if (data->status_buf[chip->irqs[i].reg_offset /
 				     map->reg_stride] & chip->irqs[i].mask) {
 			handle_nested_irq(irq_find_mapping(data->domain, i));
-			handled = true;
+			handled++;
 		}
 	}
 
+	return handled;
+}
+
+static irqreturn_t regmap_irq_thread(int irq, void *d)
+{
+	struct regmap_irq_chip_data *data = d;
+	const struct regmap_irq_chip *chip = data->chip;
+	struct regmap *map = data->map;
+	ktime_t calltime = 0, retrytime;
+	int ret, handled = 0, retries = 0;
+
+	if (chip->handle_reread)
+		calltime = ktime_get();
+
+	if (chip->handle_pre_irq)
+		chip->handle_pre_irq(chip->irq_drv_data);
+
+	if (chip->runtime_pm) {
+		ret = pm_runtime_get_sync(map->dev);
+		if (ret < 0) {
+			dev_err(map->dev, "IRQ thread failed to resume: %d\n",
+				ret);
+			goto out_runtime_put;
+		}
+	}
+
+	do {
+		ret = regmap_read_irq_status(data);
+		if (ret)
+			goto out_runtime_put;
+
+		ret = regmap_irq_handle_pending(data);
+		if (ret < 0)
+			goto out_runtime_put;
+
+		if (!ret)
+			break;
+
+		handled += ret;
+		retries++;
+
+		if (chip->handle_reread) {
+			s64 msecs;
+
+			retrytime = ktime_get();
+			msecs = ktime_to_ms(ktime_sub(retrytime, calltime));
+			if (msecs > REGMAP_IRQ_THREAD_MAX_MSECS) {
+				dev_err(map->dev,
+					"IRQ thread timeout after %i retries\n",
+					retries);
+				goto out_runtime_put;
+			}
+		}
+	} while (chip->handle_reread);
+
+out_runtime_put:
 	if (chip->runtime_pm)
 		pm_runtime_put(map->dev);
 
-exit:
 	if (chip->handle_post_irq)
 		chip->handle_post_irq(chip->irq_drv_data);
 
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -897,6 +897,7 @@ struct regmap_irq {
  * @ack_invert:  Inverted ack register: cleared bits for ack.
  * @wake_invert: Inverted wake register: cleared bits are wake enabled.
  * @type_invert: Invert the type flags.
+ * @handle_reread: Read interrupt status until no more interrupts are seen.
  * @runtime_pm:  Hold a runtime PM lock on the device when accessing it.
  *
  * @num_regs:    Number of registers in each control bank.
@@ -934,6 +935,7 @@ struct regmap_irq_chip {
 	bool wake_invert:1;
 	bool runtime_pm:1;
 	bool type_invert:1;
+	bool handle_reread:1;
 
 	int num_regs;
 
-- 
2.12.1
