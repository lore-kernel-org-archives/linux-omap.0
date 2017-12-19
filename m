From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/7] ARM: dts: dra7: Add properties to enable PCIe x2 lane mode
Date: Tue, 19 Dec 2017 15:01:27 +0530
Message-ID: <20171219093133.16565-2-kishon@ti.com>
References: <20171219093133.16565-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171219093133.16565-1-kishon-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

ti,syscon-lane-sel and ti,syscon-lane-conf properties specific to enable
PCIe x2 lane mode are added here.

Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/dra7.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index ac9216293b7c..9966d82dbd7c 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -309,6 +309,8 @@
 				ti,hwmods = "pcie1";
 				phys = <&pcie1_phy>;
 				phy-names = "pcie-phy0";
+				ti,syscon-lane-conf = <&scm_conf 0x558>;
+				ti,syscon-lane-sel = <&scm_conf_pcie 0x18>;
 				interrupt-map-mask = <0 0 0 7>;
 				interrupt-map = <0 0 0 1 &pcie1_intc 1>,
 						<0 0 0 2 &pcie1_intc 2>,
@@ -334,6 +336,8 @@
 				phys = <&pcie1_phy>;
 				phy-names = "pcie-phy0";
 				ti,syscon-unaligned-access = <&scm_conf1 0x14 2>;
+				ti,syscon-lane-conf = <&scm_conf 0x558>;
+				ti,syscon-lane-sel = <&scm_conf_pcie 0x18>;
 				status = "disabled";
 			};
 		};
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
