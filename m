From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 04/23] OMAPDSS: DSI: set regulator voltage to 1.8V
Date: Thu, 24 Apr 2014 13:17:00 +0300
Message-ID: <1398334639-14172-5-git-send-email-tomi.valkeinen@ti.com>
References: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Archit Taneja <archit@ti.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
List-Id: linux-omap@vger.kernel.org

Set the DSI vdd regulator voltage to the required 1.8V.

This is required for the case when the regulator in the DT data defines
a range of allowed voltages. In this case it's required to set the
voltage, as otherwise enabling the voltage fails.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dsi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/dsi.c b/drivers/video/fbdev/omap2/dss/dsi.c
index 8be9b04d8849..57f120896b43 100644
--- a/drivers/video/fbdev/omap2/dss/dsi.c
+++ b/drivers/video/fbdev/omap2/dss/dsi.c
@@ -1161,6 +1161,7 @@ static int dsi_regulator_init(struct platform_device *dsidev)
 {
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	struct regulator *vdds_dsi;
+	int r;
 
 	if (dsi->vdds_dsi_reg != NULL)
 		return 0;
@@ -1173,6 +1174,15 @@ static int dsi_regulator_init(struct platform_device *dsidev)
 		return PTR_ERR(vdds_dsi);
 	}
 
+	if (regulator_can_change_voltage(vdds_dsi)) {
+		r = regulator_set_voltage(vdds_dsi, 1800000, 1800000);
+		if (r) {
+			devm_regulator_put(vdds_dsi);
+			DSSERR("can't set the DSI regulator voltage\n");
+			return r;
+		}
+	}
+
 	dsi->vdds_dsi_reg = vdds_dsi;
 
 	return 0;
-- 
1.9.1
