From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 16/22] ARM: ux500: Remove '0x's from OMAP3430 SDP DTS file
Date: Fri, 19 Jul 2013 14:58:47 +0100
Message-ID: <1374242333-6852-16-git-send-email-lee.jones@linaro.org>
References: <1374242333-6852-1-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f54.google.com ([74.125.83.54]:34616 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760572Ab3GSN7e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Jul 2013 09:59:34 -0400
Received: by mail-ee0-f54.google.com with SMTP id t10so2402580eei.41
        for <linux-omap@vger.kernel.org>; Fri, 19 Jul 2013 06:59:32 -0700 (PDT)
In-Reply-To: <1374242333-6852-1-git-send-email-lee.jones@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, linus.walleij@stericsson.com, srinidhi.kasagar@stericsson.com, Lee Jones <lee.jones@linaro.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/omap3430-sdp.dts | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/omap3430-sdp.dts b/arch/arm/boot/dts/oma=
p3430-sdp.dts
index e2249bc..281914e 100644
--- a/arch/arm/boot/dts/omap3430-sdp.dts
+++ b/arch/arm/boot/dts/omap3430-sdp.dts
@@ -84,15 +84,15 @@
 			label =3D "bootloader-nor";
 			reg =3D <0 0x40000>;
 		};
-		partition@0x40000 {
+		partition@40000 {
 			label =3D "params-nor";
 			reg =3D <0x40000 0x40000>;
 		};
-		partition@0x80000 {
+		partition@80000 {
 			label =3D "kernel-nor";
 			reg =3D <0x80000 0x200000>;
 		};
-		partition@0x280000 {
+		partition@280000 {
 			label =3D "filesystem-nor";
 			reg =3D <0x240000 0x7d80000>;
 		};
@@ -125,19 +125,19 @@
 			label =3D "xloader-nand";
 			reg =3D <0 0x80000>;
 		};
-		partition@0x80000 {
+		partition@80000 {
 			label =3D "bootloader-nand";
 			reg =3D <0x80000 0x140000>;
 		};
-		partition@0x1c0000 {
+		partition@1c0000 {
 			label =3D "params-nand";
 			reg =3D <0x1c0000 0xc0000>;
 		};
-		partition@0x280000 {
+		partition@280000 {
 			label =3D "kernel-nand";
 			reg =3D <0x280000 0x500000>;
 		};
-		partition@0x780000 {
+		partition@780000 {
 			label =3D "filesystem-nand";
 			reg =3D <0x780000 0x7880000>;
 		};
@@ -170,19 +170,19 @@
 			label =3D "xloader-onenand";
 			reg =3D <0 0x80000>;
 		};
-		partition@0x80000 {
+		partition@80000 {
 			label =3D "bootloader-onenand";
 			reg =3D <0x80000 0x40000>;
 		};
-		partition@0xc0000 {
+		partition@c0000 {
 			label =3D "params-onenand";
 			reg =3D <0xc0000 0x20000>;
 		};
-		partition@0xe0000 {
+		partition@e0000 {
 			label =3D "kernel-onenand";
 			reg =3D <0xe0000 0x200000>;
 		};
-		partition@0x2e0000 {
+		partition@2e0000 {
 			label =3D "filesystem-onenand";
 			reg =3D <0x2e0000 0xfd20000>;
 		};
--=20
1.8.1.2

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
