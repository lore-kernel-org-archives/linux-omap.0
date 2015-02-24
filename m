From: NeilBrown <neilb@suse.de>
Subject: [PATCH 14/15] twl4030_charger: Increase current carefully while
 watching voltage.
Date: Tue, 24 Feb 2015 15:33:53 +1100
Message-ID: <20150224043353.4243.32335.stgit@notabene.brown>
References: <20150224043341.4243.23291.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20150224043341.4243.23291.stgit@notabene.brown>
Sender: linux-pm-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: GTA04 owners <gta04-owner@goldelico.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The USB Battery Charging spec (BC1.2) suggests a dedicated
charging port can deliver from 0.5 to 5.0A at between 4.75 and 5.25
volts.

To choose the "correct" current voltage setting requires a trial
and error approach: try to draw current and see if the voltage drops
too low.

Even with a configure Standard Downstream Port, it may not be possible
to reliably pull 500mA - depending on cable quality and source
quality I have reports of charging failure due to the voltage dropping
too low.

To address both these concern, this patch introduce incremental
current setting.
The current pull from VBUS is increased in steps of 20mA every 100ms
until the target is reached or until the measure voltage drops below
4.75V.  If the voltage does go too long, the target current is reduced
by 20mA and kept there.

This applies to currents selected automatically, or to values
set via sysfs.  So setting a large value will cause the maximum
available to be used - up to the limit of 1.7mA imposed by the
hardware.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 drivers/power/twl4030_charger.c |   54 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/power/twl4030_charger.c b/drivers/power/twl4030_charger.c
index e5a0225ea87e..7ad6b4b531d7 100644
--- a/drivers/power/twl4030_charger.c
+++ b/drivers/power/twl4030_charger.c
@@ -117,6 +117,18 @@ struct twl4030_bci {
 #define	CHARGE_AUTO	1
 #define	CHARGE_LINEAR	2
 
+	/* When setting the USB current we slowly increase the
+	 * requested current until target is reached or the voltage
+	 * drops below 4.75V.  In the latter case we set back one
+	 * step.
+	 */
+	int			usb_cur_actual;
+	struct delayed_work	current_worker;
+#define	USB_CUR_STEP	20000	/* 20mA at a time */
+#define	USB_MIN_VOLT	4750000	/* 4.75V */
+#define	USB_CUR_DELAY	msecs_to_jiffies(100)
+#define	USB_MAX_CURRENT	1700000 /* TWL4030 caps at 1.7mA */
+
 	unsigned long		event;
 };
 
@@ -249,8 +261,14 @@ static int twl4030_charger_update_current(struct twl4030_bci *bci)
 		cur = bci->ac_cur;
 		bci->ac_is_active = 1;
 	} else {
-		cur = bci->usb_cur;
+		cur = bci->usb_cur_actual;
 		bci->ac_is_active = 0;
+		if (cur > bci->usb_cur) {
+			cur = bci->usb_cur;
+			bci->usb_cur_actual = cur;
+		}
+		if (cur < bci->usb_cur)
+			schedule_delayed_work(&bci->current_worker, USB_CUR_DELAY);
 	}
 
 	/* First, check thresholds and see if cgain is needed */
@@ -379,6 +397,38 @@ static int twl4030_charger_update_current(struct twl4030_bci *bci)
 	return 0;
 }
 
+static void twl4030_current_worker(struct work_struct *data)
+{
+	int v;
+	int res;
+	struct twl4030_bci *bci = container_of(data, struct twl4030_bci,
+					       current_worker.work);
+
+	res = twl4030bci_read_adc_val(TWL4030_BCIVBUS);
+	if (res < 0)
+		v = 0;
+	else
+		/* BCIVBUS uses ADCIN8, 7/1023 V/step */
+		v = res * 6843;
+
+	printk("v=%d cur=%d target=%d\n", v, bci->usb_cur_actual,
+	       bci->usb_cur);
+
+	if (v < USB_MIN_VOLT) {
+		/* Back up and stop adjusting. */
+		bci->usb_cur_actual -= USB_CUR_STEP;
+		bci->usb_cur = bci->usb_cur_actual;
+	} else if (bci->usb_cur_actual >= bci->usb_cur ||
+		   bci->usb_cur_actual + USB_CUR_STEP > USB_MAX_CURRENT) {
+		/* Reach target and volts are OK - stop */
+		return;
+	} else {
+		bci->usb_cur_actual += USB_CUR_STEP;
+		schedule_delayed_work(&bci->current_worker, USB_CUR_DELAY);
+	}
+	twl4030_charger_update_current(bci);
+}
+
 /*
  * Enable/Disable USB Charge functionality.
  */
@@ -441,6 +491,7 @@ static int twl4030_charger_enable_usb(struct twl4030_bci *bci, bool enable)
 			pm_runtime_put_autosuspend(bci->transceiver->dev);
 			bci->usb_enabled = 0;
 		}
+		bci->usb_cur_actual = 0;
 	}
 
 	return ret;
@@ -972,6 +1023,7 @@ static int __init twl4030_bci_probe(struct platform_device *pdev)
 	}
 
 	INIT_WORK(&bci->work, twl4030_bci_usb_work);
+	INIT_DELAYED_WORK(&bci->current_worker, twl4030_current_worker);
 
 	bci->usb_nb.notifier_call = twl4030_bci_usb_ncb;
 	if (bci->dev->of_node) {


