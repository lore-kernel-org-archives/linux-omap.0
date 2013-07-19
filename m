From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 12/22] ARM: ux500: Remove '0x's from OMAP2420 H4 DTS file
Date: Fri, 19 Jul 2013 14:58:43 +0100
Message-ID: <1374242333-6852-12-git-send-email-lee.jones@linaro.org>
References: <1374242333-6852-1-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f175.google.com ([209.85.215.175]:40272 "EHLO
	mail-ea0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760630Ab3GSN70 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Jul 2013 09:59:26 -0400
Received: by mail-ea0-f175.google.com with SMTP id z7so2379675eaf.20
        for <linux-omap@vger.kernel.org>; Fri, 19 Jul 2013 06:59:25 -0700 (PDT)
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
