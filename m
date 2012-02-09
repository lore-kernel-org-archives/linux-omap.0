From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] RM: OMAP4: board-4430sdp: don't initialize value that is never used
Date: Thu,  9 Feb 2012 22:30:34 +0100
Message-ID: <1328823034-9668-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50763 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758244Ab2BIVak (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Feb 2012 16:30:40 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: kernel@pengutronix.de, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

sdp4430_spi_board_info.irq was initialized to ETH_KS8851_IRQ and in
omap_4430sdp_init() overwritten with gpio_to_irq(ETH_KS8851_IRQ) before
sdp4430_spi_board_info was registered. This is a bit confusing, so
better don't initialize .irq and document that it is set later.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-omap2/board-4430sdp.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/=
board-4430sdp.c
index 39fba9d..991a289 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -321,7 +321,10 @@ static struct spi_board_info sdp4430_spi_board_inf=
o[] __initdata =3D {
 		.bus_num                =3D 1,
 		.chip_select            =3D 0,
 		.max_speed_hz           =3D 24000000,
-		.irq                    =3D ETH_KS8851_IRQ,
+		/*
+		 * .irq is set to gpio_to_irq(ETH_KS8851_IRQ)
+		 * in omap_4430sdp_init
+		 */
 	},
 };
=20
--=20
1.7.9

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
