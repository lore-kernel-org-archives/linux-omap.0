From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH] ARM: dts: omap3: Include missing bandgap data for ti-soc-thermal driver
Date: Sat, 26 Dec 2015 00:32:25 +0100
Message-ID: <1451086345-3340-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Pavel Machek <pavel@ucw.cz>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: linux-omap@vger.kernel.org

Driver for omap3 with documentation is there since v4.4-rc1.

Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
---
 arch/arm/boot/dts/omap34xx.dtsi |    5 +++++
 arch/arm/boot/dts/omap36xx.dtsi |    5 +++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/omap34xx.dtsi b/arch/arm/boot/dts/omap34=
xx.dtsi
index 4f6b2d5..c3f488f 100644
--- a/arch/arm/boot/dts/omap34xx.dtsi
+++ b/arch/arm/boot/dts/omap34xx.dtsi
@@ -54,6 +54,11 @@
 				#size-cells =3D <0>;
 			};
 		};
+
+		bandgap {
+			reg =3D <0x48002524 0x4>;
+			compatible =3D "ti,omap34xx-bandgap";
+		};
 	};
 };
=20
diff --git a/arch/arm/boot/dts/omap36xx.dtsi b/arch/arm/boot/dts/omap36=
xx.dtsi
index 86253de..00f98c1 100644
--- a/arch/arm/boot/dts/omap36xx.dtsi
+++ b/arch/arm/boot/dts/omap36xx.dtsi
@@ -86,6 +86,11 @@
 				#size-cells =3D <0>;
 			};
 		};
+
+		bandgap {
+			reg =3D <0x48002524 0x4>;
+			compatible =3D "ti,omap36xx-bandgap";
+		};
 	};
 };
=20
--=20
1.7.9.5
