From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH] ARM: dts: OMAP3-N900: Fix offset for smc91x ethernet
Date: Thu, 19 Feb 2015 17:49:50 +0100
Message-ID: <1424364590-14603-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:62864 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbbBSQuH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Feb 2015 11:50:07 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>

Offset for smc91x must be zero otherwise smc91x linux kernel driver doe=
s not
detect smc91x ethernet hardware in qemu N900 machine.

Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
---
 arch/arm/boot/dts/omap3-n900.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3=
-n900.dts
index ff36fbe..b9c1c62 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -770,7 +770,7 @@
 		compatible =3D "smsc,lan91c94";
 		interrupt-parent =3D <&gpio2>;
 		interrupts =3D <22 IRQ_TYPE_LEVEL_HIGH>;	/* gpio54 */
-		reg =3D <1 0x300 0xf>;		/* 16 byte IO range at offset 0x300 */
+		reg =3D <1 0x0 0xf>;		/* 16 byte IO range */
 		bank-width =3D <2>;
 		pinctrl-names =3D "default";
 		pinctrl-0 =3D <&ethernet_pins>;
--=20
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
