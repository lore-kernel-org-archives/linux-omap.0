From: NeilBrown <neilb@suse.de>
Subject: [PATCH 12/15] twl4030_charger: add software controlled linear
 charging mode.
Date: Tue, 24 Feb 2015 15:33:52 +1100
Message-ID: <20150224043352.4243.11227.stgit@notabene.brown>
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

Add a 'continuous' option for usb charging which enabled
the "linear" charging mode of the twl4030.

Linear charging does a good job with not so reliable power sources, since
several voltage controlling is then often too intelligent.
It was used with a bike hub dynamo since a year or so. In that case there
are automatically charging stops when the cyclist needs a break.

Orignal-by: Andreas Kemnade <andreas@kemnade.info>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 drivers/power/twl4030_charger.c |   57 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 52 insertions(+), 5 deletions(-)

diff --git a/drivers/power/twl4030_charger.c b/drivers/power/twl4030_charger.c
index 19e8dbb1303e..6c53f0b601a4 100644
--- a/drivers/power/twl4030_charger.c
+++ b/drivers/power/twl4030_charger.c
@@ -24,6 +24,8 @@
 #include <linux/usb/otg.h>
 #include <linux/i2c/twl4030-madc.h>
 
+#define TWL4030_BCIMDEN		0x00
+#define TWL4030_BCIMDKEY	0x01
 #define TWL4030_BCIMSTATEC	0x02
 #define TWL4030_BCIICHG		0x08
 #define TWL4030_BCIVAC		0x0a
@@ -35,13 +37,16 @@
 #define TWL4030_BCIIREF1	0x27
 #define TWL4030_BCIIREF2	0x28
 #define TWL4030_BCIMFKEY	0x11
+#define TWL4030_BCIMFEN3	0x14
 #define TWL4030_BCIMFTH8	0x1d
 #define TWL4030_BCIMFTH9	0x1e
+#define TWL4030_BCIWDKEY	0x21
 
 #define TWL4030_BCIMFSTS1	0x01
 
 #define TWL4030_BCIAUTOWEN	BIT(5)
 #define TWL4030_CONFIG_DONE	BIT(4)
+#define TWL4030_CVENAC		BIT(2)
 #define TWL4030_BCIAUTOUSB	BIT(1)
 #define TWL4030_BCIAUTOAC	BIT(0)
 #define TWL4030_CGAIN		BIT(5)
@@ -110,6 +115,7 @@ struct twl4030_bci {
 	int			usb_mode; /* charging mode requested */
 #define	CHARGE_OFF	0
 #define	CHARGE_AUTO	1
+#define	CHARGE_LINEAR	2
 
 	unsigned long		event;
 };
@@ -392,16 +398,44 @@ static int twl4030_charger_enable_usb(struct twl4030_bci *bci, bool enable)
 			bci->usb_enabled = 1;
 		}
 
-		/* forcing the field BCIAUTOUSB (BOOT_BCI[1]) to 1 */
-		ret = twl4030_clear_set_boot_bci(0, TWL4030_BCIAUTOUSB);
-		if (ret < 0)
-			return ret;
+		if (bci->usb_mode == CHARGE_AUTO) {
+			/* forcing the field BCIAUTOUSB (BOOT_BCI[1]) to 1 */
+			ret = twl4030_clear_set_boot_bci(0, TWL4030_BCIAUTOUSB);
+			twl4030_clear_set_boot_bci(0, TWL4030_BCIAUTOAC|TWL4030_CVENAC);
+		}
 
 		/* forcing USBFASTMCHG(BCIMFSTS4[2]) to 1 */
 		ret = twl4030_clear_set(TWL_MODULE_MAIN_CHARGE, 0,
 			TWL4030_USBFASTMCHG, TWL4030_BCIMFSTS4);
+		if (bci->usb_mode == CHARGE_LINEAR) {
+			twl4030_clear_set_boot_bci(TWL4030_BCIAUTOAC|TWL4030_CVENAC, 0);
+			/* Watch dog key: WOVF acknowledge */
+			ret = twl_i2c_write_u8(TWL_MODULE_MAIN_CHARGE, 0x33,
+					       TWL4030_BCIWDKEY);
+			/* 0x24 + EKEY6:  off mode */
+			ret = twl_i2c_write_u8(TWL_MODULE_MAIN_CHARGE, 0x2a,
+					       TWL4030_BCIMDKEY);
+			/* EKEY2: Linear charge: usb path */
+			ret = twl_i2c_write_u8(TWL_MODULE_MAIN_CHARGE, 0x26,
+					       TWL4030_BCIMDKEY);
+			/* WDKEY5: stop watchdog count */
+			ret = twl_i2c_write_u8(TWL_MODULE_MAIN_CHARGE, 0xf3,
+					       TWL4030_BCIWDKEY);
+			/* enable MFEN3 access */
+			ret = twl_i2c_write_u8(TWL_MODULE_MAIN_CHARGE, 0x9c,
+					       TWL4030_BCIMFKEY);
+			 /* ICHGEOCEN - end-of-charge monitor (current < 80mA)
+			  *                      (charging continues)
+			  * ICHGLOWEN - current level monitor (charge continues)
+			  * don't monitor over-current or heat save
+			  */
+			ret = twl_i2c_write_u8(TWL_MODULE_MAIN_CHARGE, 0xf0,
+					       TWL4030_BCIMFEN3);
+		}
 	} else {
 		ret = twl4030_clear_set_boot_bci(TWL4030_BCIAUTOUSB, 0);
+		ret |= twl_i2c_write_u8(TWL_MODULE_MAIN_CHARGE, 0x2a,
+					TWL4030_BCIMDKEY);
 		if (bci->usb_enabled) {
 			pm_runtime_mark_last_busy(bci->transceiver->dev);
 			pm_runtime_put_autosuspend(bci->transceiver->dev);
@@ -637,7 +671,7 @@ static int twl4030_bci_usb_ncb(struct notifier_block *nb, unsigned long val,
 /*
  * sysfs charger enabled store
  */
-static char *modes[] = { "off", "auto" };
+static char *modes[] = { "off", "auto", "continuous" };
 static ssize_t
 twl4030_bci_mode_store(struct device *dev, struct device_attribute *attr,
 			  const char *buf, size_t n)
@@ -650,6 +684,8 @@ twl4030_bci_mode_store(struct device *dev, struct device_attribute *attr,
 		mode = 0;
 	else if (sysfs_streq(buf, modes[1]))
 		mode = 1;
+	else if (sysfs_streq(buf, modes[2]))
+		mode = 2;
 	else
 		return -EINVAL;
 	twl4030_charger_enable_usb(bci, false);
@@ -748,6 +784,17 @@ static int twl4030_bci_get_property(struct power_supply *psy,
 		is_charging = state & TWL4030_MSTATEC_USB;
 	else
 		is_charging = state & TWL4030_MSTATEC_AC;
+	if (!is_charging) {
+		u8 s;
+		twl4030_bci_read(TWL4030_BCIMDEN, &s);
+		if (psy->type == POWER_SUPPLY_TYPE_USB)
+			is_charging = s & 1;
+		else
+			is_charging = s & 2;
+		if (is_charging)
+			/* A little white lie */
+			state = TWL4030_MSTATEC_QUICK1;
+	}
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:


