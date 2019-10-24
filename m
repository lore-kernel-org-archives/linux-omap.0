From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH v5 net-next 10/12] ARM: dts: dra7: add dt nodes for new cpsw switch dev driver
Date: Thu, 24 Oct 2019 13:09:12 +0300
Message-ID: <20191024100914.16840-11-grygorii.strashko@ti.com>
References: <20191024100914.16840-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191024100914.16840-1-grygorii.strashko@ti.com>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Andrew Lunn <andrew@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Jiri Pirko <jiri@resnulli.us>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>, Ivan Vecera <ivecera@redhat.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

Add DT nodes for new cpsw switch dev driver.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 arch/arm/boot/dts/dra7-l4.dtsi | 52 ++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm/boot/dts/dra7-l4.dtsi b/arch/arm/boot/dts/dra7-l4.dtsi
index 5cac2dd58241..2f3a19edc7af 100644
--- a/arch/arm/boot/dts/dra7-l4.dtsi
+++ b/arch/arm/boot/dts/dra7-l4.dtsi
@@ -3079,6 +3079,58 @@
 					phys = <&phy_gmii_sel 2>;
 				};
 			};
+
+			mac_sw: switch@0 {
+				compatible = "ti,dra7-cpsw-switch","ti,cpsw-switch";
+				reg = <0x0 0x4000>;
+				ranges = <0 0 0x4000>;
+				clocks = <&gmac_main_clk>;
+				clock-names = "fck";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				syscon = <&scm_conf>;
+				status = "disabled";
+
+				interrupts = <GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "rx_thresh", "rx", "tx", "misc";
+
+				ethernet-ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					cpsw_port1: port@1 {
+						reg = <1>;
+						label = "port1";
+						mac-address = [ 00 00 00 00 00 00 ];
+						phys = <&phy_gmii_sel 1>;
+					};
+
+					cpsw_port2: port@2 {
+						reg = <2>;
+						label = "port2";
+						mac-address = [ 00 00 00 00 00 00 ];
+						phys = <&phy_gmii_sel 2>;
+					};
+				};
+
+				davinci_mdio_sw: mdio@1000 {
+					compatible = "ti,cpsw-mdio","ti,davinci_mdio";
+					clocks = <&gmac_clkctrl DRA7_GMAC_GMAC_CLKCTRL 0>;
+					clock-names = "fck";
+					#address-cells = <1>;
+					#size-cells = <0>;
+					bus_freq = <1000000>;
+					reg = <0x1000 0x100>;
+				};
+
+				cpts {
+					clocks = <&gmac_clkctrl DRA7_GMAC_GMAC_CLKCTRL 25>;
+					clock-names = "cpts";
+				};
+			};
 		};
 	};
 };
-- 
2.17.1
