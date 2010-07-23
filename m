From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH 05/11] ARM: omap1: nokia770: move mipid_dev_init() to .init.text
Date: Fri, 23 Jul 2010 21:58:28 +0200
Message-ID: <1279915120-4373-5-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1279915120-4373-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43145 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757386Ab0GWT7I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Jul 2010 15:59:08 -0400
In-Reply-To: <1279915120-4373-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

mipid_dev_init() is only called by omap_nokia770_init that lives in
=2Einit.text.  So it's save to move the former to .init.text, too.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-omap1/board-nokia770.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1=
/board-nokia770.c
index 71e1a3f..6c4dd0e 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -113,7 +113,7 @@ static struct mipid_platform_data nokia770_mipid_pl=
atform_data =3D {
 	.shutdown =3D mipid_shutdown,
 };
=20
-static void mipid_dev_init(void)
+static void __init mipid_dev_init(void)
 {
 	const struct omap_lcd_config *conf;
=20
--=20
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
