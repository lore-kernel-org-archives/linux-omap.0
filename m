From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] ARM: OMAP: RX-51: change probe order of touchscreen and panel SPI devices
Date: Wed,  1 May 2013 19:59:57 +0300
Message-ID: <1367427597-30060-1-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:52250 "EHLO
	filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752649Ab3EARAv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 May 2013 13:00:51 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Joni Lapilainen <joni.lapilainen@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Felipe Balbi <balbi@ti.com>, stable@vger.kernel.org

Commit 9fdca9df (spi: omap2-mcspi: convert to module_platform_driver)
broke the SPI display/panel driver probe on RX-51/N900. The exact cause=
 is
not fully understood, but it seems to be related to the probe order. SP=
I
communication to the panel driver (spi1.2) fails unless the touchscreen
(spi1.0) has been probed/initialized before. When the omap2-mcspi drive=
r
was converted to a platform driver, it resulted in that the devices are
probed immediately after the board registers them in the order they are
listed in the board file.

=46ix the issue by moving the touchscreen before the panel in the SPI
device list.

The patch fixes the following failure:

[    1.260955] acx565akm spi1.2: invalid display ID
[    1.265899] panel-acx565akm display0: acx_panel_probe panel detect e=
rror
[    1.273071] omapdss CORE error: driver probe failed: -19

Tested-by: Sebastian Reichel <sre@debian.org>
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Pali Roh=C3=A1r <pali.rohar@gmail.com>
Cc: Joni Lapilainen <joni.lapilainen@gmail.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: stable@vger.kernel.org
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/ma=
ch-omap2/board-rx51-peripherals.c
index 1a88467..18ca61e 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -73,11 +73,11 @@
 #define LIS302_IRQ1_GPIO 181
 #define LIS302_IRQ2_GPIO 180  /* Not yet in use */
=20
-/* list all spi devices here */
+/* List all SPI devices here. Note that the list/probe order seems to =
matter! */
 enum {
 	RX51_SPI_WL1251,
-	RX51_SPI_MIPID,		/* LCD panel */
 	RX51_SPI_TSC2005,	/* Touch Controller */
+	RX51_SPI_MIPID,		/* LCD panel */
 };
=20
 static struct wl12xx_platform_data wl1251_pdata;
--=20
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
