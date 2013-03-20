From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v4 19/21] ARM: dts: OMAP4: Add HS USB Host IP nodes
Date: Wed, 20 Mar 2013 17:44:58 +0200
Message-ID: <1363794300-31526-20-git-send-email-rogerq@ti.com>
References: <1363794300-31526-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1363794300-31526-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: balbi@ti.com, rogerq@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>
List-Id: linux-omap@vger.kernel.org

Adds device nodes for HS USB Host module, TLL module,
OHCI and EHCI controllers.

CC: Beno=C3=AEt Cousson <b-cousson@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dts=
i
index 739bb79..b7db1a2 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -529,5 +529,35 @@
 			ti,hwmods =3D "timer11";
 			ti,timer-pwm;
 		};
+
+		usbhstll: usbhstll@4a062000 {
+			compatible =3D "ti,usbhs-tll";
+			reg =3D <0x4a062000 0x1000>;
+			interrupts =3D <0 78 0x4>;
+			ti,hwmods =3D "usb_tll_hs";
+		};
+
+		usbhshost: usbhshost@4a064000 {
+			compatible =3D "ti,usbhs-host";
+			reg =3D <0x4a064000 0x800>;
+			ti,hwmods =3D "usb_host_hs";
+			#address-cells =3D <1>;
+			#size-cells =3D <1>;
+			ranges;
+
+			usbhsohci: ohci@4a064800 {
+				compatible =3D "ti,ohci-omap3", "usb-ohci";
+				reg =3D <0x4a064800 0x400>;
+				interrupt-parent =3D <&gic>;
+				interrupts =3D <0 76 0x4>;
+			};
+
+			usbhsehci: ehci@4a064c00 {
+				compatible =3D "ti,ehci-omap", "usb-ehci";
+				reg =3D <0x4a064c00 0x400>;
+				interrupt-parent =3D <&gic>;
+				interrupts =3D <0 77 0x4>;
+			};
+		};
 	};
 };
--=20
1.7.4.1
