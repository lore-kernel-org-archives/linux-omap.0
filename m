From: NeilBrown <neilb@suse.de>
Subject: [PATCH 08/15] twl4030_charger: distinguish between USB current and
 'AC' current
Date: Tue, 24 Feb 2015 15:33:51 +1100
Message-ID: <20150224043351.4243.50342.stgit@notabene.brown>
References: <20150224043341.4243.23291.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150224043341.4243.23291.stgit@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: GTA04 owners <gta04-owner@goldelico.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The twl4030 charger has two current sources, 'USB' and 'AC' (which is
really DC of course...).

If 'AC' is providing current, we should set the current limit
differently to when it isn't (and so USB is used).
So split 'cur' into 'usb_cur' and 'ac_cur' and use accordingly.

Now we must review the current setting on any interrupt or USB
event which might indicate that the charger-source has changed.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 drivers/power/twl4030_charger.c |   30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/power/twl4030_charger.c b/drivers/power/twl4030_charger.c
index 7c35cd9ba171..bfc9b808301e 100644
--- a/drivers/power/twl4030_charger.c
+++ b/drivers/power/twl4030_charger.c
@@ -22,6 +22,7 @@
 #include <linux/power_supply.h>
 #include <linux/notifier.h>
 #include <linux/usb/otg.h>
+#include <linux/i2c/twl4030-madc.h>
 
 #define TWL4030_BCIMSTATEC	0x02
 #define TWL4030_BCIICHG		0x08
@@ -103,7 +104,9 @@ struct twl4030_bci {
 	/* ichg values in uA. If any are 'large', we set CGAIN to
 	 * '1' which doubles the range for half the precision.
 	 */
-	int			ichg_eoc, ichg_lo, ichg_hi, cur;
+	int			ichg_eoc, ichg_lo, ichg_hi;
+	int			usb_cur, ac_cur;
+	bool			ac_is_active;
 
 	unsigned long		event;
 };
@@ -224,11 +227,23 @@ static int ua2regval(int ua, bool cgain)
 static int twl4030_charger_update_current(struct twl4030_bci *bci)
 {
 	int status;
+	int cur;
 	unsigned reg, cur_reg;
 	u8 bcictl1, oldreg, fullreg;
 	int cgain = 0;
 	u8 boot_bci;
 
+	/* If VAC exceeds 4.5V (MADC 11) and ac is enabled, set current
+	 * for 'ac'
+	 */
+	if (twl4030_get_madc_conversion(11) > 4500) {
+		cur = bci->ac_cur;
+		bci->ac_is_active = 1;
+	} else {
+		cur = bci->usb_cur;
+		bci->ac_is_active = 0;
+	}
+
 	/* First, check thresholds and see if cgain is needed */
 	if (bci->ichg_eoc >= 200000)
 		cgain = 1;
@@ -236,7 +251,7 @@ static int twl4030_charger_update_current(struct twl4030_bci *bci)
 		cgain = 1;
 	if (bci->ichg_hi >= 820000)
 		cgain = 1;
-	if (bci->cur > 852000)
+	if (cur > 852000)
 		cgain = 1;
 
 	status = twl4030_bci_read(TWL4030_BCICTL1, &bcictl1);
@@ -311,7 +326,7 @@ static int twl4030_charger_update_current(struct twl4030_bci *bci)
 
 	/* And finally, set the current.  This is stored in
 	 * two registers. */
-	reg = ua2regval(bci->cur, cgain);
+	reg = ua2regval(cur, cgain);
 	/* we have only 10 bit */
 	if (reg > 0x3ff)
 		reg = 0x3ff;
@@ -364,6 +379,8 @@ static int twl4030_charger_enable_usb(struct twl4030_bci *bci, bool enable)
 
 	if (enable && !IS_ERR_OR_NULL(bci->transceiver)) {
 
+		twl4030_charger_update_current(bci);
+
 		/* Need to keep phy powered */
 		if (!bci->usb_enabled) {
 			pm_runtime_get_sync(bci->transceiver->dev);
@@ -456,6 +473,7 @@ static irqreturn_t twl4030_charger_interrupt(int irq, void *arg)
 	struct twl4030_bci *bci = arg;
 
 	dev_dbg(bci->dev, "CHG_PRES irq\n");
+	twl4030_charger_update_current(bci);
 	power_supply_changed(&bci->ac);
 	power_supply_changed(&bci->usb);
 
@@ -488,6 +506,7 @@ static irqreturn_t twl4030_bci_interrupt(int irq, void *arg)
 		power_supply_changed(&bci->ac);
 		power_supply_changed(&bci->usb);
 	}
+	twl4030_charger_update_current(bci);
 
 	/* various monitoring events, for now we just log them here */
 	if (irqs1 & (TWL4030_TBATOR2 | TWL4030_TBATOR1))
@@ -701,10 +720,11 @@ static int __init twl4030_bci_probe(struct platform_device *pdev)
 	bci->ichg_eoc = 80100; /* Stop charging when current drops to here */
 	bci->ichg_lo = 241000; /* low threshold */
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
