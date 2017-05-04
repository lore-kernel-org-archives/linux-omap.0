From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/4] power: supply: cpcap-charger: Fix enable for 3.8V charge setting
Date: Wed,  3 May 2017 17:15:31 -0700
Message-ID: <20170504001532.10585-4-tony@atomide.com>
References: <20170504001532.10585-1-tony@atomide.com>
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20170504001532.10585-1-tony@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>
List-Id: linux-omap@vger.kernel.org

Zero is a valid register value for for 3.8V charging.

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
@@ -262,7 +262,7 @@ static int cpcap_charger_set_state(struct cpcap_charger_ddata *ddata,
 	bool enable;
 	int error;
 
-	enable = max_voltage && (charge_current || trickle_current);
+	enable = (charge_current || trickle_current);
 	dev_dbg(ddata->dev, "%s enable: %i\n", __func__, enable);
 
 	if (!enable) {
-- 
2.12.2
