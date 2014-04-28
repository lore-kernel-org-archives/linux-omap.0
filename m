From: =?UTF-8?q?Guido=20Mart=C3=ADnez?= <guido@vanguardiasur.com.ar>
Subject: [PATCH 1/4] ARM: dts: am335x-bone-common: use phandles for USB and DMA refs
Date: Mon, 28 Apr 2014 10:58:29 -0300
Message-ID: <1398693512-5355-1-git-send-email-guido@vanguardiasur.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yk0-f177.google.com ([209.85.160.177]:55215 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016AbaD1OAX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Apr 2014 10:00:23 -0400
Received: by mail-yk0-f177.google.com with SMTP id 9so1731571ykp.36
        for <linux-omap@vger.kernel.org>; Mon, 28 Apr 2014 07:00:23 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, bcousson@baylibre.com, tony@atomide.com
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, =?UTF-8?q?Ezequiel=20Garc=C3=ADa?= <ezequiel@vanguardiasur.com.ar>, =?UTF-8?q?Guido=20Mart=C3=ADnez?= <guido@vanguardiasur.com.ar>

Use phandles instead of unit adresses to reference usb and dma nodes.
This makes the DT more robust and readable.

Signed-off-by: Guido Mart=C3=ADnez <guido@vanguardiasur.com.ar>
---
 arch/arm/boot/dts/am335x-bone-common.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/=
dts/am335x-bone-common.dtsi
index 2e7d932..b95bc9a 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
@@ -183,28 +183,28 @@
 &usb {
 	status =3D "okay";
=20
-	control@44e10620 {
+	&usb_ctrl_mod {
 		status =3D "okay";
 	};
=20
-	usb-phy@47401300 {
+	&usb0_phy {
 		status =3D "okay";
 	};
=20
-	usb-phy@47401b00 {
+	&usb1_phy {
 		status =3D "okay";
 	};
=20
-	usb@47401000 {
+	&usb0 {
 		status =3D "okay";
 	};
=20
-	usb@47401800 {
+	&usb1 {
 		status =3D "okay";
 		dr_mode =3D "host";
 	};
=20
-	dma-controller@47402000  {
+	&cppi41dma  {
 		status =3D "okay";
 	};
 };
--=20
1.9.2

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
