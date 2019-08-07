From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 5/8] soc: ti: omap-prm: add omap4 PRM data
Date: Wed, 7 Aug 2019 10:48:56 +0300
Message-ID: <1565164139-21886-6-git-send-email-t-kristo@ti.com>
References: <1565164139-21886-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1565164139-21886-1-git-send-email-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: ssantosh@kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, robh+dt@kernel.org
Cc: tony@atomide.com, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Add PRM data for omap4 family of SoCs.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/soc/ti/omap_prm.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/soc/ti/omap_prm.c b/drivers/soc/ti/omap_prm.c
index 870515e3..9b8d5945 100644
--- a/drivers/soc/ti/omap_prm.c
+++ b/drivers/soc/ti/omap_prm.c
@@ -54,7 +54,27 @@ struct omap_reset_data {
 
 #define OMAP_PRM_NO_RSTST	BIT(0)
 
+struct omap_prm_data omap4_prm_data[] = {
+	{ .name = "mpu", .base = 0x4a306300, .pwstst = 0x4 },
+	{ .name = "tesla", .base = 0x4a306400, .pwstst = 0x4, .rstctl = 0x10, .rstst = 0x14 },
+	{ .name = "abe", .base = 0x4a306500, .pwstst = 0x4 },
+	{ .name = "always_on_core", .base = 0x4a306600, .pwstst = 0x4 },
+	{ .name = "core", .base = 0x4a306700, .pwstst = 0x4, .rstctl = 0x210, .rstst = 0x214 },
+	{ .name = "ivahd", .base = 0x4a306f00, .pwstst = 0x4, .rstctl = 0x10, .rstst = 0x14 },
+	{ .name = "cam", .base = 0x4a307000, .pwstst = 0x4 },
+	{ .name = "dss", .base = 0x4a307100, .pwstst = 0x4 },
+	{ .name = "gfx", .base = 0x4a307200, .pwstst = 0x4 },
+	{ .name = "l3init", .base = 0x4a307300, .pwstst = 0x4 },
+	{ .name = "l4per", .base = 0x4a307400, .pwstst = 0x4 },
+	{ .name = "cefuse", .base = 0x4a307600, .pwstst = 0x4 },
+	{ .name = "wkup", .base = 0x4a307700, .pwstst = 0x4 },
+	{ .name = "emu", .base = 0x4a307900, .pwstst = 0x4 },
+	{ .name = "device", .base = 0x4a307b00, .rstctl = 0x0, .rstst = 0x4 },
+	{ },
+};
+
 static const struct of_device_id omap_prm_id_table[] = {
+	{ .compatible = "ti,omap4-prm-inst", .data = omap4_prm_data },
 	{ },
 };
 
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
