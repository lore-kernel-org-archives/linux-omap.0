From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv8 9/9] soc: ti: omap-prm: add omap5 PRM data
Date: Tue, 8 Oct 2019 15:55:44 +0300
Message-ID: <20191008125544.20679-10-t-kristo@ti.com>
References: <20191008125544.20679-1-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191008125544.20679-1-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, ssantosh@kernel.org
Cc: tony@atomide.com, devicetree@vger.kernel.org, p.zabel@pengutronix.de, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Add PRM instance data for omap5 family of SoCs. Initially this is just
used to provide reset support.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/soc/ti/omap_prm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/soc/ti/omap_prm.c b/drivers/soc/ti/omap_prm.c
index 73ea64896770..38e8704c51ad 100644
--- a/drivers/soc/ti/omap_prm.c
+++ b/drivers/soc/ti/omap_prm.c
@@ -84,6 +84,14 @@ static const struct omap_prm_data omap4_prm_data[] = {
 	{ },
 };
 
+static const struct omap_prm_data omap5_prm_data[] = {
+	{ .name = "dsp", .base = 0x4ae06400, .rstctrl = 0x10, .rstst = 0x14, .rstmap = rst_map_01 },
+	{ .name = "core", .base = 0x4ae06700, .rstctrl = 0x210, .rstst = 0x214, .clkdm_name = "ipu", .rstmap = rst_map_012 },
+	{ .name = "iva", .base = 0x4ae07200, .rstctrl = 0x10, .rstst = 0x14, .rstmap = rst_map_012 },
+	{ .name = "device", .base = 0x4ae07c00, .rstctrl = 0x0, .rstst = 0x4, .rstmap = rst_map_01, .flags = OMAP_PRM_HAS_RSTCTRL | OMAP_PRM_HAS_NO_CLKDM },
+	{ },
+};
+
 static const struct omap_prm_data dra7_prm_data[] = {
 	{ .name = "dsp1", .base = 0x4ae06400, .rstctrl = 0x10, .rstst = 0x14, .rstmap = rst_map_01 },
 	{ .name = "ipu", .base = 0x4ae06500, .rstctrl = 0x10, .rstst = 0x14, .clkdm_name = "ipu1", .rstmap = rst_map_012 },
@@ -136,6 +144,7 @@ static const struct omap_prm_data am4_prm_data[] = {
 
 static const struct of_device_id omap_prm_id_table[] = {
 	{ .compatible = "ti,omap4-prm-inst", .data = omap4_prm_data },
+	{ .compatible = "ti,omap5-prm-inst", .data = omap5_prm_data },
 	{ .compatible = "ti,dra7-prm-inst", .data = dra7_prm_data },
 	{ .compatible = "ti,am3-prm-inst", .data = am3_prm_data },
 	{ .compatible = "ti,am4-prm-inst", .data = am4_prm_data },
-- 
2.17.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
