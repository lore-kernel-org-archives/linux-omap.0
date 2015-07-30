From: NeilBrown <neil@brown.name>
Subject: [PATCH 13/13] twl4030_charger: assume a 'charger' can supply
 maximum current.
Date: Thu, 30 Jul 2015 10:11:25 +1000
Message-ID: <20150730001124.4012.1604.stgit@noble>
References: <20150730001113.4012.18086.stgit@noble>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20150730001113.4012.18086.stgit@noble>
Sender: linux-pm-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org, real GTA04 owners <gta04-owner@goldelico.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: linux-omap@vger.kernel.org

If it cannot, we will stop pulling more current when voltage drops.

Signed-off-by: NeilBrown <neil@brown.name>
---
 drivers/power/twl4030_charger.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/power/twl4030_charger.c b/drivers/power/twl4030_charger.c
index 2c537ee11bbe..c7432f532a83 100644
--- a/drivers/power/twl4030_charger.c
+++ b/drivers/power/twl4030_charger.c
@@ -697,8 +697,10 @@ static void twl4030_bci_usb_work(struct work_struct *data)
 	struct twl4030_bci *bci = container_of(data, struct twl4030_bci, work);
 
 	switch (bci->event) {
-	case USB_EVENT_VBUS:
 	case USB_EVENT_CHARGER:
+		bci->usb_cur = USB_MAX_CURRENT;
+		/* FALL THROUGH */
+	case USB_EVENT_VBUS:
 		twl4030_charger_enable_usb(bci, true);
 		break;
 	case USB_EVENT_NONE:


