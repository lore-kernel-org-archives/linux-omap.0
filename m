From: Dan Murphy <dmurphy@ti.com>
Subject: [v3 PATCH 2/6] dt: TI: Describe the ti reset DT entries
Date: Thu, 17 Jul 2014 11:45:27 -0500
Message-ID: <1405615531-15649-2-git-send-email-dmurphy@ti.com>
References: <1405615531-15649-1-git-send-email-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34423 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757478AbaGQQqB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Jul 2014 12:46:01 -0400
In-Reply-To: <1405615531-15649-1-git-send-email-dmurphy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc: tony@atomide.com, Dan Murphy <dmurphy@ti.com>

Describe the TI reset DT entries for TI SoC's.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---

v3 - Changed Headline no other changes

 .../devicetree/bindings/reset/ti,reset.txt         |  103 ++++++++++++++++++++
 1 file changed, 103 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/ti,reset.txt

diff --git a/Documentation/devicetree/bindings/reset/ti,reset.txt b/Documentation/devicetree/bindings/reset/ti,reset.txt
new file mode 100644
index 0000000..9d5c29c
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/ti,reset.txt
@@ -0,0 +1,103 @@
+Texas Instruments Reset Controller
+======================================
+Please also refer to reset.txt in this directory for common reset
+controller binding usage.
+
+Specifying the reset entries for the IP module
+==============================================
+Parent module:
+This is the module node that contains the reset registers and bits.
+
+example:
+			prcm_resets: resets {
+				compatible = "ti,dra7-resets";
+				#reset-cells = <1>;
+			};
+
+Required parent properties:
+- compatible : Should be one of,
+		"ti,omap4-prm" for OMAP4 PRM instances
+		"ti,omap5-prm" for OMAP5 PRM instances
+		"ti,dra7-prm" for DRA7xx PRM instances
+		"ti,am4-prcm" for AM43xx PRCM instances
+		"ti,am3-prcm" for AM33xx PRCM instances
+
+Required child reset property:
+- compatible : Should be
+		"resets" for All TI SoCs
+
+example:
+		prm: prm@4ae06000 {
+			compatible = "ti,omap5-prm";
+			reg = <0x4ae06000 0x3000>;
+
+			prm_resets: resets {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				#reset-cells = <1>;
+			};
+		};
+
+
+Reset node declaration
+==============================================
+The reset node is declared in a parent child relationship.  The main parent
+is the PRCM module which contains the base address.  The first child within
+the reset parent declares the target modules reset name.  This is followed by
+the control and status offsets.
+
+Within the first reset child node is a secondary child node which declares the
+reset signal of interest.  Under this node the control and status bits
+are declared.  These bits declare the bit mask for the target reset.
+
+
+Required properties:
+reg - This is the register offset from the PRCM parent.
+	This must be declared as:
+
+	reg = <control register offset>,
+		  <status register offset>;
+
+control-bit - This is the bit within the register which controls the reset
+	of the target module.  This is declared as a bit mask for the register.
+status-bit - This is the bit within the register which contains the status of
+	the reset of the target module.
+	This is declared as a bit mask for the register.
+
+example:
+&prm_resets {
+	dsp_rstctrl {
+		reg = <0x1c00>,
+			  <0x1c04>;
+
+		dsp_reset: dsp_reset {
+			control-bit = <0x01>;
+			status-bit = <0x01>;
+		};
+	};
+};
+
+
+
+Client Node Declaration
+==============================================
+This is the consumer of the parent node to declare what resets this
+particular module is interested in.
+
+example:
+	src: src@55082000 {
+		    resets = <&reset_src phandle>;
+			reset-names = "<reset_name>";
+	};
+
+Required Properties:
+reset_src - This is the parent DT entry for the reset controller
+phandle - This is the phandle of the specific reset to be used by the clien
+	driver.
+reset-names - This is the reset name of module that the device driver
+	needs to be able to reset.  This value must correspond to a value within
+	the reset controller array.
+
+example:
+resets = <&prm_resets &dsp_mmu_reset>;
+reset-names = "dsp_mmu_reset";
-- 
1.7.9.5

