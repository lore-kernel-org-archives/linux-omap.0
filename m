From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/4] power: supply: cpcap-charger: Keep trickle charger bits disabled
Date: Wed,  3 May 2017 17:15:32 -0700
Message-ID: <20170504001532.10585-5-tony@atomide.com>
References: <20170504001532.10585-1-tony@atomide.com>
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20170504001532.10585-1-tony@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>
List-Id: linux-omap@vger.kernel.org

Android does not seem to set the trickle charger bits, and these
seem to be only used by the bootloader when bringing up a
completely discharged battery. So let's keep the trickle charging
bits disabled and avoid misconfiguring the hardware.

Fixes: 0c9888e3c192 ("power: supply: cpcap-charger: Add minimal
CPCAP PMIC battery charger")
Cc: Marcel Partap <mpartap@gmx.net>
Cc: Michael Scott <michael.scott@linaro.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/power/supply/cpcap-charger.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/cpcap-charger.c
--- a/drivers/power/supply/cpcap-charger.c
+++ b/drivers/power/supply/cpcap-charger.c
@@ -470,8 +470,7 @@ static void cpcap_usb_detect(struct work_struct *work)
 
 		error = cpcap_charger_set_state(ddata,
 						CPCAP_REG_CRM_VCHRG_4V35,
-						max_current,
-						CPCAP_REG_CRM_TR_0A72);
+						max_current, 0);
 		if (error)
 			goto out_err;
 	} else {
-- 
2.12.2
