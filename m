From: NeilBrown <neilb@suse.de>
Subject: [PATCH 10/15] twl4030_charger: only draw USB current as negotiated
 with host.
Date: Tue, 24 Feb 2015 15:33:52 +1100
Message-ID: <20150224043352.4243.84042.stgit@notabene.brown>
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

If the phy has been told what current it can draw, it tells us
and now we use that number.

Note that 'vbus_draw' is in mA, while usb_cur is in uA.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 drivers/power/twl4030_charger.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/power/twl4030_charger.c b/drivers/power/twl4030_charger.c
index b0242786d047..01090a440583 100644
--- a/drivers/power/twl4030_charger.c
+++ b/drivers/power/twl4030_charger.c
@@ -597,6 +597,7 @@ static void twl4030_bci_usb_work(struct work_struct *data)
 	switch (bci->event) {
 	case USB_EVENT_VBUS:
 	case USB_EVENT_CHARGER:
+	case USB_EVENT_ENUMERATED:
 		twl4030_charger_enable_usb(bci, true);
 		break;
 	case USB_EVENT_NONE:
@@ -609,6 +610,7 @@ static int twl4030_bci_usb_ncb(struct notifier_block *nb, unsigned long val,
 			       void *priv)
 {
 	struct twl4030_bci *bci = container_of(nb, struct twl4030_bci, usb_nb);
+	unsigned *vbus_draw = priv;
 
 	dev_dbg(bci->dev, "OTG notify %lu\n", val);
 
@@ -619,6 +621,9 @@ static int twl4030_bci_usb_ncb(struct notifier_block *nb, unsigned long val,
 		bci->usb_cur = 100000;
 
 	bci->event = val;
+	if (val == USB_EVENT_ENUMERATED && vbus_draw &&
+	    *vbus_draw * 1000 > bci->usb_cur)
+		bci->usb_cur = *vbus_draw * 1000;
 	schedule_work(&bci->work);
 
 	return NOTIFY_OK;
