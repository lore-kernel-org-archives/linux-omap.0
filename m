From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH] ARM: dts: omap3-igep: Add fixed always-on regulators to common dtsi file
Date: Sat, 29 Dec 2012 18:04:44 -0300
Message-ID: <1356815084-6943-1-git-send-email-ezequiel.garcia@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.32.191]:54243 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753149Ab2L2VFA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 29 Dec 2012 16:05:00 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Cc: Ezequiel Garcia <elezegarcia@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, Javier Martinez Canillas <javier@dowhile0.org>

These regulators are common to igep0020 and igep0030 boards
and are needed by smsc911x controller.

Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Enric Balletbo i Serra <eballetbo@gmail.com>
Cc: Javier Martinez Canillas <javier@dowhile0.org>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/omap3-igep.dtsi |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-igep.dtsi b/arch/arm/boot/dts/omap=
3-igep.dtsi
index dd01c46..91a42ce 100644
--- a/arch/arm/boot/dts/omap3-igep.dtsi
+++ b/arch/arm/boot/dts/omap3-igep.dtsi
@@ -24,6 +24,18 @@
 		ti,mcbsp =3D <&mcbsp2>;
 		ti,codec =3D <&twl_audio>;
 	};
+
+        vddvario: regulator-vddvario {
+                compatible =3D "regulator-fixed";
+                regulator-name =3D "vddvario";
+                regulator-always-on;
+        };
+
+        vdd33a: regulator-vdd33a {
+                compatible =3D "regulator-fixed";
+                regulator-name =3D "vdd33a";
+                regulator-always-on;
+        };
 };
=20
 &omap3_pmx_core {
--=20
1.7.8.6

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
