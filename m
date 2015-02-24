From: NeilBrown <neilb@suse.de>
Subject: [PATCH 15/15] twl4030_charger: assume a 'charger' can supply
 maximum current.
Date: Tue, 24 Feb 2015 15:33:53 +1100
Message-ID: <20150224043353.4243.7374.stgit@notabene.brown>
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

If it cannot, we will stop pulling more current when voltage drops.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 drivers/power/twl4030_charger.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/power/twl4030_charger.c b/drivers/power/twl4030_charger.c
index 7ad6b4b531d7..89e2c121dd22 100644
--- a/drivers/power/twl4030_charger.c
+++ b/drivers/power/twl4030_charger.c
@@ -691,8 +691,10 @@ static void twl4030_bci_usb_work(struct work_struct *data)
 	struct twl4030_bci *bci = container_of(data, struct twl4030_bci, work);
 
 	switch (bci->event) {
-	case USB_EVENT_VBUS:
 	case USB_EVENT_CHARGER:
+		bci->usb_cur = USB_MAX_CURRENT;
+		/* FALL THROUGH */
+	case USB_EVENT_VBUS:
 	case USB_EVENT_ENUMERATED:
 		twl4030_charger_enable_usb(bci, true);
 		break;
