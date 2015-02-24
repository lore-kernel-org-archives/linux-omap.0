From: NeilBrown <neilb@suse.de>
Subject: [PATCH 05/15] twl4030_charger: trust phy to determine when USB
 power is available.
Date: Tue, 24 Feb 2015 15:33:51 +1100
Message-ID: <20150224043351.4243.20278.stgit@notabene.brown>
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

The usb phy driver already determines when VBUS is available,
so repeating the test in the charger driver is pointless duplication.

On probe, process the last event from the phy, and from then on,
do whatever the phy tells us without double-checking.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 drivers/power/twl4030_charger.c |   33 ++++++---------------------------
 1 file changed, 6 insertions(+), 27 deletions(-)

diff --git a/drivers/power/twl4030_charger.c b/drivers/power/twl4030_charger.c
index 11f352a5ef55..db8931a17541 100644
--- a/drivers/power/twl4030_charger.c
+++ b/drivers/power/twl4030_charger.c
@@ -178,28 +178,6 @@ static int twl4030_is_battery_present(struct twl4030_bci *bci)
 }
 
 /*
- * Check if VBUS power is present
- */
-static int twl4030_bci_have_vbus(struct twl4030_bci *bci)
-{
-	int ret;
-	u8 hwsts;
-
-	ret = twl_i2c_read_u8(TWL_MODULE_PM_MASTER, &hwsts,
-			      TWL4030_PM_MASTER_STS_HW_CONDITIONS);
-	if (ret < 0)
-		return 0;
-
-	dev_dbg(bci->dev, "check_vbus: HW_CONDITIONS %02x\n", hwsts);
-
-	/* in case we also have STS_USB_ID, VBUS is driven by TWL itself */
-	if ((hwsts & TWL4030_STS_VBUS) && !(hwsts & TWL4030_STS_USB_ID))
-		return 1;
-
-	return 0;
-}
-
-/*
  * Enable/Disable USB Charge functionality.
  */
 static int twl4030_charger_enable_usb(struct twl4030_bci *bci, bool enable)
@@ -207,10 +185,6 @@ static int twl4030_charger_enable_usb(struct twl4030_bci *bci, bool enable)
 	int ret;
 
 	if (enable && !IS_ERR_OR_NULL(bci->transceiver)) {
-		/* Check for USB charger connected */
-		if (!twl4030_bci_have_vbus(bci))
-			return -ENODEV;
-
 		/*
 		 * Until we can find out what current the device can provide,
 		 * require a module param to enable USB charging.
@@ -649,7 +623,12 @@ static int __init twl4030_bci_probe(struct platform_device *pdev)
 		dev_warn(&pdev->dev, "failed to unmask interrupts: %d\n", ret);
 
 	twl4030_charger_enable_ac(true);
-	twl4030_charger_enable_usb(bci, true);
+	if (!IS_ERR_OR_NULL(bci->transceiver))
+		twl4030_bci_usb_ncb(&bci->usb_nb,
+				    bci->transceiver->last_event,
+				    NULL);
+	else
+		twl4030_charger_enable_usb(bci, false);
 	if (pdata)
 		twl4030_charger_enable_backup(pdata->bb_uvolt,
 					      pdata->bb_uamp);
