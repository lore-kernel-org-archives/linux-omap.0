From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/4] power: supply: cpcap-charger: Fix charger name
Date: Wed,  3 May 2017 17:15:29 -0700
Message-ID: <20170504001532.10585-2-tony@atomide.com>
References: <20170504001532.10585-1-tony@atomide.com>
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20170504001532.10585-1-tony@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>
List-Id: linux-omap@vger.kernel.org

I noticed we have a different name from what Android is using.
Let's not break the /sys/class/power user space interface here
and use the same naming as Android has.

On Android we have the following for droid 4:

$ ls /sys/class/power_supply/
ac battery usb

So let's use the usb naming here for charger too.

Fixes: 0c9888e3c192 ("power: supply: cpcap-charger: Add minimal
CPCAP PMIC battery charger")
Cc: Marcel Partap <mpartap@gmx.net>
Cc: Michael Scott <michael.scott@linaro.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/power/supply/cpcap-charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/cpcap-charger.c
--- a/drivers/power/supply/cpcap-charger.c
+++ b/drivers/power/supply/cpcap-charger.c
@@ -602,7 +602,7 @@ static int cpcap_charger_init_iio(struct cpcap_charger_ddata *ddata)
 }
 
 static const struct power_supply_desc cpcap_charger_usb_desc = {
-	.name		= "cpcap_usb",
+	.name		= "usb",
 	.type		= POWER_SUPPLY_TYPE_USB,
 	.properties	= cpcap_charger_props,
 	.num_properties	= ARRAY_SIZE(cpcap_charger_props),
-- 
2.12.2
