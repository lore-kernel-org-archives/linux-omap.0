From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 12/22] ARM: dts: Remove '0x's from OMAP2420 H4 DTS file
Date: Mon, 22 Jul 2013 11:52:31 +0100
Message-ID: <1374490361-25769-12-git-send-email-lee.jones@linaro.org>
References: <1374490361-25769-1-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f49.google.com ([74.125.83.49]:54591 "EHLO
	mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932107Ab3GVKxM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Jul 2013 06:53:12 -0400
Received: by mail-ee0-f49.google.com with SMTP id b57so3681161eek.36
        for <linux-omap@vger.kernel.org>; Mon, 22 Jul 2013 03:53:11 -0700 (PDT)
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
 arch/arm/boot/dts/omap2420-h4.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/omap2420-h4.dts b/arch/arm/boot/dts/omap=
2420-h4.dts
index 224c08f..34cdecb 100644
--- a/arch/arm/boot/dts/omap2420-h4.dts
+++ b/arch/arm/boot/dts/omap2420-h4.dts
@@ -50,15 +50,15 @@
 			label =3D "bootloader";
 			reg =3D <0 0x20000>;
 		};
-		partition@0x20000 {
+		partition@20000 {
 			label =3D "params";
 			reg =3D <0x20000 0x20000>;
 		};
-		partition@0x40000 {
+		partition@40000 {
 			label =3D "kernel";
 			reg =3D <0x40000 0x200000>;
 		};
-		partition@0x240000 {
+		partition@240000 {
 			label =3D "file-system";
 			reg =3D <0x240000 0x3dc0000>;
 		};
--=20
1.8.1.2

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
