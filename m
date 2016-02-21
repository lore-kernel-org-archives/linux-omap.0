From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH 6/6] ARM: dts: n900: Rename isp1704 to isp1707 to match correct name
Date: Sun, 21 Feb 2016 12:28:23 +0100
Message-ID: <1456054103-19551-7-git-send-email-pali.rohar@gmail.com>
References: <1456054103-19551-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456054103-19551-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Pavel Machel <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Nishanth Menon <nm@ti.com>
Cc: linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: linux-omap@vger.kernel.org

This change does not break existing userspace or Maemo software because
isp1704_charger.c always export power supply device under isp1704 name.

Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
---
 arch/arm/boot/dts/omap3-n900.dts |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3=
-n900.dts
index 82df643..e0443cd 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -107,8 +107,8 @@
 		};
 	};
=20
-	isp1704: isp1704 {
-		compatible =3D "nxp,isp1704";
+	isp1707: isp1707 {
+		compatible =3D "nxp,isp1707";
 		nxp,enable-gpio =3D <&gpio3 3 GPIO_ACTIVE_HIGH>;
 		usb-phy =3D <&usb2_phy>;
 	};
@@ -735,7 +735,7 @@
 		ti,termination-current =3D <100>;
 		ti,resistor-sense =3D <68>;
=20
-		ti,usb-charger-detection =3D <&isp1704>;
+		ti,usb-charger-detection =3D <&isp1707>;
 	};
 };
=20
--=20
1.7.9.5
