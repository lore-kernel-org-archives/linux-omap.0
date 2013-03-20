From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v4 20/21] ARM: dts: OMAP3: Add HS USB Host IP nodes
Date: Wed, 20 Mar 2013 17:44:59 +0200
Message-ID: <1363794300-31526-21-git-send-email-rogerq@ti.com>
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
 arch/arm/boot/dts/omap3.dtsi |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dts=
i
index 1acc261..a14f74b 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -397,5 +397,36 @@
 			ti,timer-alwon;
 			ti,timer-secure;
 		};
+
+		usbhstll: usbhstll@48062000 {
+			compatible =3D "ti,usbhs-tll";
+			reg =3D <0x48062000 0x1000>;
+			interrupts =3D <78>;
+			ti,hwmods =3D "usb_tll_hs";
+		};
+
+		usbhshost: usbhshost@48064000 {
+			compatible =3D "ti,usbhs-host";
+			reg =3D <0x48064000 0x400>;
+			ti,hwmods =3D "usb_host_hs";
+			#address-cells =3D <1>;
+			#size-cells =3D <1>;
+			ranges;
+
+			usbhsohci: ohci@48064400 {
+				compatible =3D "ti,ohci-omap3", "usb-ohci";
+				reg =3D <0x48064400 0x400>;
+				interrupt-parent =3D <&intc>;
+				interrupts =3D <76>;
+			};
+
+			usbhsehci: ehci@48064800 {
+				compatible =3D "ti,ehci-omap", "usb-ehci";
+				reg =3D <0x48064800 0x400>;
+				interrupt-parent =3D <&intc>;
+				interrupts =3D <77>;
+			};
+		};
+
 	};
 };
--=20
1.7.4.1
