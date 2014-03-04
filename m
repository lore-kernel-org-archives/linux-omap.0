From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 09/14] ARM: OMAP2: PRM: add support for OMAP2 specific clock providers
Date: Tue, 4 Mar 2014 11:18:15 +0200
Message-ID: <1393924700-6510-10-git-send-email-t-kristo@ti.com>
References: <1393924700-6510-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57519 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756658AbaCDJTo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 Mar 2014 04:19:44 -0500
In-Reply-To: <1393924700-6510-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, nm@ti.com, mturquette@linaro.org, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

This patch adds support for initializing also omap2-prcm and omap2-scrm
through DT.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 .../devicetree/bindings/arm/omap/prcm.txt          |   65 ++++++++++++++++++++
 arch/arm/mach-omap2/prm_common.c                   |    2 +
 2 files changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/omap/prcm.txt

diff --git a/Documentation/devicetree/bindings/arm/omap/prcm.txt b/Documentation/devicetree/bindings/arm/omap/prcm.txt
new file mode 100644
index 0000000..79074da
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/omap/prcm.txt
@@ -0,0 +1,65 @@
+OMAP PRCM bindings
+
+Power Reset and Clock Manager lists the device clocks and clockdomains under
+a DT hierarchy. Each TI SoC can have multiple PRCM entities listed for it,
+each describing one module and the clock hierarchy under it. see [1] for
+documentation about the individual clock/clockdomain nodes.
+
+[1] Documentation/devicetree/bindings/clock/ti/*
+
+Required properties:
+- compatible:	Must be one of:
+		"ti,am3-prcm"
+		"ti,am3-scrm"
+		"ti,am4-prcm"
+		"ti,am4-scrm"
+		"ti,omap2-prcm"
+		"ti,omap2-scrm"
+		"ti,omap3-prm"
+		"ti,omap3-cm"
+		"ti,omap3-scrm"
+		"ti,omap4-cm1"
+		"ti,omap4-prm"
+		"ti,omap4-cm2"
+		"ti,omap4-scrm"
+		"ti,omap5-prm"
+		"ti,omap5-cm-core-aon"
+		"ti,omap5-scrm"
+		"ti,omap5-cm-core"
+		"ti,dra7-prm"
+		"ti,dra7-cm-core-aon"
+		"ti,dra7-cm-core"
+- reg:		Contains PRCM module register address range
+		(base address and length)
+- clocks:	clocks for this module
+- clockdomains:	clockdomains for this module
+
+Example:
+
+cm: cm@48004000 {
+	compatible = "ti,omap3-cm";
+	reg = <0x48004000 0x4000>;
+
+	cm_clocks: clocks {
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	cm_clockdomains: clockdomains {
+	};
+}
+
+&cm_clocks {
+	omap2_32k_fck: omap_32k_fck {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <32768>;
+	};
+};
+
+&cm_clockdomains {
+	core_l3_clkdm: core_l3_clkdm {
+		compatible = "ti,clockdomain";
+		clocks = <&sdrc_ick>;
+	};
+};
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index b4c4ab9..878ae9f 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -475,6 +475,8 @@ static struct of_device_id omap_prcm_dt_match_table[] = {
 	{ .compatible = "ti,am3-scrm" },
 	{ .compatible = "ti,am4-prcm" },
 	{ .compatible = "ti,am4-scrm" },
+	{ .compatible = "ti,omap2-prcm" },
+	{ .compatible = "ti,omap2-scrm" },
 	{ .compatible = "ti,omap3-prm" },
 	{ .compatible = "ti,omap3-cm" },
 	{ .compatible = "ti,omap3-scrm" },
-- 
1.7.9.5

