From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv8 1/9] dt-bindings: omap: add new binding for PRM instances
Date: Tue, 8 Oct 2019 15:55:36 +0300
Message-ID: <20191008125544.20679-2-t-kristo@ti.com>
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

Add new binding for OMAP PRM (Power and Reset Manager) instances. Each
of these will act as a power domain controller and potentially as a reset
provider.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Tony Lindgren <tony@atomide.com>
---
v7:
  - dropped clocks property from example

 .../devicetree/bindings/arm/omap/prm-inst.txt | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/omap/prm-inst.txt

diff --git a/Documentation/devicetree/bindings/arm/omap/prm-inst.txt b/Documentation/devicetree/bindings/arm/omap/prm-inst.txt
new file mode 100644
index 000000000000..dfe7c7789ca7
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/omap/prm-inst.txt
@@ -0,0 +1,29 @@
+OMAP PRM instance bindings
+
+Power and Reset Manager is an IP block on OMAP family of devices which
+handle the power domains and their current state, and provide reset
+handling for the domains and/or separate IP blocks under the power domain
+hierarchy.
+
+Required properties:
+- compatible:	Must contain one of the following:
+		"ti,am3-prm-inst"
+		"ti,am4-prm-inst"
+		"ti,omap4-prm-inst"
+		"ti,omap5-prm-inst"
+		"ti,dra7-prm-inst"
+		and additionally must contain:
+		"ti,omap-prm-inst"
+- reg:		Contains PRM instance register address range
+		(base address and length)
+
+Optional properties:
+- #reset-cells:	Should be 1 if the PRM instance in question supports resets.
+
+Example:
+
+prm_dsp2: prm@1b00 {
+	compatible = "ti,omap-prm-inst", "ti,dra7-prm-inst";
+	reg = <0x1b00 0x40>;
+	#reset-cells = <1>;
+};
-- 
2.17.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
