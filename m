From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 06/14] staging: ti-soc-thermal: Add counter_delay_mask field to temp_sensor_registers struct
Date: Mon, 1 Apr 2013 12:04:38 -0400
Message-ID: <1364832286-17304-7-git-send-email-eduardo.valentin@ti.com>
References: <1364832286-17304-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46070 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758686Ab3DAQH3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Apr 2013 12:07:29 -0400
In-Reply-To: <1364832286-17304-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devel@driverdev.osuosl.org, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, J Keerthy <j-keerthy@ti.com>, Eduardo Valentin <eduardo.valentin@ti.com>

From: J Keerthy <j-keerthy@ti.com>

Add counter_delay_mask field to temp_sensor_registers structure.

Signed-off-by: J Keerthy <j-keerthy@ti.com>
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/staging/ti-soc-thermal/ti-bandgap.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/ti-soc-thermal/ti-bandgap.h b/drivers/staging/ti-soc-thermal/ti-bandgap.h
index 04c6ec2..8f9bdb9 100644
--- a/drivers/staging/ti-soc-thermal/ti-bandgap.h
+++ b/drivers/staging/ti-soc-thermal/ti-bandgap.h
@@ -79,6 +79,7 @@
  * @mask_hot_mask: mask to bandgap_mask_ctrl.mask_hot
  * @mask_cold_mask: mask to bandgap_mask_ctrl.mask_cold
  * @mask_sidlemode_mask: mask to bandgap_mask_ctrl.mask_sidlemode
+ * @mask_counter_delay_mask: mask to bandgap_mask_ctrl.mask_counter_delay
  * @mask_freeze_mask: mask to bandgap_mask_ctrl.mask_free
  * @mask_clear_mask: mask to bandgap_mask_ctrl.mask_clear
  * @mask_clear_accum_mask: mask to bandgap_mask_ctrl.mask_clear_accum
@@ -127,6 +128,7 @@ struct temp_sensor_registers {
 	u32	mask_hot_mask;
 	u32	mask_cold_mask;
 	u32	mask_sidlemode_mask; /* not used: but may be needed for pm */
+	u32	mask_counter_delay_mask;
 	u32	mask_freeze_mask;
 	u32	mask_clear_mask; /* not used: but needed for trending */
 	u32	mask_clear_accum_mask; /* not used: but needed for trending */
-- 
1.7.7.1.488.ge8e1c

