From: =?UTF-8?q?Guido=20Mart=C3=ADnez?= <guido@vanguardiasur.com.ar>
Subject: [PATCH v2 1/4] ARM: dts: am335x-bone-common: use phandles for USB and DMA refs
Date: Mon, 28 Apr 2014 17:54:32 -0300
Message-ID: <1398718475-1883-1-git-send-email-guido@vanguardiasur.com.ar>
References: <1398693512-5355-1-git-send-email-guido@vanguardiasur.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yk0-f171.google.com ([209.85.160.171]:56535 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752338AbaD1U4g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Apr 2014 16:56:36 -0400
Received: by mail-yk0-f171.google.com with SMTP id 10so1054076ykt.30
        for <linux-omap@vger.kernel.org>; Mon, 28 Apr 2014 13:56:35 -0700 (PDT)
In-Reply-To: <1398693512-5355-1-git-send-email-guido@vanguardiasur.com.ar>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: bcousson@baylibre.com
Cc: tony@atomide.com, linux-omap@vger.kernel.org, george.cherian@ti.com, =?UTF-8?q?Ezequiel=20Garc=C3=ADa?= <ezequiel@vanguardiasur.com.ar>, =?UTF-8?q?Guido=20Mart=C3=ADnez?= <guido@vanguardiasur.com.ar>

Use phandles instead of unit adresses to reference usb and dma nodes.
This makes the DT more robust and readable.

Signed-off-by: Guido Mart=C3=ADnez <guido@vanguardiasur.com.ar>
---
 arch/arm/boot/dts/am335x-bone-common.dtsi | 38 +++++++++++++++--------=
--------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/=
dts/am335x-bone-common.dtsi
index 2e7d932..ded1283 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
@@ -182,31 +182,31 @@
=20
 &usb {
 	status =3D "okay";
+};
=20
-	control@44e10620 {
-		status =3D "okay";
-	};
+&usb_ctrl_mod {
+	status =3D "okay";
+};
=20
-	usb-phy@47401300 {
-		status =3D "okay";
-	};
+&usb0_phy {
+	status =3D "okay";
+};
=20
-	usb-phy@47401b00 {
-		status =3D "okay";
-	};
+&usb1_phy {
+	status =3D "okay";
+};
=20
-	usb@47401000 {
-		status =3D "okay";
-	};
+&usb0 {
+	status =3D "okay";
+};
=20
-	usb@47401800 {
-		status =3D "okay";
-		dr_mode =3D "host";
-	};
+&usb1 {
+	status =3D "okay";
+	dr_mode =3D "host";
+};
=20
-	dma-controller@47402000  {
-		status =3D "okay";
-	};
+&cppi41dma  {
+	status =3D "okay";
 };
=20
 &i2c0 {
--=20
1.9.2

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
