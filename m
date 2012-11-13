From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 5/5] staging: omap-thermal: fix context restore function
Date: Tue, 13 Nov 2012 11:43:22 -0400
Message-ID: <1352821402-13458-6-git-send-email-eduardo.valentin@ti.com>
References: <1352821402-13458-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1352821402-13458-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: b-cousson@ti.com, devel@driverdev.osuosl.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Radhesh Fadnis <radhesh.fadnis@ti.com>, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Radhesh Fadnis <radhesh.fadnis@ti.com>

In the context restore function, if the context is lost or
not is being checked by the contents of the counter register.
But this is logic hold good as long as counter reset value is
zero, if the reset value is non-zero then above logic doesn't
hold good. Hence removed checking of the register value and
restoring the context.

Signed-off-by: Radhesh Fadnis <radhesh.fadnis@ti.com>
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/staging/omap-thermal/omap-bandgap.c |   56 ++++++++++-----------------
 1 files changed, 21 insertions(+), 35 deletions(-)

diff --git a/drivers/staging/omap-thermal/omap-bandgap.c b/drivers/staging/omap-thermal/omap-bandgap.c
index c5f39ec..d6be31d 100644
--- a/drivers/staging/omap-thermal/omap-bandgap.c
+++ b/drivers/staging/omap-thermal/omap-bandgap.c
@@ -1078,41 +1078,27 @@ static int omap_bandgap_restore_ctxt(struct omap_bandgap *bg_ptr)
 		if (OMAP_BANDGAP_HAS(bg_ptr, COUNTER))
 			val = omap_bandgap_readl(bg_ptr, tsr->bgap_counter);
 
-		if (val == 0) {
-			if (OMAP_BANDGAP_HAS(bg_ptr, TSHUT_CONFIG))
-				omap_bandgap_writel(bg_ptr,
-					rval->tshut_threshold,
-						   tsr->tshut_threshold);
-			/* Force immediate temperature measurement and update
-			 * of the DTEMP field
-			 */
-			omap_bandgap_force_single_read(bg_ptr, i);
-
-			if (OMAP_BANDGAP_HAS(bg_ptr, COUNTER))
-				omap_bandgap_writel(bg_ptr, rval->bg_counter,
-							   tsr->bgap_counter);
-			if (OMAP_BANDGAP_HAS(bg_ptr, MODE_CONFIG))
-				omap_bandgap_writel(bg_ptr, rval->bg_mode_ctrl,
-							   tsr->bgap_mode_ctrl);
-			if (OMAP_BANDGAP_HAS(bg_ptr, TALERT)) {
-				omap_bandgap_writel(bg_ptr,
-							   rval->bg_threshold,
-							   tsr->bgap_threshold);
-				omap_bandgap_writel(bg_ptr, rval->bg_ctrl,
-							   tsr->bgap_mask_ctrl);
-			}
-		} else {
-			temp = omap_bandgap_readl(bg_ptr,
-						  tsr->temp_sensor_ctrl);
-			temp &= (tsr->bgap_dtemp_mask);
-			omap_bandgap_force_single_read(bg_ptr, i);
-			if (temp == 0 && OMAP_BANDGAP_HAS(bg_ptr, TALERT)) {
-				temp = omap_bandgap_readl(bg_ptr,
-							  tsr->bgap_mask_ctrl);
-				temp |= 1 << __ffs(tsr->mode_ctrl_mask);
-				omap_bandgap_writel(bg_ptr, temp,
-							   tsr->bgap_mask_ctrl);
-			}
+		if (OMAP_BANDGAP_HAS(bg_ptr, TSHUT_CONFIG))
+			omap_bandgap_writel(bg_ptr,
+				rval->tshut_threshold,
+					   tsr->tshut_threshold);
+		/* Force immediate temperature measurement and update
+		 * of the DTEMP field
+		 */
+		omap_bandgap_force_single_read(bg_ptr, i);
+
+		if (OMAP_BANDGAP_HAS(bg_ptr, COUNTER))
+			omap_bandgap_writel(bg_ptr, rval->bg_counter,
+						   tsr->bgap_counter);
+		if (OMAP_BANDGAP_HAS(bg_ptr, MODE_CONFIG))
+			omap_bandgap_writel(bg_ptr, rval->bg_mode_ctrl,
+						   tsr->bgap_mode_ctrl);
+		if (OMAP_BANDGAP_HAS(bg_ptr, TALERT)) {
+			omap_bandgap_writel(bg_ptr,
+						   rval->bg_threshold,
+						   tsr->bgap_threshold);
+			omap_bandgap_writel(bg_ptr, rval->bg_ctrl,
+						   tsr->bgap_mask_ctrl);
 		}
 	}
 
-- 
1.7.7.1.488.ge8e1c
