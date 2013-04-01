From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 01/14] staging: ti-soc-thermal: return error in case power switch is not supported
Date: Mon, 1 Apr 2013 12:04:33 -0400
Message-ID: <1364832286-17304-2-git-send-email-eduardo.valentin@ti.com>
References: <1364832286-17304-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1364832286-17304-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devel@driverdev.osuosl.org, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-omap@vger.kernel.org

Improve ti_bandgap_power by returning an error code in case
the device does not support controlling its power state.

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/staging/ti-soc-thermal/ti-bandgap.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/ti-soc-thermal/ti-bandgap.c b/drivers/staging/ti-soc-thermal/ti-bandgap.c
index d479e50..a6aa75f 100644
--- a/drivers/staging/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/staging/ti-soc-thermal/ti-bandgap.c
@@ -100,17 +100,19 @@ do {								\
  */
 static int ti_bandgap_power(struct ti_bandgap *bgp, bool on)
 {
-	int i;
+	int i, ret = 0;
 
-	if (!TI_BANDGAP_HAS(bgp, POWER_SWITCH))
+	if (!TI_BANDGAP_HAS(bgp, POWER_SWITCH)) {
+		ret = -ENOTSUPP;
 		goto exit;
+	}
 
 	for (i = 0; i < bgp->conf->sensor_count; i++)
 		/* active on 0 */
 		RMW_BITS(bgp, i, temp_sensor_ctrl, bgap_tempsoff_mask, !on);
 
 exit:
-	return 0;
+	return ret;
 }
 
 /**
-- 
1.7.7.1.488.ge8e1c

