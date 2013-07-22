From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 14/22] ARM: dts: Remove '0x's from OMAP3 IGEP0030 DTS file
Date: Mon, 22 Jul 2013 11:52:33 +0100
Message-ID: <1374490361-25769-14-git-send-email-lee.jones@linaro.org>
References: <1374490361-25769-1-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f181.google.com ([209.85.215.181]:37480 "EHLO
	mail-ea0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932107Ab3GVKxP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Jul 2013 06:53:15 -0400
Received: by mail-ea0-f181.google.com with SMTP id a15so3780893eae.40
        for <linux-omap@vger.kernel.org>; Mon, 22 Jul 2013 03:53:14 -0700 (PDT)
In-Reply-To: <1374490361-25769-1-git-send-email-lee.jones@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, linus.walleij@stericsson.com, Lee Jones <lee.jones@linaro.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/omap3-igep0030.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-igep0030.dts b/arch/arm/boot/dts/o=
map3-igep0030.dts
index 644d0538..f628200 100644
--- a/arch/arm/boot/dts/omap3-igep0030.dts
+++ b/arch/arm/boot/dts/omap3-igep0030.dts
@@ -74,19 +74,19 @@
 			label =3D "SPL";
 			reg =3D <0 0x100000>;
 		};
-		partition@0x80000 {
+		partition@80000 {
 			label =3D "U-Boot";
 			reg =3D <0x100000 0x180000>;
 		};
-		partition@0x1c0000 {
+		partition@1c0000 {
 			label =3D "Environment";
 			reg =3D <0x280000 0x100000>;
 		};
-		partition@0x280000 {
+		partition@280000 {
 			label =3D "Kernel";
 			reg =3D <0x380000 0x300000>;
 		};
-		partition@0x780000 {
+		partition@780000 {
 			label =3D "Filesystem";
 			reg =3D <0x680000 0x1f980000>;
 		};
--=20
1.8.1.2

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
