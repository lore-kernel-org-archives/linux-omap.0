From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH 11/11] ARM: omap: ams-delta: move config to .init.data
Date: Fri, 23 Jul 2010 21:58:34 +0200
Message-ID: <1279915120-4373-11-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1279915120-4373-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43180 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759246Ab0GWT7f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Jul 2010 15:59:35 -0400
In-Reply-To: <1279915120-4373-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Kalle Valo <kalle.valo@iki.fi>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

Most other boards have their config in .init.data, too, so this should
be OK.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-omap1/board-ams-delta.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap=
1/board-ams-delta.c
index fdd1dd5..6b936cc 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -173,7 +173,7 @@ static struct omap_usb_config ams_delta_usb_config =
__initdata =3D {
 	.pins[0]	=3D 2,
 };
=20
-static struct omap_board_config_kernel ams_delta_config[] =3D {
+static struct omap_board_config_kernel ams_delta_config[] __initdata =3D=
 {
 	{ OMAP_TAG_LCD,		&ams_delta_lcd_config },
 };
=20
--=20
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
