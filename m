From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 2/7] ARM: dts: DRA74x: Use PCIe compatible specific to dra74
Date: Tue, 19 Dec 2017 15:01:28 +0530
Message-ID: <20171219093133.16565-3-kishon@ti.com>
References: <20171219093133.16565-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171219093133.16565-1-kishon-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Use dra74 specific compatible string for PCIe while preserving
the older compatible. While at that add a new label for the
2nd instance of pcie.

Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/dra7.dtsi   |  2 +-
 arch/arm/boot/dts/dra74x.dtsi | 12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 9966d82dbd7c..333f6a634ff9 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -349,7 +349,7 @@
 			ranges = <0x51800000 0x51800000 0x3000
 				  0x0	     0x30000000 0x10000000>;
 			status = "disabled";
-			pcie@51800000 {
+			pcie2_rc: pcie@51800000 {
 				compatible = "ti,dra7-pcie";
 				reg = <0x51800000 0x2000>, <0x51802000 0x14c>, <0x1000 0x2000>;
 				reg-names = "rc_dbics", "ti_conf", "config";
diff --git a/arch/arm/boot/dts/dra74x.dtsi b/arch/arm/boot/dts/dra74x.dtsi
index 24e6746c5b26..a001eecf3b14 100644
--- a/arch/arm/boot/dts/dra74x.dtsi
+++ b/arch/arm/boot/dts/dra74x.dtsi
@@ -124,3 +124,15 @@
 		status = "disabled";
 	};
 };
+
+&pcie1_rc {
+	compatible = "ti,dra746-pcie-rc", "ti,dra7-pcie";
+};
+
+&pcie1_ep {
+	compatible = "ti,dra746-pcie-ep", "ti,dra7-pcie-ep";
+};
+
+&pcie2_rc {
+	compatible = "ti,dra746-pcie-rc", "ti,dra7-pcie";
+};
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
