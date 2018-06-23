From: David Lechner <david@lechnology.com>
Subject: [PATCH 4/8] dt-bindings: add bindings for TI PRU as remoteproc
Date: Sat, 23 Jun 2018 16:08:06 -0500
Message-ID: <20180623210810.21232-5-david@lechnology.com>
References: <20180623210810.21232-1-david@lechnology.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180623210810.21232-1-david@lechnology.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: David Lechner <david@lechnology.com>, Ohad Ben-Cohen <ohad@wizery.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This adds a new binding for the TI Programmable Runtime Unit (PRU)
as a remoteproc device.

Signed-off-by: David Lechner <david@lechnology.com>
---
 .../bindings/remoteproc/ti_pru_rproc.txt      | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/ti_pru_rproc.txt

diff --git a/Documentation/devicetree/bindings/remoteproc/ti_pru_rproc.txt b/Documentation/devicetree/bindings/remoteproc/ti_pru_rproc.txt
new file mode 100644
index 000000000000..0e80a8db46d0
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/ti_pru_rproc.txt
@@ -0,0 +1,51 @@
+TI Programmable Realtime Unit (PRU)
+===================================
+
+Some TI Sitara SoCs contain a Programmable Realtime Unit subsystem with two
+processor cores that can be used for hard-realtime tasks.
+
+
+Required properties:
+--------------------
+The following are the mandatory properties:
+
+- compatible:		Should be one of the following,
+			    "ti,da850-pru-rproc" for AM18xx/OMAPL138 SoCs
+			    "ti,am3352-pru-rproc" for AM355x SoCs
+
+- reg:			Should contain the memory region for the PRUSS
+
+- interrupts: 		Should contain the interrupt number used to receive the
+			virtualqueue kick interrupts from the PRU (i.e.
+			PRU_EVTOUT0 and PRU_EVTOUT1)
+
+- interrupt-names	Should contain "pru0-vq", "pru1-vq"
+
+Optional properties:
+--------------------
+
+- power-domains:	A phandle to the power domain that powers the PRUSS
+
+- ti,hwmods:		Name of the hwmod associated to the PRUSS, which is
+			typically "pruss"
+
+Example:
+--------
+
+	// AM18xx
+	pru_rproc: cpu@30000 {
+		compatible = "ti,da850-pru-rproc";
+		reg = <0x30000 0x10000>;
+		interrupts = <3>, <4>;
+		interrupt-names = "pru0-vq", "pru1-vq";
+		power-domains = <&psc0 13>;
+	};
+
+	// AM335x
+	pru_rproc: cpu@4a300000 {
+		compatible = "ti,am3352-pru-rproc";
+		reg = <0x4a300000 0x80000>;
+		interrupts = <20>, <21>;
+		interrupt-names = "pru0-vq", "pru1-vq";
+		ti,hwmods = "pruss";
+	};
-- 
2.17.1
