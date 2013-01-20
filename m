From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH] RX-51: Register twl4030-madc device
Date: Sun, 20 Jan 2013 03:54:26 +0100
Message-ID: <1358650466-29917-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:44389 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752288Ab3ATC4U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 19 Jan 2013 21:56:20 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>

Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/ma=
ch-omap2/board-rx51-peripherals.c
index 9a0dbb7..286292e 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -1364,6 +1364,16 @@ static void __init rx51_init_lirc(void)
 }
 #endif
=20
+static struct platform_device madc_hwmon =3D {
+	.name	=3D "twl4030_madc_hwmon",
+	.id	=3D -1,
+};
+
+static void __init rx51_init_twl4030_hwmon(void)
+{
+	platform_device_register(&madc_hwmon);
+}
+
 void __init rx51_peripherals_init(void)
 {
 	rx51_i2c_init();
@@ -1386,5 +1396,6 @@ void __init rx51_peripherals_init(void)
 		omap_hsmmc_init(mmc);
=20
 	rx51_charger_init();
+	rx51_init_twl4030_hwmon();
 }
=20
--=20
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
