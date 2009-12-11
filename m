From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 09/14] omap3: rx51: Use wl1251 in SPI mode 3
Date: Fri, 11 Dec 2009 15:54:05 -0800
Message-ID: <20091211235405.3189.53868.stgit@localhost>
References: <20091211234919.3189.95607.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:60899 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934037AbZLKXx7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Dec 2009 18:53:59 -0500
In-Reply-To: <20091211234919.3189.95607.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Kalle Valo <kalle.valo@nokia.com>, linux-omap@vger.kernel.org

From: Kalle Valo <kalle.valo@nokia.com>

Otherwise Extreme Lower Power (ELP) wakeup doesn't work properly.

Signed-off-by: Kalle Valo <kalle.valo@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 8144420..bf26ad3 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -60,7 +60,7 @@ static struct spi_board_info rx51_peripherals_spi_board_info[] __initdata = {
 		.bus_num		= 4,
 		.chip_select		= 0,
 		.max_speed_hz   	= 48000000,
-		.mode                   = SPI_MODE_2,
+		.mode                   = SPI_MODE_3,
 		.controller_data	= &wl1251_mcspi_config,
 		.platform_data		= &wl1251_pdata,
 	},

