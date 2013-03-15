From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 22/23] ARM: dts: OMAP3: Add HS USB Host IP nodes
Date: Fri, 15 Mar 2013 17:16:43 +0200
Message-ID: <1363360604-21368-23-git-send-email-rogerq@ti.com>
References: <1363360604-21368-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1363360604-21368-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Adds device nodes for HS USB Host module, TLL module,
OHCI and EHCI controllers.

CC: Beno=C3=AEt Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
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

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
