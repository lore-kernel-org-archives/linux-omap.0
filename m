From: NeilBrown <neilb@suse.de>
Subject: [PATCH 06/15] twl4030_charger: split uA calculation into a function.
Date: Tue, 24 Feb 2015 15:33:51 +1100
Message-ID: <20150224043351.4243.86053.stgit@notabene.brown>
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

We will need this calculation in other places, so
create functions to map between register value and uA value.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 drivers/power/twl4030_charger.c |   48 ++++++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 13 deletions(-)

diff --git a/drivers/power/twl4030_charger.c b/drivers/power/twl4030_charger.c
index db8931a17541..0b6fb06a0c01 100644
--- a/drivers/power/twl4030_charger.c
+++ b/drivers/power/twl4030_charger.c
@@ -178,6 +178,40 @@ static int twl4030_is_battery_present(struct twl4030_bci *bci)
 }
 
 /*
+ * TI provided formulas:
+ * CGAIN == 0: ICHG = (BCIICHG * 1.7) / (2^10 - 1) - 0.85
+ * CGAIN == 1: ICHG = (BCIICHG * 3.4) / (2^10 - 1) - 1.7
+ * Here we use integer approximation of:
+ * CGAIN == 0: val * 1.6618 - 0.85 * 1000
+ * CGAIN == 1: (val * 1.6618 - 0.85 * 1000) * 2
+ */
+/*
+ * convert twl register value for currents into uA
+ */
+static int regval2ua(int regval, bool cgain)
+{
+	if (cgain)
+		return (regval * 16618 - 8500 * 1000) / 5;
+	else
+		return (regval * 16618 - 8500 * 1000) / 10;
+}
+
+/*
+ * convert uA currents into twl register value
+ */
+static int ua2regval(int ua, bool cgain)
+{
+	int ret;
+	if (cgain)
+		ua /= 2;
+	ret = (ua * 10 + 8500 * 1000) / 16618;
+	/* rounding problems */
+	if (ret < 512)
+		ret = 512;
+	return ret;
+}
+
+/*
  * Enable/Disable USB Charge functionality.
  */
 static int twl4030_charger_enable_usb(struct twl4030_bci *bci, bool enable)
@@ -366,14 +400,6 @@ static int twl4030_bci_usb_ncb(struct notifier_block *nb, unsigned long val,
 	return NOTIFY_OK;
 }
 
-/*
- * TI provided formulas:
- * CGAIN == 0: ICHG = (BCIICHG * 1.7) / (2^10 - 1) - 0.85
- * CGAIN == 1: ICHG = (BCIICHG * 3.4) / (2^10 - 1) - 1.7
- * Here we use integer approximation of:
- * CGAIN == 0: val * 1.6618 - 0.85
- * CGAIN == 1: (val * 1.6618 - 0.85) * 2
- */
 static int twl4030_charger_get_current(void)
 {
 	int curr;
@@ -388,11 +414,7 @@ static int twl4030_charger_get_current(void)
 	if (ret)
 		return ret;
 
-	ret = (curr * 16618 - 850 * 10000) / 10;
-	if (bcictl1 & TWL4030_CGAIN)
-		ret *= 2;
-
-	return ret;
+	return regval2ua(curr, bcictl1 & TWL4030_CGAIN);
 }
 
 /*
