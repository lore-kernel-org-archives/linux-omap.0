From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 5/8] staging: ti-soc-thermal: make unexported functions local
Date: Mon, 18 Mar 2013 10:59:13 -0400
Message-ID: <1363618756-15851-6-git-send-email-eduardo.valentin@ti.com>
References: <1363618756-15851-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1363618756-15851-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-omap@vger.kernel.org

Move _ti_bandgap_write_threshold and _ti_bandgap_read_threshold to static
area, as they are local functions.

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>

diff --git a/drivers/staging/ti-soc-thermal/ti-bandgap.c b/drivers/staging/ti-soc-thermal/ti-bandgap.c
index 6a0b1ac..c850e13 100644
--- a/drivers/staging/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/staging/ti-soc-thermal/ti-bandgap.c
@@ -477,8 +477,8 @@ exit:
  * Validates the mCelsius range and update the requested threshold.
  * Call this function only if bandgap features HAS(TALERT).
  */
-int _ti_bandgap_write_threshold(struct ti_bandgap *bgp, int id, int val,
-				bool hot)
+static int _ti_bandgap_write_threshold(struct ti_bandgap *bgp, int id, int val,
+				       bool hot)
 {
 	struct temp_sensor_data *ts_data;
 	struct temp_sensor_registers *tsr;
@@ -531,8 +531,8 @@ exit:
  * This function can be used to read t_hot or t_cold, depending on @hot value.
  * Call this function only if bandgap features HAS(TALERT).
  */
-int _ti_bandgap_read_threshold(struct ti_bandgap *bgp, int id, int *val,
-			       bool hot)
+static int _ti_bandgap_read_threshold(struct ti_bandgap *bgp, int id, int *val,
+				      bool hot)
 {
 	struct temp_sensor_registers *tsr;
 	u32 temp, mask;
-- 
1.7.7.1.488.ge8e1c
