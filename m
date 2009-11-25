From: Kalle Valo <kalle.valo@iki.fi>
Subject: [PATCH] omap3: rx51: Use wl1251 in SPI mode 3
Date: Wed, 25 Nov 2009 23:31:33 +0200
Message-ID: <20091125213133.28326.91119.stgit@tikku>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from emh05.mail.saunalahti.fi ([62.142.5.111]:44995 "EHLO
	emh05.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759187AbZKYViX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Nov 2009 16:38:23 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh05-2.mail.saunalahti.fi (Postfix) with SMTP id 3C3378BEF0
	for <linux-omap@vger.kernel.org>; Wed, 25 Nov 2009 23:31:35 +0200 (EET)
Received: from [127.0.1.1] (a91-155-131-184.elisa-laajakaista.fi [91.155.131.184])
	by emh06.mail.saunalahti.fi (Postfix) with ESMTP id 26227E51A2
	for <linux-omap@vger.kernel.org>; Wed, 25 Nov 2009 23:31:34 +0200 (EET)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Kalle Valo <kalle.valo@nokia.com>

Otherwise Extreme Lower Power (ELP) wakeup doesn't work properly.

Signed-off-by: Kalle Valo <kalle.valo@nokia.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 4f347f8..e66d728 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -59,7 +59,7 @@ static struct spi_board_info rx51_peripherals_spi_board_info[] __initdata = {
 		.bus_num		= 4,
 		.chip_select		= 0,
 		.max_speed_hz   	= 48000000,
-		.mode                   = SPI_MODE_2,
+		.mode                   = SPI_MODE_3,
 		.controller_data	= &wl1251_mcspi_config,
 		.platform_data		= &wl1251_pdata,
 	},

