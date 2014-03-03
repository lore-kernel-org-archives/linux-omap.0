From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 04/12] ARM: dts: omap5: Add clocks to usb3_phy node
Date: Mon, 3 Mar 2014 17:07:26 +0200
Message-ID: <1393859254-10937-5-git-send-email-rogerq@ti.com>
References: <1393859254-10937-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1393859254-10937-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kishon@ti.com, balbi@ti.com, tony@atomide.com
Cc: george.cherian@ti.com, balajitk@ti.com, hdegoede@redhat.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, rogerq@ti.com, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>
List-Id: linux-omap@vger.kernel.org

The pipe3-phy driver expects certain named clocks.
Provide the necessary clocks.

CC: Beno=C3=AEt Cousson <bcousson@baylibre.com>
CC: Tony Lindgren <tony@atomide.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dts=
i
index 1c68558..a7f5930 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -760,6 +760,8 @@
 				      <0x4a084c00 0x40>;
 				reg-names =3D "phy_rx", "phy_tx", "pll_ctrl";
 				ctrl-module =3D <&omap_control_usb3phy>;
+				clocks =3D <&usb_phy_cm_clk32k>, <&sys_clkin>;
+				clock-names =3D "wkupclk", "sysclk";
 				#phy-cells =3D <0>;
 			};
 		};
--=20
1.8.3.2
