From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] ARM: OMAP1: devices: configure omap1_spi100k only on OMAP7xx
Date: Mon, 19 Nov 2018 21:49:43 +0200
Message-ID: <20181119194943.351-1-aaro.koskinen@iki.fi>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: linux-omap@vger.kernel.org

Configure omap1_spi100k only on OMAP7xx. This allows running multiboard
kernels on non-OMAP7xx HW with CONFIG_SPI_OMAP_100K enabled.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/arm/mach-omap1/devices.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index baaf902b7016..e1243b5d554f 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -244,6 +244,9 @@ struct platform_device omap_spi2 = {
 
 static void omap_init_spi100k(void)
 {
+	if (!cpu_is_omap7xx())
+		return;
+
 	omap_spi1.dev.platform_data = ioremap(OMAP7XX_SPI1_BASE, 0x7ff);
 	if (omap_spi1.dev.platform_data)
 		platform_device_register(&omap_spi1);
-- 
2.17.0
