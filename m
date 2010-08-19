From: "Krogerus Heikki (EXT-Teleca/Helsinki)"
	<ext-heikki.krogerus@nokia.com>
Subject: [PATCHv2 2/2] omap: rx51: add support for USB chargers
Date: Thu, 19 Aug 2010 15:09:37 +0300
Message-ID: <1282219777-17657-3-git-send-email-ext-heikki.krogerus@nokia.com>
References: <1282219777-17657-1-git-send-email-ext-heikki.krogerus@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mgw-sa02.nokia.com ([147.243.1.48]:62511 "EHLO
	mgw-sa02.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753052Ab0HSMKL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Aug 2010 08:10:11 -0400
In-Reply-To: <1282219777-17657-1-git-send-email-ext-heikki.krogerus@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, dwmw2@infradead.org, cbou@mail.ru, felipe.balbi@nokia.com, ameya.palande@nokia.com, markus.lehtonen@nokia.com, roger.quadros@nokia.com

From: Heikki Krogerus <ext-heikki.krogerus@nokia.com>

This enables isp1704 power supply driver on RX51, allowing
USB charger detection with N900.

Signed-off-by: Heikki Krogerus <ext-heikki.krogerus@nokia.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 9a5eb87..a4b1f8b 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -104,6 +104,10 @@ static struct spi_board_info rx51_peripherals_spi_board_info[] __initdata = {
 	},
 };
 
+static struct platform_device rx51_charger_device = {
+	.name = "isp1704_charger",
+};
+
 #if defined(CONFIG_KEYBOARD_GPIO) || defined(CONFIG_KEYBOARD_GPIO_MODULE)
 
 #define RX51_GPIO_CAMERA_LENS_COVER	110
@@ -909,5 +913,6 @@ void __init rx51_peripherals_init(void)
 	spi_register_board_info(rx51_peripherals_spi_board_info,
 				ARRAY_SIZE(rx51_peripherals_spi_board_info));
 	omap2_hsmmc_init(mmc);
+	platform_device_register(&rx51_charger_device);
 }
 
-- 
1.7.0.4

