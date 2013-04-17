From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 3/3] arm: add bandgap entry for OMAP4460 devices
Date: Wed, 17 Apr 2013 16:29:34 -0400
Message-ID: <1366230574-31547-4-git-send-email-eduardo.valentin@ti.com>
References: <1366230574-31547-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1366230574-31547-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: b-cousson@ti.com
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Include bandgap devices for OMAP4460 devices.

Cc: "Beno=C3=AEt Cousson" <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 arch/arm/boot/dts/omap4460.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/omap4460.dtsi b/arch/arm/boot/dts/omap44=
60.dtsi
index 7c2c23c..3808b5c 100644
--- a/arch/arm/boot/dts/omap4460.dtsi
+++ b/arch/arm/boot/dts/omap4460.dtsi
@@ -29,4 +29,13 @@
 			     <0 55 0x4>;
 		ti,hwmods =3D "debugss";
 	};
+
+	bandgap {
+		reg =3D <0x4a002260 0x4
+			0x4a00232C 0x4
+			0x4a002378 0x18>;
+		compatible =3D "ti,omap4460-bandgap";
+		interrupts =3D <0 126 4>; /* talert */
+		ti,tshut-gpio =3D <86>;
+	};
 };
--=20
1.8.2.1.342.gfa7285d
