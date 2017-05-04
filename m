From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/4] power: supply: cpcap-charger: Fix charge voltage configuration
Date: Wed,  3 May 2017 17:15:30 -0700
Message-ID: <20170504001532.10585-3-tony@atomide.com>
References: <20170504001532.10585-1-tony@atomide.com>
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20170504001532.10585-1-tony@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>
List-Id: linux-omap@vger.kernel.org

We have the charge voltage wrong, it should be 4.35V instead of 4.2V.
This will cause the battery to never get fully charged.

I noticed this when looking at the Andoid kernel battery and charger
status for a fully charged battery:

# grep VOLTAGE_NOW /sys/class/power_supply/battery/uevent
POWER_SUPPLY_VOLTAGE_NOW=4351000

Also the battery on droid 4 says "4.35, 1735/1785mAh (min/typ),
6.6/6.8 Wh (min/typ)". Presumably the 4.35 on the battery is the
charge voltage.

And finally, on Android the CPCAP CRM register is set to 0x03b5 where
the b is the charge voltage.

Let's fix the charge voltage define and update the charge configuration
to use the 4.35V setting.

Fixes: 0c9888e3c192 ("power: supply: cpcap-charger: Add minimal
CPCAP PMIC battery charger")
Cc: Marcel Partap <mpartap@gmx.net>
Cc: Michael Scott <michael.scott@linaro.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/power/supply/cpcap-charger.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/cpcap-charger.c
--- a/drivers/power/supply/cpcap-charger.c
+++ b/drivers/power/supply/cpcap-charger.c
@@ -76,7 +76,7 @@
 #define CPCAP_REG_CRM_VCHRG_4V30	CPCAP_REG_CRM_VCHRG(0x8)
 #define CPCAP_REG_CRM_VCHRG_4V32	CPCAP_REG_CRM_VCHRG(0x9)
 #define CPCAP_REG_CRM_VCHRG_4V34	CPCAP_REG_CRM_VCHRG(0xa)
-#define CPCAP_REG_CRM_VCHRG_4V36	CPCAP_REG_CRM_VCHRG(0xb)
+#define CPCAP_REG_CRM_VCHRG_4V35	CPCAP_REG_CRM_VCHRG(0xb)
 #define CPCAP_REG_CRM_VCHRG_4V38	CPCAP_REG_CRM_VCHRG(0xc)
 #define CPCAP_REG_CRM_VCHRG_4V40	CPCAP_REG_CRM_VCHRG(0xd)
 #define CPCAP_REG_CRM_VCHRG_4V42	CPCAP_REG_CRM_VCHRG(0xe)
@@ -469,7 +469,7 @@ static void cpcap_usb_detect(struct work_struct *work)
 			max_current = CPCAP_REG_CRM_ICHRG_0A528;
 
 		error = cpcap_charger_set_state(ddata,
-						CPCAP_REG_CRM_VCHRG_4V20,
+						CPCAP_REG_CRM_VCHRG_4V35,
 						max_current,
 						CPCAP_REG_CRM_TR_0A72);
 		if (error)
-- 
2.12.2
