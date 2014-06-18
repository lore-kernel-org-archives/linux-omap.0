From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH] omap3-n900.dts: Rename model name to "Nokia RX-51 board"
Date: Wed, 18 Jun 2014 18:57:15 +0200
Message-ID: <1403110635-29696-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Russell King <linux@arm.linux.org.uk>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@debian.org>, Pavel Machek <pavel@ucw.cz>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: linux-omap@vger.kernel.org

Use same name as in legacy board code. There are lot of userspace appli=
cations
which using machine/model name for determinating device type. And chang=
ing this
name will break all of them. Due to small features support in DT code o=
nly non
DT kernel was used for Nokia N900 until now.

Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
---
 arch/arm/boot/dts/omap3-n900.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3=
-n900.dts
index 6c6551a..e23ee96 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -13,7 +13,7 @@
 #include <dt-bindings/input/input.h>
=20
 / {
-	model =3D "Nokia N900";
+	model =3D "Nokia RX-51 board";
 	compatible =3D "nokia,omap3-n900", "ti,omap3430", "ti,omap3";
=20
 	aliases {
--=20
1.7.9.5
