From: NeilBrown <neil@brown.name>
Subject: [PATCH 07/13] twl4030_charger: distinguish between USB current and
 'AC' current
Date: Thu, 30 Jul 2015 10:11:24 +1000
Message-ID: <20150730001124.4012.48552.stgit@noble>
References: <20150730001113.4012.18086.stgit@noble>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150730001113.4012.18086.stgit@noble>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org, real GTA04 owners <gta04-owner@goldelico.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: linux-omap@vger.kernel.org


The twl4030 charger has two current sources, 'USB' and 'AC'
(presumably "Accessory Charger" because it isn't Alternating Current).

If 'AC' is providing current, we should set the current limit
differently to when it isn't (and so USB is used).
So split 'cur' into 'usb_cur' and 'ac_cur' and use accordingly.

Now we must review the current setting on any interrupt or USB
event which might indicate that the charger-source has changed.

Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: NeilBrown <neil@brown.name>
---
 drivers/power/twl4030_charger.c |   36 +++++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/drivers/power/twl4030_charger.c b/drivers/power/twl4030_charger.c
index 3b7cc631bb8a..982675df21b7 100644
--- a/drivers/power/twl4030_charger.c
+++ b/drivers/power/twl4030_charger.c
@@ -22,6 +22,7 @@
 #include <linux/power_supply.h>
 #include <linux/notifier.h>
 #include <linux/usb/otg.h>
+#include <linux/i2c/twl4030-madc.h>
 
 #define TWL4030_BCIMSTATEC	0x02
 #define TWL4030_BCIICHG		0x08
@@ -101,10 +102,13 @@ struct twl4030_bci {
 	int			usb_enabled;
 
 	/*
-	 * ichg values in uA. If any are 'large', we set CGAIN to
-	 * '1' which doubles the range for half the precision.
+	 * ichg_* and *_cur values in uA. If any are 'large', we set
+	 * CGAIN to '1' which doubles the range for half the
+	 * precision.
 	 */
-	unsigned int		ichg_eoc, ichg_lo, ichg_hi, cur;
+	unsigned int		ichg_eoc, ichg_lo, ichg_hi;
+	unsigned int		usb_cur, ac_cur;
+	bool			ac_is_active;
 
 	unsigned long		event;
 };
@@ -225,11 +229,24 @@ static int ua2regval(int ua, bool cgain)
 static int twl4030_charger_update_current(struct twl4030_bci *bci)
 {
 	int status;
+	int cur;
 	unsigned reg, cur_reg;
 	u8 bcictl1, oldreg, fullreg;
 	bool cgain = false;
 	u8 boot_bci;
 
+	/*
+	 * If AC (Accessory Charger) voltage exceeds 4.5V (MADC 11)
+	 * and AC is enabled, set current for 'ac'
+	 */
+	if (twl4030_get_madc_conversion(11) > 4500) {
+		cur = bci->ac_cur;
+		bci->ac_is_active = true;
+	} else {
+		cur = bci->usb_cur;
+		bci->ac_is_active = false;
+	}
+
 	/* First, check thresholds and see if cgain is needed */
 	if (bci->ichg_eoc >= 200000)
 		cgain = true;
@@ -237,7 +254,7 @@ static int twl4030_charger_update_current(struct twl4030_bci *bci)
 		cgain = true;
 	if (bci->ichg_hi >= 820000)
 		cgain = true;
-	if (bci->cur > 852000)
+	if (cur > 852000)
 		cgain = true;
 
 	status = twl4030_bci_read(TWL4030_BCICTL1, &bcictl1);
@@ -318,7 +335,7 @@ static int twl4030_charger_update_current(struct twl4030_bci *bci)
 	 * And finally, set the current.  This is stored in
 	 * two registers.
 	 */
-	reg = ua2regval(bci->cur, cgain);
+	reg = ua2regval(cur, cgain);
 	/* we have only 10 bits */
 	if (reg > 0x3ff)
 		reg = 0x3ff;
@@ -371,6 +388,8 @@ static int twl4030_charger_enable_usb(struct twl4030_bci *bci, bool enable)
 
 	if (enable && !IS_ERR_OR_NULL(bci->transceiver)) {
 
+		twl4030_charger_update_current(bci);
+
 		/* Need to keep phy powered */
 		if (!bci->usb_enabled) {
 			pm_runtime_get_sync(bci->transceiver->dev);
@@ -463,6 +482,7 @@ static irqreturn_t twl4030_charger_interrupt(int irq, void *arg)
 	struct twl4030_bci *bci = arg;
 
 	dev_dbg(bci->dev, "CHG_PRES irq\n");
+	twl4030_charger_update_current(bci);
 	power_supply_changed(bci->ac);
 	power_supply_changed(bci->usb);
 
@@ -495,6 +515,7 @@ static irqreturn_t twl4030_bci_interrupt(int irq, void *arg)
 		power_supply_changed(bci->ac);
 		power_supply_changed(bci->usb);
 	}
+	twl4030_charger_update_current(bci);
 
 	/* various monitoring events, for now we just log them here */
 	if (irqs1 & (TWL4030_TBATOR2 | TWL4030_TBATOR1))
@@ -724,10 +745,11 @@ static int twl4030_bci_probe(struct platform_device *pdev)
 	bci->ichg_eoc = 80100; /* Stop charging when current drops to here */
 	bci->ichg_lo = 241000; /* Low threshold */
 	bci->ichg_hi = 500000; /* High threshold */
+	bci->ac_cur = 500000; /* 500mA */
 	if (allow_usb)
-		bci->cur = 500000;  /* 500mA */
+		bci->usb_cur = 500000;  /* 500mA */
 	else
-		bci->cur = 100000;  /* 100mA */
+		bci->usb_cur = 100000;  /* 100mA */
 
 	bci->dev = &pdev->dev;
 	bci->irq_chg = platform_get_irq(pdev, 0);
