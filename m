From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] ARM: dts: omap3-beagle: fix the USB phy node
Date: Mon, 17 Jun 2013 15:27:17 +0200
Message-ID: <1371475637-16951-1-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:36801 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756074Ab3FQN1e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jun 2013 09:27:34 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>

I haven't tested this but it should not work the way it is now. The
format for of_parse_phandle() is usuall "phandle index" not the other
way around.

Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
Cc: Roger Quadros <rogerq@ti.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/boot/dts/omap3-beagle.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/oma=
p3-beagle.dts
index 6eec699..a12e9b0 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -128,7 +128,7 @@
 };
=20
 &usbhsehci {
-	phys =3D <0 &hsusb2_phy>;
+	phys =3D <&hsusb2_phy 0>;
 };
=20
 &twl_gpio {
--=20
1.8.3.1

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
