From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH v5 3/6] bus: ti-sysc: Add support for using ti-sysc for MCAN on dra76x
Date: Mon, 9 Jul 2018 22:18:38 +0530
Message-ID: <20180709164841.14182-4-faiz_abbas@ti.com>
References: <20180709164841.14182-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180709164841.14182-1-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Cc: robh+dt@kernel.org, bcousson@baylibre.com, tony@atomide.com, paul@pwsan.com, t-kristo@ti.com, mark.rutland@arm.com, faiz_abbas@ti.com, sboyd@kernel.org
List-Id: linux-omap@vger.kernel.org

The dra76x MCAN generic interconnect module has a its own
format for the bits in the control registers.

Therefore add a new module type, new regbits and new capabilities
specific to the MCAN module.

Acked-by: Rob Herring <robh@kernel.org>
CC: Tony Lindgren <tony@atomide.com>
Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 .../devicetree/bindings/bus/ti-sysc.txt        |  1 +
 drivers/bus/ti-sysc.c                          | 18 ++++++++++++++++++
 include/dt-bindings/bus/ti-sysc.h              |  2 ++
 include/linux/platform_data/ti-sysc.h          |  1 +
 4 files changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/bus/ti-sysc.txt b/Documentation/devicetree/bindings/bus/ti-sysc.txt
index d8ed5b780ed9..91dc2333af01 100644
--- a/Documentation/devicetree/bindings/bus/ti-sysc.txt
+++ b/Documentation/devicetree/bindings/bus/ti-sysc.txt
@@ -36,6 +36,7 @@ Required standard properties:
 		"ti,sysc-omap-aes"
 		"ti,sysc-mcasp"
 		"ti,sysc-usb-host-fs"
+		"ti,sysc-dra7-mcan"
 
 - reg		shall have register areas implemented for the interconnect
 		target module in question such as revision, sysc and syss
diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index 1cc29629d238..ad1cd6888757 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -1552,6 +1552,23 @@ static const struct sysc_capabilities sysc_omap4_usb_host_fs = {
 	.regbits = &sysc_regbits_omap4_usb_host_fs,
 };
 
+static const struct sysc_regbits sysc_regbits_dra7_mcan = {
+	.dmadisable_shift = -ENODEV,
+	.midle_shift = -ENODEV,
+	.sidle_shift = -ENODEV,
+	.clkact_shift = -ENODEV,
+	.enwkup_shift = 4,
+	.srst_shift = 0,
+	.emufree_shift = -ENODEV,
+	.autoidle_shift = -ENODEV,
+};
+
+static const struct sysc_capabilities sysc_dra7_mcan = {
+	.type = TI_SYSC_DRA7_MCAN,
+	.sysc_mask = SYSC_DRA7_MCAN_ENAWAKEUP | SYSC_OMAP4_SOFTRESET,
+	.regbits = &sysc_regbits_dra7_mcan,
+};
+
 static int sysc_init_pdata(struct sysc *ddata)
 {
 	struct ti_sysc_platform_data *pdata = dev_get_platdata(ddata->dev);
@@ -1743,6 +1760,7 @@ static const struct of_device_id sysc_match[] = {
 	{ .compatible = "ti,sysc-mcasp", .data = &sysc_omap4_mcasp, },
 	{ .compatible = "ti,sysc-usb-host-fs",
 	  .data = &sysc_omap4_usb_host_fs, },
+	{ .compatible = "ti,sysc-dra7-mcan", .data = &sysc_dra7_mcan, },
 	{  },
 };
 MODULE_DEVICE_TABLE(of, sysc_match);
diff --git a/include/dt-bindings/bus/ti-sysc.h b/include/dt-bindings/bus/ti-sysc.h
index 2c005376ac0e..7138384e2ef9 100644
--- a/include/dt-bindings/bus/ti-sysc.h
+++ b/include/dt-bindings/bus/ti-sysc.h
@@ -15,6 +15,8 @@
 /* SmartReflex sysc found on 36xx and later */
 #define SYSC_OMAP3_SR_ENAWAKEUP		(1 << 26)
 
+#define SYSC_DRA7_MCAN_ENAWAKEUP	(1 << 4)
+
 /* SYSCONFIG STANDBYMODE/MIDLEMODE/SIDLEMODE supported by hardware */
 #define SYSC_IDLE_FORCE			0
 #define SYSC_IDLE_NO			1
diff --git a/include/linux/platform_data/ti-sysc.h b/include/linux/platform_data/ti-sysc.h
index 990aad477458..2efa3470a451 100644
--- a/include/linux/platform_data/ti-sysc.h
+++ b/include/linux/platform_data/ti-sysc.h
@@ -14,6 +14,7 @@ enum ti_sysc_module_type {
 	TI_SYSC_OMAP4_SR,
 	TI_SYSC_OMAP4_MCASP,
 	TI_SYSC_OMAP4_USB_HOST_FS,
+	TI_SYSC_DRA7_MCAN,
 };
 
 struct ti_sysc_cookie {
-- 
2.17.0
